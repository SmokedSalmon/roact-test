local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Roact = require(ReplicatedStorage.Packages.roact)

local WithTextShadow = require(ReplicatedStorage.Components.WithTextShadow)

-- TODO Constants & Configs
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
local Modal = Roact.Component:extend('Modal')

function Modal:init()
    print('Modal has initiated')
end

function Modal:render()
    -- local children = self.props[Roact.Children]
    -- if children.Title then
    --     warn(`You passed a 'Title' Modal's props, it will be replaced by Modal's Internal Title component. You can change props.Title to avoid this`)
    -- end
    -- children.Title = createModalTitle({ title = self.props.title })

    local children = table.clone(self.props[Roact.Children] or {})
    local title = createModalTitle({ title = self.props.title })
    table.insert(children, title)
    return Roact.createElement('Frame', {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Name = 'TestModal',
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0.5, 0, 0.6, 0),
        Rotation = 0,
        ZIndex = ZIs.modal,
    }, children)
end

return Modal
