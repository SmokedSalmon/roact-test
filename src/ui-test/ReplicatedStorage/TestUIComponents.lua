local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Roact = require(ReplicatedStorage.Packages.roact)
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)

local Components = ReplicatedStorage.Shared.Components
local AtomicComponents = Components.Atomic
local StoreService = require(ReplicatedStorage.Shared.Store)
local Modal = require(Components.Modal)
local WithCustomBackground = require(AtomicComponents.WithCustomBackground)
local GridContainer = require(AtomicComponents.GridContainer)
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
            FontFace = Font.fromName('JosefinSans'),
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

function TestArsenalCard()
    return Roact.createElement(Card, {
        Padding = {
            PaddingLeft = UDim.new(0, 10),
            PaddingTop = UDim.new(0, 10),
            PaddingRight = UDim.new(0, 10),
            PaddingBottom = UDim.new(0, 10),
        },
    }, {
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
        FontFace = Font.new('JosefinSans', Enum.FontWeight.Bold),
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

return {
    TestMainMenu = TestMainMenu,
    TestArsenalCard = TestArsenalCard,
    TestShadowedSignText = TestShadowedSignText,
}