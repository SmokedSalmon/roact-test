--[[
    Card Component
    Used as a displaying item in a grid container
]]
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Roact = require(ReplicatedStorage.Packages.roact)
local Components = ReplicatedStorage.Components
local AtomicComponents = Components.Atomic
local Border = require(AtomicComponents.Border)

-- Constants & Configs
local DefaultUIPadding = Roact.createElement('UIPadding', {
    PaddingLeft = UDim.new(0, 10),
    PaddingTop = UDim.new(0, 10),
    PaddingRight = UDim.new(0, 10),
    PaddingBottom = UDim.new(0, 10),
})

local Card = Roact.Component:extend('Card')

function Card:render()
    local _props = self.props or {}
    _props.Name = _props.Name or 'CardRoot'
    -- _props.ClipDescendants = true
    -- Since we have to cater Shadow, background is facilitated with a child frame named BG. Otherwise the Shadow will be over root container's own Background
    local _backgroundTransparency = _props.BackgroundTransparency or 0
    _props.BackgroundTransparency = 1
    local uiPadding = _props.uiPadding or DefaultUIPadding
    local borderProps = { Thickness = _props.BorderThickness or _props.BorderSizePixel }
    local bgProps = { BackgroundTransparency = _backgroundTransparency }

    return Roact.createElement('Frame', _props, {
        UIPadding = DefaultUIPadding,
        Border = Roact.createElement(Border, borderProps)
    })
end

return Card
