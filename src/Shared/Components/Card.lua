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

local function ContentBox(rotation: number, children: {Roact.Component}?)
    return Roact.createElement(Box, {
        Size = UDim2.new(1, 0, 1, 0),
        Background = {
            Image = {
                Size = UDim2.new(1, 0, 0.7, 0),
                Image = 'rbxasset://textures/ui/GuiImagePlaceholder.png',
            }
        },
        Rotation = rotation,
    }, children)
end

function Card:init()
    self._rotation = math.random(-1.5, 1.5)
end

function Card:render()
    -- print(`Card render`)
    local _props = TableUtil.Assign({
        Padding = DefaultPadding,
        Border = {
            Thickness = 2,
            CornerRadius = UDim.new(0, 5),
            Rotation = self._rotation,
        }
    }, self.props)
    
    local children = _props[Roact.Children]
    _props[Roact.Children] = { Content = ContentBox(self._rotation, children)}

    _props.Name = _props.Name or 'Card'
    -- _props.ClipDescendants = true

    return Roact.createElement(Box, _props)
end

-- function Card:shouldUpdate(np, ns)
--     print(`Should update: {self.props ~= np}`)
--     return self.props ~= np or self.state ~= ns
-- end

function Card:didUpdate()
    print(`Card updated`)
end

return Card
