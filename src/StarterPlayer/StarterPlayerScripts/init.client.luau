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
local WithCustomBackground = require(AtomicComponents.WithCustomBackground)
local GridContainer = require(AtomicComponents.GridContainer)
local Card = require(Components.Card)
local Button = require(Components.Button)
local Box = require(AtomicComponents.Box)
local UIModules = require(ReplicatedStorage.UIModules)

local GuiRoot = Roact.createElement('ScreenGui', {
    IgnoreGuiInset = true,
}, {
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
            Card1 = Roact.createElement(Card, { Name = 'CardTest', LayoutOrder = 1 }),
            ButtonTest = Roact.createElement(Button, {
                padding = { PaddingLeft = UDim.new(0, 20) },
                textButton = {
                    Text = 'Click Me', TextSize = 16, FontFace = Font.new('rbxasset://fonts/families/JosefinSans.json', Enum.FontWeight.Bold),
                    [Roact.Event.MouseButton1Click] = function(pass) print(pass) end,
                },
                LayoutOrder = 2,
            }),
            Card2 = Roact.createElement(Card, { Name = 'CardTest', LayoutOrder = 3}),
            Card3 = Roact.createElement(Card, { Name = 'CardTest', LayoutOrder = 4}),
            Card4 = Roact.createElement(Card, { Name = 'CardTest', LayoutOrder = 5}),
            Card5 = Roact.createElement(Card, { Name = 'CardTest', LayoutOrder = 6}),
            Card6 = Roact.createElement(Card, { Name = 'CardTest', LayoutOrder = 7}),
            Card7 = Roact.createElement(Card, { Name = 'CardTest', LayoutOrder = 8}),
        })
    }),
    HListContainerTest = UIModules.createHListContainerDummy(),
    VListContainerTest = UIModules.createVListContainerDummy(),
    BoxTest = Roact.createElement(Box, {
        AnchorPoint = Vector2.new(.5, .5),
        Position = UDim2.new(.5, 0, .5, 0),
        Size = UDim2.new(.5, 0, .6, 0),
        BackgroundColor3 = Color3.fromRGB(118, 214, 255),
        shadowBackgroundColor3 = Color3.fromRGB(0, 84, 147),
    })
})

local guiUnmountHandler = Roact.mount(GuiRoot, Players.LocalPlayer.PlayerGui, 'Test GUI')

task.wait(1000)
print('Unmounting GUI')
Roact.unmount(guiUnmountHandler)