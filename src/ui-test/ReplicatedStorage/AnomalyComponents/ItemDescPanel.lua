--[[
    2nd-level Menu - Arsenal Panel
]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Roact = require(ReplicatedStorage.Packages.roact)
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
local UIState = require(ReplicatedStorage.UIState)

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
local TButton = require(Components.TButton)

local ItemDescPanel = Roact.PureComponent:extend('ItemDescPanel')

local function ActionButton(props: {}?)
    local _props = props or {}
    return Roact.createElement(TButton, {
        AutomaticSize = Enum.AutomaticSize.XY,
        Size = UDim2.new(0, 0, 0, 0),
        Text = _props.Text or 'Button',
        TextSize = 20,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        FontFace = Font.fromName('Bangers'),
        Padding = {
            PaddingLeft = UDim.new(0, 10),
            PaddingTop = UDim.new(0, 10),
            PaddingRight = UDim.new(0, 10),
            PaddingBottom = UDim.new(0, 10),
        },
        Background = {
            CornerRadius = _props.CornerRadius or UDim.new(0, 5),
            Color3 = _props.Color3 or Color3.fromRGB(0, 192, 255),
        },
        Shadow = {
            Color3 = _props.ShadowColor3 or Color3.fromRGB(0, 124, 166)
        },
        Event = _props.Event,
    })
end


function ItemDescPanel:render()
    local history = self.props.history
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
                Row3 = Roact.createElement(ColumnContainer, {
                    AutomaticSize = Enum.AutomaticSize.X,
                    Size = UDim2.new(0, 0, 0.15, 0),
                    Scroll = false,
                    Layout = {
                        Padding = UDim.new(0, 20),
                    }
                }, {
                    Buy = ActionButton({
                        Text = 'Buy',
                        Color3  =Color3.fromRGB(0, 192, 255),
                        ShadowColor3 = Color3.fromRGB(0, 124, 166),
                        Event = {
                            Activated = function() print('Bought') end,
                        },
                    }),
                    Cancel = ActionButton({
                        Text = 'Cancel',
                        Color3  =Color3.fromRGB(255, 0, 0),
                        ShadowColor3 = Color3.fromRGB(114, 2, 2),
                        Event = {
                            Activated = function() history:goBack() end,
                        },
                    }),
                })
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

-- Connect Client UI Global State
local ItemDescPanelWithUIState = UIState.WithUIState(
    ItemDescPanel,
    function(state)
        return {}
    end,
    function(dispatch)
        return {}
    end
)

return ItemDescPanelWithUIState
