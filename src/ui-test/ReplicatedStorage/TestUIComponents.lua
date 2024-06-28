local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Roact = require(ReplicatedStorage.Packages.roact)

local Components = ReplicatedStorage.Shared.Components
local AtomicComponents = Components.Atomic
local StoreService = require(ReplicatedStorage.Shared.Store)
local Modal = require(Components.Modal)
local WithCustomBackground = require(AtomicComponents.WithCustomBackground)
local GridContainer = require(AtomicComponents.GridContainer)
local Card = require(Components.Card)
local Button = require(Components.Button)
local ListContainer = require(AtomicComponents.ListContainer)
local Box = require(AtomicComponents.Box)

local function TestMainMenuButton(name)
    return Roact.createElement(Button, {
        Padding = {
            PaddingLeft = UDim.new(0, 10),
            PaddingTop = UDim.new(0, 10),
            PaddingRight = UDim.new(0, 10),
            PaddingBottom = UDim.new(0, 10),
        },
        Button = {
            Text = name,
            FontFace = Font.fromName('JosefinSans'),
            TextSize = 50,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center,
        },
        Event = {
            Activated = function() print('Pressed') end,
            MouseEnter = function() print('Mouse Entered') end,
            MouseLeave = function() print('Mouse Left') end,
            TouchPan = function() print('Panned') end,
            TouchTap = function() print('Tapped') end,
        },
    })
end

local TestMainMenu = Roact.createElement(Box, {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.new(0.8, 0, 0.8, 0),
}, {
    List = Roact.createElement(Box, {
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.new(0.5, 0, 0, 0),
        Size = UDim2.new(0.3, 0, 1, 0),
    }, {
        UIListLayout = Roact.createElement('UIListLayout', {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center,
        }, {}),
        Button1 = TestMainMenuButton('Play'),
        Button2 = TestMainMenuButton('Arsenal'),
        Button3 = TestMainMenuButton('Encyclopedia'),
    })
})

return {
    TestMainMenu = TestMainMenu,
}