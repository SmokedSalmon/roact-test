--[[
    Border Component with Corner
]]
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Roact = require(ReplicatedStorage.Packages.roact)

-- Constants & Configs
-- TODO centralize zIndex settings
local ZIs = {
    border = 10,
}
local DefaultPosition = UDim2.new(0, 0, 0, 0)
local DefaultSize = UDim2.new(1, 0, 1, 0)
local DefaultCornerRadius = UDim.new(0, 5)
local DefaultBorderThickness = 1

local function Border(props: {}?)
    local _props = props or {}
    if _props.BackgroundTransparency and _props.BackgroundTransparency < 1 then
        warn("Border's BackgroundTransparency will be overridden as 1 and render with 'UIStroke' instead")
    end
    _props.Name = _props.Name or 'Border'
    _props.BackgroundTransparency = 1 -- Use 'UIStroke' for border line due to UICorner
    _props.Position = _props.Position or DefaultPosition
    _props.Size = _props.Size or DefaultSize
    _props.ZIndex = _props.ZIndex or ZIs.border
    return Roact.createElement('Frame', _props, {
        UICorner = Roact.createElement('UICorner', { CornerRadius = _props.CornerRadius or DefaultCornerRadius }),
        UIStroke = Roact.createElement('UIStroke', { Thickness = _props.BorderSizePixel or _props.BorderThickness or DefaultBorderThickness }),
    })
end

return Border
