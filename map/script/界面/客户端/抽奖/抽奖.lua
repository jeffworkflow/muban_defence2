local ui = require 'ui.client.util'

local slot = {
    1,2,3,4,5,
    14,6,13,7,
    12,11,10,9,8
}
--业务：抽奖 类似 王者荣耀 夺宝
local new_ui = class.panel:builder
{
    x = 430,--假的
    y = 142,--假的
    w = 1068,
    h = 607,
    level = 5,
    -- is_show = true,
    is_show = false,
    normal_image = [[image\抽奖\bg.blp]],
    alpha = 0.7,

    --关闭按钮
    -- close_button = {
    --     type = 'button',
    --     x = 1068 -32-5,
    --     y = 5,
    --     w = 32,
    --     h = 32,
    --     normal_image = 'image\\抽奖\\close.tga',
    --     has_ani = true,
    --     on_button_clicked = function (self,button)
    --         local pannel = self.parent
    --         pannel:hide()
    --     end, 
    -- },
    --开始按钮
    start_button = {
        type = 'button',
        x = 415,
        y = 280,
        w = 241,
        h = 59,
        normal_image = [[image\抽奖\btn_start.tga]],
        has_ani = true,
        text = ac.player.self.save_coin,
        on_button_clicked = function(self)
            local p = ac.player.self
            if (p.save_coin or 0) >= 1 then 
                p.save_coin = p.save_coin -1 
                local pannel = self.parent
                local info = {
                    type = 'draw',
                    func_name = 'draw',
                    params = {
                        [1] = p.save_coin,
                    }
                }
                ui.send_message(info)
                pannel:start(pannel.last_selected or 1)
                self:hide()
            else
                p:sendMsg('票子不够')
            end
        end,
        text = {
            type = 'text',
            text = '开始' ,
            align = 'center',
            font_size =15,
            color = 0xff000000,
        },
    },
       
    --预设奖池
    award_list = {
        { rand = 7.14,      name = '挖宝熟练度+100'},
        { rand = 7.14,     name = '挖宝熟练度+100'},
        { rand = 7.14,      name = '挖宝熟练度+100'},
        { rand = 7.14,      name = '挖宝熟练度+100'},
        { rand = 7.14,      name = '挖宝熟练度+100'},
        { rand = 7.14,      name = '挖宝熟练度+100'},
        { rand = 7.14,      name = '挖宝熟练度+100'},
        { rand = 7.14,      name = '王昭君'},
        { rand = 7.14,      name = '挖宝熟练度+100'},
        { rand = 7.14,      name = '挖宝熟练度+100'},
        { rand = 7.14,      name = '挖宝熟练度+100'},
        { rand = 7.14,      name = '挖宝熟练度+100'},
        { rand = 7.14,      name = '挖宝熟练度+100'},
        { rand = 7.18,      name = '挖宝熟练度+100'},
    },

    
    --预设20个奖品位置
    create_btns = function(self)
        self.btns = {}
        self.choose_btns = {}
        local space = 2 --字间距
        local base_i = 1
        local base_x = 67
        local base_y = 56
        local ix = 1
        for i =1,20 do 
            if i == 7 or i == 8 or i == 9 or i == 12 or i == 13 or i == 14 then
            else 
                -- local pic = self:add_button(img_path, base_x +(base_i-1)*(space+186), base_y, 186, 124)
                local name = self.award_list[slot[ix]].name
                local pic = self:add_award_ui(base_x +(base_i-1)*(space+186), base_y,name)
                self.btns[slot[ix]] = pic
                local pic = self:add_button([[]], base_x +(base_i-1)*(space+186), base_y, 186, 124)
                self.choose_btns[slot[ix]] = pic
                ix = ix + 1
            end

            base_i = base_i + 1
            if i%5 == 0 then 
                base_y = base_y + 124 + space
                base_i = 1
            end
        end  

    end,
    fresh_save_coin = function(self)
        -- self.start_button.text:set_text(ac.player.self.save_coin) 
    end,
    fresh = function(self)
        self:fresh_save_coin()
        local p = ac.player.self
        for i,data in ipairs(p.award_list) do 
            -- local is_save_item = ac.table.ItemData[data.name]
            local skl = ac.skill[data.name] 
            -- print(skl.name,skl.color_name,skl.title,skl.tip,skl.art)
            local title = skl.color_name or skl.title or skl.name
            local tip = skl.get_tip and skl:get_tip() or skl.tip
            local art = skl.art

            self.btns[i].name = skl.name
            self.btns[i].icon:set_normal_image(art)
            self.btns[i].btn.on_button_mouse_enter = function(self)
                self:tooltip(title,tip,0,400,84,10)
            end   
            self.btns[i].text:set_text(title)
        end
    end,
    add_award_ui = function(self,x,y,name)
        local skl = ac.skill[name]
        -- print('art:',name,skl.art,skl.tip)
        local award_ui = class.panel:builder
        {
            parent = self,
            x = x,--假的
            y = y,--假的
            w = 186,
            h = 124,
            normal_image = [[image\抽奖\bg_award.tga]],--背景
            name = name,
            icon = {
                type = 'texture',
                x = 55,
                y = 13,
                w = 76,
                h = 76,
                normal_image = skl.art,--背景
            },
            btn = {
                type = 'button',
                x = 55,
                y = 13,
                w = 76,
                h = 76,
                normal_image = [[]],--背景
                on_button_mouse_enter = function(self)
                    -- print('按钮进入咯')
                    self:tooltip(skl:get_title(),skl:get_tip(),0,400,84,10)
                end   
            },
            text = {
                type = 'text',
                x = 55,
                y = 98,
                w = 76,
                h = 16,
                text = name,
                align = 'center',
                font_size =10,
            },
        }
        return award_ui
    end,
    --真正开始抽奖，从哪个位置开始
    start = function(self,start)
        --一共转多久
        local p = ac.player.self
        local time =2 
        self.time = 2
        local speed = 0.05 --0.05秒位移一个物品
        self.moved = 0 --已经位移数
        local max_cnt = math.floor(time/0.01 + speed *20 /0.01)
        ac.timer(0.01 * 1000,max_cnt,function(t)
            if ('%.2f').format(t.cnt * 0.01) ~= ('%.2f').format(speed * (self.moved +1)) then 
                return
            end 
            self.moved  = self.moved + 1 
            local slot = (start + self.moved) % 14 
            slot = slot == 0 and 14 or slot
            -- print('激活：',slot)
            self.choose_btns[slot]:set_normal_image([[image\抽奖\bg_choosed.tga]])
            --抽中
            if t.cnt * 0.01 >= time and self.btns[slot].name == p.reward_name then 
                print('中奖啦：',slot,self.btns[slot].name,p.reward_name)
                --2秒后关闭 ui，提示中奖
                ac.wait(2.5*1000,function()
                    --发起同步请求
                    local info = {
                        type = 'draw',
                        func_name = 'award',
                        params = {
                            [1] = p.reward_name,
                        }
                    }
                    ui.send_message(info)
                    self.start_button:show()
                    self:hide()
                end)
                self.choose_btns[slot]:blink(0.7,0.2,true)
                self.last_selected = slot
                self:fresh_save_coin()
                t:remove()
            else
                self.choose_btns[slot]:fade(0.3) --淡化2秒
            end
        end)


    end,
    --初始化
    new = function(self)
        local pannel = self
        self:create_btns()
        --  --拥有多少门票
        --  local has_tickets = self:add_text('拥有 |cff00ff00100|r',415,348, 241, 24,12,'center')
    end,    

}
ac.ui.client.draw = new_ui
ac.wait(100,function()
    new_ui:new()
end)
--关闭F7
-- local game_event = {}
-- game_event.on_key_down = function (code)
--     -- if code == KEY.F5 then 
--     --     ac.player(ac.player.self.id):sendMsg('排行榜还在努力制作中，敬请期待',5)
--     -- end
--     if code == KEY.F7 then 
--         if new_ui == nil then return end 
--         if new_ui.is_show then 
--             new_ui:hide()
--         else 
--             new_ui:show()
--         end 
--     elseif code == KEY.ESC then 
--         new_ui:hide()
--     end 
-- end 
-- game.register_event(game_event)

local ui = require 'ui.server.util'
--处理同步请求
local event = {
    draw = function (data)  
        local player = ui.player 
        local hero = player.hero
        player.save_coin = data
        player.reward_name = ac.get_reward_name(player.award_list or new_ui.award_list)
        print('点击开始抽奖，同步的存档硬币：',player,data,player.reward_name)
    end,
    --给奖励
    award = function (data)  
        local player = ui.player 
        local hero = player.hero
        local ok
        --加熟练度
        for k,v in string.gsub(player.reward_name,'-','+-'):gmatch '(%S+)%+([-%d.]+%s-)' do
            local key = ac.server.name2key(k)
            player:Map_AddServerValue(key,tonumber(v))
            ok = true
        end    
        if ok then 
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ff00玩家|cff00ffff'..player:get_name()..'|cff00ff00在幸运转盘抽奖的时候，惊喜获得|cffff0000'..player.reward_name..'|cff00ff00，熟练度存档可按F4进行查看',10)
            return 
        end

        local skl = ac.skill[player.reward_name]
        if skl.name =='谢谢参与' then 
            player:sendMsg('|cffffe799【系统消息】|r|cff00ff00幸运转盘不断旋转，最终停在了|cffff0000'..player.reward_name..'|cff00ff00的位置',10)
            return 
        end
        if skl.skill_type == '存档物品' then 
            hero:add_item(player.reward_name) 
            -- player:sendMsg('恭喜获得'..skl.color_name,5)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ff00玩家|cff00ffff'..player:get_name()..'|cff00ff00在幸运转盘抽奖的时候，惊喜获得|cffff0000【可存档装备】'..skl.color_name,10)
        else 
            local key = ac.server.name2key(player.reward_name)
            player:Map_AddServerValue(key,1)
            local book_name 
            if finds(player.reward_name,'我是大魔头','黄金矿工','书呆子','剑瞎子','采蘑菇的小姑娘','扭蛋人生','du徒','强悍之人','血牛','一出门就被秒','绝世魔剑') then 
                book_name = '隐藏成就'
            else
                book_name = '成神'
            end
            local skl = hero:find_skill(player.reward_name,nil,true)
            if not skl then 
                ac.game:event_notify('技能-插入魔法书',hero,book_name,player.reward_name)
                ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ff00玩家|cff00ffff'..player:get_name()..'|cff00ff00在幸运转盘抽奖的时候，惊喜获得|cffff0000【可存档成就】'..player.reward_name..'|cff00ff00，成就属性可最强魔灵-隐藏成就/天神物品中查看',10)
            else
                skl:upgrade(1)
                ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ff00玩家|cff00ffff'..player:get_name()..'|cff00ff00在幸运转盘抽奖的时候，惊喜获得|cffff0000【可存档成就】'..player.reward_name..'|cff00ff00，成就属性可最强魔灵-隐藏成就/天神物品中查看',10)
            end
        end
    end
}
ui.register_event('draw',event)

--游戏失败 且游戏时长>=15分钟给一个令牌
ac.game:event '游戏-结束' (function(trg,flag)
    if flag then 
        return 
    end
    local time = 60 * 30
    -- local time = 1 * 1
    if ac.g_game_time >=time  then 
        for i=1,10 do 
            local p = ac.player(i)
            if p:is_player() then
                p.save_coin = (p.save_coin or 0) + 1
            end
        end
        new_ui:show()
        -- player:sendMsg('|cffffe799【系统消息】|r|cff00ff00胜败乃兵家常事，大侠请重新来过！',5)
    end
end)

