--[[
    Card Component
    Used as a displaying item in a grid container
]]
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Roact = require(ReplicatedStorage.Packages.roact)
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
local Components = ReplicatedStorage.Shared.Components
local AtomicComponents = Components.Atomic
local Box = require(AtomicComponents.Box)

-- Constants & Configs
local DefaultPadding = {
    PaddingLeft = UDim.new(0, 0),
    PaddingTop = UDim.new(0, 0),
    PaddingRight = UDim.new(0, 0),
    PaddingBottom = UDim.new(0, 0),
}

local Card = Roact.PureComponent:extend('Card')

function Card:render()
    -- print(`Card render`)
    local _props = TableUtil.Assign({
        Padding = DefaultPadding,
        Border = {
            Thickness = 2,
            CornerRadius = UDim.new(0, 5),
            Rotation = 2,
        }
    }, self.props)
    _props.Name = _props.Name or 'Card'
    -- _props.ClipDescendants = true

    return Roact.createElement(Box, _props)
end

function Card:init()
    -- print('Card Initiated')
end

-- function Card:shouldUpdate(np, ns)
--     print(`Should update: {self.props ~= np}`)
--     return self.props ~= np or self.state ~= ns
-- end

function Card:didUpdate()
    print(`Card updated`)
end

return Card
