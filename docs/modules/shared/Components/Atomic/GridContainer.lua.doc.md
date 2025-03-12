# GridContainer Component
> Maybe `Deprecated` as `Box` Component and its `Layout` option support all its features?

## Overview
A Roact container component that arranges items in a grid layout with **rows** and **columns**, similar to CSS **Flex-box**.


## Features
- Supports both scrollable and non-scrollable grid layouts.
- Automatically manages `UIGridLayout` for consistent grid arrangement.
- Configurable row and column counts, as well as scrolling direction and automatic canvas size.


## Usage

### Options
| Property            | Type                  | Default Value                     | Description                                                                 |
|---------------------|-----------------------|-----------------------------------|-----------------------------------------------------------------------------|
| `isScrollable`      | `boolean`             | `false`                           | Whether the grid container should be scrollable.                            |
| `Position`          | `UDim2`               | `UDim2.new(0, 0, 0, 0)`           | The position of the grid container.                                        |
| `Size`              | `UDim2`               | `UDim2.new(1, 0, 1, 0)`           | The size of the grid container.                                            |
| `grid`              | `table`               | `{}`                              | A table containing properties for the UIGridLayout.                         |
| `grid.SortOrder`    | `Enum.SortOrder`      | `Enum.SortOrder.LayoutOrder`      | The sort order for the grid items.                                         |
| `grid.RowCount`      | `number`              | `3`                               | The number of rows in the grid.                                             |
| `grid.ColumnCount`  | `number`              | `3`                               | The number of columns in the grid.                                          |
| `ScrollingDirection`| `Enum.ScrollingDirection`| `Enum.ScrollingDirection.Y`       | The scrolling direction for scrollable grids.                               |
| `AutomaticCanvasSize`| `Enum.AutomaticSize`  | `Enum.AutomaticSize.Y`            | The automatic canvas size behavior for scrollable grids.                   |

### Example Codes

#### Basic Example
```lua
local GridContainer = require(path.to.GridContainer)

local grid = Roact.createElement(GridContainer, {
    isScrollable = true,
    Position = UDim2.new(0.5, -150, 0.5, -150),
    Size = UDim2.new(0, 300, 0, 300),
    grid = {
        SortOrder = Enum.SortOrder.LayoutOrder,
        RowCount = 2,
        ColumnCount = 3
    }
}, {
    Item1 = Roact.createElement("TextLabel", {
        Text = "Item 1",
        Size = UDim2.new(1, 0, 1, 0)
    }),
    Item2 = Roact.createElement("TextLabel", {
        Text = "Item 2",
        Size = UDim2.new(1, 0, 1, 0)
    }),
    Item3 = Roact.createElement("TextLabel", {
        Text = "Item 3",
        Size = UDim2.new(1, 0, 1, 0)
    })
})

Roact.mount(grid, RoactRootElement)
```

#### Non-Scrollable Example
```lua
local GridContainer = require(path.to.GridContainer)

local grid = Roact.createElement(GridContainer, {
    isScrollable = false,
    Size = UDim2.new(1, 0, 1, 0),
    grid = {
        RowCount = 4,
        ColumnCount = 4
    }
}, {
    Item1 = Roact.createElement("TextLabel", {
        Text = "Item 1",
        Size = UDim2.new(1, 0, 1, 0)
    }),
    Item2 = Roact.createElement("TextLabel", {
        Text = "Item 2",
        Size = UDim2.new(1, 0, 1, 0)
    })
})

Roact.mount(grid, RoactRootElement)
```
