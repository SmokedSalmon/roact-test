# ImageFrame UI Component

## Overview
Framed Image utilizing `Box` Component and an Image Instance


## Features
- Separated frame and image box style
- Customizable frame padding
- Configurable `background` color and `corner radius`
- Supports image scaling and transparency


## Usage

### Options
- `Image`: The image asset to be displayed.
- `ImageColor3`: The color of the image.
- `ImageTransparency`: The transparency level of the image.
- `ScaleType`: The scaling behavior of the image.
- `FramePadding`: Custom padding for the frame.
- `Background`: Properties for the background, including `BackgroundColor3` and `CornerRadius`. Same as `Box` Component

### Example Codes
```lua
local ImageFrame = require(script.ImageFrame)

local imageFrame = Roact.createElement(ImageFrame, {
    Image = "rbxassetid://123456789",
    ImageColor3 = Color3.fromRGB(255, 255, 255),
    ImageTransparency = 0.5,
    ScaleType = Enum.ScaleType.Stretch,
    FramePadding = {
        PaddingLeft = UDim.new(0, 20),
        PaddingTop = UDim.new(0, 20),
        PaddingRight = UDim.new(0, 20),
        PaddingBottom = UDim.new(0, 20),
    },
    Background = {
        BackgroundColor3 = Color3.fromRGB(118, 214, 255),
        CornerRadius = UDim.new(0, 15),
    },
})
```
