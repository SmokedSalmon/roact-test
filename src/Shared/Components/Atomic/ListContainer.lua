--[[
    List Container Component that arrange items in List Layout
]]
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Roact = require(ReplicatedStorage.Packages.roact)
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)

-- Constants & Configs
local DefaultDirection = Enum.FillDirection.Horizontal
local DefaultPadding = UDim.new(0, 10) -- Spacing padding, not UIPadding
local DefaultPosition = UDim2.new(0, 0, 0, 0)
local DefaultSize = UDim2.new(1, 0, 1, 0)
local DefaultSort = Enum.SortOrder.LayoutOrder

local ListContainer = Roact.Component:extend('ListContainer')

function ListContainer:render()
    local _props = TableUtil.Assign({
        isScrollable = false,
        listDirection = DefaultDirection,
        Position = DefaultPosition,
        Size = DefaultSize,
        layout = {},
    }, self.props or {})

    if _props.ScrollingDirection then
        warn(`You have set "ScrollingDirection: {_props.ScrollingDirection}", which may conflict with the "listDirection" of this Component. You should avoid setting "ScrollingDirection" unless you know what you are doing, as it is automatic determined by "listDirection"`)
    end
    if _props.layout.FillDirection then
        warn(`You have set "FillDirection: {_props.layout.ScrollingDirection}", which may conflict with the "listDirection" of this Component. You should avoid setting "FillDirection" of the UIListLayout unless you know what you are doing, as it is automatic determined by "listDirection"`)
    end

    local isScrollable = _props.isScrollable
    local _layoutProps = TableUtil.Assign({
        FillDirection = _props.listDirection,
        Padding = DefaultPadding,
        SortOrder = DefaultSort,
    }, _props.layout)
    _props.isScrollable = nil
    _props.listDirection = nil
    _props.layout = nil

    local isHorizontal = _layoutProps.FillDirection == Enum.FillDirection.Horizontal

    -- [TODO] check conflict with potential UILayout Component under the this container Component
    -- for _, child in pairs(_props[Roact.Children]) do
    --     print(child)
    --     if child.IsA and child:IsA('UILayout') then
    --         warn(`You've included another UI Layout "{typeof(child)}" as its child under this ListContainer, it may conflict the underlying UIListLayout and cause un-desired UI behavior`)
    --     end
    -- end
    if _props[Roact.Children] and _props[Roact.Children].UIListLayout then
        warn(`You've included another UIListLayout as its child under this ListContainer, it will be overridden with internal UIListLayout`)
    end
    _props[Roact.Children].UIListLayout = Roact.createElement('UIListLayout', _layoutProps)

    if isScrollable then
        _props = TableUtil.Assign({
            ScrollingDirection = isHorizontal and Enum.ScrollingDirection.X or Enum.ScrollingDirection.Y,
            AutomaticCanvasSize = isHorizontal and Enum.AutomaticSize.X or Enum.AutomaticSize.Y,
        }, _props)
        if _props.AutomaticCanvasSize ~= Enum.AutomaticSize.None then
            _props.CanvasSize = UDim2.new(0, 0, 0, 0) -- make sure no scrolling when it is NOT necessary
        end
        return Roact.createElement('ScrollingFrame', _props)
    end

    return Roact.createElement('Frame', _props)
end

return ListContainer
