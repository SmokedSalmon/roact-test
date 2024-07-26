--[[
    Game Constants
]]

-- Chapter & Level Definitions
local Chapters = {
    {
        id = 'Chapter1',
        name = 'Chapter 1',
        levels = {
            { id = '1-1', name = 'Level 1-1' },
            { id = '1-2', name = 'Level 1-2' },
            { id = '1-3', name = 'Level 1-3' },
            { id = '1-4', name = 'Level 1-4' },
            { id = '1-5', name = 'Level 1-5' },
            { id = '1-6', name = 'Level 1-6' },
            { id = '1-7', name = 'Level 1-7' },
        },
        next = 'Chapter2',
    },
    {
        id = 'Chapter2',
        name = 'Chapter 2',
        levels = {
            { id = '2-1', name = 'Level 2-1' },
            { id = '2-2', name = 'Level 2-2' },
            { id = '2-3', name = 'Level 2-3' },
        },
        next = 'Chapter3',
    },
    {
        id = 'Chapter3',
        name = 'Chapter 2',
        levels = {
            { id = '3-1', name = 'Level 3-1' },
            { id = '3-2', name = 'Level 3-2' },
            { id = '3-3', name = 'Level 3-3' },
            { id = '3-4', name = 'Level 3-4' },
            { id = '3-5', name = 'Level 3-5' },
        },
        next = nil,
    },
}
table.freeze(Chapters)

return {
    Chapters = Chapters,
}