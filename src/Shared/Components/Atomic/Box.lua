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
    BackgroundTransparency = 1,
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
    
    -- Children that may conflicts Background, Border and Padding
    local _children = _props[Roact.Children] or {}
    if _children.__BG or _children.__Shadow or _children.__Border or _children.UIPadding or _children.UICorner then
        warn('Manually creating the following elements should be avoided: {__BG, __Shadow, __Border, UIPadding, UICorner}')
        warn('They will be replaced by those of the same name which are created internally by this Component')
    end

    -- Padding
    local _paddingProps = TableUtil.Assign(DefaultPadding, _props.Padding)
    _children.Padding = Roact.createElement('UIPadding', _paddingProps)
    _props.Padding = nil

    -- Background
    local _bgProps = nil
    if _props.Background then
        _bgProps = TableUtil.Assign(DefaultBGProps, {
            BackgroundColor3 = _props.Background.Color3,
            BackgroundTransparency = _props.Background.Transparency,
            BorderColor3 = _props.BorderColor3,
        })
        if not _props.bgIgnorePadding then
            _bgProps.Position -= UDim2.new(_paddingProps.PaddingLeft, _paddingProps.PaddingTop)
            _bgProps.Size += UDim2.new(_paddingProps.PaddingLeft, _paddingProps.PaddingTop) + UDim2.new(_paddingProps.PaddingRight, _paddingProps.PaddingBottom)
        end
        if _props.Background.CornerRadius then
            _bgProps[Roact.Children] = { UICorner = Roact.createElement('UICorner', { CornerRadius = _props.Background.CornerRadius }) }
        end
        -- render after Border & Shadow as it might be impact by them
    end

    -- Border
    if _props.Border then
        local _borderThickness = _props.Border.Thickness or _props.BorderSizePixel
        local _renderBorderElement = _props.Border.forceRenderBorderFrame or (
            (_borderThickness >= 1) and (
                -- Roblox's logic, border's transparency is effected by Parent
                _props.Border.Transparency ~= (_bgProps and _bgProps.BackgroundTransparency)
                -- Roblox's logic, parent instance's Corner once set, border should use UIStroke
                or (_bgProps and _bgProps.CornerRadius and _props.Border.CornerRadius ~= _bgProps.CornerRadius)
                -- Other properties that requires to use UIStroke to render border
                or _props.Border.Size
                or _props.Border.Offset
                or _props.Border.LineJoinMode
                or _props.Border.ApplyStrokeMode
        )
        )
        local _borderStrokeProps = TableUtil.Assign(DefaultBorderStrokeProps, {
            Color = _props.Border.Color,
            Thickness = _borderThickness,
            Transparency = _props.Border.Transparency,
            LineJoinMode = _props.Border.LineJoinMode,
            ApplyStrokeMode = _props.Border.ApplyStrokeMode,
        })

        -- Border can be rendered as __BG Frame's border or a separated __Border Frame
        if _renderBorderElement then
            local _borderFrameProps = TableUtil.Assign(DefaultBorderFrameProps, {})
            if _bgProps then
                _borderFrameProps = TableUtil.Assign(_borderFrameProps, _bgProps)
                _bgProps.BorderSizePixel = 0
            end
            if _props.Border.Size then
                -- -1 scale because this is relative to Background
                _borderFrameProps.Size += (_props.Border.Size - UDim2.new(1, 0, 1, 0))
            end
            if _props.Border.Offset then _borderFrameProps.Position += _props.Border.Offset end
            _borderFrameProps[Roact.Children] = { UIStroke = Roact.createElement('UIStroke', _borderStrokeProps) }
            local _borderCornerRadius = _props.Border.CornerRadius or (_bgProps and _bgProps.CornerRadius)
            if _borderCornerRadius then
                _borderFrameProps[Roact.Children].UICorner = Roact.createElement('UICorner', { CornerRadius = _props.Border.CornerRadius })
            end
            _children.__Border = Roact.createElement('Frame', _borderFrameProps)
        else
            if _bgProps then _bgProps.BorderSizePixel = _borderStrokeProps.Thickness end
        end
    end

    -- Shadow
    if _props.Shadow then
        local _shadowProps = TableUtil.Assign(DefaultShadowProps, {
            Size = _bgProps.Size,
            BackgroundColor3 = _props.Shadow.Color3,
            BackgroundTransparency = _props.Shadow.Transparency,
        })
        if _bgProps then
            _shadowProps.Position = _bgProps.Position + (_props.Shadow.Offset or DefaultShadowOffset)
        end
        if _props.Shadow.Size then
            -- -1 scale because this is relative to Background
            _shadowProps.Size += (_props.Shadow.Size - UDim2.new(1, 0, 1, 0))
        end
        local _shadowCornerRadius = _props.Shadow.CornerRadius or (_bgProps and _bgProps.CornerRadius)
        if _shadowCornerRadius then
            _shadowProps[Roact.Children] = { UICorner = Roact.createElement('UICorner', { CornerRadius = _shadowCornerRadius }) }
        end
        _children.__Shadow = Roact.createElement('Frame', _shadowProps)
    end
    
    -- clear non-standard properties from actual Roblox Instance
    _props.Background = nil
    _props.Border = nil
    _props.Shadow = nil
    _props.bgIgnorePadding = nil

    if _bgProps then
        _children.__BG = Roact.createElement('Frame', _bgProps)
    end
    _props[Roact.Children] = _children
    _props = TableUtil.Assign(_props, RootFramePropsOverride) -- Remove all properties that are NOT related to the root frame
    return Roact.createElement('Frame', _props)
end

return Box
