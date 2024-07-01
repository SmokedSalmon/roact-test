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

local Components = ReplicatedStorage.Shared.Components
local AtomicComponents = Components.Atomic
local StoreService = require(ReplicatedStorage.Shared.Store)
local Modal = require(Components.Modal)
local WithCustomBackground = require(AtomicComponents.WithCustomBackground)
local Box = require(AtomicComponents.Box)
local Button = require(Components.Button)
local Card = require(Components.Card)
local GridContainer = require(ReplicatedStorage.Shared.Components.GridContainer)
local TestUIComponents = require(ReplicatedStorage.TestUIComponents)

-- Test for Static Menus
local GuiRoot = Roact.createElement('ScreenGui', {
    IgnoreGuiInset = true,
}, {
    TestMainMenu = TestUIComponents.TestMainMenu,
})

-- Test for Store Helpers
local defaultValue = { Scope1 = { Text = 'Passed Down' } }
local GlobalStore = StoreService.createStore(defaultValue, 'UIStore')

local GuiRootWithStoreHelpers = Roact.createElement('ScreenGui', {
    IgnoreGuiInset = true,
}, {
    Root = GlobalStore.ProvideFor({
        TestContainer = Roact.createElement(Box, {
            Position = UDim2.new(0, 0, 0, 0),
            Size = UDim2.new(1, 0, 1, 0),
            Padding = {
                PaddingLeft = UDim.new(0, 50),
                PaddingTop = UDim.new(0, 50),
                PaddingRight = UDim.new(0, 50),
                PaddingBottom = UDim.new(0, 50),
            },
        }, {
            -- Test a single Button
            -- Button1 = Roact.createElement(Button, {
            --     Padding = {
            --         PaddingLeft = UDim.new(0, 20),
            --         PaddingTop = UDim.new(0, 20),
            --         PaddingRight = UDim.new(0, 20),
            --         PaddingBottom = UDim.new(0, 20),
            --     },
            --     Button = {
            --         Text = 'Click Me'
            --     },
            --     Event = {
            --         Activated = function() print('Pressed') end,
            --         MouseEnter = function() print('Mouse Entered') end,
            --         MouseLeave = function() print('Mouse Left') end,
            --         TouchPan = function() print('Panned') end,
            --         TouchTap = function() print('Tapped') end,
            --     },
            -- })

            -- Test A single Card
            -- Card1 = Roact.createElement(Card, {}),

            -- Test Grid Container
            Container1 = Roact.createElement(GridContainer, {}, {
                Card1 = Roact.createElement(Card, {}),
                Card2 = Roact.createElement(Card, {}),
                Card3 = Roact.createElement(Card, {}),
                Card4 = Roact.createElement(Card, {}),
                Card5 = Roact.createElement(Card, {}),
                Card6 = Roact.createElement(Card, {}),
                Card7 = Roact.createElement(Card, {}),
                Card8 = Roact.createElement(Card, {}),
                Card9 = Roact.createElement(Card, {}),
                Card10 = Roact.createElement(Card, {}),
                Card11 = Roact.createElement(Card, {}),
            })
        })
    })
})

-- local guiUnmountHandler = Roact.mount(GuiRoot, Players.LocalPlayer.PlayerGui, 'Test GUI')
local guiUnmountHandler = Roact.mount(GuiRootWithStoreHelpers, Players.LocalPlayer.PlayerGui, 'Test GUI')

task.wait(1000)
print('Unmounting GUI')
Roact.unmount(guiUnmountHandler)