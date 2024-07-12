--[[
    Button for Top Level Menu
]]
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Roact = require(ReplicatedStorage.Packages.roact)
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
local Box = require(ReplicatedStorage.Shared.Components.Atomic.Box)
local Icon = require(ReplicatedStorage.Shared.Components.Icon)
local WithEvents = require(ReplicatedStorage.Shared.Components.Atomic.WithEvents)

-- Constants & Configs
local DefaultRootContainerProps = {
    
}
local DefaultSquareProps = {
    AutomaticSize = Enum.AutomaticSize.XY,
    BackgroundColor3 = Color3.fromRGB(128, 128, 128),
    ZIndex = 1,
    Size = UDim2.new(1, 0, 0, 30),
    Position = UDim2.new(0, -20, 0.4, -5),
    BackgroundTransparency = 0,
}
local DefaultButtonProps = {
    AnchorPoint = Vector2.new(0, 0),
    Size = UDim2.new(0, 0, 0, 0),
    AutomaticSize = Enum.AutomaticSize.XY,
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Text = 'Button',
    FontFace = Font.new('rbxasset://fonts/families/JosefinSans.json'),
    TextSize = 50,
    TextXAlignment = Enum.TextXAlignment.Center,
    TextYAlignment = Enum.TextYAlignment.Center,
    ZIndex = 10,
}

local ColorSquareButton = Roact.Component:extend('CSButton')

function ColorSquareButton:init()
    self._squareRot = math.random(-3, 3)
end

function ColorSquareButton:render()
    local _rootProps = TableUtil.Assign(DefaultRootContainerProps, self.props)
    local _tButtonProps = TableUtil.Assign(DefaultButtonProps, self.props.Button)
    local _squareProps = TableUtil.Assign(DefaultSquareProps, self.props.Square)
    _squareProps.Rotation = self._squareRot
        
    _rootProps.Button = nil
    _rootProps.Square = nil
    _rootProps.Event = nil

    -- Pointer Interact is handled by the Invisible mask
    _tButtonProps.Interactable = false
    _squareProps.Interactable = false
    local _event = self.props.Event

    return Roact.createElement(Box, _rootProps, {
        InteractZone = Roact.createElement(WithEvents('TextButton'), {
            Position = UDim2.new(0, 0, 0, 0),
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            TextTransparency = 1,
            Event = _event,
        }),
        Content = Roact.createElement(Box, {
            AutomaticSize = Enum.AutomaticSize.XY, -- Content Box always fits what it is wrapping
            Size = UDim2.new(0, 0, 0, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
        }, {
            TextButton = Roact.createElement(WithEvents('TextButton'), _tButtonProps, {}),
            Square = Roact.createElement(WithEvents(Icon), _squareProps),
        }),
    })
end

return ColorSquareButton
