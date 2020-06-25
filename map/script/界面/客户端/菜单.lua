local ui = require 'ui.client.util'
class.screen_button = extends(class.button){
    new = function (parant,x,y,info)
        -- print_r(info)
        local button = class.button.new(parant,info.path,x,y,info.w or 84,info.h or 84)
        button.tx_name = button:add_text(info.title,0,64,info.w or 84,info.h or 84,12,'center')
        button.tx_name:set_color(0xffff0000)
        button.__index = class.screen_button

        button.info = info 
        return button
    end,
    fresh_name = function(self)
        --处理 在线奖励 
        local total_time = 600 
        -- local total_time = 30 
        ac.loop(1000,function(t)
            --modify by jeff 
            total_time = total_time - 1
            local str = os.date("!%H:%M:%S", total_time)
            self.tx_name:set_text(str)
            if total_time == 0  then
                --发送文字
                ac.player.self:sendMsg('|cffffe799【系统消息】|r游戏开局已过10分钟 |cff00ffff所有玩家|r获得一个|cffff0000神奇的令牌|r 请查看英雄的背包栏')
                for i=1,10 do 
                    local p = ac.player(i)
                    if p:is_player() then 
                        if p.hero then 
                            p.hero:add_item('神奇的令牌') 
                        end 
                    end       
                end    
                self:destroy()
                t:remove()
            end
        end)
    end,    

    on_button_clicked = function (self)
        if self.info then 
            local key = self.info.key
            if key then
                japi.SendMessage(0x100,KEY[key],0)
                japi.SendMessage(0x101,KEY[key],1)
            end
            if finds(self.info.name,'绝世','风骚') then 
                local skl = ac.player.self.hero:find_skill(self.info.name,nil,true)
                if skl and not skl:is_cooling() then 
                    local info = {
                        type = 'jsmj',
                        func_name = 'jsmj',
                        params = {
                            [1] = self.info.name,
                        }
                    }
                    ui.send_message(info)
                end
            end
        end
    end,

    on_button_mouse_enter = function (self)
        if self.info then 
            if self.info.name == '神奇的令牌' then 
                self:tooltip('|cffffe799神奇的令牌|r',self.info.tip,-1,300,94)
            else
                local with = #self.info.tip >=100 and 400 or 200
                local high = #self.info.tip >=100 and 300 or 84
                self:tooltip(self.info.name,self.info.tip,0,with,high)
            end    

        end
    end,
}

local ui = require 'ui.server.util'
--处理同步请求
local event = {
    jsmj = function (name)
        local player = ui.player 
        local hero = player.hero
        if hero then 
            local skl = hero:find_skill(name,nil)
            if skl then 
                skl:cast()
            end
        end
    end,
}
ui.register_event('jsmj',event)


-- ac.game:event '玩家-注册英雄' (function(trg, player, hero)
--     if not player:is_self() then 
--         return 
--     end
ac.wait(30*1000,function()
    local ui_info = {
        {
            name = "F2回城",  
            path = 'image\\控制台\\F2_home.blp',
            key = 'F2', 
            tip = "F2回城",
        },
        {
            name = "F3进入练功房",  
            path = 'image\\控制台\\f3_liangongfang.blp',
            key = 'F3', 
            tip = "F3进入练功房",
            is_show_name = false,
        },
        {
            name = '神奇的令牌', 
            title = '神奇的令牌', 
            path = 'lingpai.blp',
            -- key = 'F3', 
            tip = "|cff00ff00开局10分钟可获得一个|cffff0000神奇的令牌|r|n|n",
            x = 1800,
            y = 638,
        },

    }
    local is_jsmj
    if ac.player.self.server['绝世魔剑'] and ac.player.self.server['绝世魔剑'] >0 then 
        local temp =
        {
            name = '绝世魔剑',  
            path = ac.skill['绝世魔剑'].art,
            -- key = 'F3', 
            tip = ac.skill['绝世魔剑']:get_tip(),
            x = 10,
            y = 350,
            w = 52,
            h = 52,
        }
        table.insert(ui_info,temp)
        is_jsmj = true
    end

    if ac.player.self.cus_server['风骚'] and ac.player.self.cus_server['风骚'] >0 then 
        local temp =
        {
            name = '风骚',  
            path = ac.skill['风骚'].art,
            -- key = 'F3', 
            tip = ac.skill['风骚']:get_tip(),
            x = 10,
            y = is_jsmj and 420 or 350,
            w = 52,
            h = 52,
        }
        table.insert(ui_info,temp)
    end
    
    if ac.player.self.server['绝世神剑'] and ac.player.self.server['绝世神剑'] >0 then 
        local temp =
        {
            name = '绝世神剑',  
            path = ac.skill['绝世神剑'].art,
            -- key = 'F3', 
            tip = ac.skill['绝世神剑']:get_tip(),
            x = 10 + 52 + 10,
            y = 350,
            w = 52,
            h = 52,
        }
        table.insert(ui_info,temp)
    end

    for index,info in ipairs(ui_info) do 
        local button 
        if info.x and info.y then 
            button = class.screen_button.create(info.x,info.y,info)
        else      
            button = class.screen_button.create(10,50 + index*84*1.2,info)
        end    
        if info.name =='神奇的令牌' then 
            button:fresh_name()
        end    
    end 
end)