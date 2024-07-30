local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Roact = require(ReplicatedStorage.Packages.roact)
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)

local Components = ReplicatedStorage.Modules.Components
local AtomicComponents = Components.Atomic
local StoreService = require(ReplicatedStorage.Modules.Store)
local Modal = require(Components.Modal)
local WithCustomBackground = require(AtomicComponents.WithCustomBackground)
local GridContainer = require(Components.GridContainer)
local RowContainer = require(Components.RowContainer)
local ColumnContainer = require(Components.ColumnContainer)
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
            FontFace = Font.new('rbxasset://fonts/families/JosefinSans.json'),
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

local function TestTabButton(props: {})
    if not props then
        error('Missing props for button')
    end
    return Roact.createElement(Button, {
        Button = {
            Text = props.Text,
            FontFace = Font.new('rbxasset://fonts/families/JosefinSans.json'),
            TextSize = 26,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Center,
        },
        Event = {
            Activated = function() print('Pressed') end,
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

function TestItemCard(cardProps: {}?)
    local _props = TableUtil.Assign({
        Padding = {
            PaddingLeft = UDim.new(0, 10),
            PaddingTop = UDim.new(0, 10),
            PaddingRight = UDim.new(0, 10),
            PaddingBottom = UDim.new(0, 10),
        }
    }, cardProps)
    return Roact.createElement(Card, cardProps, {
        Infos = Roact.createElement(Box, {
            Position = UDim2.new(0.3, 0, 0.35, 0),
            Size = UDim2.new(0.7, 0, 0.65, 0),
        }, {
            UIListLayout = Roact.createElement('UIListLayout', {
                FillDirection = Enum.FillDirection.Vertical,
            }),
            Label1 = Roact.createElement('TextLabel', {
                Size = UDim2.new(1, 0, 0, 20),
                BackgroundTransparency = 1,
                Text = 'Label',
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Center,
                TextYAlignment = Enum.TextYAlignment.Center
            }),
            Label2 = Roact.createElement('TextLabel', {
                Size = UDim2.new(1, 0, 0, 20),
                BackgroundTransparency = 1,
                Text = 'Label',
                TextSize = 14,
                TextYAlignment = Enum.TextYAlignment.Center
            }),
        })
    })
end

function TestShadowedSignText(props: {}?)
    local DefaultProps = {
        Name = 'ShadowedSign',
        BackgroundTransparency = 1,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0, 0),
        Size = UDim2.new(0, 200, 0, 50),
        Color = Color3.fromRGB(255, 255, 255),
        ShadowColor = Color3.fromRGB(115, 250, 121),
        FontFace = Font.new('rbxasset://fonts/families/JosefinSans.json', Enum.FontWeight.Bold),
        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Center,
    }
    local _props = TableUtil.Assign(DefaultProps, props or {})
    _props.TextColor3 = _props.ShadowColor
    _props.ShadowColor = nil
    local _props2 = table.clone(_props)
    _props2.Position = UDim2.new(0.5, -3, 0.5, -3)
    _props2.Name = 'TopText'
    _props2.TextColor3 = _props2.Color
    _props.Color = nil
    _props2.Color = nil
    
    return Roact.createElement('TextLabel', _props, {
        UIStroke = Roact.createElement('UIStroke', {
            Color = _props.TextColor3,
            Thickness = 2,
        }),
        Top = Roact.createElement('TextLabel', _props2)
    })
end

function TestArsenalPage()
    return Roact.createElement(Box, {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0.7, 0, 0.7, 0),
        Background = {
            Color3 = Color3.fromRGB(118, 214, 255),
            CornerRadius = UDim.new(0, 15),
        },
        Shadow = {
            Color3 = Color3.fromRGB(0, 84, 147),
            Offset = UDim2.new(0, 5, 0, 5)
        }
    }, {
        
        -- Panel Sign
        SignLabel = Roact.createElement(TestShadowedSignText, {
            Text = 'Arsenal',
            TextSize = 50,
            Color = Color3.fromRGB(255, 255, 255),
            ShadowColor = Color3.fromRGB(115, 250, 121),
        }),
        -- Left Tab
        LeftTab = Roact.createElement(Box, {
            Position = UDim2.new(-0.15, 0, 0.2, 0),
            Size = UDim2.new(0.3, 0.85),
        }, {
            UIListLayout = Roact.createElement('UIListLayout', {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
            }),
            Button1 = TestTabButton({ Text = 'Play' }),
            Button2 = TestTabButton({ Text = 'Arsenal' }),
            Button3 = TestTabButton({ Text = 'Encyclopedia' }),
        }),
        -- Test Grid Container
        Container1 = Roact.createElement(GridContainer, {
            Position = UDim2.new(0.1, 0, 0.15, 0),
            Size = UDim2.new(0.9, 0, 0.85, 0),
        }, {
            Card1 = TestItemCard(),
            Card2 = TestItemCard(),
            Card3 = TestItemCard(),
            Card4 = TestItemCard(),
            Card5 = TestItemCard(),
            Card6 = TestItemCard(),
            Card7 = TestItemCard(),
            Card8 = TestItemCard(),
            Card9 = TestItemCard(),
            Card10 = TestItemCard(),
            Card11 = TestItemCard(),
        })
    })
end

function TestLevelCard()
    return TestItemCard({
        Size = UDim2.new(0, 160, 0, 100 ),
        Padding = {
            PaddingLeft = UDim.new(0, 10),
            PaddingTop = UDim.new(0, 10),
            PaddingRight = UDim.new(0, 10),
            PaddingBottom = UDim.new(0, 10),
        }
    })
end

function TestLevelPage()
    return Roact.createElement(Box, {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0.7, 0, 0.7, 0),
        Background = {
            Color3 = Color3.fromRGB(118, 214, 255),
            CornerRadius = UDim.new(0, 5),
        },
        Shadow = {
            Color3 = Color3.fromRGB(0, 84, 147),
            Offset = UDim2.new(0, 5, 0, 5)
        }
    }, {
        -- Panel Sign
        SignLabel = Roact.createElement(TestShadowedSignText, {
            Text = 'Select Level',
            TextSize = 50,
            Color = Color3.fromRGB(255, 255, 255),
            ShadowColor = Color3.fromRGB(115, 250, 121),
        }),
        -- Left Tab
        LeftTab = Roact.createElement(Box, {
            Position = UDim2.new(-0.15, 0, 0.2, 0),
            Size = UDim2.new(0.3, 0.85),
        }, {
            UIListLayout = Roact.createElement('UIListLayout', {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
            }),
            Button1 = TestTabButton({ Text = 'Basics' }),
            Button2 = TestTabButton({ Text = 'Block Them Up' }),
            Button3 = TestTabButton({ Text = 'Combos, Tech-up' }),
        }),
        -- Row/Column Container
        Container1 = Roact.createElement(RowContainer, {
            Position = UDim2.new(0.1, 0, 0.15, 0),
            Size = UDim2.new(0.9, 0, 0.85, 0),
            List = {
                Padding = UDim.new(0, 10),
            }
        }, {
            Row1 = Roact.createElement(Box, {
                AutomaticSize = Enum.AutomaticSize.Y,
                Size = UDim2.new(1, 0, 0, 0),
            }, {
                ChapterDesc = Roact.createElement('TextLabel', {
                    BackgroundTransparency = 1,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Size = UDim2.new(1, 0, 0, 0),
                    Text = 'Integer ante lorem, placerat eu pellentesque non, scelerisque ac libero. Pellentesque ultrices a tortor vitae pharetra. Mauris posuere ipsum ipsum, vel interdum eros malesuada id. Sed rutrum at ligula a vulputate. Aliquam in placerat orci. platea dictumst.',
                    FontFace = Font.fromName('SourceSansPro'),
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Top,
                    TextWrapped = true,
                })
            }),
            Row2 = Roact.createElement(ColumnContainer, {
                AutomaticSize = Enum.AutomaticSize.Y,
                Size = UDim2.new(1, 0, 0, 0),
            }, {
                Card1 = TestLevelCard(),
                Card2 = TestLevelCard(),
                Card3 = TestLevelCard(),
                Card4 = TestLevelCard(),
                Card5 = TestLevelCard(),
            }),
            Row3 = Roact.createElement(ColumnContainer, {
                AutomaticSize = Enum.AutomaticSize.Y,
                Size = UDim2.new(1, 0, 0, 0),
            }, {
                Card1 = TestLevelCard(),
                Card2 = TestLevelCard(),
                Card3 = TestLevelCard(),
            }),
            Row4 = Roact.createElement(ColumnContainer, {
                AutomaticSize = Enum.AutomaticSize.Y,
                Size = UDim2.new(1, 0, 0, 0),
            }, {
                Card1 = TestLevelCard(),
                Card2 = TestLevelCard(),
                Card3 = TestLevelCard(),
            }),
            Row5 = Roact.createElement(ColumnContainer, {
                AutomaticSize = Enum.AutomaticSize.Y,
                Size = UDim2.new(1, 0, 0, 0),
            }, {
                Card1 = TestLevelCard(),
                Card2 = TestLevelCard(),
                Card3 = TestLevelCard(),
            }),
        })
    })
end

-- Description Popup/Page
local function TestStatItem()
    return Roact.createElement(Box, {
        Size = UDim2.new(1/3, 0, 0, 60),
        Padding = {
            PaddingLeft = UDim.new(0, 5),
            PaddingRight = UDim.new(0, 5),
        }
    }, {
        StatBG = Roact.createElement(Box, {
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new(0, 0, 0.6, 0),
            Size = UDim2.new(1, 0, 0, 30),
            Background = {
                Color3 = Color3.fromRGB(255, 126, 121),
                CornerRadius = UDim.new(0, 10),
            },
            ZIndex = -10,
        }),
        Content = Roact.createElement(Box, {
            Size = UDim2.new(1, 0, 1, 0),
        }, {
            Icon = Roact.createElement(Box, {
                AutomaticSize = Enum.AutomaticSize.Y,
                Position = UDim2.new(0, 0, 0.15, 0),
                Size = UDim2.new(0, 40, 0, 40),
            }, {
                Img = Roact.createElement('ImageLabel', {
                    Position = UDim2.new(0, 5, 0, -5),
                    Size = UDim2.new(1, 0, 1, 0),
                    Image = 'rbxassetid://13384578429',
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                })
            }),
            Value = Roact.createElement('TextLabel', {
                Text = '25.06',
                AnchorPoint = Vector2.new(1, 0.5),
                AutomaticSize = Enum.AutomaticSize.XY,
                Position = UDim2.new(0.95, 0, 0.6, 0),
                Size = UDim2.new(0.7, 0, 0, 0),
                FontFace = Font.fromName('Bangers'),
                TextSize = 24,
                TextColor3 = Color3.fromRGB(255, 255, 255),
                TextXAlignment = Enum.TextXAlignment.Right,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
            })
        })
    })
end

function TestDescPage()
    local _leftRotation = -2
    local _rightRotation = 1
    return Roact.createElement(Box, {
        Size = UDim2.new(1, 0, 1, 0),
    }, {
        LeftPanel = Roact.createElement(Box, {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.308, 0, 0.5, 0),
            Size = UDim2.new(0.416, 0, 0.8, 0),
            Background = {
                Color3 = Color3.fromRGB(118, 214, 255),
                Rotation = _leftRotation,
                CornerRadius = UDim.new(0, 5),
            },
            Shadow = {
                Color3 = Color3.fromRGB(0, 84, 147),
                Offset = UDim2.new(0, 5, 0, 5),
                Rotation = _leftRotation + 1,
            },
        }, {
            SignLabel = Roact.createElement(TestShadowedSignText, {
                Text = 'Dart-Tower',
                TextSize = 50,
                Color = Color3.fromRGB(255, 255, 255),
                ShadowColor = Color3.fromRGB(115, 250, 121),
            }),
            Container1 = Roact.createElement(RowContainer, {
                Position = UDim2.new(0.1, 0, 0.15, 0),
                Size = UDim2.new(0.9, 0, 0.85, 0),
                List = {
                    Padding = UDim.new(0, 10),
                    VerticalFlex = Enum.UIFlexAlignment.None,
                }
            }, {
                Row1 = Roact.createElement(Box, {
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Position = UDim2.new(0, 0, 0, 0),
                    Size = UDim2.new(1, 0, 0, 0),
                }, {
                    UIListLayout = Roact.createElement('UIListLayout', {
                        FillDirection = Enum.FillDirection.Horizontal,
                        HorizontalFlex = Enum.UIFlexAlignment.SpaceEvenly,
                        VerticalFlex = Enum.UIFlexAlignment.None,
                        Wraps = true,
                    }),
                    StatCard1 = TestStatItem(),
                    StatCard2 = TestStatItem(),
                    StatCard3 = TestStatItem(),
                    StatCard4 = TestStatItem(),
                    StatCard5 = TestStatItem(),
                }),
                Row2 = Roact.createElement(Box, {
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Size = UDim2.new(1, 0, 0, 0),
                }, {
                    TowerDesc = Roact.createElement('TextLabel', {
                        BackgroundTransparency = 1,
                        AutomaticSize = Enum.AutomaticSize.Y,
                        Size = UDim2.new(1, 0, 0, 0),
                        Text = 'Integer ante lorem, placerat eu pellentesque non, scelerisque ac libero. Pellentesque ultrices a tortor vitae pharetra. Mauris posuere ipsum ipsum, vel interdum eros malesuada id. Sed rutrum at ligula a vulputate. Aliquam in placerat orci. platea dictumst.',
                        FontFace = Font.fromName('SourceSansPro'),
                        TextSize = 14,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextYAlignment = Enum.TextYAlignment.Top,
                        TextWrapped = true,
                    })
                }),
            }),
        })
    })
end

return {
    TestTabButton = TestTabButton,
    TestMainMenu = TestMainMenu,
    TestItemCard = TestItemCard,
    TestShadowedSignText = TestShadowedSignText,
    TestArsenalPage = TestArsenalPage,
    TestLevelPage = TestLevelPage,
    TestDescPage = TestDescPage,
}