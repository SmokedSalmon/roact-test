--[[
    GUI's Global Store using Roact's Context API
]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Packages.roact)

local GlobalStore = Roact.createContext({})

return GlobalStore
