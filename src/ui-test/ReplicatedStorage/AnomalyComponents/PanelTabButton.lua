--[[
    Button for Tab Panel
]]
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Roact = require(ReplicatedStorage.Packages.roact)
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
local TButton = require(ReplicatedStorage.Shared.Components.TButton)
local ColorSquareButton = require(script.Parent.ColorSquareButton)

-- Constants & Configs
local defaultButtonProps = {
    Text = 'Button',
    FontFace = Font.new('rbxasset://fonts/families/JosefinSans.json'),
    TextSize = 26,
    TextXAlignment = Enum.TextXAlignment.Center,
    TextYAlignment = Enum.TextYAlignment.Center, 
}
local defaultSquareProps = {
    BackgroundColor3 = Color3.fromRGB(128, 128, 128)
}

local PanelTabButton = Roact.Component:extend('TabButton')

function PanelTabButton(props: {}?)
    local _props = TableUtil.Assign({}, props)
    local _buttonProps = TableUtil.Assign(defaultButtonProps, _props.Button)
    local _squareProps = TableUtil.Assign(defaultSquareProps, _props.Square)

    return Roact.createElement(ColorSquareButton, {
        Button = _buttonProps,
        Square = _squareProps,
        Event = _props.Event,
        Size = UDim2.new(1, 0, 0, 60)
    })
end

return PanelTabButton
