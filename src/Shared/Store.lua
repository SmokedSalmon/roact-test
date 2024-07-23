--[[
    GUI's Global Store using Roact's Context API
]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Packages.roact)
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
type StoreType = {
    Provider: Roact.Component,
    Consumer: Roact.Component,
    dispatch: (string, {any}?) -> nil,
}

local function createStore(initState: any, reducer: () -> ({})): StoreType
    local _context = Roact.createContext(initState or {})
    local Provider = Roact.PureComponent:extend('StoreProvider')

    local actions = {} -- [TODO]

    function Provider:init()
        local dispatch
        if reducer and typeof(reducer) == 'function' then
            dispatch = function(name: string, payload: {any}?)
                local newState = reducer(self.state, name, payload)
                self:setState(newState)
            end
        else
            dispatch = function() end
        end
        print(dispatch)
        initState.dispatch = dispatch
        self:setState(initState)
    end

    function Provider:render()
        return Roact.createElement(_context.Provider, {
            value = self.state
        }, self.props[Roact.Children])
    end

    return {
        actions = actions,
        Provider = Provider,
        Consumer = _context.Consumer,
        Context = _context,
    }
end

-- The good old Redux 'connect' pattern
function WithStore(Component: Roact.Component, Store: StoreType, mapStateToProps: any, mapDispatchToProps: any): Roact.Component
    if not mapStateToProps then
        mapStateToProps = function(state) return state end
    end
    if not mapDispatchToProps then
        mapDispatchToProps = function() return {} end
    end
    
    return function (props: {}?)
        return Roact.createElement(Store.Consumer, {
            render = function(stateWithDispatch)
                local dispatch = stateWithDispatch.dispatch
                local _props = TableUtil.Assign(props or {}, mapStateToProps(stateWithDispatch))
                _props.dispatch = nil
                _props = TableUtil.Assign(_props, mapDispatchToProps(dispatch, props))
                return Roact.createElement(Component, _props)
            end
        })
    end
end

-- The React's hook API and useXXX patter
-- [TODO] we need to pass the entire hook object and wrap the underlying Component
-- function useStore()
-- end

local StoreModule = {
    createStore = createStore,
    WithStore = WithStore,
}

return StoreModule
