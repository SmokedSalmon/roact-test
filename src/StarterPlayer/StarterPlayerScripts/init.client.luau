local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Roact = require(ReplicatedStorage.Packages.roact)

-- Hello World Example
-- local app = Roact.createElement("ScreenGui", {}, {
--     HelloWorld = Roact.createElement("TextLabel", {
--         Size = UDim2.new(0, 400, 0, 300),
--         Text = "Hello, Roact is launched!"
--     })
-- })
-- Roact.mount(app, Players.LocalPlayer.PlayerGui)
-- print("Client finished")

local Components = ReplicatedStorage.Components
local AtomicComponents = Components.Atomic
local Modal = require(Components.Modal)
local WithCustomBackground = require(Components.WithCustomBackground)
local GridContainer = require(AtomicComponents.GridContainer)
local Card = require(Components.Card)
local Button = require(Components.Button)

local GuiRoot = Roact.createElement('ScreenGui', {}, {
    TestModel = Roact.createElement(WithCustomBackground(Modal), {
        title = 'Arsenal',
        bg = {
            BackgroundColor3 = Color3.fromRGB(118, 214, 255),
            shadow = { BackgroundColor3 = Color3.fromRGB(0, 84, 147) },
        },
    }, {
        CardsContainerTest = Roact.createElement(GridContainer, {
            isScrollable = true,
            BackgroundTransparency = 1,
        }, {
            Roact.createElement(Card, { Name = 'CardTest'}),
            Roact.createElement(Button, {
                Name = 'ButtonTest',
                padding = { PaddingLeft = UDim.new(0, 20) },
                textButton = { Text = 'Click Me' },
            }),
            Roact.createElement(Card, { Name = 'CardTest'}),
            Roact.createElement(Card, { Name = 'CardTest'}),
            Roact.createElement(Card, { Name = 'CardTest'}),
            Roact.createElement(Card, { Name = 'CardTest'}),
            Roact.createElement(Card, { Name = 'CardTest'}),
            Roact.createElement(Card, { Name = 'CardTest'}),
        }),
    })
})

local guiUnmountHandler = Roact.mount(GuiRoot, Players.LocalPlayer.PlayerGui, 'Test GUI')

task.wait(100)
print('Unmounting GUI')
Roact.unmount(guiUnmountHandler)