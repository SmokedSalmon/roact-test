--[[
    GUI's Global Store using Roact's Context API
]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Packages.roact)
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
type StoreType = {
    Provider: Roact.Component,
    Consumer: Roact.Component,
}

local function createStore(initState: any): StoreType
    local _context = Roact.createContext(initState or {})
    local Provider = Roact.PureComponent:extend('StoreProvider')
    function Provider:init()
        self:setState(initState)
    end

    function Provider:render()
        return Roact.createElement(_context.Provider, {
            value = self.state
        }, self.props[Roact.Children])
    end

    local actions = {} -- [TODO]

    return {
        actions = actions,
        Provider = Provider,
        Consumer = _context.Consumer,
        Context = _context,
    }
end

function WithStore(Component: Roact.Component, Store: StoreType, mapStateToProps: any, mapDispatchFunc: any)
    if not mapStateToProps then
        mapStateToProps = function(state) return state end
    end
    if not mapDispatchFunc then
        mapDispatchFunc = function() return {} end
    end
    
    return function (props: {}?)
        return Roact.createElement(Store.Consumer, {
            render = function(state)
                local _props = TableUtil.Assign(props or {}, mapStateToProps(state))
                _props = TableUtil.Assign(_props, mapDispatchFunc(state))
                return Roact.createElement(Component, _props)
            end
        })
    end
end

local StoreModule = {
    createStore = createStore,
    WithStore = WithStore,
}

return StoreModule
