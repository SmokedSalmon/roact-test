local ReplicatedStorage = game:GetService('ReplicatedStorage')
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
local Store = require(ReplicatedStorage.Shared.Store)
local CONST = require(ReplicatedStorage.CONST)

-- Player Level Progress
export type ProgressType = {
    [string]: number,
}
export type GenericAssetRegistryType = { [number | string]: boolean }
export type PlayerAssetType = {
    towers: {GenericAssetRegistryType},
    upgrades: {GenericAssetRegistryType},
    accessories: {GenericAssetRegistryType},
}

export type UIStateType = {
    progress: ProgressType,
    owned: PlayerAssetType,
}

-- === Progress Related ===
type ChapterType = { id: string, name: string, levels: number, next: string? }

local _initProgress = {}
_initProgress[1] = 1
for i = 2, #CONST.Chapters do
    _initProgress[i] = 0
end
-- Test
_initProgress[1] = 3
_initProgress[2] = 2
local _InitState: UIStateType = {
    progress = _initProgress,
    owned = {
        towers = {
            [1] = true,
            [2] = true,
            [3] = false,
            [4] = true,
            [5] = false,
            -- ...
        },
        upgrades = {},
        accessories = {},
    }
}

-- Reducer
function Reducer(state: UIStateType, name: string, payload: any)
    if name == 'advance_progress' then
        if not payload then
            warn(`[{name}] Missing payload`)
            return table.clone(state)
        end
        if not payload.chapter then
            warn(`[{name}] Invalid chapter - {payload.chapter and payload.chapter}`)
            return table.clone(state)
        end
        local chapter = payload.chapter
        local mLevel = CONST.Chapters[chapter] and #CONST.Chapters[chapter].levels
        if not mLevel then
            warn(`[{name}] Invalid chapter - {payload.chapter and payload.chapter}`)
            return table.clone(state)
        end

        local progress = state.progress
        if progress[chapter] >= mLevel then
            local nextChapter = chapter + 1
            if not nextChapter then
                return table.clone(state)
            end
            return TableUtil.Assign(state, {
                progress = TableUtil.Assign(progress, {
                    [chapter] = #CONST.Chapters[chapter].levels,
                    [nextChapter] = 1
                })
            })
        else
            return TableUtil.Assign(state, {
                progress = TableUtil.Assign(progress, {
                    [chapter] = progress[chapter] + 1
                })
            })
        end
        
    elseif name == 'update_progress' then
        -- [TODO]
        -- if not payload or not payload.chapter or not CONST.Chapters[payload.chapter] then
        --     warn(`[{name}] Invalid chapter - {payload.chapter and payload.chapter}`)
        --     return table.clone(state)
        -- end

    elseif name == 'reducer_test' then
        print('reducer_test')
        return table.clone(state)
    end
end

-- Create the Global UIState Store object
local GlobalStore: UIStateType = Store.createStore(_InitState, Reducer)

-- Quick helper/wrapper to make a Component access this Global UIState
function WithUIState(Component: Roact.Component, mapStateToProps: any, mapDispatchToProps: any): Roact.Component
    return Store.WithStore(Component, GlobalStore, mapStateToProps, mapDispatchToProps)
end

return {
    Reducer = Reducer,
    WithUIState = WithUIState,
    Store = GlobalStore,
}
