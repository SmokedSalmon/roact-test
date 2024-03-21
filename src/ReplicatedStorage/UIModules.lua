local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Roact = require(ReplicatedStorage.Packages.roact)

local Components = ReplicatedStorage.Components
local AtomicComponents = Components.Atomic
local Store = require(ReplicatedStorage.Store)
local Modal = require(Components.Modal)
local WithCustomBackground = require(AtomicComponents.WithCustomBackground)
local GridContainer = require(AtomicComponents.GridContainer)
local Card = require(Components.Card)
local Button = require(Components.Button)
local ListContainer = require(AtomicComponents.ListContainer)
local Box = require(AtomicComponents.Box)

local function createModalDummy()
    return Roact.createElement(WithCustomBackground(Modal), {
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
    })
end

-- Test for state update & Context-connected Component
local StateModal = Roact.Component:extend('StateModal')

function StateModal:init()
    self:setState({
        k1 = Color3.fromRGB(118, 214, 255)
    })
    coroutine.wrap(function()
        task.wait(1)
        print('color change')
        self:setState({
            k1 = Color3.fromRGB(255, 0, 0)
        })
    end)()
end

function StateModal:render()
    return Roact.createElement(WithCustomBackground(Modal), {
        title = 'Arsenal',
        bg = {
            BackgroundColor3 = self.state.k1,
            shadow = { BackgroundColor3 = self.props.shadowColor or Color3.fromRGB(0, 84, 147) },
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
    })
end

local function createStateModalDummy()
    return Roact.createElement(StateModal, {})
end

local function createStateAndContextualModalDummy()
    return Roact.createElement(Store.Consumer, {
        render = function(store)
            return Roact.createElement(StateModal, {
                shadowColor = store.Scope1.shadowColor,
            })
        end,
    })
end

local function createHListContainerDummy()
    return Roact.createElement(ListContainer, {
        isScrollable = true,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.new(0.2, 0, 0.8, 0),
        Size = UDim2.new(0.6, 0, 0.167, 0),
        layout = {
            VerticalAlignment = Enum.VerticalAlignment.Center,
        },
    }, {
        Button1 = Roact.createElement(Button, {
            textButton = {
                Text = 'Melee Tower', TextSize = 16, FontFace = Font.new('rbxasset://fonts/families/JosefinSans.json', Enum.FontWeight.Bold),
                [Roact.Event.MouseButton1Click] = function(pass) print(pass) end,
            },
            LayoutOrder = 1,
        }),
        Button2 = Roact.createElement(Button, {
            textButton = {
                Text = 'Rifle', TextSize = 16, FontFace = Font.new('rbxasset://fonts/families/JosefinSans.json', Enum.FontWeight.Bold),
                [Roact.Event.MouseButton1Click] = function(pass) print(pass) end,
            },
            LayoutOrder = 2,
        }),
        Button3 = Roact.createElement(Button, {
            textButton = {
                Text = ' + ', TextSize = 16, FontFace = Font.new('rbxasset://fonts/families/JosefinSans.json', Enum.FontWeight.Bold),
            },
            LayoutOrder = 3,
        }),
        Button4 = Roact.createElement(Button, {
            textButton = {
                Text = ' + ', TextSize = 16, FontFace = Font.new('rbxasset://fonts/families/JosefinSans.json', Enum.FontWeight.Bold),
            },
            LayoutOrder = 4,
        }),
        Button5 = Roact.createElement(Button, {
            textButton = {
                AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.new(0, 200, 1, 0),
                Text = ' + ', TextSize = 16, FontFace = Font.new('rbxasset://fonts/families/JosefinSans.json', Enum.FontWeight.Bold),
            },
            LayoutOrder = 5,
        }),
        Button6 = Roact.createElement(Button, {
            textButton = {
                Text = ' + ', TextSize = 16, FontFace = Font.new('rbxasset://fonts/families/JosefinSans.json', Enum.FontWeight.Bold),
            },
            LayoutOrder = 6,
        }),
        Button7 = Roact.createElement(Button, {
            textButton = {
                Text = ' + ', TextSize = 16, FontFace = Font.new('rbxasset://fonts/families/JosefinSans.json', Enum.FontWeight.Bold),
            },
            LayoutOrder = 7,
        })
    })
end

local function createVListContainerDummy()
    return Roact.createElement(ListContainer, {
        isScrollable = true,
        listDirection = Enum.FillDirection.Vertical,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(.5, .5),
        Position = UDim2.new(0.056, 0, 0.5, 0),
        Size = UDim2.new(0.1, 0, 0.8, 0),
        layout = {
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
        },
    }, {
        Button1 = Roact.createElement(Button, {
            textButton = {
                Text = 'Metior', TextSize = 16, FontFace = Font.new('rbxasset://fonts/families/JosefinSans.json', Enum.FontWeight.Bold),
                [Roact.Event.MouseButton1Click] = function(pass) print(pass) end,
            },
            LayoutOrder = 1,
        }),
        Button2 = Roact.createElement(Button, {
            textButton = {
                Text = 'Burst', TextSize = 16, FontFace = Font.new('rbxasset://fonts/families/JosefinSans.json', Enum.FontWeight.Bold),
                [Roact.Event.MouseButton1Click] = function(pass) print(pass) end,
            },
            LayoutOrder = 2,
        }),
        Button3 = Roact.createElement(Button, {
            textButton = {
                Text = ' + ', TextSize = 16, FontFace = Font.new('rbxasset://fonts/families/JosefinSans.json', Enum.FontWeight.Bold),
            },
            LayoutOrder = 3,
        }),
        Button4 = Roact.createElement(Button, {
            textButton = {
                Text = ' + ', TextSize = 16, FontFace = Font.new('rbxasset://fonts/families/JosefinSans.json', Enum.FontWeight.Bold),
            },
            LayoutOrder = 4,
        }),
        Button5 = Roact.createElement(Button, {
            textButton = {
                AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(1, 0, 0, 300),
                Text = ' + ', TextSize = 16, FontFace = Font.new('rbxasset://fonts/families/JosefinSans.json', Enum.FontWeight.Bold),
            },
            LayoutOrder = 5,
        }),
        Button6 = Roact.createElement(Button, {
            textButton = {
                Text = ' + ', TextSize = 16, FontFace = Font.new('rbxasset://fonts/families/JosefinSans.json', Enum.FontWeight.Bold),
            },
            LayoutOrder = 6,
        }),
        Button7 = Roact.createElement(Button, {
            textButton = {
                Text = ' + ', TextSize = 16, FontFace = Font.new('rbxasset://fonts/families/JosefinSans.json', Enum.FontWeight.Bold),
            },
            LayoutOrder = 7,
        })
    })
end

local function createBoxDummy()
    return Roact.createElement(Box, {
        AnchorPoint = Vector2.new(.5, .5),
        Position = UDim2.new(.5, 0, .5, 0),
        Size = UDim2.new(.5, 0, .6, 0),
        BackgroundColor3 = Color3.fromRGB(118, 214, 255),
        BackgroundTransparency = 0.8,
        backgroundCorner = UDim.new(0, 60),
        
        -- Corner
        -- CornerRadius = UDim.new(0, 20),
        
        -- Shadow
        enableShadow = true,
        -- shadowBackgroundColor3 = Color3.fromRGB(0, 84, 147),
        shadowTransparency = .5,
        shadowOffset = UDim2.new(0, 5, 0, 10),
        shadowCorner = UDim.new(0, 5),
        -- forceRenderShadowFrame = true,

        -- Border
        BorderColor3 = Color3.fromRGB(255, 0, 0),
        -- borderOffset = UDim2.new(0, -3, 0, -10),
        borderThickness = 3,
        borderTransparency = 0.8,
        -- borderCorner = UDim.new(0, 60),
        -- borderLineJoinMode = Enum.LineJoinMode.Round,
        -- borderApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
        -- forceRenderBorderFrame = true,

        -- Padding
        Padding = {
            PaddingLeft = UDim.new(0, 10),
            PaddingTop = UDim.new(0, 20),
            -- PaddingRight = UDim.new(0, 10),
            -- PaddingBottom = UDim.new(0, 10),
        },
    })
end

local function createButtonBaseDummy()
    return Roact.createElement(Box, {
        AnchorPoint = Vector2.new(.5, .5),
        Position = UDim2.new(.5, 0, .5, 0),
        Size = UDim2.new(0, 40, 0, 40),
        BackgroundColor3 = Color3.fromRGB(255, 147, 0),
        -- Corner
        CornerRadius = UDim.new(0.5, 0),
        
        -- Shadow
        enableShadow = true,
        shadowBackgroundColor3 = Color3.fromRGB(148, 82, 0),
        shadowSize = UDim2.new(1, 10, 1, 0),
        shadowOffset = UDim2.new(0, 2, 0, 2),

        -- Border
        BorderColor3 = Color3.fromRGB(255, 0, 0),
        borderSize = UDim2.new(1, 5, 1, -2),
        borderOffset = UDim2.new(0, -3, 0, -10),
        borderThickness = 3,
        -- borderTransparency = 1,
        -- borderCorner = UDim.new(0, 60),
        -- borderLineJoinMode = Enum.LineJoinMode.Round,
        -- borderApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
        -- forceRenderBorderFrame = true,
    })
end

return {
    createModalDummy = createModalDummy,
    createStateModalDummy = createStateModalDummy,
    createStateAndContextualModalDummy = createStateAndContextualModalDummy,
    createHListContainerDummy = createHListContainerDummy,
    createVListContainerDummy = createVListContainerDummy,
    createBoxDummy = createBoxDummy,
    createButtonBaseDummy = createButtonBaseDummy,
}