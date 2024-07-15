local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Roact = require(ReplicatedStorage.Packages.roact)
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)

local Components = ReplicatedStorage.Shared.Components
local AtomicComponents = Components.Atomic
local StoreService = require(ReplicatedStorage.Shared.Store)
local Modal = require(Components.Modal)
local WithCustomBackground = require(AtomicComponents.WithCustomBackground)
local GridContainer = require(Components.GridContainer)
local RowContainer = require(Components.RowContainer)
local ColumnContainer = require(Components.ColumnContainer)
local Card = require(Components.Card)
local ColorSquareButton = require(script.Parent.ColorSquareButton)
local ItemCard = require(script.Parent.ItemCard)
local ShadowedSign = require(script.Parent.ShadowedSign)
local PanelTabButton = require(script.Parent.PanelTabButton)
local StatItem = require(script.Parent.StatItem)
local DescGallery = require(script.Parent.DescGallery)
local ListContainer = require(AtomicComponents.ListContainer)
local Box = require(AtomicComponents.Box)

function EntryMenu(props)
    local history = props.history
    return Roact.createElement(Box, {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0.5, 0, 0.8, 0),
    }, {
        List = Roact.createElement(Box, {
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.new(0.5, 0, 0, 0),
            Size = UDim2.new(1, 0, 1, 0),
        }, {
            UIListLayout = Roact.createElement('UIListLayout', {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center,
            }, {}),
            Button1 = Roact.createElement(ColorSquareButton, {
                Button = { Text = 'Play' },
                Square = { BackgroundColor3 = Color3.fromRGB(115, 253, 255) },
                Size = UDim2.new(1, 0, 0, 60),
                Event = {
                    Activated = function() history:push('/play') end
                },
            }),
            Button2 = Roact.createElement(ColorSquareButton, {
                Button = { Text = 'Arsenal' },
                Square = { BackgroundColor3 = Color3.fromRGB(212, 251, 121) },
                Size = UDim2.new(1, 0, 0, 60),
                Event = {
                    Activated = function() history:push('/arsenal') end
                },
            }),
            Button3 = Roact.createElement(ColorSquareButton, {
                Button = { Text = 'Encyclopedia' },
                Square = { BackgroundColor3 = Color3.fromRGB(255, 212, 121) },
                Size = UDim2.new(1, 0, 0, 60),
                Event = {
                    Activated = function() history:push('/encyclopedia') end
                },
            }),
        })
    })
end

function PlayMenu(routeProps)
    local history = routeProps.history
    return Roact.createElement(Box, {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0.5, 0, 0.8, 0),
    }, {
        List = Roact.createElement(Box, {
            AnchorPoint = Vector2.new(0.5, 0),
            Position = UDim2.new(0.5, 0, 0, 0),
            Size = UDim2.new(1, 0, 1, 0),
        }, {
            UIListLayout = Roact.createElement('UIListLayout', {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                VerticalAlignment = Enum.VerticalAlignment.Center,
            }, {}),
            Button1 = Roact.createElement(ColorSquareButton, {
                Button = { Text = 'Tutorial' },
                Square = { BackgroundColor3 = Color3.fromRGB(115, 253, 255) },
                Size = UDim2.new(1, 0, 0, 60)
            }),
            Button2 = Roact.createElement(ColorSquareButton, {
                Button = { Text = 'New Campaign' },
                Square = { BackgroundColor3 = Color3.fromRGB(212, 251, 121) },
                Size = UDim2.new(1, 0, 0, 60)
            }),
            Button3 = Roact.createElement(ColorSquareButton, {
                Button = { Text = 'Continue' },
                Square = { BackgroundColor3 = Color3.fromRGB(255, 212, 121) },
                Size = UDim2.new(1, 0, 0, 60)
            }),
            Button4 = Roact.createElement(ColorSquareButton, {
                Button = { Text = 'Select Level' },
                Square = { BackgroundColor3 = Color3.fromRGB(212, 251, 121) },
                Size = UDim2.new(1, 0, 0, 60),
                Event = {
                    Activated = function() history:push('/play/level') end
                }
            }),
        })
    })
end

function LevelPanel()
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
        SignLabel = Roact.createElement(ShadowedSign, {
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
            Button1 = PanelTabButton({
                Button = { Text = 'Basics' },
                Square = { BackgroundColor3 = Color3.fromRGB(115, 253, 255) },
            }),
            Button2 = PanelTabButton({
                Button = { Text = 'Block Them Up' },
                Square = { BackgroundColor3 = Color3.fromRGB(212, 251, 121) },
            }),
            Button3 = PanelTabButton({
                Button = { Text = 'Combos, Tech-up' },
                Square = { BackgroundColor3 = Color3.fromRGB(255, 212, 121) },
            }),
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
                Scroll = false,
            }, {
                Card1 = LevelCard(),
                Card2 = LevelCard(),
                Card3 = LevelCard(),
                Card4 = LevelCard(),
            }),
            Row3 = Roact.createElement(ColumnContainer, {
                AutomaticSize = Enum.AutomaticSize.Y,
                Size = UDim2.new(1, 0, 0, 0),
                Scroll = false,
            }, {
                Card1 = LevelCard(),
                Card2 = LevelCard(),
                Card3 = LevelCard(),
            }),
            Row4 = Roact.createElement(ColumnContainer, {
                AutomaticSize = Enum.AutomaticSize.Y,
                Size = UDim2.new(1, 0, 0, 0),
                Scroll = false,
            }, {
                Card1 = LevelCard(),
                Card2 = LevelCard(),
                Card3 = LevelCard(),
            }),
            Row5 = Roact.createElement(ColumnContainer, {
                AutomaticSize = Enum.AutomaticSize.Y,
                Size = UDim2.new(1, 0, 0, 0),
                Scroll = false,
            }, {
                Card1 = LevelCard(),
                Card2 = LevelCard(),
                Card3 = LevelCard(),
            }),
        })
    })
end

function ArsenalPanel(routeProps)
    local history = routeProps.history
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
        SignLabel = Roact.createElement(ShadowedSign, {
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
            Button1 = PanelTabButton({
                Button = { Text = 'Towers' },
                Square = { BackgroundColor3 = Color3.fromRGB(115, 253, 255) },
            }),
            Button2 = PanelTabButton({
                Button = { Text = 'Upgrades' },
                Square = { BackgroundColor3 = Color3.fromRGB(212, 251, 121) },
            }),
            Button3 = PanelTabButton({
                Button = { Text = 'Accessories' },
                Square = { BackgroundColor3 = Color3.fromRGB(255, 212, 121) },
            }),
        }),
        -- Test Grid Container
        Container1 = Roact.createElement(GridContainer, {
            Position = UDim2.new(0.1, 0, 0.15, 0),
            Size = UDim2.new(0.9, 0, 0.85, 0),
        }, {
            Card1 = ItemCard({ Event = {
                Activated = function() history:push('/itemDetail') end
            }}),
            Card2 = ItemCard({ Event = {
                Activated = function() history:push('/itemDetail') end
            }}),
            Card3 = ItemCard({ Event = {
                Activated = function() history:push('/itemDetail') end
            }}),
            Card4 = ItemCard({ Event = {
                Activated = function() history:push('/itemDetail') end
            }}),
            Card5 = ItemCard({ Event = {
                Activated = function() history:push('/itemDetail') end
            }}),
            Card6 = ItemCard({ Event = {
                Activated = function() history:push('/itemDetail') end
            }}),
            Card7 = ItemCard({ Event = {
                Activated = function() history:push('/itemDetail') end
            }}),
            Card8 = ItemCard({ Event = {
                Activated = function() history:push('/itemDetail') end
            }}),
            Card9 = ItemCard({ Event = {
                Activated = function() history:push('/itemDetail') end
            }}),
            Card10 = ItemCard({ Event = {
                Activated = function() history:push('/itemDetail') end
            }}),
            Card11 = ItemCard({ Event = {
                Activated = function() history:push('/itemDetail') end
            }}),
        })
    })
end

function LevelCard()
    return ItemCard({
        Size = UDim2.new(0, 160, 0, 100 ),
        Padding = {
            PaddingLeft = UDim.new(0, 10),
            PaddingTop = UDim.new(0, 10),
            PaddingRight = UDim.new(0, 10),
            PaddingBottom = UDim.new(0, 10),
        }
    })
end

function DescPanel()
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
            SignLabel = Roact.createElement(ShadowedSign, {
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
                    StatCard1 = StatItem(),
                    StatCard2 = StatItem(),
                    StatCard3 = StatItem(),
                    StatCard4 = StatItem(),
                    StatCard5 = StatItem(),
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
        }),
        RightPanel = Roact.createElement(DescGallery, {
            Position = UDim2.new(0.5, 0, 0, 0),
            Size = UDim2.new(0.5, 0, 1, 0),
            Image1 = {
                FramePadding = {
                    PaddingLeft = UDim.new(0, 10),
                    PaddingTop = UDim.new(0, 10),
                    PaddingRight = UDim.new(0, 10),
                    PaddingBottom = UDim.new(0, 50),
                },
                Background = {
                    Color3 = Color3.fromRGB(118, 214, 255),
                },
                Shadow = {
                    Color3 = Color3.fromRGB(0, 84, 147),
                },
                Image = 'rbxasset://textures/ui/GuiImagePlaceholder.png',
            },
        }),
    })
end

return {
    EntryMenu = EntryMenu,
    PlayMenu = PlayMenu,
    ArsenalPanel = ArsenalPanel,
    LevelPanel = LevelPanel,
    DescPanel = DescPanel,
}