# Modal Component

## Overview
A customizable UI element to display Modal Dialogs in Roblox applications.


## Features
- **Styled & Shadowed Title**: Pre-defined with Customizable shadow effect Title through the `WithTextShadow` 
- **Flexible Positioning**: The modal's position and size can be adjusted using UDim2 properties.
- **Children Elements**: all children are under the outer `Frame` Element


## Usage

### Options
- **title**: The title text to be displayed at the top of the modal. (Default: 'Default Title')
- **Name**: The name of the modal frame. (Default: 'TestModal')
- **Position**: The position of the modal on the screen, specified using UDim2. (Default: UDim2.new(0.5, 0, 0.5, 0))
- **Size**: The size of the modal, specified using UDim2. (Default: UDim2.new(0.5, 0, 0.6, 0))
- **fontFace**: The font face for the title text. (Default: `Font.new('rbxasset://fonts/families/JosefinSans.json', Enum.FontWeight.Bold, Enum.FontStyle.Normal`))
- **TextSize**: The size of the title text. (Default: 50)
- **ZIndex**: The layer priority of the modal and its children. (Default: 0 for modal, 10 for title)

### Example Codes
```lua
local Roact = require(game:GetService('ReplicatedStorage').Packages.roact)
local Modal = require(game:GetService('ReplicatedStorage').Modal)

local function App()
    return Roact.createElement(Modal, {
        title = "Welcome",
        Name = "WelcomeModal",
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0.5, 0, 0.6, 0),
        fontFace = Font.new('rbxasset://fonts/families/JosefinSans.json', Enum.FontWeight.Bold, Enum.FontStyle.Normal),
        TextSize = 50,
    }, {
        Roact.createElement('TextLabel', {
            Text = 'This is a modal dialog',
            Size = UDim2.new(1, 0, 0.5, 0),
            BackgroundColor3 = Color3.new(1, 1, 1),
            TextColor3 = Color3.new(0, 0, 0),
            TextWrapped = true,
        })
    })
end

local handle = Roact.mount(App(), game.Players.LocalPlayer.PlayerGui)
```

This example demonstrates how to create a modal with a custom title and additional content inside the modal.
