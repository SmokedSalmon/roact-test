--[[
    Panel with Vertical Tab
    [TODO] Image Button
]]
-- local ReplicatedStorage = game:GetService('ReplicatedStorage')
-- local Roact = require(ReplicatedStorage.Packages.roact)
-- local TableUtil = require(ReplicatedStorage.Packages.TableUtil)
-- local Box = require(ReplicatedStorage.Shared.Components.Atomic.Box)

-- -- Constants & Configs
-- local DefaultUIPadding = {
--     PaddingLeft = UDim.new(0, 10),
--     PaddingTop = UDim.new(0, 10),
--     PaddingRight = UDim.new(0, 10),
--     PaddingBottom = UDim.new(0, 10),
-- }
-- local DefaultRootContainerProps = {
--     -- [TODO] make this a Container Root Component
--     BackgroundTransparency = 1,
--     BorderSizePixel = 0,
--     AutomaticSize = Enum.AutomaticSize.XY, -- Default fit to content
-- }
-- local DefaultTextButtonProps = {
--     Size = UDim2.new(1, 0, 1, 0),
--     AutomaticSize = Enum.AutomaticSize.XY, -- Default fit to content
-- }

-- local Button = Roact.Component:extend('Button')

-- function Button:render()
--     local _props = TableUtil.Assign(DefaultRootContainerProps, self.props or {})
    
--     local _buttonProps = TableUtil.Assign(DefaultTextButtonProps, _props.Button or {})
--     _props.Button = nil

--     if _props.Event and typeof(_props.Event) == 'table' then
--         for event, handler in pairs(_props.Event) do
--             _buttonProps[Roact.Event[event]] = handler
--         end
--         _props.Event = nil
--     end

--     _props[Roact.Children] = TableUtil.Assign({
--         TextButton = Roact.createElement('TextButton', _buttonProps, {}),
--     }, _props[Roact.Children])
    
--     return Roact.createElement(Box, _props)
-- end

-- function Button:willUnmount()
--     -- if self.__handlers.onActivated then self.__handlers.onActivated:Disconnect() end
-- end

-- return Button