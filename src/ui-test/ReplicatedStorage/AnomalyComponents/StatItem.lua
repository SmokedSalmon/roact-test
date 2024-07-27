--[[
    Stat Value Item
]]
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Roact = require(ReplicatedStorage.Packages.roact)
local Box = require(ReplicatedStorage.Shared.Components.Atomic.Box)

-- Constants & Configs

local StatItem = Roact.Component:extend('StatItem')

function StatItem()
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
                AutomaticSize = Enum.AutomaticSize.None,
                Position = UDim2.new(0, 0, 0.15, 0),
                Size = UDim2.new(0, 40, 0, 40),
            }, {
                Img = Roact.createElement('ImageLabel', {
                    Position = UDim2.new(0, 5, 0, -5),
                    Size = UDim2.new(1, 0, 1, 0),
                    Image = 'rbxassetid://13384578429',
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    ScaleType = Enum.ScaleType.Crop,
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

return StatItem
