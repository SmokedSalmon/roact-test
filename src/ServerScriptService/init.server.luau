-- Dummy data connection
local ReplicatedStorage = game:GetService('ReplicatedStorage')

local dummyFolder = Instance.new('Folder')
dummyFolder.Name = '__Status__'
dummyFolder.Parent = ReplicatedStorage

local Value1 = Instance.new('IntValue')
Value1.Name = 'Value1'
Value1.Value = 1
Value1.Parent = dummyFolder


local RemainingSec = Instance.new('IntValue')
RemainingSec.Name = 'RemainingSec'
RemainingSec.Value = 60
RemainingSec.Parent = dummyFolder

local Health = Instance.new('NumberValue')
Health.Name = 'Health'
Health.Value = 100.00
Health.Parent = dummyFolder

coroutine.wrap(function()
    task.wait(3)
    Value1.Value = 5
    print(`Value1 changed to {Value1.Value}`)
end)()

coroutine.wrap(function()
    while RemainingSec.Value > 0 do
        task.wait(1)
        RemainingSec.Value -= 1
        print(`RemainingSec: {RemainingSec.Value}`)
    end
end)()

coroutine.wrap(function()
    while Health.Value > 0 do
        task.wait(math.random(0, 1))
        Health.Value -= math.random(2, 5)
        print(`Health: {Health.Value}`)
    end
end)()
