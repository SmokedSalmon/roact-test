# Icon Component

## Overview
A versatile Roact element designed to display icons with customizable styling and padding options.


## Features
- Padding and automatic sizing.
- Supports **background**, **border**, and **shadow** configuration.
- Compatible with Roblox's ImageLabel for icon display.


## Usage

### Create an Instance
To create an instance of the Icon component, you need to import it and pass the required props to the component.

### Options
The Icon component accepts the following props:

| Prop Name | Type | Description |
|-----------|------|-------------|
| `Padding` | `UDim` or `table` | Custom padding for the component. Can be a table with `PaddingLeft`, `PaddingTop`, `PaddingRight`, and `PaddingBottom` properties,  same as `Box` Component |
| `Background` | `Color3` or `nil` | Background color,  same as `Box` Component |
| `Border` | `table` or `nil` | Border properties, same as `Box` Component. |
| `Shadow` | `table` or `nil` | Shadow properties, same as `Box` Component. |
| `AnchorPoint` | `Vector2` | Anchor point of the component. |
| `Position` | `UDim2` | Position of the component. |
| `Size` | `UDim2` | Size of the component. |
| `Image` | `string` | Path to the icon image. |
| `ScaleType` | `Enum.ScaleType` | Scaling behavior of the icon image. |

### Example Codes
```lua
local Icon = require(path.to.Icon)

local iconInstance = Roact.createElement(Icon, {
    Padding = {
        PaddingLeft = UDim.new(0, 10),
        PaddingTop = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10),
        PaddingBottom = UDim.new(0, 10)
    },
    Background = Color3.fromRGB(255, 255, 255),
    Border = {
        Color = Color3.fromRGB(0, 0, 0),
        Size = 1
    },
    Shadow = {
        Offset = Vector2.new(2, 2),
        Transparency = 0.5
    },
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.new(0, 50, 0, 50),
    Image = "rbxassetid://123456789",
    ScaleType = Enum.ScaleType.Fit
})
```
