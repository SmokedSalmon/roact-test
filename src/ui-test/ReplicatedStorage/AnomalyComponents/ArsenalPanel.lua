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

local Tab = { Tower = 1, Upgrade = 2, Accessory = 3 }

local ArsenalPanel = Roact.PureComponent:extend('ArsenalPanel')

function ArsenalPanel:loadData()
    if self.state.loading then return end

    self:setState(TableUtil.Assign(self.state, {
        loading = true,
        error = '',
    }))

    -- TODO make/use a promise-like helper for such async action
    coroutine.wrap(function()
        task.wait(math.random(30, 60) / 100)
        self:setState(TableUtil.Assign(self.state, {
            loading = false
        }))
    end)()
end

-- Move this to constants or config
local _TowerDef = {
    [1] = {},
    [2] = {},
    [3] = {},
    [4] = {},
    [5] = {},
    [6] = {},
    [7] = {},
    [8] = {},
    [9] = {},
    [10] = {},
    [11] = {},
}
local _UpgradeDef = {
    [1] = {},
    [2] = {},
    [3] = {},
}
local _AccessoryDef = {
    [1] = {},
    [2] = {},
    [3] = {},
    [4] = {},
    [5] = {},
}

local function TowerCards(history, status)
    local cards = {}
    local _status = status or {}
    for i = 1, #_TowerDef do
        cards[`Card{i}`] = ItemCard({
            active = _status[i],
            LayoutOrder = i - 1,
            Event = {
                Activated = function() history:push('/itemDetail') end
            }
        })
    end

    return Roact.createFragment(cards)
end

local function UpgradeCards(history, status)
    local cards = {}
    local _status = status or {}
    for i = 1, #_UpgradeDef do
        cards[`Card{i}`] = ItemCard({
            active = _status[i],
            LayoutOrder = i - 1,
            Event = {
                Activated = function() history:push('/itemDetail') end
            }
        })
    end

    return Roact.createFragment(cards)
end

local function AccessoryCards(history, status)
    local cards = {}
    local _status = status or {}
    for i = 1, #_AccessoryDef do
        cards[`Card{i}`] = ItemCard({
            active = _status[i],
            LayoutOrder = i - 1,
            Event = {
                Activated = function() history:push('/itemDetail') end
            }
        })
    end

    return Roact.createFragment(cards)
end

local function MainContent(contentProps: {})
    local Cards
    if contentProps.tab == Tab.Upgrade then
        Cards = UpgradeCards(contentProps.history, contentProps.owned.upgrades)
    elseif contentProps.tab == Tab.Accessory then
        Cards = AccessoryCards(contentProps.history, contentProps.owned.accessories)
    else
        Cards = TowerCards(contentProps.history, contentProps.owned.towers)
    end
    return Roact.createElement(GridContainer, {
        Position = UDim2.new(0.1, 0, 0.15, 0),
        Size = UDim2.new(0.9, 0, 0.85, 0),
    }, {
        Cards,
    })
end

function ArsenalPanel:init()
    self:loadData()
    self:setState({
        tab = Tab.Tower,
    })
end

function ArsenalPanel:render()
    local history = self.props.history
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
                Event = {
                    Activated = function()
                        self:setState({ tab = Tab.Tower })
                        self:loadData()
                    end
                },
            }),
            Button2 = PanelTabButton({
                Button = { Text = 'Upgrades' },
                Square = { BackgroundColor3 = Color3.fromRGB(212, 251, 121) },
                Event = {
                    Activated = function()
                        self:setState({ tab = Tab.Upgrade })
                        self:loadData()
                    end
                },
            }),
            Button3 = PanelTabButton({
                Button = { Text = 'Accessories' },
                Square = { BackgroundColor3 = Color3.fromRGB(255, 212, 121) },
                Event = {
                    Activated = function()
                        self:setState({ tab = Tab.Accessory })
                        self:loadData()
                    end
                },
            }),
            Button4 = PanelTabButton({
                Button = { Text = 'Back' },
                Square = { BackgroundColor3 = Color3.fromRGB(208, 31, 31) },
                Event = {
                    Activated = function() history:goBack() end
                }
            }),
        }),
        self.state.loading
            and Roact.createElement('TextLabel', { Text = 'Loading ...' })
            or MainContent({
                history = self.props.history,
                owned = self.props.owned,
                tab = self.state.tab,
            })
    })
end

-- Connect Client UI Global State
local ArsenalPanelWithUIState = UIState.WithUIState(
    ArsenalPanel,
    function(state)
        return {
            owned = table.clone(state.owned)
        }
    end,
    function(dispatch)
        return {}
    end
)

return ArsenalPanelWithUIState
