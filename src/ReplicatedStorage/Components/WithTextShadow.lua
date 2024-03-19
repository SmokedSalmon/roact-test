local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Roact = require(ReplicatedStorage.Packages.roact)

-- Constants & Configs
local ZIndexDiff = -1

local function WithShadowWrapper(WrappedTextComponent: Roact.Component | string)
    local ComponentWithShadow = Roact.Component:extend('WithShadow')
    
    function ComponentWithShadow:render()
        local propsToUse = table.clone(self.props)
        propsToUse.Position = UDim2.new(propsToUse.Position.X + UDim.new(0, 3), propsToUse.Position.Y + UDim.new(0, 3))
        propsToUse.ZIndex = (self.props.ZIndex or 0) + ZIndexDiff
        -- local children = self.props[Roact.Children] or {}
        local Name = self.props.Name or 'Text'
        local ShadowName = `{Name}-Shadow`
        
        return Roact.createFragment({
            [Name] = Roact.createElement(WrappedTextComponent, self.props),
            -- Roact.createElement(WrappedComponent, propsToUse, children)
            [ShadowName] = Roact.createElement('TextLabel', propsToUse)
        })
    end

    return ComponentWithShadow
end

return WithShadowWrapper
