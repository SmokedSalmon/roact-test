# RowContainer UI Component
> Overlapped with `ListContainer` + Horizontal Alignment???
> Maybe not, this Component is newer and utilize `Box` Component

## Overview
`Box` component that arranges items in a vertical list layout


## Features
- **Vertical Layout**: Automatically arranges child elements horizontally  
  It create a `UIListLayout` with pre-defined options under the hood
- Scrollable container with vertical layout
  - Automatic canvas sizing for dynamic content


## Usage

### Options
- `Position`: The position of the container (default: `UDim2.new(0, 0, 0, 0)`).
- `Size`: The size of the container (default: `UDim2.new(1, 0, 1, 0)`).
- `Scroll`: A table containing scrolling properties:
  - `AutomaticCanvasSize`: Automatically adjusts the canvas size in the Y direction (default: `Enum.AutomaticSize.Y`).
  - `CanvasPosition`: Initial canvas position (default: `Vector2.new(0, 0)`).
  - `CanvasSize`: Initial canvas size (default: `UDim2.new(0, 0, 0, 0)`).
  - `ScrollBarThickness`: Thickness of the scroll bar (default: `12`).
  - `ScrollingDirection`: Direction of scrolling (default: `Enum.ScrollingDirection.Y`).
  - `VerticalScrollBarInset`: Inset position of the scroll bar (default: `Enum.ScrollBarInset.ScrollBar`).
  - `VerticalScrollBarPosition`: Position of the vertical scroll bar (default: `Enum.VerticalScrollBarPosition.Right`).
- `List`: A table containing list layout properties:
  - `FillDirection`: Direction to fill the list (default: `Enum.FillDirection.Vertical`).
  - `VerticalFlex`: Vertical alignment of list items (default: `Enum.UIFlexAlignment.SpaceBetween`).

### Example Codes
```lua
-- Import the RowContainer component
local RowContainer = require(path.to.RowContainer)

-- Create an instance of RowContainer
local rowContainer = Roact.createElement(RowContainer, {
    Position = UDim2.new(0.1, 0, 0.1, 0),
    Size = UDim2.new(0.8, 0, 0.8, 0),
    Scroll = {
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollBarThickness = 10,
    },
    List = {
        -- FillDirection = Enum.FillDirection.Vertical,
        VerticalFlex = Enum.UIFlexAlignment.SpaceBetween,
    }, {
        Item1 = Roact.createElement('TextLabel', {
            Text = 'Item 1',
            Size = UDim2.new(0, 50, 0, 30),
            BackgroundColor3 = Color3.new(1, 0, 0),
        }),
        Item2 = Roact.createElement('TextLabel', {
            Text = 'Item 2',
            Size = UDim2.new(0, 50, 0, 30),
            BackgroundColor3 = Color3.new(0, 1, 0),
        }),
        Item3 = Roact.createElement('TextLabel', {
            Text = 'Item 3',
            Size = UDim2.new(0, 50, 0, 30),
            BackgroundColor3 = Color3.new(0, 0, 1),
        }),
    }
})
```
