local jass = require 'jass.common'
local hotkey = require '通用.hotkey'

local DialogHandle = {}

local function onClick(dialog, btn)
    dialog:hide()
    if not dialog.onClick then
        return
    end
    for _, button in ipairs(dialog._button) do
        if button.handle == btn then
            dialog:onClick(button.name)
            break
        end
    end
end

local function getDialogHandle(player)
    if DialogHandle[player] then
        return DialogHandle[player]
    end
    local handle = jass.DialogCreate()
    local trg = jass.CreateTrigger()
    jass.TriggerRegisterDialogEvent(trg, handle)
    jass.TriggerAddCondition(trg, jass.Condition(function ()
        local btn = jass.GetClickedButton()
        local dialog = player._dialog[1]
        if dialog then
            onClick(dialog, btn)
        end
    end))

    DialogHandle[player] = handle
    return handle
end

local mt = {}
mt.__index = mt
mt.type = 'dialog'

function mt:__tostring()
    return ('{dialog|%s|%s}'):format(self.handle, self._title)
end

function mt:setTitle(title)
    if type(title) ~= 'string' then
        return
    end
    self._title = title
    if self:isVisible() then
        jass.DialogSetMessage(self.handle, self._title)
    end
end

function mt:addButton(name, key, description)
    if type(name) ~= 'string' then
        return
    end
    if description == nil then
        description = name
    else
        description = tostring(description)
    end
    self._button[#self._button+1] = {
        name = name,
        hotkey = key,
        description = description,
    }
end

function mt:refresh()
    if not self:isVisible() then
        return
    end
    jass.DialogClear(self.handle)
    jass.DialogSetMessage(self.handle, self._title)
    for _, button in ipairs(self._button) do
        button.handle = jass.DialogAddButton(self.handle, button.description, hotkey[button.hotkey] or 0)
    end
end

function mt:isVisible()
    return self.owner._dialog[1] == self
end

function mt:show()
    for i, dl in ipairs(self.owner._dialog) do
        if dl == self then
            table.remove(self.owner._dialog, i)
            break
        end
    end
    table.insert(self.owner._dialog, 1, self)
    self:refresh()
    jass.DialogDisplay(self.owner.handle, self.handle, true)
end

function mt:hide()
    for i, dl in ipairs(self.owner._dialog) do
        if dl == self then
            table.remove(self.owner._dialog, i)
            break
        end
    end
    if #self.owner._dialog == 0 then
        jass.DialogDisplay(self.owner.handle, self.handle, false)
    else
        self.owner._dialog[1]:show()
    end
end



function ac.player.__index:dialog(data)
    local player = self
    if not player:is_player() then
        return nil
    end
    if type(data) ~= 'table' then
        return nil
    end
    if ac.clock() == 0.0 then
        log.error('对话框不能在初始化时创建')
        return nil
    end
    if not player._dialog then
        player._dialog = {}
    end
    local handle = getDialogHandle(player)

    local dialog = setmetatable({
        owner = player,
        handle = handle,
        _button = {},
        _title = '',
    }, mt)

    dialog:setTitle(data[1])
    for _, info in ipairs(data) do
        if type(info) == 'table' then
            dialog:addButton(info[1], info[2], info[3])
        end
    end
    dialog:show()
    return dialog
end
