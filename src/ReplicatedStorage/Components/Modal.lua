local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Roact = require(ReplicatedStorage.Packages.roact)

local WithTextShadow = require(ReplicatedStorage.Components.WithTextShadow)

-- Constants & Configs
-- TODO centralize zIndex settings
local ZIs = {
    bg = -10,
    modal = 0,
    title = 10,
}
-- To be replaced by a Title Component --
local function createModalTitle(props)
    if not props then
        return Roact.createElement('TextLabel', {
            Text = 'Default Title'
        }, {})
    end
    
    local titleText = props.title or 'DefaultTitle'
    -- TODO theme
    local fontFace = props.fontFace or Font.new('rbxasset://fonts/families/JosefinSans.json', Enum.FontWeight.Bold, Enum.FontStyle.Normal)
    return  Roact.createElement(WithTextShadow('TextLabel'), {
        Text = titleText,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0, 0),
        FontFace = fontFace,
        TextSize = 50,
        TextXAlignment = Enum.TextXAlignment.Center,
        TextYAlignment = Enum.TextYAlignment.Center,
        ZIndex = ZIs.title,
    })
end

-- ===== Modal Component ===== --
local Modal = Roact.PureComponent:extend('Modal')

function Modal:init()
    -- print('Modal has initiated')
end

function Modal:render()
    local _props = table.clone(self.props or {})
    _props.AnchorPoint = Vector2.new(0.5, 0.5)
    _props.Name = _props.Name or 'TestModal'
    _props.Position = UDim2.new(0.5, 0, 0.5, 0)
    _props.Size = UDim2.new(0.5, 0, 0.6, 0)
    _props.Rotation = 0
    _props.ZIndex = ZIs.modal
    
    -- local children = _props[Roact.Children]
    -- if children.Title then
    --     warn(`You passed a 'Title' Modal's props, it will be replaced by Modal's Internal Title component. You can change props.Title to avoid this`)
    -- end
    -- children.Title = createModalTitle({ title = _props.title })

    local children = table.clone(_props[Roact.Children] or {})
    local title = createModalTitle({ title = _props.title })
    _props.title = nil
    table.insert(children, title)
    _props[Roact.Children] = children
    return Roact.createElement('Frame', _props)
end

return Modal
