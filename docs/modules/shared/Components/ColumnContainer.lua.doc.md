# ColumnContainer Component
> Overlapped with `ListContainer`+ Vertical Alignment???
> Maybe not, this Component is newer and utilize `Box` Component

## Overview
`Box` component that arranges items in a horizontal list layout

## Features
- **Horizontal Layout**: Automatically arranges child elements horizontally  
  It create a `UIListLayout` with pre-defined options under the hood
- **Scrolling Support**: Supports horizontal scrolling with customizable scrollbar settings.
  - Automatic canvas sizing for dynamic content


## Usage

### Options
- **Position**: The position of the container (default: `UDim2.new(0, 0, 0, 0)`).
- **Size**: The size of the container (default: `UDim2.new(1, 0, 1, 0)`).
- **AutomaticSize**: The automatic size behavior of the container (default: `Enum.AutomaticSize.None`).
- **Scroll**: A table containing scrolling properties:
  - **AutomaticCanvasSize**: The automatic canvas size behavior (default: `Enum.AutomaticSize.X`).
  - **CanvasPosition**: The initial canvas position (default: `Vector2.new(0, 0)`).
  - **CanvasSize**: The size of the canvas (default: `UDim2.new(0, 0, 0, 0)`).
  - **ScrollBarThickness**: The thickness of the scrollbar (default: `12`).
  - **ScrollingDirection**: The direction of scrolling (default: `Enum.ScrollingDirection.X`).
  - **HorizontalScrollBarInset**: The inset behavior of the horizontal scrollbar (default: `Enum.ScrollBarInset.ScrollBar`).
- **Layout**: A table containing layout properties:
  - **SortOrder**: The sort order of the layout (default: `Enum.SortOrder.LayoutOrder`).
  - **FillDirection**: The direction in which items are filled (default: `Enum.FillDirection.Horizontal`).
  - **VerticalAlignment**: The vertical alignment of items (default: `Enum.VerticalAlignment.Center`).
  - **Padding**: The padding between items (default: `UDim.new(0, 10)`).

### Example Codes

```lua
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Roact = require(ReplicatedStorage.Packages.roact)
local ColumnContainer = require(ReplicatedStorage.Components.ColumnContainer)

local function App()
    return Roact.createElement(ColumnContainer, {
        Position = UDim2.new(0, 10, 0, 10),
        Size = UDim2.new(0, 300, 0, 100),
        Scroll = {
            AutomaticCanvasSize = Enum.AutomaticSize.X,
            ScrollBarThickness = 8,
        },
        Layout = {
            Padding = UDim.new(0, 5),
        },
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
    })
end

local handle = Roact.mount(App(), workspace, 'App')
```
