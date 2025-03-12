# Box Component

## Overview
Basic container component, Highly Customizable, including **background**, **border**, **shadow**, **corner radius**, **scrolling**, **padding** and other similar features of HTML `<div>` element.  
It provides a flexible way to create styled containers in Roblox UI


## Features
- Customizable **background** with color, **transparency**, and **image** support.
- Configurable **borders** with **thickness**, **color**, and **transparency**.
- Shadow support with **offset**, **size**, and **corner radius**.
- Padding
- Scrolling
- Automatic handling of corner radius and border rendering.


## Usage

### Create an Instance
To create an instance of the Box component, you need to use Roact and pass the required properties to the component.

### Options
- `Background`: Table with properties for background color (`Color3`), transparency, rotation, and corner radius.
- `Border`: Table with properties for border color, thickness, transparency, and additional styling options.
- `Shadow`: Table with properties for shadow color, transparency, offset, and size.
- `Padding`: UDim padding values.
- `Scroll`: Enable scrolling with additional scrolling properties.
- `AutomaticSize`: Set automatic size behavior.
- Other standard Roact Frame properties.

### Example Codes
```lua
local Box = require(path_to_Box)

-- Basic Box with background and border
local boxInstance = Roact.createElement(Box, {
    Background = {
        Color3 = Color3.fromRGB(255, 255, 255),
        Transparency = 0.5,
        CornerRadius = UDim.new(0, 10)
    },
    Border = {
        Color = Color3.fromRGB(0, 0, 0),
        Thickness = 2,
        Transparency = 0.2
    },
    Size = UDim2.new(0, 200, 0, 100),
    Position = UDim2.new(0.5, -100, 0.5, -50)
})

-- Box with shadow and padding
local boxWithShadow = Roact.createElement(Box, {
    Background = {
        Color3 = Color3.fromRGB(200, 200, 255),
        Transparency = 0
    },
    Shadow = {
        Color3 = Color3.fromRGB(0, 0, 0),
        Transparency = 0.5,
        Offset = UDim2.new(0, 5, 0, 5)
    },
    Padding = {
        PaddingTop = UDim.new(0, 10),
        PaddingBottom = UDim.new(0, 10),
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10)
    },
    Size = UDim2.new(0, 300, 0, 200),
    Position = UDim2.new(0.5, -150, 0.5, -100)
})
```
