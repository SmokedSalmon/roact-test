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
local Store = require(ReplicatedStorage.Store)
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
    -- TestModel = UIModules.createModalDummy(),
    TestModel = UIModules.createStateModalDummy(),
    HListContainerTest = UIModules.createHListContainerDummy(),
    VListContainerTest = UIModules.createVListContainerDummy(),
    -- BoxTest = UIModules.createBoxDummy(),
    -- ButtonBaseTest = UIModules.createButtonBaseDummy(),
})

local GlobalStoreProvider = Roact.Component:extend('GlobalStore')
function GlobalStoreProvider:init()
    self:setState({
        Scope1 = {
            shadowColor = Color3.fromRGB(0, 0, 0)
        },
        Scope2 = {},
    })
    coroutine.wrap(function()
        task.wait(2)
        print('Shadow color changed')
        self:setState({
            Scope1 = {
                shadowColor = Color3.fromRGB(0, 84, 147)
            },
            Scope2 = {},
        })
    end)()
end
function GlobalStoreProvider:render()
    return Roact.createElement(Store.Provider, {
        value = self.state
    }, self.props[Roact.Children])
end
local GuiRootWithStore = Roact.createElement('ScreenGui', {
    IgnoreGuiInset = true,
}, {
    GlobalStoreProvider = Roact.createElement(GlobalStoreProvider, {}, {
        -- TestModel = UIModules.createModalDummy(),
        TestModel = UIModules.createStateAndContextualModalDummy(),
        HListContainerTest = UIModules.createHListContainerDummy(),
        VListContainerTest = UIModules.createVListContainerDummy(),
        -- BoxTest = UIModules.createBoxDummy(),
        -- ButtonBaseTest = UIModules.createButtonBaseDummy(),
    })
})

-- local guiUnmountHandler = Roact.mount(GuiRoot, Players.LocalPlayer.PlayerGui, 'Test GUI')
local guiUnmountHandler = Roact.mount(GuiRootWithStore, Players.LocalPlayer.PlayerGui, 'Test GUI')

task.wait(1000)
print('Unmounting GUI')
Roact.unmount(guiUnmountHandler)