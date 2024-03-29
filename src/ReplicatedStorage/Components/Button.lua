--[[
    Button Component
    [TODO] Image Button
]]
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Roact = require(ReplicatedStorage.Packages.roact)
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)

-- Constants & Configs
local DefaultUIPadding = {
    PaddingLeft = UDim.new(0, 10),
    PaddingTop = UDim.new(0, 10),
    PaddingRight = UDim.new(0, 10),
    PaddingBottom = UDim.new(0, 10),
}
local DefaultRootContainerProps = {
    -- [TODO] make this a Container Root Component
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    AutomaticSize = Enum.AutomaticSize.XY, -- Default fit to content
}
local DefaultTextButtonProps = {
    Size = UDim2.new(1, 0, 1, 0),
    AutomaticSize = Enum.AutomaticSize.XY, -- Default fit to content
}

local Button = Roact.Component:extend('Button')

function Button:render()
    local _props = TableUtil.Assign(DefaultRootContainerProps, self.props or {})
    local _paddingProps = TableUtil.Assign(DefaultUIPadding, _props.padding or {})
    _props.padding = nil
    
    local _textButtonProps = TableUtil.Assign(DefaultTextButtonProps, _props.textButton or {})
    _props.textButton = nil

    _props[Roact.Children] = TableUtil.Assign({
        TextButton = Roact.createElement('TextButton', _textButtonProps, {
            UIPadding = Roact.createElement('UIPadding', _paddingProps),
        }),
    }, _props[Roact.Children])
    
    return Roact.createElement('Frame', _props)
end

return Button
