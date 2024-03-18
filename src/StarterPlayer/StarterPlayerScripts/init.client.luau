local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Roact = require(ReplicatedStorage.Packages.roact)

-- Hello World Example
-- local app = Roact.createElement("ScreenGui", {}, {
--     HelloWorld = Roact.createElement("TextLabel", {
--         Size = UDim2.new(0, 400, 0, 300),
--         Text = "Hello, Roact is launched!"
--     })
-- })
-- Roact.mount(app, Players.LocalPlayer.PlayerGui)
-- print("Client finished")

local Modal = require(ReplicatedStorage.Components.Modal)
local WithBoxShadow = require(ReplicatedStorage.Components.WithBoxShadow)
local GuiRoot = Roact.createElement('ScreenGui', {}, {
    TestModel = Roact.createElement(WithBoxShadow(Modal), {
        title = 'Arsenal'
    })
})

local guiUnmountHandler = Roact.mount(GuiRoot, Players.LocalPlayer.PlayerGui, 'Test GUI')

wait(100)
print('Unmounting GUI')
Roact.unmount(guiUnmountHandler)