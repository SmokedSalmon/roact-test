--[[
    Adds Event props and behaviors to Components, as substitute of the key "[Roact.Event{event-name}]"
    Make sure the Wrapped Component owns no property named 'Events', as it is the very key of the property to inject
]]
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Roact = require(ReplicatedStorage.Packages.roact)

function WithEventsWrapper(WrappedComponent: Roact.Component | string)
    local ComponentWithEvents = Roact.Component:extend('WithEvents')
    
    function ComponentWithEvents:render()
        if self.props and self.props.Event and typeof(self.props.Event) == 'table' then
            for event, handler in pairs(self.props.Event) do
                self.props[Roact.Event[event]] = handler
            end
            self.props.Event = nil
        end
        return Roact.createElement(WrappedComponent, self.props)
    end

    return ComponentWithEvents
end

return WithEventsWrapper
