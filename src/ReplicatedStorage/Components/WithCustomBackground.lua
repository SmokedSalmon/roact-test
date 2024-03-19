--[[
    Background with Shadow and other effects
    It populates an individual Frame as Background to replace Container's original Background as such background must be able to mask things like shadow
    Use "props.bg" as the property object for Background
    It also populates an individual Frame as Shadow
    Use "props.bg.shadow" as the property object for Shadow
]]
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Roact = require(ReplicatedStorage.Packages.roact)
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)

-- Constants & Configs
local DefaultPosition = UDim2.new(0, 0, 0, 0)
local DefaultSize = UDim2.new(1, 0, 1, 0)
local DefaultShadowOffset = UDim2.new(0, 3, 0, 3)
-- TODO centralize zIndex settings
local ZIs = {
    BG = -10,
    BG_Shadow = -11,
}

local function WithShadowWrapper(WrappedComponent: Roact.Component | string)
    local ComponentWithShadow = Roact.Component:extend('WithShadow')
    
    function ComponentWithShadow:render()
        local _bgProps = TableUtil.Assign({
            Position = DefaultPosition,
            Size = DefaultSize,
            ZIndex = ZIs.BG,
        }, (self.props and self.props.bg) or {})
        local _shadowProps = _bgProps.shadow or {}
        _bgProps.shadow = nil
        self.props.bg = nil
        -- the BG Frame will takeovers original Element's Background-related properties
        self.props.BackgroundTransparency = 1
        
        local children = self.props[Roact.Children] or {}
        children.BG = Roact.createElement('Frame', _bgProps)
        if _shadowProps then
            _shadowProps = TableUtil.Assign({
                Position = _bgProps.Position + DefaultShadowOffset,
                Size = DefaultSize,
                ZIndex = ZIs.BG_Shadow,
                BorderSizePixel = 0,
            }, _shadowProps)
            children.BGShadow = Roact.createElement('Frame', _shadowProps)
        end
        -- return Roact.createElement(WrappedComponent, _props, children) -- DO NOT use this
        -- use props[Roact.Children] key instead of 3rd argument here to avoid Roact warning
        self.props[Roact.Children] = children
        return Roact.createElement(WrappedComponent, self.props)
    end

    return ComponentWithShadow
end

return WithShadowWrapper
