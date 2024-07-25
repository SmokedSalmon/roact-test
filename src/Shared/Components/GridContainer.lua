--[[
    Grid Container, made for Items/Cards put in a grid/table
    Scrollable
]]
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Roact = require(ReplicatedStorage.Packages.roact)
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
local AtomicComponents = ReplicatedStorage.Shared.Components.Atomic
local Box = require(AtomicComponents.Box)

-- Constants & Configs
local DefaultLayoutProps = {
    SortOrder = Enum.SortOrder.LayoutOrder,
    CellPadding = UDim2.new(0, 0, 0, 0),
    CellSize = UDim2.new(1/3, 0, 1/3, 0), -- TODO Parameterized
    FillDirection = Enum.FillDirection.Horizontal,
}
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
    }
}
-- local DefaultTextButtonProps = {
--     Size = UDim2.new(1, 0, 1, 0),
--     AutomaticSize = Enum.AutomaticSize.XY, -- Default fit to content
-- }

local GridContainer = Roact.Component:extend('GridContainer')

function GridContainer:render()
    local _props = TableUtil.Assign(DefaultRootContainerProps, self.props or {})
    local _layoutProps = TableUtil.Assign(DefaultLayoutProps, _props.Layout)
    _props.Layout = nil

    _props[Roact.Children] = TableUtil.Assign({
        UIGridLayout = Roact.createElement('UIGridLayout', _layoutProps),
    }, _props[Roact.Children])
    
    return Roact.createElement(Box, _props)
end

return GridContainer
