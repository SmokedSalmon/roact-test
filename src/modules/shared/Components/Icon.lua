--[[
    Icon Component
]]
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Roact = require(ReplicatedStorage.Packages.roact)
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
local Box = require(script.Parent.Atomic.Box)
local WithEvents = require(script.Parent.Atomic.WithEvents)

-- Constants & Configs
local DefaultPadding = {
    PaddingLeft = UDim.new(0, 0),
    PaddingTop = UDim.new(0, 0),
    PaddingRight = UDim.new(0, 0),
    PaddingBottom = UDim.new(0, 0),
}
local DefaultRootContainerProps = {
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    AutomaticSize = Enum.AutomaticSize.XY, -- Default fit to content
}
local DefaultIconProps = {
    AnchorPoint = Vector2.new(0, 0),
    Size = UDim2.new(1, 0, 1, 0),
    AutomaticSize = Enum.AutomaticSize.None, -- Frame over content, as Icon suggest
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScaleType = Enum.ScaleType.Stretch,
}

local Icon = Roact.Component:extend('Icon')

function Icon:render()
    local _props = TableUtil.Assign(DefaultIconProps, self.props)

    local _rootBox = _props.Padding
        or _props.Background
        or _props.Border
        or _props.Shadow
    local RootBox: Roact.Component
    
    if _rootBox then
        local _boxProps = {
            Background = _props.Background,
            Border = _props.Border,
            Shadow = _props.Shadow,
            Padding = _props.Padding,
            AnchorPoint = _props.AnchorPoint,
            Position = _props.Position,
            Size = _props.Size
        }
        if _boxProps.Padding then
            local xPadding = _boxProps.Padding.PaddingLeft or UDim.new(0, 0)
            xPadding += _boxProps.Padding.PaddingRight or UDim.new(0, 0)
            local yPadding = _boxProps.Padding.PaddingTop or UDim.new(0, 0)
            yPadding += _boxProps.Padding.PaddingBottom or UDim.new(0, 0)
            _boxProps.Size += UDim2.new(xPadding, yPadding)
        end
        _props.Background = nil
        _props.Border = nil
        _props.Shadow = nil
        _props.Padding = nil

        -- Root Box already takes over the AnchorPoint as a whole, thus the TextButton always sits in the center
        _props.AnchorPoint = Vector2.new(0.5, 0.5)
        return Roact.createElement(Box, _boxProps, {
            Icon = Roact.createElement(WithEvents('ImageLabel'), _props, {})
        })
    end
    return Roact.createElement(WithEvents('ImageLabel'), _props, {})
end

return Icon
