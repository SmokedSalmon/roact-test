# WithEvents Component

## Overview
Syntax Sugar/Utility to wrap a Roact components with a single option - `Event` to inject event handlers, simplifying event binding without directly using `Roact.Event`

## Features
- Compatible with all Roact Events


## Usage
### Create an Instance
Wrap your target component using the `WithEvents` function, which takes a Roact component or a string reference to a component as its argument.

### Options
- **WrappedComponent**: The component to be wrapped with event handling capabilities. Can be a Roact component or a string reference to a component.
- **Event**: A table containing event names as keys and their corresponding handler functions as values. This table is automatically processed and injected into the wrapped component.

### Example Codes
```lua
-- Import the WithEventsWrapper utility
local WithEvents = require(script.WithEvents)

-- Define a sample component to be wrapped
local function SampleComponent(props)
    return Roact.createElement("TextLabel", {
        Text = "Click Me!",
        Size = UDim2.fromScale(0.5, 0.5)
    })
end

-- Wrap the component with WithEvents
local ComponentWithEvents = WithEvents(SampleComponent)

-- Create an instance with event handlers
local instance = Roact.createElement(ComponentWithEvents, {
    Event = {
        MouseButton1Click = function(rbx)
            print("Button clicked by Mouse Button 1!")
        end,
        Activated = function()
            print("Button clicked!")
        end
    }
})
> Simply pass the handler with the correspondent [`Roact.EVENT_NAME`](https://roblox.github.io/roact/guide/events/) as the key of the `Event` property upon element creations

-- Render the instance
Roact.mount(instance, game.Players.LocalPlayer.PlayerGui)
```
