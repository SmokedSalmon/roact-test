local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Roact = require(ReplicatedStorage.Packages.roact)

-- TODO Constants & Configs
local ZIs = {
    Shadow = -11,
}

local function WithShadowWrapper(WrappedComponent: Roact.Component | string)
    local ComponentWithShadow = Roact.Component:extend('WithShadow')
    
    function ComponentWithShadow:render()
        local propsToUse = table.clone(self.props)
        local children = self.props[Roact.Children] or {}
        children.Shadow = Roact.createElement('Frame', {
            Position = UDim2.new(0, 3, 0, 3),
            Size = UDim2.new(1, 0, 1, 0),
            Rotation = 0,
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            BorderSizePixel = 0,
            ZIndex = ZIs.Shadow,
        })
        return Roact.createElement(WrappedComponent, propsToUse, children)
    end

    return ComponentWithShadow
end

return WithShadowWrapper
