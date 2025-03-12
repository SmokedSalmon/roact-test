# Store Module

## Overview
A global state management module using **Roact's Context API** for Roblox GUI development.

> It is recommended to create a **Singleton** Store Instance, with:
> - defined **Reducer** function
> - a **Global State** Object
> - `WithXXX` helper function to **connect** pure Component with access Global State
>
> Please refer to the [UIState.lua](../../../src/ui-test/ReplicatedStorage/UIState.lua) for examples

## Features
- Centralized state management using **Roact's Context API**.
- Support for **Redux-like** `createStore`, `Provider`, and `Consumer` components.
- Higher-order component `WithStore` to connect components to the store.


## Usage
### Create A Store
Call the `createStore` function with initial state and a reducer function.

#### Options
- `initState`: The initial state of the store.
- `reducer`: A function that takes the current state, action name, and payload, and returns the new state.

#### Example Codes
```lua
local StoreModule = require(path.to.StoreModule)
local initialState = { counter = 0 }
local function reducer(state, action, payload)
    if action == "increment" then
        return { counter = state.counter + 1 }
    elseif action == "decrement" then
        return { counter = state.counter - 1 }
    end
    return state
end

local store = StoreModule.createStore(initialState, reducer)
```

### Using the Store with Components

#### Example Codes
See [UIState.lua](../../../src/ui-test/ReplicatedStorage/UIState.lua) for examples