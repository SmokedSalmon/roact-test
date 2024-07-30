--[[
    Album Section for item Description Panel
]]
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
local Roact = require(ReplicatedStorage.Packages.roact)
local Box = require(ReplicatedStorage.Modules.Components.Atomic.Box)
local ImageFrame = require(ReplicatedStorage.Modules.Components.ImageFrame)

-- Constants & Configs
local defaultImage1Props = {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.45, 0, 0.36, 0),
    Size = UDim2.new(0.9, 0, 0.65, 0),
    ZIndex = 10,
    Rotation = 2,
    Background = {
        BackgroundColor3 = Color3.fromRGB(118, 214, 255),
        CornerRadius = UDim.new(0, 10),
    }
}
local defaultImage2Props = {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.284, 0, 0.67, 0),
    Size = UDim2.new(0.354, 0, 0.295, 0),
    ZIndex = 11,
    Rotation = 4,
    Background = {
        Color3 = Color3.fromRGB(255, 126, 121),
        CornerRadius = UDim.new(0, 5),
    },
    Shadow = {
        Color3 = Color3.fromRGB(148, 17, 0),
        Offset = UDim2.new(0, 5, 0, 5),
    }
}
local defaultImage3Props = {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.61, 0, 0.55, 0),
    Size = UDim2.new(0.334, 0, 0.279, 0),
    ZIndex = 12,
    Rotation = 4,
    Background = {
        Color3 = Color3.fromRGB(255, 126, 121),
        CornerRadius = UDim.new(0, 5),
    },
    Shadow = {
        Color3 = Color3.fromRGB(148, 17, 0),
        Offset = UDim2.new(0, 6, 0, 6),
    }
}
local defaultImage4Props = {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.65, 0, 0.8, 0),
    Size = UDim2.new(0.290, 0, 0.242, 0),
    ZIndex = 13,
    Rotation = 4,
    Background = {
        Color3 = Color3.fromRGB(255, 126, 121),
        CornerRadius = UDim.new(0, 5),
    },
    Shadow = {
        Color3 = Color3.fromRGB(148, 17, 0),
        Offset = UDim2.new(0, 8, 0, 8),
    }
}

local DescGallery = Roact.Component:extend('DescGallery')

function DescGallery:render()
    local _rootProps = TableUtil.Assign({}, self.props)
    local _image1Props = TableUtil.Assign(defaultImage1Props, _rootProps.Image1)
    _rootProps.Image1 = nil
    local _image2Props = TableUtil.Assign(defaultImage2Props, _rootProps.Image2)
    _rootProps.Image2 = nil
    local _image3Props = TableUtil.Assign(defaultImage3Props, _rootProps.Image3)
    _rootProps.Image3 = nil
    local _image4Props = TableUtil.Assign(defaultImage4Props, _rootProps.Image4)
    _rootProps.Image4 = nil

    
    return Roact.createElement(Box, _rootProps, {
        Image1 = Roact.createElement(ImageFrame, _image1Props),
        Image2 = Roact.createElement(ImageFrame, _image2Props),
        Image3 = Roact.createElement(ImageFrame, _image3Props),
        Image4 = Roact.createElement(ImageFrame, _image4Props),
    })
end

return DescGallery
