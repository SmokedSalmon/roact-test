--[[
    Album Section for item Description Panel
]]
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
local Roact = require(ReplicatedStorage.Packages.roact)
local Box = require(ReplicatedStorage.Shared.Components.Atomic.Box)

-- Constants & Configs
local defaultFramePadding = {
    PaddingLeft = UDim.new(0, 10),
    PaddingTop = UDim.new(0, 10),
    PaddingRight = UDim.new(0, 10),
    PaddingBottom = UDim.new(0, 10),
}
local defaultInnerImageProps = {
    Image = 'rbxasset://textures/ui/GuiImagePlaceholder.png',
    Position = UDim2.new(0, 0, 0, 0),
    Size = UDim2.new(1, 0, 1, 0),
    BorderSizePixel = 0,
    ScaleType = Enum.ScaleType.Stretch,
}
local defaultImage1BgProps = {
    BackgroundColor3 = Color3.fromRGB(118, 214, 255),
    CornerRadius = UDim.new(0, 10),
}
local defaultImage1Props = {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.45, 0, 0.35, 0),
    Size = UDim2.new(0.9, 0, 0.6, 0),
    ZIndex = 10,
    Rotation = 2,
}

local DescGallery = Roact.Component:extend('DescGallery')

function DescGallery:render()
    local _rootProps = TableUtil.Assign({}, self.props)
    local _image1Props = TableUtil.Assign(defaultImage1Props, _rootProps.Image1)
    _image1Props.Padding = TableUtil.Assign({}, _image1Props.Padding)
    _image1Props.Background = TableUtil.Assign(defaultImage1BgProps, _image1Props.Background)
    _image1Props.Border = TableUtil.Assign({}, _image1Props.Border)
    _image1Props.Shadow = TableUtil.Assign({}, _image1Props.Shadow)
    local _image1FramePadding = _image1Props.FramePadding or table.clone(defaultFramePadding)
    _image1Props.FramePadding = nil
    local _innerImage1Props = TableUtil.Assign(defaultInnerImageProps, {
        Image = _image1Props.Image,
        ImageColor3 = _image1Props.ImageColor3,
        ImageTransparency = _image1Props.ImageTransparency,
        ScaleType = _image1Props.ScaleType,
    })
    _image1Props.Image = nil
    _image1Props.ImageColor3 = nil
    _image1Props.ImageTransparency = nil
    _image1Props.ScaleType = nil
    _rootProps.Image1 = nil
    
    return Roact.createElement(Box, _rootProps, {
        Image1 = Roact.createElement(Box, _image1Props, {
            ImageBox = Roact.createElement(Box, {
                Position = UDim2.new(0, 0, 0, 0),
                Size = UDim2.new(1, 0, 1, 0),
                Padding = _image1FramePadding,
            }, {
                Image = Roact.createElement('ImageLabel', _innerImage1Props)
            })
        })
    })
end

return DescGallery
