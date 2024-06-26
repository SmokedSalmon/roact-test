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
local GridContainer = require(AtomicComponents.GridContainer)
local Card = require(Components.Card)
local Button = require(Components.Button)
local Box = require(AtomicComponents.Box)

-- Test for Store Helpers
local defaultValue = { Scope1 = { Text = 'Passed Down' } }
local GlobalStore = StoreService.createStore(defaultValue, 'UIStore')

local GuiRootWithStoreHelpers = Roact.createElement('ScreenGui', {
    IgnoreGuiInset = true,
}, {
    Root = GlobalStore.ProvideFor({
        TestContainer = Roact.createElement(Box, {}, {
            Button1 = Roact.createElement(Button, {
                textButton = {
                    Text = 'Click Me'
                }
            })
        })
    })
})

local guiUnmountHandler = Roact.mount(GuiRootWithStoreHelpers, Players.LocalPlayer.PlayerGui, 'Test GUI')

task.wait(1000)
print('Unmounting GUI')
Roact.unmount(guiUnmountHandler)