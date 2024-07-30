--[[
    Item Card Component
]]
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Roact = require(ReplicatedStorage.Packages.roact)
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
local Box = require(ReplicatedStorage.Modules.Components.Atomic.Box)
local Card = require(ReplicatedStorage.Modules.Components.Card)
local WithEvents = require(ReplicatedStorage.Modules.Components.Atomic.WithEvents)

-- Constants & Configs
local DefaultProps = {
    active = true,
}

local ItemCard = Roact.Component:extend('ItemCard')

function ItemCard(props: {}?)
    local _props = TableUtil.Assign(DefaultProps, props)
    local _event = _props.Event
    _props.Event = nil

    return Roact.createElement(Card, _props, {
        InteractZone = Roact.createElement(WithEvents('TextButton'), {
            Position = UDim2.new(0, 0, 0, 0),
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            TextTransparency = 1,
            Event = _event,
        }),
        Infos = Roact.createElement(Box, {
            Position = UDim2.new(0.3, 0, 0.35, 0),
            Size = UDim2.new(0.7, 0, 0.65, 0),
        }, {
            UIListLayout = Roact.createElement('UIListLayout', {
                FillDirection = Enum.FillDirection.Vertical,
            }),
            Label1 = Roact.createElement('TextLabel', {
                Size = UDim2.new(1, 0, 0, 20),
                BackgroundTransparency = 1,
                Text = 'Label',
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center
            }),
            Label2 = Roact.createElement('TextLabel', {
                Size = UDim2.new(1, 0, 0, 20),
                BackgroundTransparency = 1,
                Text = 'Label',
                TextSize = 14,
                TextYAlignment = Enum.TextYAlignment.Center
            }),
        })
    })
end

return ItemCard
