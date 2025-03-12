# ListContainer Component
> Maybe `Deprecated` as `Box` Component and its `Layout` option support all its features?

## Overview
A Roact container component that arranges child items in a **horizontal/vertical** list layout, supporting both **scrollable** and **non-scrollable** configurations.

## Features
- **Horizontal & Vertical Layout**
- **Scrollable Option**: Supports scrollable frames for overflow content.
- **Customizable Padding and Sorting**: Allows customization of item **spacing** and **sorting** order.
- **Conflict Warnings**: Provides warnings for potential conflicts with nested UI layouts.


## Usage

### Options

- **isScrollable**: Boolean indicating whether the container should be scrollable. Defaults to `false`.
- **listDirection**: The direction of the list layout. Defaults to `Enum.FillDirection.Horizontal`.
- **Position**: The position of the container. Defaults to `UDim2.new(0, 0, 0, 0)`.
- **Size**: The size of the container. Defaults to `UDim2.new(1, 0, 1, 0)`.
- **layout**: A table containing additional layout properties:
  - **FillDirection**: Overrides the default fill direction.
  - **Padding**: The spacing between items. Defaults to `UDim.new(0, 10)`.
  - **SortOrder**: The sorting order of the items. Defaults to `Enum.SortOrder.LayoutOrder`.

### Example Codes
```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Packages.roact)
local ListContainer = require(ReplicatedStorage.Components.ListContainer)

local function App()
    return Roact.createElement(ListContainer, {
        isScrollable = true,
        listDirection = Enum.FillDirection.Horizontal,
        Size = UDim2.new(1, 0, 0, 100),
        layout = {
            Padding = UDim.new(0, 5),
            SortOrder = Enum.SortOrder.LayoutOrder
        }
    }, {
        Item1 = Roact.createElement("TextLabel", {
            Text = "Item 1",
            Size = UDim2.new(0, 100, 1, 0),
            BackgroundColor3 = Color3.new(1, 0, 0)
        }),
        Item2 = Roact.createElement("TextLabel", {
            Text = "Item 2",
            Size = UDim2.new(0, 100, 1, 0),
            BackgroundColor3 = Color3.new(0, 1, 0)
        }),
        Item3 = Roact.createElement("TextLabel", {
            Text = "Item 3",
            Size = UDim2.new(0, 100, 1, 0),
            BackgroundColor3 = Color3.new(0, 0, 1)
        })
    })
end

local handle = Roact.mount(App(), workspace)
```

In this example, `ListContainer` is configured to be scrollable with a horizontal layout. The items are arranged with a padding of 5 pixels between them.
