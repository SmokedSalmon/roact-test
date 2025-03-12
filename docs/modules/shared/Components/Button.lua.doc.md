# Button Component
> @Deprecated  
> It is recommended to use `TButton` instead
> 
> Un-reviewed AI-generated Document

## Overview


## Features
1. **Customizable Appearance**: The button's appearance can be customized through various properties, including padding and automatic sizing.
2. **Event Handling**: Supports event handling for button interactions, such as clicks.
3. **Nested Components**: Allows nesting of other UI components within the button.
4. **Automatic Sizing**: Automatically adjusts the button size to fit its content.

## Usage

### Create an Instance
To create an instance of the `Button` component, you need to import the necessary libraries and use Roact to render it. Here is a step-by-step guide:

1. **Import Dependencies**:
   Ensure you have the required modules, including `Roact` and `TableUtil`.

2. **Create the Button Instance**:
   Use `Roact.createElement` to create a new instance of the `Button` component.

### Options
The `Button` component accepts several properties to customize its behavior and appearance. These properties can be passed as a table to the component:

- **Root Container Properties**:
  - `BackgroundTransparency`: Sets the transparency of the root container.
  - `BorderSizePixel`: Sets the border size of the root container.
  - `AutomaticSize`: Controls the automatic sizing behavior of the root container.

- **Button Properties**:
  - `Size`: Sets the size of the button.
  - `AutomaticSize`: Controls the automatic sizing behavior of the button.

- **Event Properties**:
  - `Event`: A table containing event handlers for the button (e.g., `MouseButton1Click`).

### Example Codes
Here is an example of how to create and render a `Button` component:

```lua
-- Import necessary libraries
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Roact = require(ReplicatedStorage.Packages.roact)
local Button = require(ReplicatedStorage.Components.Button)

-- Create a new instance of the Button component
local buttonInstance = Roact.createElement(Button, {
    Button = {
        Size = UDim2.new(0, 100, 0, 50),
        Text = "Click Me!",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundColor3 = Color3.fromRGB(0, 128, 255),
    },
    Event = {
        MouseButton1Click = function()
            print("Button clicked!")
        end,
    },
})

-- Render the button
local handle = Roact.mount(buttonInstance, workspace)
```

## Members

### Public
- **Properties**:
  - `Button`: A table containing properties for the `TextButton` element.
  - `Event`: A table containing event handlers for the button.
  - `Children`: A table containing nested components to be rendered within the button.

### Static
There are no static members for the `Button` component.

### Private
- **Properties**:
  - `__handlers`: Internal handlers for managing button events (e.g., `onActivated`).

- **Methods**:
  - `willUnmount()`: A lifecycle method called when the component is about to be unmounted. It is used to disconnect event handlers.

---

**Note**: This component is deprecated. It is recommended to use `TButton` for new implementations.
