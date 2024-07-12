--[[
    Button for Tab Panel
]]
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Roact = require(ReplicatedStorage.Packages.roact)
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
local TButton = require(ReplicatedStorage.Shared.Components.TButton)

-- Constants & Configs

local PanelTabButton = Roact.Component:extend('TabButton')

function PanelTabButton(props: {}?)
    local _props = TableUtil.Assign({}, props)
    return Roact.createElement(TButton, {
        Text = _props.Text or 'Button',
        FontFace = Font.new('rbxasset://fonts/families/JosefinSans.json'),
        TextSize = 26,
        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Center,
        Event = {
            Activated = function() print('Pressed') end,
            TouchTap = function() print('Tapped') end,
        },
    })
end

return PanelTabButton
