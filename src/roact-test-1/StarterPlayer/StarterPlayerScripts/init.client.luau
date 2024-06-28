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
local StoreService = require(ReplicatedStorage.Store)
local Modal = require(Components.Modal)
local WithCustomBackground = require(AtomicComponents.WithCustomBackground)
local GridContainer = require(AtomicComponents.GridContainer)
local Card = require(Components.Card)
local Button = require(Components.Button)
local Box = require(AtomicComponents.Box)
local UIModules = require(ReplicatedStorage.Shared.UIModules)

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

local GlobalStoreProvider = Roact.PureComponent:extend('GlobalStore')
function GlobalStoreProvider:init()
    self:setState({
        Scope1 = {
            shadowColor = Color3.fromRGB(0, 0, 0)
        },
        Scope2 = {
            count1 = 1,
            count2 = 1,
        },
    })
    
    coroutine.wrap(function()
        task.wait(2)
        -- print('Shadow color changed')
        self.state.Scope1.shadowColor = Color3.fromRGB(0, 84, 147)
        -- self:setState({
        --     Scope1 = {
        --         shadowColor = Color3.fromRGB(0, 84, 147)
        --     },
        --     Scope2 = {},
        -- })
        self:setState(self.state)
    end)()

    coroutine.wrap(function()
        for i = 1, 100, 1 do
            local ns = self.state
            task.wait(1)
            ns.Scope2.count1 += 1
            ns.Scope2.count2 += 1
            self:setState(ns)
        end
    end)()
end

function GlobalStoreProvider:render()
    return Roact.createElement(StoreService.GlobalStore.Context.Provider, {
        value = self.state
    }, self.props[Roact.Children])
end

local Lv1Consumer = Roact.createElement(StoreService.GlobalStore.Context.Consumer, {
    render = function(gs)
        print(`Outer: count1 - {gs.Scope2.count1} | count2 - {gs.Scope2.count2}`)
    end
})

local Lv2Provider = Roact.PureComponent:extend('Lv2Provider')
function Lv2Provider:init()
    print('init')
    self:setState({
        Scope1 = {
            shadowColor = Color3.fromRGB(0, 0, 0)
        },
        Scope2 = {
            count1 = 100,
            count2 = 100,
        }
    })
    print('Resetting Context in 5')
    coroutine.wrap(function()
        task.wait(5)
        self:setState({
            Scope1 = {
                shadowColor = Color3.fromRGB(0, 0, 0)
            },
            Scope2 = {
                count1 = 's',
                count2 = 's',
            }
        })
    end)()
end
function Lv2Provider:render()
    return Roact.createElement(StoreService.GlobalStore.Context.Provider, {
        value = self.state
    }, self.props[Roact.Children])
end

local Lv2Consumer = Roact.createElement(StoreService.GlobalStore.Context.Consumer, {
    render = function(gs)
        print(`Lv2: count1 - {gs.Scope2.count1} | count2 - {gs.Scope2.count2}`)
    end
})


local GuiRootWithStore = Roact.createElement('ScreenGui', {
    IgnoreGuiInset = true,
}, {
    GlobalStoreProvider = Roact.createElement(GlobalStoreProvider, {}, {
        -- TestModel = UIModules.createModalDummy(),
        TestModel = UIModules.createStateAndContextualModalDummy(),
        -- HListContainerTest = UIModules.createHListContainerDummy(),
        -- VListContainerTest = UIModules.createVListContainerDummy(),
        -- BoxTest = UIModules.createBoxDummy(),
        -- ButtonBaseTest = UIModules.createButtonBaseDummy(),
        -- Lv1Consumer,
        -- Roact.createElement(Lv2Provider, {}, {
        --     Lv2Consumer,
        -- })
    })
})

-- local guiUnmountHandler = Roact.mount(GuiRoot, Players.LocalPlayer.PlayerGui, 'Test GUI')
local guiUnmountHandler = Roact.mount(GuiRootWithStore, Players.LocalPlayer.PlayerGui, 'Test GUI')

-- Test for Store Helpers
local defaultValue = { Scope1 = { Text = 'Passed Down' } }
local testGlobalStore = StoreService.createStore(defaultValue, 'gs')

local GuiRootWithStoreHelpers = Roact.createElement('ScreenGui', {
    IgnoreGuiInset = true,
}, {
    Root = testGlobalStore.ProvideFor({
        -- TestModel = UIModules.createModalDummy(),
        -- TestModel = UIModules.createStateAndContextualModalDummy(),
        -- HListContainerTest = UIModules.createHListContainerDummy(),
        -- VListContainerTest = UIModules.createVListContainerDummy(),
        -- -- BoxTest = UIModules.createBoxDummy(),
        -- -- ButtonBaseTest = UIModules.createButtonBaseDummy(),
        -- Lv1Consumer,
        -- Roact.createElement(Lv2Provider, {}, {
        --     Lv2Consumer,
        -- })
        TestFrame = Roact.createElement('Frame', {}, {
            testGlobalStore.asConsumer('TextLabel', function(state) return state.Scope1 end)
        })
    })
})

-- local guiUnmountHandler = Roact.mount(GuiRootWithStoreHelpers, Players.LocalPlayer.PlayerGui, 'Test GUI')

task.wait(1000)
print('Unmounting GUI')
Roact.unmount(guiUnmountHandler)