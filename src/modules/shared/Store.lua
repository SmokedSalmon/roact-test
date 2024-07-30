--[[
    GUI's Global Store using Roact's Context API
]]
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Packages.roact)
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
export type DispatchType = (string, {}?) -> nil
export type StoreType = {
    Context: { Provider: Roact.Component, Consumer: Roact.Component }, -- internal Roact.Context Object
    Provider: Roact.Component,
    Consumer: Roact.Component,
}

local function createStore(initState: any, reducer: () -> ({})): StoreType
    local _context = Roact.createContext(initState or {})
    -- Store manipulator
    local _dispatch
    -- Extend Roact.Context.Provider with Store features by injecting Store's reducer in it
    local Provider = Roact.PureComponent:extend('StoreProvider')

    function Provider:init()
        if reducer and typeof(reducer) == 'function' then
            _dispatch = function(name: string, payload: {any}?)
                local newState = reducer(self.state, name, payload)
                self:setState(newState)
            end
        else
            _dispatch = function() end
        end
        self:setState(initState)
    end

    function Provider:render()
        return Roact.createElement(_context.Provider, {
            -- pass an array containing the getter and setter of the Store, similar to React's useReducer
            value = { self.state, _dispatch }
        }, self.props[Roact.Children])
    end

    return {
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
            render = function(storeHandle)
                local state, dispatch = unpack(storeHandle)
                local _props = TableUtil.Assign(props or {}, mapStateToProps(state))
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
