# Border Component Documentation
> Maybe `Deprecated` as `Box` Component provides `Board` options to support all it features

## Overview
UI element that provides a customizable border with rounded corners for any Roblox UI frame.


## Features
- Customizable **border thickness** and **corner radius**.
- Utilizes `UIStroke` and `UICorner` for rendering borders and rounded corners.
- Overrides `BackgroundTransparency` to ensure borders are rendered correctly.


## Usage

### Create an Instance
To create an instance of the Border component, you need to use Roact and pass the necessary properties to the component.

### Options
- `Name`: The name of the Border instance (optional).
- `Position`: The position of the Border instance (default is `UDim2.new(0, 0, 0, 0)`).
- `Size`: The size of the Border instance (default is `UDim2.new(1, 0, 1, 0)`).
- `CornerRadius`: The corner radius of the border (default is `UDim.new(0, 5)`).
- `BorderThickness`: The thickness of the border (default is `1`).
- `ZIndex`: The Z-index of the Border instance (default is `10`).

### Example Codes

```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Packages.roact)
local Border = require(ReplicatedStorage.Border)

local function App()
    return Roact.createElement("ScreenGui", {}, {
        Border = Roact.createElement(Border, {
            Name = "MyBorder",
            Position = UDim2.new(0.5, -100, 0.5, -50),
            Size = UDim2.new(0, 200, 0, 100),
            CornerRadius = UDim.new(0, 10),
            BorderThickness = 2,
        })
    })
end

local handle = Roact.mount(Roact.createElement(App), game.Players.LocalPlayer:WaitForChild("PlayerGui"))
```
