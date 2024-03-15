local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Roact = require(ReplicatedStorage.Packages.roact)

local app = Roact.createElement("ScreenGui", {}, {
    HelloWorld = Roact.createElement("TextLabel", {
        Size = UDim2.new(0, 400, 0, 300),
        Text = "Hello, Roact is launched!"
    })
})

Roact.mount(app, Players.LocalPlayer.PlayerGui)
print("Client finished")