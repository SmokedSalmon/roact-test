local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Roact = require(ReplicatedStorage.Packages.roact)
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)

local Components = ReplicatedStorage.Shared.Components
local AtomicComponents = Components.Atomic
local StoreService = require(ReplicatedStorage.Shared.Store)
local Modal = require(Components.Modal)
local WithCustomBackground = require(AtomicComponents.WithCustomBackground)
local GridContainer = require(Components.GridContainer)
local RowContainer = require(Components.RowContainer)
local ColumnContainer = require(Components.ColumnContainer)
local Card = require(Components.Card)
local ColorSquareButton = require(script.Parent.ColorSquareButton)
local ItemCard = require(script.Parent.ItemCard)
local ShadowedSign = require(script.Parent.ShadowedSign)
local PanelTabButton = require(script.Parent.PanelTabButton)
local StatItem = require(script.Parent.StatItem)
local DescGallery = require(script.Parent.DescGallery)
local ListContainer = require(AtomicComponents.ListContainer)
local Box = require(AtomicComponents.Box)

function LevelCard()
    return ItemCard({
        Size = UDim2.new(0, 160, 0, 100 ),
        Padding = {
            PaddingLeft = UDim.new(0, 10),
            PaddingTop = UDim.new(0, 10),
            PaddingRight = UDim.new(0, 10),
            PaddingBottom = UDim.new(0, 10),
        }
    })
end

function LevelRow(chapter: string, level: string, active: boolean)
    local rCount = math.round(math.random(1, 3))
    local cardChildren = {}
    for i = 1, rCount do
        cardChildren[`Card{i}`] = LevelCard()
    end
    return Roact.createElement(ColumnContainer, {
        AutomaticSize = Enum.AutomaticSize.Y,
        Size = UDim2.new(1, 0, 0, 0),
        Scroll = false,
        BackgroundColor3 = Color3.fromRGB(128, 128, 128),
        BackgroundTransparency = active and 1 or 0.5,
    }, cardChildren)
end

local SelectLevelPanel = Roact.PureComponent:extend('PlayMenu')

function SelectLevelPanel:loadProgress()
    if self.state.loading then return end

    self:setState(TableUtil.Assign(self.state, {
        loading = true,
        error = '',
    }))

    -- TODO make/use a promise-like helper for such async action
    coroutine.wrap(function()
        task.wait(2)
        self:setState(TableUtil.Assign(self.state, {
            loading = false
        }))
    end)()
end

local function MainContent(contents: {})
    local level = contents.level
    local advanceChapter = contents.advanceChapter
    local levelRows = contents.levelRows
    
    return Roact.createFragment({
        -- Left Tab
        LeftTab = Roact.createElement(Box, {
            Position = UDim2.new(-0.15, 0, 0.2, 0),
            Size = UDim2.new(0.3, 0.85),
        }, {
            UIListLayout = Roact.createElement('UIListLayout', {
                FillDirection = Enum.FillDirection.Vertical,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
            }),
            TestText = Roact.createElement('TextLabel', {
                Text = `Chapter1: {level}`,
            }),
            Button1 = PanelTabButton({
                Button = { Text = 'Basics' },
                Square = { BackgroundColor3 = Color3.fromRGB(115, 253, 255) },
            }),
            Button2 = PanelTabButton({
                Button = { Text = 'Block Them Up' },
                Square = { BackgroundColor3 = Color3.fromRGB(212, 251, 121) },
            }),
            Button3 = PanelTabButton({
                Button = { Text = 'Combos, Tech-up' },
                Square = { BackgroundColor3 = Color3.fromRGB(255, 212, 121) },
            }),
            Button4 = PanelTabButton({
                Button = { Text = 'Next Level' },
                Square = { BackgroundColor3 = Color3.fromRGB(208, 31, 190) },
                Event = {
                    Activated = advanceChapter
                }
            }),
        }),
        -- Row/Column Container
        Container1 = Roact.createElement(RowContainer, {
            Position = UDim2.new(0.1, 0, 0.15, 0),
            Size = UDim2.new(0.9, 0, 0.85, 0),
            List = {
                Padding = UDim.new(0, 10),
            }
        }, {
            Row1 = Roact.createElement(Box, {
                AutomaticSize = Enum.AutomaticSize.Y,
                Size = UDim2.new(1, 0, 0, 0),
            }, {
                ChapterDesc = Roact.createElement('TextLabel', {
                    BackgroundTransparency = 1,
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Size = UDim2.new(1, 0, 0, 0),
                    Text = 'Integer ante lorem, placerat eu pellentesque non, scelerisque ac libero. Pellentesque ultrices a tortor vitae pharetra. Mauris posuere ipsum ipsum, vel interdum eros malesuada id. Sed rutrum at ligula a vulputate. Aliquam in placerat orci. platea dictumst.',
                    FontFace = Font.fromName('SourceSansPro'),
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Top,
                    TextWrapped = true,
                })
            }),
            Roact.createFragment(levelRows),
        })
    })
end

function SelectLevelPanel:init()
    self:loadProgress()
end

function SelectLevelPanel:render()
    local _props = self.props
    local refresh = _props.refresh or function() end
    local advanceChapter = _props.advanceChapter or function() end
    local progress = _props.progress
    local level = progress and progress.Chapter1

    local levelRows = {}
    for i = 1, 7 do
        -- Row1 is reserved for Chapter Description
        levelRows[`Row{i + 1}`] = LevelRow('Chapter1', i, i <= level)
    end

    return Roact.createElement(Box, {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(0.7, 0, 0.7, 0),
        Background = {
            Color3 = Color3.fromRGB(118, 214, 255),
            CornerRadius = UDim.new(0, 5),
        },
        Shadow = {
            Color3 = Color3.fromRGB(0, 84, 147),
            Offset = UDim2.new(0, 5, 0, 5)
        }
    }, {
        -- Panel Sign
        SignLabel = Roact.createElement(ShadowedSign, {
            Text = 'Select Level',
            TextSize = 50,
            Color = Color3.fromRGB(255, 255, 255),
            ShadowColor = Color3.fromRGB(115, 250, 121),
        }),
        self.state.loading
            and Roact.createElement('TextLabel', { Text = 'Loading ...' })
            or MainContent({ level = level, advanceChapter = advanceChapter, levelRows = levelRows }),
    })
end

return SelectLevelPanel
