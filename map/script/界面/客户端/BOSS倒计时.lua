local mt = {}
mt.__index = mt

mt.unit = nil
--持续时间
mt.time = 0
--绑定的计时器
mt.timer = nil

function mt:new(u)
    local texttag = class.panel:builder{
        x = 0,
        y = 0,
        w = 100,
        h = 25,
        normal_image = 'Transparent.tga',

        text = {
            type = 'text',
            font_size = 14,
            text = '|cff00a3d9倒计时：90s|r',
        }
    }

    texttag:bind_unit_overhead(u)

    self.ui = texttag
end

function ac.unit.__index:create_texttag_timer(time)
    local text = setmetatable({},mt)
    text:new(self)

    text.timer = ac.timer(1000,time,function(t)
        local color = '|cff00a3d9'
        if t.count <= 10 then
            color = '|cffec2453'
        end

        text.ui.text:set_text(color .. '倒计时:' .. math.ceil(t.count) .. 's|r')
        
        if t.count == 0 then
            self:kill()
        end
    end)

    self:event '单位-死亡'(function(trg)
        text.ui:destroy()
        if text.timer then
            text.timer:remove()
        end
        trg:remove()
    end)
    
end