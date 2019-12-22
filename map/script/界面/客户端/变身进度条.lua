local panel = ac.ui.client.panel
local transform = class.panel:builder{
    parent = panel, --父级
    x = 818,
    y = 853,
    w = 289,
    h = 8,
    level = 2,
    is_show = false,
    normal_image = 'image\\bs_jdt_k.tga',

    title = {x = 2,y = -12.5,w = 50,h = 10,font_size = 9,text = '暴风雪',type = 'text',},
    path =  {x = 2,y = 2,w = 285,h = 4,normal_image = 'image\\bs_jdt_s.tga',type = 'texture'},
    art = {x = -20,y = -12,w = 20,h = 20,normal_image = 'x.blp',type = 'texture',},
    time_text = {x = 238,y = -10,w = 50,h = 10,font_size = 7,align = 'right',text = '',type = 'text'},
}

local mt = {}
mt.__index = mt

mt.type = '变身进度条'
mt.ui = transform
mt.owner = nil

local function onClick(o)
    if not o.onClick then
        return
    end
    o:onClick()
end

function mt:new(player)
    local o = setmetatable({},self)
    o.owner = player
    return o
end

function mt:remove()
    if self.removes then
        return
    end
    self.removes = true

    if self.timer then
        self.timer:remove()
        self.timer = nil
        if self.owner:is_self() then
            self.ui:hide()
        end
    end
end

function mt:set_progress(min,max)
    local min = min / 10
    --修改文本
    self.ui.time_text:set_text('|cffaeaeae'..min ..'/' ..max ..'s|r')
    --修改进度
    self.ui.path:set_control_size(min / max * 285,4)
end

--时间为秒级
function ac.player.__index:Change_progress(data)
    local time = data.time
    local title = data.title
    local art = data.art
    local o = mt:new(self)
    
    --修改技能名
    o.ui.title:set_text('|cffc7c7c7' .. title .. '|r')
    --修改技能图标
    o.ui.art:set_normal_image(art)
    --还原一下进度条
    o.ui.path:set_control_size(285,4)
    --还原一下倒计时文本
    o.ui.time_text:set_text('|cffaeaeae'..time ..'/' ..time ..'s|r')
    --显示UI
    if self:is_self() then
        o.ui:show()
    end

    --每0.1秒刷新一次
    o.timer = ac.timer(100,time * 10,function(t)
        o:set_progress(t.count,time)
        if t.count == 0 then
            onClick(o)
            o:remove()
        end
    end)

    return o
end