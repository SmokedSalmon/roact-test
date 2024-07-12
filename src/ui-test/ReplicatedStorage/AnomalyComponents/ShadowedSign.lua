--[[
    Shadow-Style Text as Panel Sign
]]
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Roact = require(ReplicatedStorage.Packages.roact)
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)

-- Constants & Configs
local defaultProps = {
    Name = 'ShadowedSign',
    BackgroundTransparency = 1,
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0, 0),
    Size = UDim2.new(0, 200, 0, 50),
    Color = Color3.fromRGB(255, 255, 255),
    ShadowColor = Color3.fromRGB(115, 250, 121),
    FontFace = Font.new('rbxasset://fonts/families/JosefinSans.json', Enum.FontWeight.Bold),
    TextXAlignment = Enum.TextXAlignment.Center,
    TextYAlignment = Enum.TextYAlignment.Center,
}

local ShadowedSign = Roact.Component:extend('ShadowedSign')

function ShadowedSign(props: {}?)
    local _props = TableUtil.Assign(defaultProps, props)
    _props.TextColor3 = _props.ShadowColor
    _props.ShadowColor = nil
    local _props2 = table.clone(_props)
    _props2.Position = UDim2.new(0.5, -3, 0.5, -3)
    _props2.Name = 'TopText'
    _props2.TextColor3 = _props2.Color
    _props.Color = nil
    _props2.Color = nil
    
    return Roact.createElement('TextLabel', _props, {
        UIStroke = Roact.createElement('UIStroke', {
            Color = _props.TextColor3,
            Thickness = 2,
        }),
        Top = Roact.createElement('TextLabel', _props2)
    })
end

return ShadowedSign
