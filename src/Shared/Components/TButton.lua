--[[
    Text Button Component
]]
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Roact = require(ReplicatedStorage.Packages.roact)
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
local Box = require(ReplicatedStorage.Shared.Components.Atomic.Box)

-- Constants & Configs
local DefaultUIPadding = {
    PaddingLeft = UDim.new(0, 10),
    PaddingTop = UDim.new(0, 10),
    PaddingRight = UDim.new(0, 10),
    PaddingBottom = UDim.new(0, 10),
}
local DefaultRootContainerProps = {
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    AutomaticSize = Enum.AutomaticSize.XY, -- Default fit to content
}
local DefaultTextButtonProps = {
    AnchorPoint = Vector2.new(0, 0),
    Size = UDim2.new(1, 0, 1, 0),
    AutomaticSize = Enum.AutomaticSize.XY, -- Default fit to content
}

local Button = Roact.Component:extend('Button')

function Button:render()
    local _props = TableUtil.Assign(DefaultTextButtonProps, self.props)

    if _props.Event and typeof(_props.Event) == 'table' then
        for event, handler in pairs(_props.Event) do
            _props[Roact.Event[event]] = handler
        end
        _props.Event = nil
    end

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
            TextButton = Roact.createElement('TextButton', _props, {})
        })
    end
    return Roact.createElement('TextButton', _props, {})
end

function Button:willUnmount()
    -- if self.__handlers.onActivated then self.__handlers.onActivated:Disconnect() end
end

return Button
