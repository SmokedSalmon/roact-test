--[[
    Framed Image
]]
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Roact = require(ReplicatedStorage.Packages.roact)
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
local Components = ReplicatedStorage.Shared.Components
local AtomicComponents = Components.Atomic
local Box = require(AtomicComponents.Box)

-- Constants & Configs
local defaultFramePadding = {
    PaddingLeft = UDim.new(0, 10),
    PaddingTop = UDim.new(0, 10),
    PaddingRight = UDim.new(0, 10),
    PaddingBottom = UDim.new(0, 10),
}

local defaultOuterProps = {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(1, 0, 1, 0),
    Size = UDim2.new(1, 0, 1, 0),
}

local defaultBgProps = {
    BackgroundColor3 = Color3.fromRGB(118, 214, 255),
    CornerRadius = UDim.new(0, 10),
}
local defaultImageProps = {
    Image = 'rbxasset://textures/ui/GuiImagePlaceholder.png',
    Position = UDim2.new(0, 0, 0, 0),
    Size = UDim2.new(1, 0, 1, 0),
    BorderSizePixel = 0,
    ScaleType = Enum.ScaleType.Stretch,
}

local ImageFrame = Roact.PureComponent:extend('ImageFrame')

function ImageFrame(props: {}?)

    local _outerProps = TableUtil.Assign(defaultOuterProps, props)
    _outerProps.Padding = TableUtil.Assign({}, _outerProps.Padding)
    _outerProps.Background = TableUtil.Assign(defaultBgProps, _outerProps.Background)
    _outerProps.Border = TableUtil.Assign({}, _outerProps.Border)
    _outerProps.Shadow = TableUtil.Assign({}, _outerProps.Shadow)
    local _framePadding = _outerProps.FramePadding or table.clone(defaultFramePadding)
    _outerProps.FramePadding = nil
    local _imageProps = TableUtil.Assign(defaultImageProps, {
        Image = _outerProps.Image,
        ImageColor3 = _outerProps.ImageColor3,
        ImageTransparency = _outerProps.ImageTransparency,
        ScaleType = _outerProps.ScaleType,
    })
    _outerProps.Image = nil
    _outerProps.ImageColor3 = nil
    _outerProps.ImageTransparency = nil
    _outerProps.ScaleType = nil

    return Roact.createElement(Box, _outerProps, {
        ImageBox = Roact.createElement(Box, {
            Position = UDim2.new(0, 0, 0, 0),
            Size = UDim2.new(1, 0, 1, 0),
            Padding = _framePadding,
        }, {
            Image = Roact.createElement('ImageLabel', _imageProps)
        })
    })
end

return ImageFrame
