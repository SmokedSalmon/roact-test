local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Roact = require(ReplicatedStorage.Packages.roact)
local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
local UIState = require(ReplicatedStorage.UIState)

local CONST = require(ReplicatedStorage.CONST)
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
    local pCount = math.round(math.random(1, 3))
    local cardChildren = {}
    for i = 1, pCount do
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

local TutorialPanel = Roact.PureComponent:extend('TutorialPanel')

function TutorialPanel:loadProgress()
    if self.state.loading then return end

    self:setState(TableUtil.Assign(self.state, {
        loading = true,
        error = '',
    }))

    -- TODO make/use a promise-like helper for such async action
    coroutine.wrap(function()
        task.wait(1)
        self:setState(TableUtil.Assign(self.state, {
            loading = false
        }))
    end)()
end

local function MainContent(contentProps: {})
    local levelRows = contentProps.levelRows
    
    return Roact.createFragment({
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

function TutorialPanel:switchTab(whichChapter)
    self:setState({ chapter = whichChapter })
end

function TutorialPanel:init()
    self:loadProgress()
    self:setState({ chapter = 1 })
end

function TutorialPanel:render()
    local _props = self.props
    local history = _props.history
    local progress = _props.progress
    local levelCount = #CONST.Chapters[self.state.chapter].levels or 0
    local levelProgress = progress and progress[self.state.chapter]

    local levelRows = {}
    for i = 1, levelCount do
        -- Row1 is reserved for Chapter Description
        levelRows[`Row{i + 1}`] = LevelRow(CONST.Chapters[self.state.chapter].id, i, i <= levelProgress)
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
            Text = 'Tutorials',
            TextSize = 50,
            Color = Color3.fromRGB(255, 255, 255),
            ShadowColor = Color3.fromRGB(115, 250, 121),
        }),
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
                Text = `{CONST.Chapters[self.state.chapter].name}: {levelProgress}`,
            }),
            Button1 = PanelTabButton({
                Button = { Text = CONST.TutorialChapters[1].name },
                Square = { BackgroundColor3 = Color3.fromRGB(115, 253, 255) },
                Event = {
                    Activated = function() self:switchTab(1) end
                },
            }),
            Button2 = PanelTabButton({
                Button = { Text = CONST.TutorialChapters[2].name },
                Square = { BackgroundColor3 = Color3.fromRGB(212, 251, 121) },
                Event = {
                    Activated = function() self:switchTab(2) end
                },
            }),
            Button3 = PanelTabButton({
                Button = { Text = CONST.TutorialChapters[3].name },
                Square = { BackgroundColor3 = Color3.fromRGB(255, 212, 121) },
                Event = {
                    Activated = function() self:switchTab(3) end
                },
            }),
            Button4 = PanelTabButton({
                Button = { Text = 'Back' },
                Square = { BackgroundColor3 = Color3.fromRGB(208, 31, 31) },
                Event = {
                    Activated = function() history:goBack() end
                }
            }),
        }),
        self.state.loading
            and Roact.createElement('TextLabel', { Text = 'Loading ...' })
            or MainContent({ levelRows = levelRows }),
    })
end

local TutorialPanelWithUIState = UIState.WithUIState(
    TutorialPanel,
    nil,
    function(dispatch)
        return {
            -- refresh = function() dispatch('reducer_test') end,
        }
    end
)

return TutorialPanelWithUIState
