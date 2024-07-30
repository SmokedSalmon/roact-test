--[[
    Box Component, the Basic Container Component with Box-Related Styles (Background, Border, Shadow, Corner, etc,)
    It populates an individual Frame as Background to replace Container's original Background as such background must be able to mask things like shadow
    [Note]
    Padding, unlike Margin, it extends size of Background, Shadow and Border, just like HTML DOM
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
    Content = 5,
    Border = 10,
    BG = -10,
    Shadow = -11,
}
local DefaultShadowOffset = UDim2.new(0, 3, 0, 3)
local DefaultFrameProps = {
    Position = UDim2.new(0, 0, 0, 0),
    Size = UDim2.new(0, 100, 0, 100),
    -- The follow properties are rendered by the __BG, __Shadow, __Border Frames, unless you specifically set it
    -- Since we have to cater Shadow, background is facilitated with a child frame named BG. Otherwise the Shadow will be over root container's own Background
    -- Therefore the root Frame are transparent to let them manifest
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
local DefaultBorderProps = {
    Color = Color3.fromRGB(0, 0, 0),
    Thickness = 1,
    Transparency = 0,
}
local DefaultBorderFrameProps = {
    Position = DefaultBGProps.Position,
    Size = DefaultBGProps.Size,
    BackgroundTransparency = 1,
    BorderSizePixel = 0, -- Border is implemented by its UIStroke Element
    ZIndex = DefaultZIs.Border,
}
local DefaultBorderStrokeProps = {
    Color = DefaultBorderProps.Color,
    Thickness = DefaultBorderProps.Thickness,
    Transparency = 0, -- Not setting this default value means it follows __BG Frame's
}

local Box = Roact.Component:extend('Box')

function Box:render()
    -- Verify properties & options
    local _props = TableUtil.Assign(DefaultFrameProps, self.props or {})
    _props.BackgroundTransparency = 1
    _props.BorderSizePixel = 0
    
    -- Children that may conflicts Background, Border and Padding
    local _contentChildren = _props[Roact.Children] or {}
    -- if _contentChildren.__BG or _contentChildren.__Shadow or _contentChildren.__Border or _contentChildren.UIPadding or _contentChildren.UICorner then
    --     warn('Manually creating the following elements should be avoided: {__BG, __Shadow, __Border, UIPadding, UICorner}')
    --     warn('They will be replaced by those of the same name which are created internally by this Component')
    -- end
    local _rootChildren = {}

    -- Padding
    if _props.Padding then
        _contentChildren['UIPadding'] = Roact.createElement('UIPadding', _props.Padding)
    -- Content Frame, mainly cater Padding
        local _contentProps = {
            AutomaticSize = _props.AutomaticSize,
            Position = UDim2.new(0, 0, 0, 0),
            -- TODO align with outer box existence
            -- Rotation = _props.Rotation,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ZIndex = DefaultZIs.Content,
        }
        if _props.AutomaticSize == Enum.AutomaticSize.XY then
            _contentProps.Size = UDim2.new(0, 0, 0, 0)
        elseif _props.AutomaticSize == Enum.AutomaticSize.X then
            _contentProps.Size = UDim2.new(0, 0, 1, 0)
        elseif _props.AutomaticSize == Enum.AutomaticSize.Y then
            _contentProps.Size = UDim2.new(1, 0, 0, 0)
        else
            _contentProps.Size = UDim2.new(1, 0, 1, 0)
        end
        _rootChildren['__Content'] = Roact.createElement('Frame', _contentProps, _contentChildren)
    else
        _rootChildren = _contentChildren
    end

    -- Background
    local _bgProps
    local _bgCornerRadius
    if _props.Background then
        _bgProps = TableUtil.Assign(DefaultBGProps, {
            BackgroundColor3 = _props.Background.Color3,
            BackgroundTransparency = _props.Background.Transparency or 0,
            Rotation = _props.Background.Rotation,
            BorderColor3 = _props.BorderColor3,
        })
        _bgProps[Roact.Children] = {}
        if _props.Background.CornerRadius then
            _bgProps[Roact.Children].UICorner = Roact.createElement('UICorner', { CornerRadius = _props.Background.CornerRadius })
            _bgCornerRadius = _props.Background.CornerRadius
        end
        if _props.Background.Image then
            _bgProps[Roact.Children].Image = Roact.createElement('ImageLabel', _props.Background.Image)
        end
        _bgProps.ZIndex = DefaultZIs.BG
        -- render after Border & Shadow as it might be impact by them
    end

    -- Border
    if _props.Border then
        local _borderProps = TableUtil.Assign(DefaultBorderProps, _props.Border)
        _borderProps.Thickness = _borderProps.Thickness or _props.BorderSizePixel
        local _renderBorderElement = _props.Border.forceRenderBorderFrame or (
            (_borderProps.Thickness >= 1) and (
                -- Roblox's logic, border's transparency is effected by Parent
                _borderProps.Transparency ~= (_bgProps and _bgProps.BackgroundTransparency)
                -- Roblox's logic, parent instance's Corner once set, border should use UIStroke
                or (_bgProps and _bgProps.CornerRadius and _borderProps.CornerRadius ~= _bgProps.CornerRadius)
                -- Other properties that requires to use UIStroke to render border
                or _borderProps.Size
                or _borderProps.Rotation
                or _borderProps.Offset
                or _borderProps.LineJoinMode
                or _borderProps.ApplyStrokeMode
            )
        )
        local _borderStrokeProps = TableUtil.Assign(DefaultBorderStrokeProps, {
            Color = _borderProps.Color,
            Thickness = _borderProps.Thickness,
            Transparency = _borderProps.Transparency,
            LineJoinMode = _borderProps.LineJoinMode,
            ApplyStrokeMode = _borderProps.ApplyStrokeMode,
        })

        -- Border can be rendered as __BG Frame's border or a separated __Border Frame
        if _renderBorderElement then
            local _borderFrameProps = TableUtil.Assign(DefaultBorderFrameProps, {})
            if _bgProps then
                _borderFrameProps = TableUtil.Assign(_borderFrameProps, _bgProps)
                _bgProps.BorderSizePixel = 0
            end
            if _borderProps.Size then
                -- -1 scale because this is relative to Background
                _borderFrameProps.Size += (_borderProps.Size - UDim2.new(1, 0, 1, 0))
            end
            if _borderProps.Offset then _borderFrameProps.Position += _borderProps.Offset end
            _borderFrameProps.Rotation = _borderProps.Rotation
            _borderFrameProps[Roact.Children] = { UIStroke = Roact.createElement('UIStroke', _borderStrokeProps) }
            local _borderCornerRadius = _borderProps.CornerRadius or (_bgProps and _bgProps.CornerRadius)
            if _borderCornerRadius then
                _borderFrameProps[Roact.Children].UICorner = Roact.createElement('UICorner', { CornerRadius = _borderProps.CornerRadius })
            end
            _borderFrameProps.ZIndex = DefaultZIs.Border
            _rootChildren.__Border = Roact.createElement('Frame', _borderFrameProps)
        else
            if _bgProps then _bgProps.BorderSizePixel = _borderStrokeProps.Thickness end
        end
    end

    -- Shadow
    if _props.Shadow and _bgProps then
        local _shadowProps = TableUtil.Assign(DefaultShadowProps, {
            Size = _bgProps.Size,
            BackgroundColor3 = _props.Shadow.Color3,
            BackgroundTransparency = _props.Shadow.Transparency or 0,
            Rotation = _props.Shadow.Rotation,
        })
        if _bgProps then
            _shadowProps.Position = _bgProps.Position + (_props.Shadow.Offset or DefaultShadowOffset)
        end
        if _props.Shadow.Size then
            -- -1 scale because this is relative to Background
            _shadowProps.Size += (_props.Shadow.Size - UDim2.new(1, 0, 1, 0))
        end
        local _shadowCornerRadius = _props.Shadow.CornerRadius or _bgCornerRadius
        if _shadowCornerRadius then
            _shadowProps[Roact.Children] = { UICorner = Roact.createElement('UICorner', { CornerRadius = _shadowCornerRadius }) }
        end
        _shadowProps.ZIndex = DefaultZIs.Shadow
        _rootChildren.__Shadow = Roact.createElement('Frame', _shadowProps)
    end

    -- Scroll??
    local _scroll = false
    if _props.Scroll  then
        _scroll = true
        for key, value in pairs(_props.Scroll) do
            _props[key] = value
        end
    end
    
    -- clear non-standard properties from actual Roblox Instance
    _props.Padding = nil
    _props.Background = nil
    _props.Border = nil
    _props.Shadow = nil
    _props.Scroll = nil

    if _bgProps then
        _rootChildren.__BG = Roact.createElement('Frame', _bgProps)
    end
    _props[Roact.Children] = _rootChildren
    return _scroll
        and Roact.createElement('ScrollingFrame', _props)
        or Roact.createElement('Frame', _props)
end

return Box
