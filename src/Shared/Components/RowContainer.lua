--[[
    Row Container, Listed Rows
    Scrollable
]]
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Roact = require(ReplicatedStorage.Packages.roact)
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
local AtomicComponents = ReplicatedStorage.Shared.Components.Atomic
local Box = require(AtomicComponents.Box)

-- Constants & Configs
local DefaultRootContainerProps = {
    Position = UDim2.new(0, 0, 0, 0),
    Size = UDim2.new(1, 0, 1, 0),
    BorderSizePixel = 0,
    AutomaticSize = Enum.AutomaticSize.None,
    -- Scrolling
    Scroll = {
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasPosition = Vector2.new(0, 0),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 12,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar,
        VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right
    },
    List = {
        FillDirection = Enum.FillDirection.Vertical,
        VerticalFlex = Enum.UIFlexAlignment.SpaceBetween,
    }
}

local RowContainer = Roact.Component:extend('RowContainer')

function RowContainer:render()
    local _props = TableUtil.Assign(DefaultRootContainerProps, self.props or {})

    _props[Roact.Children] = TableUtil.Assign({
        UIListLayout = Roact.createElement('UIListLayout', _props.List),
    }, _props[Roact.Children])
    _props.List = nil
    
    return Roact.createElement(Box, _props)
end

return RowContainer
