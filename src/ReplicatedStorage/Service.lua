--[[
    Service Layer to fetch remote Data to UI
]]
local ReplicatedStorage = game:GetService('ReplicatedStorage')

-- Type Definition
export type UpdateChangedType = (newValue: any) -> any

-- Constants & Configs
-- TODO centralize this to Overall UI settings
local infoFolderName = '__Status__'


local InfoFolder = ReplicatedStorage:WaitForChild(infoFolderName)

local _connections: { [string]: RBXScriptConnection} = {}
local _temp: any = nil
-- data that needed to be fetched upon change
local function ConnectHealth(updateFunc: UpdateChangedType): () -> ()
    if not updateFunc or type(updateFunc) ~= 'function' then
        error('Please provide an update function to response to the new value')
    end
    local Health = InfoFolder:WaitForChild('Health')
    _temp = Health.Changed:Connect(updateFunc)
    _connections.Health = _temp

    return function()
        if _connections.Health then _connections.Health:Disconnect() end
        _connections.Health = nil
    end
end

-- one-time data fetch, asynchronously
local function GetValue1Async<A>(resolve: (value: A) -> (), reject: (error: any) -> ())
    if not resolve or type(resolve) ~= 'function' then
        error('Please provide a resolve function as the 1st argument to response to the new value asynchronously')
    end
    coroutine.wrap(function()
        local Value1 = InfoFolder:WaitForChild('Value1')
        resolve(Value1.Value)
    end)()
end
-- data that requires polling over an interval

