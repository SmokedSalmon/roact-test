# VTabPanel UI Component
> Is it `Deprecated` or `Under Development`, not sure  
> It seems all Comprehensive Panels use positioned `TabPanelButton` to achieve the same purpose  
> Un-reviewed AI-generated document

## Overview
A panel with vertical tabs, designed to organize content into multiple sections that can be navigated via tabs on the side.


## Features
- **Vertical Tabs** : Provides a vertical tab layout for easy content organization and navigation.
- **Customizable Button Properties** : Allows customization of button properties such as size and automatic size.
- **Event Handling** : Supports event handling for button interactions.

## Usage

### Options
- `DefaultRootContainerProps` : Default properties for the root container, including background transparency, border size, and automatic size.
- `DefaultTextButtonProps` : Default properties for the text button, including size and automatic size.
- `Event` : A table of event handlers for button interactions.

### Example Codes

```lua
local Roact = require(ReplicatedStorage.Packages.roact)
local VTabPanel = require(path.to.VTabPanel)

local function App()
    return Roact.createElement(VTabPanel, {
        DefaultRootContainerProps = {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.XY,
        },
        DefaultTextButtonProps = {
            Size = UDim2.new(1, 0, 1, 0),
            AutomaticSize = Enum.AutomaticSize.XY,
        },
        Event = {
            onActivated = function()
                print("Button activated")
            end,
        },
    })
end

Roact.mount(App(), game.Players.LocalPlayer.PlayerGui)
```
