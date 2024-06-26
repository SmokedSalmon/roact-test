--[[
    Grid Container Component that arrange items in rows and columns which is similar to the CSS Flex-box layout
    [TODO] How to set row count & column count? use CellSize
]]
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Roact = require(ReplicatedStorage.Packages.roact)
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)

-- Constants & Configs
local DefaultScrollingDirection = Enum.ScrollingDirection.Y
local DefaultAutomaticCanvasSize = Enum.AutomaticSize.Y
local DefaultPosition = UDim2.new(0, 0, 0, 0)
local DefaultSize = UDim2.new(1, 0, 1, 0)
local DefaultSort = Enum.SortOrder.LayoutOrder
local DefaultRowCount = 3
local DefaultColumnCount = 3

local GridContainer = Roact.Component:extend('GridContainer')

function GridContainer:render()
    local _props = TableUtil.Assign({
        isScrollable = false,
        Position = DefaultPosition,
        Size = DefaultSize,
        grid = {},
    }, self.props or {})
    local isScrollable = _props.isScrollable
    _props.isScrollable = nil
    local _gridProps = TableUtil.Assign({ SortOrder = DefaultSort }, _props.grid)
    _props.grid = nil

    -- [TODO] check conflict with potential UILayout Component under the this container Component
    -- for _, child in pairs(_props[Roact.Children]) do
    --     print(child)
    --     if child.IsA and child:IsA('UILayout') then
    --         warn(`You've included another UI Layout "{typeof(child)}" as its child under this GridContainer, it may conflict the underlying UIGridLayout and cause un-desired UI behavior`)
    --     end
    -- end
    if _props[Roact.Children] and _props[Roact.Children].UIGridLayout then
        warn(`You've included another UIGridLayout as its child under this GridContainer, it will be overridden with internal UIGridLayout`)
    end
    _props[Roact.Children].UIGridLayout = Roact.createElement('UIGridLayout', _gridProps)

    if isScrollable then
        _props = TableUtil.Assign({
            ScrollingDirection = DefaultScrollingDirection,
            AutomaticCanvasSize = DefaultAutomaticCanvasSize,
        }, _props)
        if _props.AutomaticCanvasSize ~= Enum.AutomaticSize.None then
            _props.CanvasSize = UDim2.new(0, 0, 0, 0) -- make sure no scrolling when it is NOT necessary
        end
        return Roact.createElement('ScrollingFrame', _props)
    end

    return Roact.createElement('Frame', _props)
end

return GridContainer
