# Card Component

## Overview
A styled (Lego-Themed) Box with predefined rotation and dynamic transparency

## Features
- Slightly cocked with random rotation
- Dynamic transparency based on the `active` prop
- Same options with `Box` Component


## Usage

### Options
- `active` (boolean): Sets the transparency of the card. If `true`, the card will be fully transparent; otherwise, it will have 50% transparency.


### Example Codes
```lua
local Roact = require(ReplicatedStorage.Packages.roact)
local Card = require(ReplicatedStorage.Card)

local function App()
    return Roact.createElement(Card, {
        active = true,
        BackgroundColor3 = Color3.fromRGB(255, 200, 100),
        Border = {
            Thickness = 4,
            CornerRadius = UDim.new(0, 10)
        },
        Name = "ExampleCard"
    }, {
        Roact.createElement("TextLabel", {
            Text = "Hello, World!",
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1
        })
    })
end

local handle = Roact.mount(App(), workspace, "App")
```
