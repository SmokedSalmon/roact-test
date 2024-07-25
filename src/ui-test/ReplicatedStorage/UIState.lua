local ReplicatedStorage = game:GetService('ReplicatedStorage')
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
local Store = require(ReplicatedStorage.Shared.Store)

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
-- [TODO] move to Constants or configs
local _ChapterDefs = {
    Chapter1 = { id = 'Chapter1', name = 'Chapter 1', levels = 7, next = 'Chapter2' },
    Chapter2 = { id = 'Chapter2', name = 'Chapter 2', levels = 3, next = nil },
}
local _PlayerAssetDefs = {

}
local _InitState: UIStateType = {
    progress = { Chapter1 = 1, Chapter2 = 0 },
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
        local mLevel = _ChapterDefs[chapter] and _ChapterDefs[chapter].levels
        if not mLevel then
            warn(`[{name}] Invalid chapter - {payload.chapter and payload.chapter}`)
            return table.clone(state)
        end

        local progress = state.progress
        if progress[chapter] >= mLevel then
            local nextChapter = _ChapterDefs[chapter].next
            if not nextChapter then
                return table.clone(state)
            end
            return TableUtil.Assign(state, {
                progress = TableUtil.Assign(progress, {
                    [chapter] = _ChapterDefs[chapter].levels,
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
        -- if not payload or not payload.chapter or not _ChapterDefs[payload.chapter] then
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
