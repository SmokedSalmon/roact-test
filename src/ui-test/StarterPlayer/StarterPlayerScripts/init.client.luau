local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Players = game:GetService('Players')

local Roact = require(ReplicatedStorage.Packages.roact)
local RoactRouter = require(ReplicatedStorage.Packages['roact-router'])

-- Hello World Example
-- local app = Roact.createElement('ScreenGui', {}, {
--     HelloWorld = Roact.createElement('TextLabel', {
--         Size = UDim2.new(0, 400, 0, 300),
--         Text = 'Hello, Roact is launched!'
--     })
-- })
-- Roact.mount(app, Players.LocalPlayer.PlayerGui)
-- print('Client finished')

local Components = ReplicatedStorage.Shared.Components
local AtomicComponents = Components.Atomic
local StoreService = require(ReplicatedStorage.Shared.Store)
local Modal = require(Components.Modal)
local WithCustomBackground = require(AtomicComponents.WithCustomBackground)
local Box = require(AtomicComponents.Box)
local Button = require(Components.Button)
local TButton = require(Components.TButton)
local MixedButton = require(Components.MixedButton)
local Icon = require(Components.Icon)
local Card = require(Components.Card)
local GridContainer = require(ReplicatedStorage.Shared.Components.GridContainer)
local TestUIComponents = require(ReplicatedStorage.TestUIComponents)

-- Test for Static Menus
local GuiRoot = Roact.createElement('ScreenGui', {
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling, -- Otherwise it is default to 'Global'
}, {
    TestMainMenu = TestUIComponents.TestMainMenu,
})

-- Test for Store Helpers
local defaultValue = { Scope1 = { Text = 'Passed Down' } }
local GlobalStore = StoreService.createStore(defaultValue, 'UIStore')

-- Test for Roact-Router with example pages
local function TestNavbar()
    return Roact.createElement(RoactRouter.RouterContext.Consumer, {
        render = function(context)
            local history = context.history

            return Roact.createElement('Frame', {
                Size = UDim2.new(1, 0, 0, 30),
                BackgroundTransparency = 1
            }, {
                Home = Roact.createElement('TextButton', {
                    Text = '/',
                    TextSize = 18,
                    Size = UDim2.new(0, 30, 0, 30),
                    BackgroundColor3 = Color3.new(1, 1, 1),
                    LayoutOrder = 1,

                    [Roact.Event.Activated] = function()
                        history:push('/')
                    end
                }),

                ToTestIcon = Roact.createElement('TextButton', {
                    Text = '/icon',
                    TextSize = 18,
                    Size = UDim2.new(0, 30, 0, 30),
                    BackgroundColor3 = Color3.new(1, 1, 1),
                    LayoutOrder = 2,

                    [Roact.Event.Activated] = function()
                        history:push('/icon')
                    end
                }),
        
                Layout = Roact.createElement('UIListLayout', {
                    FillDirection = Enum.FillDirection.Horizontal,
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
            })
        end
    })
end

local function TestMainMenu()
    return Roact.createElement(RoactRouter.Route, {
        path = '/',
        exact = true,
        render = function(routeProps)
            return TestUIComponents.TestArsenalPage()
        end
    })
end

local function TestIcon()
    return Roact.createElement(RoactRouter.Route, {
        path = '/icon',
        exact = true,
        render = function(routeProps)
            return Roact.createElement(Icon, {
                Padding = {
                    PaddingLeft = UDim.new(0, 20),
                    PaddingTop = UDim.new(0, 40),
                    PaddingRight = UDim.new(0, 20),
                    PaddingBottom = UDim.new(0, 40),
                },
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.new(0.5, 0, 0.5, 0),
                Size = UDim2.new(0, 220, 0, 160),
                Image = 'rbxassetid://13384578429',
                ScaleType = Enum.ScaleType.Crop,
                Event = {
                    MouseEnter = function() print('Mouse Entered') end,
                    MouseLeave = function() print('Mouse Left') end,
                },
            })
        end
    })
end

local _routerHistory
local GuiRootWithRouter = Roact.createElement(RoactRouter.Router, nil, {
    GuiScreen = Roact.createElement('ScreenGui', {
        IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling, -- Otherwise it is default to 'Global'
    }, {
        TestNavBar = Roact.createElement(TestNavbar),
        RootBox = Roact.createElement(Box, {
            Size = UDim2.new(1, 0, 1, 0),
        }, {
            Roact.createElement(TestMainMenu),
            Roact.createElement(TestIcon),
            -- Layout = Roact.createElement('UIListLayout', {
            --     HorizontalAlignment = Enum.HorizontalAlignment.Center,
            --     VerticalAlignment = Enum.VerticalAlignment.Center,
            --     FillDirection = Enum.FillDirection.Vertical,
            --     SortOrder = Enum.SortOrder.LayoutOrder,
            --     Padding = UDim.new(0, 10)
            -- })
        })
    })
})

local GuiRootWithStoreHelpers = Roact.createElement('ScreenGui', {
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling, -- Otherwise it is default to 'Global'
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

            -- Test Text Button
            -- TButton = Roact.createElement(TButton, {
            --     Padding = {
            --         PaddingLeft = UDim.new(0, 20),
            --         PaddingTop = UDim.new(0, 20),
            --         PaddingRight = UDim.new(0, 20),
            --         PaddingBottom = UDim.new(0, 20),
            --     },
            --     AnchorPoint = Vector2.new(0.3, 0.6),
            --     Position = UDim2.new(0.5, 0, 0.5, 0),
            --     Size = UDim2.new(0, 220, 0, 80),
            --     Text = 'Click Me',
            --     Event = {
            --         Activated = function() print('Pressed') end,
            --         MouseEnter = function() print('Mouse Entered') end,
            --         MouseLeave = function() print('Mouse Left') end,
            --         TouchPan = function() print('Panned') end,
            --         TouchTap = function() print('Tapped') end,
            --     },
            -- })

            -- Test Icon
            -- TestIcon = Roact.createElement(Icon, {
            --     Padding = {
            --         PaddingLeft = UDim.new(0, 20),
            --         PaddingTop = UDim.new(0, 40),
            --         PaddingRight = UDim.new(0, 20),
            --         PaddingBottom = UDim.new(0, 40),
            --     },
            --     AnchorPoint = Vector2.new(0.5, 0.5),
            --     Position = UDim2.new(0.5, 0, 0.5, 0),
            --     Size = UDim2.new(0, 220, 0, 160),
            --     Image = 'rbxassetid://13384578429',
            --     ScaleType = Enum.ScaleType.Crop,
            --     Event = {
            --         MouseEnter = function() print('Mouse Entered') end,
            --         MouseLeave = function() print('Mouse Left') end,
            --     },
            -- }),

            -- Test Mixed Button
            TestMixedButton = Roact.createElement(MixedButton, {
                Padding = {
                    PaddingLeft = UDim.new(0, 10),
                    PaddingTop = UDim.new(0, 5),
                    PaddingRight = UDim.new(0, 10),
                    PaddingBottom = UDim.new(0, 5),
                },
                Background = {
                    Color3 = Color3.fromRGB(0, 249, 0),
                    CornerRadius = UDim.new(0, 10),
                },
                Shadow = {
                    Color3 = Color3.fromRGB(0, 144, 81),
                },
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.new(0.5, 0, 0.5, 0),
                Size = UDim2.new(0, 150, 0, 60),
                Button = {
                    Size = UDim2.new(0.65, 0, 0.2, 0),
                    Text = 'Click Me',
                    FontFace = Font.new('rbxasset://fonts/families/JosefinSans.json'),
                    TextSize = 18,
                    TextXAlignment = Enum.TextXAlignment.Right,
                    TextYAlignment = Enum.TextYAlignment.Center,
                    Icon = {
                        Size = UDim2.new(0.2, 0, 0.2, 0),
                        SizeConstraint = Enum.SizeConstraint.RelativeXX,
                        Image = 'rbxassetid://13384578429',
                        ScaleType = Enum.ScaleType.Crop,
                    }
                }

                -- Event = {
                --     MouseEnter = function() print('Mouse Entered') end,
                --     MouseLeave = function() print('Mouse Left') end,
                -- },
            })

            -- Test A single Card
            -- Card1 = Roact.createElement(Card, {}),
        })
        
        -- ArsenalPage = TestUIComponents.TestArsenalPage(),
        -- SelectLevelPage = TestUIComponents.TestLevelPage(),
        -- DescPage = TestUIComponents.TestDescPage(),
    })
})

-- local guiUnmountHandler = Roact.mount(GuiRoot, Players.LocalPlayer.PlayerGui, 'Test GUI')
local guiUnmountHandler = Roact.mount(GuiRootWithRouter, Players.LocalPlayer.PlayerGui, 'Test GUI')
-- local guiUnmountHandler = Roact.mount(GuiRootWithStoreHelpers, Players.LocalPlayer.PlayerGui, 'Test GUI')

task.wait(1000)
print('Unmounting GUI')
Roact.unmount(guiUnmountHandler)