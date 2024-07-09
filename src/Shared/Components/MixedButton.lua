--[[
    Button Component with Text & Icon
]]
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Roact = require(ReplicatedStorage.Packages.roact)
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
local Box = require(ReplicatedStorage.Shared.Components.Atomic.Box)
local Icon = require(ReplicatedStorage.Shared.Components.Icon)
local TButton = require(ReplicatedStorage.Shared.Components.TButton)
local WithEvents = require(ReplicatedStorage.Shared.Components.Atomic.WithEvents)

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
    _rootProps.Button = nil
    _tButtonProps.Icon = nil

    -- Pointer Interact is handled by the Invisible mask
    _tButtonProps.Interactable = false
    _iconProps.Interactable = false

    return Roact.createElement(Box, _rootProps, {
        InteractZone = Roact.createElement(WithEvents('TextButton'), {
            Position = UDim2.new(0, 0, 0, 0),
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            TextTransparency = 1,
        }),
        Content = Roact.createElement(Box, {
            Size = UDim2.new(1, 0, 1, 0),
        }, {
            UIListLayout = Roact.createElement('UIListLayout', {
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center,
            }),
            Icon = Roact.createElement(WithEvents(Icon), _iconProps),
            TextButton = Roact.createElement(WithEvents('TextButton'), _tButtonProps, {})
        }),
    })
end

return MButton
