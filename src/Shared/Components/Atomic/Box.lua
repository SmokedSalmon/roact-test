--[[
    Box Component, the Basic Container Component with Box-Related Styles (Background, Border, Shadow, Corner, etc,)
    It populates an individual Frame as Background to replace Container's original Background as such background must be able to mask things like shadow
    [TODO]
    Description
    Performance related issues
    AspectRatioConstrain
    SizeConstrain
]]
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Roact = require(ReplicatedStorage.Packages.roact)
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)

-- Constants & Configs
-- TODO centralize zIndex settings
-- Default ZIndexes for related elements
local DefaultZIs = {
    Border = 10,
    BG = -10,
    Shadow = -11,
}
local DefaultPadding = {
    PaddingLeft = UDim.new(0, 0),
    PaddingTop = UDim.new(0, 0),
    PaddingRight = UDim.new(0, 0),
    PaddingBottom = UDim.new(0, 0),
}
local DefaultShadowOffset = UDim2.new(0, 3, 0, 3)
local DefaultFrameProps = {
    Position = UDim2.new(0, 0, 0, 0),
    Size = UDim2.new(0, 100, 0, 100),
}
-- The follow properties are rendered by the __BG, __Shadow, __Border Frames
-- Therefore the root Frame are transparent in regards to let them manifest
local RootFramePropsOverride = {
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
}
local DefaultBGProps = {
    Position = UDim2.new(0, 0, 0, 0),
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 0,
    ZIndex = DefaultZIs.BG,
    BorderSizePixel = 0, -- Border is implemented by __Border Element
}
local DefaultShadowProps = {
    Position = DefaultBGProps.Position,
    Size = DefaultBGProps.Size,
    ZIndex = DefaultZIs.Shadow,
    BorderSizePixel = 0, -- Border is implemented by __Border Element
}
local DefaultBorderFrameProps = {
    Position = DefaultBGProps.Position,
    Size = DefaultBGProps.Size,
    BackgroundTransparency = 1,
    BorderSizePixel = 0, -- Border is implemented by its UIStroke Element
    ZIndex = DefaultZIs.Border,
}
local DefaultBorderStrokeProps = {
    Color = Color3.fromRGB(0, 0, 0),
    Thickness = 0,
    Transparency = 0, -- Not setting this default value means it follows __BG Frame's
}

local Box = Roact.Component:extend('Box')

function Box:render()
    -- Verify properties & options
    local _props = TableUtil.Assign(DefaultFrameProps, self.props or {})
    -- Overall Corner
    local _cornerRadius = _props.CornerRadius
    local _bgCornerRadius = _props.backgroundCorner or _props.CornerRadius
    local _shadowCornerRadius = _props.shadowCorner or _props.CornerRadius
    local _borderCornerRadius = _props.borderCorner or _props.CornerRadius
    
    -- Padding
    local _paddingProps = TableUtil.Assign(DefaultPadding, _props.Padding)

    -- Background
    local _bgProps = TableUtil.Assign(DefaultBGProps, {
        Position = DefaultBGProps.Position - UDim2.new(_paddingProps.PaddingLeft, _paddingProps.PaddingTop),
        Size = DefaultBGProps.Size + UDim2.new(_paddingProps.PaddingLeft, _paddingProps.PaddingTop) + UDim2.new(_paddingProps.PaddingRight, _paddingProps.PaddingBottom),
        BackgroundColor3 = _props.BackgroundColor3,
        BackgroundTransparency = _props.BackgroundTransparency,
        BorderColor3 = _props.BorderColor3,
    })
    -- Border
    local _borderFrameProps = TableUtil.Assign(DefaultBorderFrameProps, {
        Position = _bgProps.Position,
        Size = _bgProps.Size,
    })
    if _props.borderSize then
        -- -1 scale because this is relative to Background
        _borderFrameProps.Size += (_props.borderSize - UDim2.new(1, 0, 1, 0))
    end
    if _props.borderOffset then _borderFrameProps.Position += _props.borderOffset end
    local _borderStrokeProps = TableUtil.Assign(DefaultBorderStrokeProps, {
        Color = _props.BorderColor3,
        Thickness = _props.borderThickness or _props.BorderSizePixel,
        Transparency = _props.borderTransparency,
        LineJoinMode = _props.borderLineJoinMode,
        ApplyStrokeMode = _props.borderApplyStrokeMode,
    })
    local _renderBorderElement = _props.forceRenderBorderFrame or (
        (_borderStrokeProps.Thickness >= 1) and (
            -- Roblox's logic, border's transparency is effected by Parent
            _borderStrokeProps.Transparency ~= _bgProps.BackgroundTransparency
            -- Roblox's logic, parent instance's Corner once set, border should use UIStroke
            or _bgCornerRadius
            or _borderCornerRadius
            -- Other properties that requires to use UIStroke to render border
            or _props.borderSize
            or _props.borderOffset
            or _props.borderLineJoinMode
            or _props.borderApplyStrokeMode
       )
    )
    -- Shadow
    local _shadowProps = TableUtil.Assign(DefaultShadowProps, {
        Position = _bgProps.Position + (_props.shadowOffset or DefaultShadowOffset),
        Size = _bgProps.Size,
        BackgroundColor3 = _props.shadowBackgroundColor3,
        BackgroundTransparency = _props.shadowTransparency,
    })
    if _props.shadowSize then
        -- -1 scale because this is relative to Background
        _shadowProps.Size += (_props.shadowSize - UDim2.new(1, 0, 1, 0))
    end
    local _renderShadowElement = _props.enableShadow
    
    -- clear properties to fit actual Roblox Instance
    _props.backgroundCorner = nil
    _props.borderSize = nil
    _props.borderOffset = nil
    _props.borderThickness = nil
    _props.borderCorner = nil
    _props.borderTransparency = nil
    _props.borderLineJoinMode = nil
    _props.borderApplyStrokeMode = nil
    _props.forceRenderBorderFrame = nil
    _props.enableShadow = nil
    _props.shadowSize = nil
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

    if _cornerRadius then
        _children.UICorner = Roact.createElement('UICorner', { CornerRadius = _cornerRadius })
    end
    if _bgCornerRadius then
        _bgProps[Roact.Children] = { UICorner = Roact.createElement('UICorner', { CornerRadius = _bgCornerRadius }) }
    end
    if _shadowCornerRadius then
        _shadowProps[Roact.Children] = { UICorner = Roact.createElement('UICorner', { CornerRadius = _shadowCornerRadius }) }
    end
    _borderFrameProps[Roact.Children] = { UIStroke = Roact.createElement('UIStroke', _borderStrokeProps) }
    if _borderCornerRadius then
        _borderFrameProps[Roact.Children].UICorner = Roact.createElement('UICorner', { CornerRadius = _borderCornerRadius })
    end

    -- Border can be rendered as __BG Frame's border or a separated __Border Frame
    if _renderBorderElement then
        _children.__Border = Roact.createElement('Frame', _borderFrameProps)
    else
        _bgProps.BorderSizePixel = _borderStrokeProps.Thickness
    end
    _children.__BG = Roact.createElement('Frame', _bgProps)
    if _renderShadowElement then _children.__Shadow = Roact.createElement('Frame', _shadowProps) end
    if _paddingProps then
        _children.Padding = Roact.createElement('UIPadding', _paddingProps)
    end

    _props = TableUtil.Assign(_props, RootFramePropsOverride) -- Remove all properties that are NOT related to the root frame
    _props[Roact.Children] = _children
    return Roact.createElement('Frame', _props)
end

return Box
