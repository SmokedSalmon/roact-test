# WithCustomBackground Component
> Deprecated  
> Use `Box` Component with `Background` and `Shadow` properties instead  
> Un-reviewed AI-generated document

## Overview
This component provides a custom background with shadow effects for UI elements in Roblox, allowing for enhanced visual customization.

## Features
- Customizable **background** and **shadow** properties.
- Positioning, offset and sizing.


## Usage

### Create an Instance

To create an instance of `WithCustomBackground`, use the `WithShadowWrapper` function and pass a Roact component as an argument. This wrapper will inject background and shadow frames into the target component.

### Options

- **props.bg**: A table containing properties for the background frame (e.g., `Position`, `Size`, `ZIndex`).
- **props.bg.shadow**: A nested table containing properties for the shadow frame (e.g., `Position`, `Size`, `ZIndex`).
- **Default Properties**:
  - `DefaultPosition`: UDim2.new(0, 0, 0, 0)
  - `DefaultSize`: UDim2.new(1, 0, 1, 0)
  - `DefaultShadowOffset`: UDim2.new(0, 3, 0, 3)

### Example Codes

```lua
local WithShadowWrapper = require(script.WithCustomBackground)

-- Example component to wrap
local MyComponent = Roact.Component:extend("MyComponent")

function MyComponent:render()
    return Roact.createElement("Frame", {
        Size = UDim2.new(0.5, 0, 0.5, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    })
end

-- Wrapping the component with custom background and shadow
local WrappedComponent = WithShadowWrapper(MyComponent)

-- Creating an instance with custom background and shadow properties
local instance = Roact.createElement(WrappedComponent, {
    bg = {
        BackgroundColor3 = Color3.fromRGB(200, 200, 200),
        shadow = {
            BackgroundColor3 = Color3.fromRGB(100, 100, 100),
            Position = UDim2.new(0, 5, 0, 5),
        }
    }
})

-- Mount the instance to the parent
Roact.mount(instance, parent)
```
