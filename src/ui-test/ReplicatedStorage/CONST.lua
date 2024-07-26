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

local TutorialChapters = {
    {
        id = 'tutorial-c1',
        name = 'Basics',
        levels = {
            { id = 't1-1', name = 'Basics-1' },
            { id = 't1-2', name = 'Basics-2' },
            { id = 't1-3', name = 'Basics-3' },
            { id = 't1-4', name = 'Basics-4' },
            { id = 't1-5', name = 'Basics-5' },
        },
        next = 'tutorial-c2',
    },
    {
        id = 'tutorial-c2',
        name = 'Block Them Up',
        levels = {
            { id = 't2-1', name = 'Block Them Up-1' },
            { id = 't2-2', name = 'Block Them Up-2' },
            { id = 't2-3', name = 'Block Them Up-3' },
            { id = 't2-4', name = 'Block Them Up-4' },
        },
        next = 'Chapter3',
    },
    {
        id = 'tutorial-c3',
        name = 'Combos, Tech-up',
        levels = {
            { id = 't3-1', name = 'Combos & Tech 3-1' },
            { id = 't3-2', name = 'Combos & Tech 3-2' },
        },
        next = nil,
    },
}
table.freeze(TutorialChapters)

return {
    Chapters = Chapters,
    TutorialChapters = TutorialChapters,
}