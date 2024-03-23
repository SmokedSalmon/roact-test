--[[
    GUI's Global Store using Roact's Context API
    Also includes the create Store Helper
]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Packages.roact)
type StoreType = {
    actions: {},
    ProvideFor: ({Roact.Component}) -> Roact.Component,
    asConsumer: (Roact.Component, ((state: any) -> any)?) -> Roact.Component,
}

-- Create Store Helper function
local function createStore(defaultValue: any, name: string?): StoreType
    local _context = Roact.createContext(defaultValue)
    local _name = name or 'Store'
    local Provider = Roact.PureComponent:extend(`{_name}Provider`)
    function Provider:init()
        self:setState(defaultValue)
    end

    function Provider:render()
        return Roact.createElement(_context.Provider, {
            value = self.state
        }, self.props[Roact.Children])
    end

    local actions = {} -- [TODO]

    local function asConsumer(
        ConsumerComponent: Roact.Component | string,
        storeToPropFunc: ((state: any) -> any)?
    ): Roact.Component
        local _getProp = storeToPropFunc or function(state: any) return state end
        return Roact.createElement(_context.Consumer, {
            render = function(store)
                return Roact.createElement(ConsumerComponent, _getProp(store))
            end,
        })
    end

    return {
        actions = actions,
        ProvideFor = function(children: {Roact.Component}?)
            return Roact.createElement(Provider, {}, children)
        end,
        asConsumer = asConsumer,
        Context = _context,
    }
end

local GlobalStore = createStore({}, 'GlobalStore')

local Store = {
    Global = GlobalStore,
    create = createStore,
}

return Store
