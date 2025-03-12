# Text Button Component Documentation

## Overview
Interactive buttons with text labels.

## Features

- Highly customizable appearance and behavior.
- Supports automatic sizing and padding.
- Event handling capabilities for user interactions.


## Usage

### Create an Instance
To create an instance of the Text Button component, you need to import it and pass the required props to the component.

### Options
- **Background**: Sets the background appearance of the button.
- **Border**: Defines the border style of the button.
- **Shadow**: Adds a shadow effect to the button.
- **Padding**: Specifies the padding inside the button.
- **Size**: Sets the size of the button.
- **Position**: Defines the position of the button.
- **AnchorPoint**: Sets the anchor point of the button.
- **AutomaticSize**: Enables automatic sizing based on content.

### Example Codes
```lua
local Button = require(path.to.TButton)

local buttonInstance = Roact.createElement(Button, {
    Text = "Click Me",
    Size = UDim2.new(0, 100, 0, 30),
    Position = UDim2.new(0.5, -50, 0.5, -15),
    BackgroundColor3 = Color3.fromRGB(255, 0, 0),
    TextColor3 = Color3.fromRGB(255, 255, 255),
    [Roact.Event.Activated] = function()
        print("Button clicked!")
    end
})
```
