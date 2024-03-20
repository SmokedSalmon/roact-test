local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Roact = require(ReplicatedStorage.Packages.roact)

local Components = ReplicatedStorage.Components
local AtomicComponents = Components.Atomic
local Modal = require(Components.Modal)
local WithCustomBackground = require(AtomicComponents.WithCustomBackground)
local GridContainer = require(AtomicComponents.GridContainer)
local Card = require(Components.Card)
local Button = require(Components.Button)
local ListContainer = require(AtomicComponents.ListContainer)

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

return {
    createHListContainerDummy = createHListContainerDummy,
    createVListContainerDummy = createVListContainerDummy,
}