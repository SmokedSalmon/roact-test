local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Roact = require(ReplicatedStorage.Packages.roact)

local Components = ReplicatedStorage.Components
local AtomicComponents = Components.Atomic
local StoreService = require(ReplicatedStorage.Store)
local Modal = require(Components.Modal)
local WithCustomBackground = require(AtomicComponents.WithCustomBackground)
local GridContainer = require(AtomicComponents.GridContainer)
local Card = require(Components.Card)
local Button = require(Components.Button)
local ListContainer = require(AtomicComponents.ListContainer)
local Box = require(AtomicComponents.Box)

-- persist it, do not create this in render cycle, otherwise it will init() instead of every update
local ModalWithCB = WithCustomBackground(Modal)

return {}