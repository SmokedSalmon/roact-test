# MButton Component Documentation

## Overview
Button Component with text and icon  
Currently the layout for the icon and text is hard-coded, it could be configured slightly via the `Layout` option  
Will be further developed for future requirement

## Features
- Configurable layout and alignment.
- Customizable button properties.

## Usage

### Create an Instance

#### Options
- `Button`: A table containing properties for the button (e.g., `Size`, `AnchorPoint`).  
  Same as `Button` Component
- `Button.Icon`: A table containing properties for the icon.  
  Same as `Icon` Component
- `Layout`: A table containing properties for the layout (e.g., `FillDirection`, `HorizontalAlignment`).

#### Example Codes
```lua
local MButton = require(path.to.MButton)

local buttonInstance = Roact.createElement(MButton, {
    Button = {
        Size = UDim2.new(0, 200, 0, 50),
        Text = "Click Me",
        Icon = {
            Image = "rbxassetid://123456789",
            Size = UDim2.new(0, 20, 0, 20),
        },
    },
    Layout = {
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Center,
    },
})
```
