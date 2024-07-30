--[[
    Button Component with Text & Icon
]]
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Roact = require(ReplicatedStorage.Packages.roact)
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
local Box = require(script.Parent.Atomic.Box)
local Icon = require(script.Parent.Icon)
local WithEvents = require(script.Parent.Atomic.WithEvents)

-- Constants & Configs
local DefaultRootContainerProps = {}
local DefaultButtonProps = {
    AnchorPoint = Vector2.new(0, 0),
    Size = UDim2.new(1, 0, 1, 0),
    AutomaticSize = Enum.AutomaticSize.None, -- Frame over content
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
}
local DefaultIconProps = {
    AutomaticSize = Enum.AutomaticSize.None, -- Frame over content
}

local MButton = Roact.Component:extend('MButton')

function MButton:render()
    local _rootProps = TableUtil.Assign(DefaultRootContainerProps, self.props)
    local _tButtonProps = TableUtil.Assign(DefaultButtonProps, self.props.Button)
    local _iconProps = TableUtil.Assign(DefaultIconProps, self.props.Button and self.props.Button.Icon)
    local _layoutProps = self.props.Layout and TableUtil.Assign({
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Center,
    }, self.props.Layout)
    local defaultLayoutMode = 'UIListLayout'
    if _layoutProps then
        _layoutProps.mode = nil
    end
    _rootProps.Button = nil
    _tButtonProps.Icon = nil

    -- Pointer Interact is handled by the Invisible mask
    _tButtonProps.Interactable = false
    _iconProps.Interactable = false

    local contentChildren = {}
    contentChildren.Layout = _layoutProps and (
        Roact.createElement(defaultLayoutMode, _layoutProps)
    )
    contentChildren.Icon = Roact.createElement(WithEvents(Icon), _iconProps)
    contentChildren.TextButton = Roact.createElement(WithEvents('TextButton'), _tButtonProps, {})

    return Roact.createElement(Box, _rootProps, {
        InteractZone = Roact.createElement(WithEvents('TextButton'), {
            Position = UDim2.new(0, 0, 0, 0),
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            TextTransparency = 1,
        }),
        Content = Roact.createElement(Box, {
            AutomaticSize = Enum.AutomaticSize.XY, -- Content Box always fits what it is wrapping
            Size = UDim2.new(0, 0, 0, 0),
        }, contentChildren),
    })
end

return MButton
