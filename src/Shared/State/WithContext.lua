--[[
    Wrapper to access Roact Context, including getter and manipulator
    For full React-hooks implementation please switch to 'useXXX' hook mode, or install correspondent library
]]
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Roact = require(ReplicatedStorage.Packages.roact)

type RoactContext = { Provider: Roact.Component, Consumer: Roact.Component }

function WithContext(Component: Roact.Component, context: RoactContext, mapPropsToState: any, mapDispatchFunc: any)
    
    return Roact.createElement(context.Consumer, {
        render = function(context)
    })

end