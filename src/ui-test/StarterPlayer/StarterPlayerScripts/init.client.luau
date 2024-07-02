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
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.new(0.7, 0, 0.7, 0),
            Background = {
                Color3 = Color3.fromRGB(118, 214, 255),
            },
            Shadow = {
                Color3 = Color3.fromRGB(0, 84, 147),
                Offset = UDim2.new(0, 5, 0, 5)
            }
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

            -- Test for Panel Sign
            SignLabel = Roact.createElement(TestUIComponents.TestShadowedSignText, {
                Text = 'Arsenal',
                TextSize = 50,
                Color = Color3.fromRGB(255, 255, 255),
                ShadowColor = Color3.fromRGB(115, 250, 121),
            }),
            -- Test Grid Container
            Container1 = Roact.createElement(GridContainer, {}, {
                Card1 = TestUIComponents.TestArsenalCard(),
                Card2 = TestUIComponents.TestArsenalCard(),
                Card3 = TestUIComponents.TestArsenalCard(),
                Card4 = TestUIComponents.TestArsenalCard(),
                Card5 = TestUIComponents.TestArsenalCard(),
                Card6 = TestUIComponents.TestArsenalCard(),
                Card7 = TestUIComponents.TestArsenalCard(),
                Card8 = TestUIComponents.TestArsenalCard(),
                Card9 = TestUIComponents.TestArsenalCard(),
                Card10 = TestUIComponents.TestArsenalCard(),
                Card11 = TestUIComponents.TestArsenalCard(),
            })
        })
    })
})

-- local guiUnmountHandler = Roact.mount(GuiRoot, Players.LocalPlayer.PlayerGui, 'Test GUI')
local guiUnmountHandler = Roact.mount(GuiRootWithStoreHelpers, Players.LocalPlayer.PlayerGui, 'Test GUI')

task.wait(1000)
print('Unmounting GUI')
Roact.unmount(guiUnmountHandler)