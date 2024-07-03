--[[
    Column Container Component that arranges items in Horizontal List Layout
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
    AutomaticSize = Enum.AutomaticSize.None,
    -- Scrolling
    Scroll = {
        AutomaticCanvasSize = Enum.AutomaticSize.X,
        CanvasPosition = Vector2.new(0, 0),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 12,
        ScrollingDirection = Enum.ScrollingDirection.X,
        HorizontalScrollBarInset = Enum.ScrollBarInset.ScrollBar,
    }
}

local ColumnContainer = Roact.Component:extend('RowContainer')

function ColumnContainer:render()
    local _props = TableUtil.Assign(DefaultRootContainerProps, self.props or {})

    _props[Roact.Children] = TableUtil.Assign({
        UIListLayout = Roact.createElement('UIListLayout', {
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = (_props.List and _props.List.Padding) or nil,
        }, {}),
    }, _props[Roact.Children])
    _props.List = nil
    
    return Roact.createElement(Box, _props)
end

return ColumnContainer
