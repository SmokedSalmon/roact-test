--[[
    Box Component, the Basic Container Component with Box-Related Styles (Background, Border, Shadow, Corner, etc,)
    It populates an individual Frame as Background to replace Container's original Background as such background must be able to mask things like shadow
    [TODO]
    Description
    AspectRatioConstrain
    SizeConstrain
]]
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Roact = require(ReplicatedStorage.Packages.roact)
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
local WithCustomBackground = require(script.Parent.WithCustomBackground)

-- Constants & Configs
-- TODO centralize zIndex settings
-- Default ZIndexes for related elements
local DefaultZIs = {
    Border = 10,
    BG = -10,
    Shadow = -11,
}
local DefaultShadowOffset = UDim2.new(0, 3, 0, 3)
local DefaultFrameProps = {
    Position = UDim2.new(0, 0, 0, 0),
    Size = UDim2.new(0, 100, 0, 100),
}
local DefaultBGProps = {
    Position = UDim2.new(0, 0, 0, 0),
    Size = UDim2.new(1, 0, 1, 0),
    ZIndex = DefaultZIs.BG,
}
local DefaultShadowProps = {
    Position = DefaultBGProps.Position,
    Size = DefaultBGProps.Size,
    ZIndex = DefaultZIs.Shadow,
    BorderSizePixel = 0,
}
local DefaultBorderProps = {
    
}

local DefaultCornerRadius = UDim2.new(0, 10)
local DefaultPadding = {
    PaddingLeft = UDim.new(0, 10),
    PaddingTop = UDim.new(0, 10),
    PaddingRight = UDim.new(0, 10),
    PaddingBottom = UDim.new(0, 10),
}

local Box = Roact.Component:extend('Box')

function Box:render()
    -- Verify properties & options
    
    local _props = TableUtil.Assign(DefaultFrameProps, self.props or {})
    
    -- Background
    local _bgProps = TableUtil.Assign(DefaultBGProps, {
        BackgroundColor3 = _props.BackgroundColor3,
        BackgroundTransparency = _props.BackgroundTransparency,
        backgroundCorner = _props.backgroundCorner,
    })
    -- Border
    local _borderProps = TableUtil.Assign(DefaultBorderProps, {
        borderOffset = _props.borderOffset,
        BorderColor3 = _props.BorderColor3,
        BorderMode = _props.BorderMode,
        BorderSizePixel = _props.BorderSizePixel,
        borderThickness = _props.borderThickness, -- Either Above or this,
        borderTransparency = _props.borderTransparency,
        borderLineJoinMode = _props.borderLineJoinMode,
        borderApplyStrokeMode = _props.borderApplyStrokeMode,
        borderCorner = _props.borderCorner,
    })
    -- Shadow
    local _shadowProps = TableUtil.Assign(DefaultShadowProps, {
        Position = DefaultShadowProps.Position + (_props.shadowOffset or DefaultShadowOffset),
        BackgroundColor3 = _props.shadowBackgroundColor3,
        -- shadowCorner = _props.shadowCorner,
        BackgroundTransparency = _props.shadowTransparency,
    })
    -- Overall Corner
    local _cornerProps = { CornerRadius = _props.CornerRadius or DefaultCornerRadius }
    -- Padding
    local _paddingProps = { Padding = _props.Padding or DefaultPadding }
    -- clear properties to fit actual Roblox Instance
    _props.backgroundCorner = nil
    _props.borderOffset = nil
    _props.borderThickness = nil
    _props.borderTransparency = nil
    _props.borderLineJoinMode = nil
    _props.borderApplyStrokeMode = nil
    _props.shadowOffset = nil
    _props.shadowBackgroundColor3 = nil
    _props.shadowCorner = nil
    _props.shadowTransparency = nil
    _props.CornerRadius = nil
    _props.Padding = nil

    local _children = _props[Roact.Children] or {}
    if _children.__BG or _children.__Shadow or _children.__Border or _children.UIPadding or _children.UICorner then
        warn('Manually creating the following elements should be avoided: {__BG, __Shadow, __Border, UIPadding, UICorner}')
        warn('They will be replaced by those of the same name which are created internally by this Component')
    end
    _children.__BG = Roact.createElement('Frame', _bgProps)
    _children.__Shadow = Roact.createElement('Frame', _shadowProps)

    _props[Roact.Children] = _children
    
    print(_props)
    print(_props.shadowBackgroundColor3)
    return Roact.createElement('Frame', _props)
end

return Box
