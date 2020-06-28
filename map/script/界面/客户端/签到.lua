--业务：签到ui开始
local ui = require 'ui.client.util'
local new_ui = class.panel:builder
{
    x = 1800,
    y = 538,
    w = 84,
    h = 84,
    level = 5,
    is_show = false,
    normal_image = [[]],
    button = {
        type = 'button',
        normal_image = [[qiandao.blp]],
        on_button_clicked = function(self)
            -- if ac.g_game_time <= 60 * 5 then 
            --     return 
            -- end
            local panel = self.parent
            local p = ac.player.self
            local start_time = p:Map_GetGameStartTime()
            if not p.qd_time then 
                print('还没有读取到签到时间')
                return 
            end
            --未签到
            if timediff(start_time,p.qd_time or 0) > 0 then 
                p:AddServerValue('qd',1) --签到天数+1 自定义服务器
                p:sendMsg('|cffebb608【系统】|r|cff00ff00签到成功，恭喜获得|cffff0000【可存档属性】每秒加全属性+'..p.cus_server['签到']..'|cff00ff00可在最强魔灵-签到系统中查看',5)
                --发起同步
                local info = {
                    type = 'qd',
                    func_name = 'qd',
                    params = {
                        [1] = p.cus_server['签到'],
                    }
                }
                ui.send_message(info)
            else
                print('已签到：',start_time,p.qd_time)
            end
            panel:destroy()
        end,
        on_button_mouse_enter = function (self)
            local skl = ac.player.self.hero:find_skill('签到',nil,true)
            self:tooltip(skl:get_title(),skl:get_tip(),-1,300,84)
        end,
    },
}
ac.ui.client.qd = new_ui

local ui = require 'ui.server.util'
--处理同步请求
local event = {
    qd = function (val)
        local player = ui.player 
        player.cus_server['签到'] = val
        player.server['签到'] = val

        player.qd_time = player:Map_GetGameStartTime()
        print('|cff00ff00点击进行本日签到，当前累计签到次数：',player.cus_server['签到'])
    end,
}
ui.register_event('qd',event)

--未签到
ac.game:event '玩家-注册英雄' (function(_, _, hero)
    local p = _
    ac.wait(5000,function()
        if p:is_self() then 
            print(p.qd_time)
            -- print('打印打印',time2string(p:Map_GetGameStartTime()),time2string(p.qd_time),timediff(p:Map_GetGameStartTime(),p.qd_time or 0 ))
            if timediff(p:Map_GetGameStartTime(),p.qd_time or 0 ) > 0 then 
                ac.ui.client.qd:show()
            end 
        end
    end)
end)