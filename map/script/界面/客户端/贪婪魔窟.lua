local ui = require 'ui.client.util'
--获取最大战斗力的玩家
local function get_max_zdl()
    local temp = {}
    for i=1,10 do 
        local p = ac.player(i)
        if p:is_player() then 
            table.insert(temp,{player = p,zdl = (p.zdl or 0)})
        end
    end
    table.sort(temp,function(a,b)
        return a.zdl > b.zdl
    end)
    return temp[1].player
end

--业务： 贪婪魔窟 最终得宝
local new_ui = class.panel:builder
{
    x = 0,
    y = 0,
    w = 1920,
    h = 1080,
    -- is_show = true,
    level =5,
    is_show = false,
    normal_image = [[image\贪婪魔窟\1 - LOGIN.tga]],
    -- alpha = 0.7,
    
    --倒计时 60 秒
    create_time = function(self)
        self.remain_time = self.remain_time or {}
        for i=1,2 do 
            local bx = 850
            local gap = 24
            local new_ui = class.panel:builder
            {
                x = bx +(i-1)*(gap+94),
                y = 126,
                w = 94,
                h = 112,
                normal_image = [[image\贪婪魔窟\n0.tga]],
                parent = self,
            }
            table.insert(self.remain_time,new_ui)
        end
    end,

    create_choose = function(self)
        local panel = self
        self.choose = self.choose or {}
        self.save_item = self.save_item or {}
        
        for i=1,2 do 
            local bx = 488
            local gap = 236
            local new_ui = class.panel:builder
            {
                x = bx +(i-1)*(gap+373),
                y = 313,
                w = 373,
                h = 529+73,
                parent = self,
                normal_image =[[]],
                text = {
                    w = 373,
                    h = 45,
                    font_size = 30,
                    align = 'center',
                    text ='|cff00ff00获得装备并离开|r',
                    type = 'text'

                },
                bg_button = {
                    y = 68,
                    w = 373,
                    h = 529,
                    -- hover_image= [[image\贪婪魔窟\gaoguang.tga]],
                    normal_image = [[image\贪婪魔窟\kapai]]..i..[[.tga]],
                    on_button_mouse_enter = function(self)
                        if not self.hover_bg then 
                            -- print('打印长宽高',self.x,self.y,self.w,self.h) 439
                            local off_x = 428 - 373
                            local off_y = 583 - 529
                            off_x = off_x/2
                            off_y = off_y/2
                            self.hover_bg = self:add_button([[image\贪婪魔窟\gaoguang.tga]],-off_x,-off_y,428,583)
                        else
                            self.hover_bg:show()
                        end
                    end,
                    on_button_mouse_leave =function(self)
                        if self.hover_bg then 
                            self.hover_bg:hide()
                        end
                    end,
                    on_button_clicked =function()
                        --同步，并发送当前点击是第几个按钮
                        print('点击了按钮',i)
                        local max_zdl_player = get_max_zdl()
                        if ac.player.self ~= max_zdl_player then 
                            ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ff00玩家 |cff00ffff'..max_zdl_player:get_name()..' |cff00ff00正在选择',5) 
                            
                            return 
                        end
                        --隐藏
                        panel:hide()
                        --发起同步请求
                        local info = {
                            type = 'cave',
                            func_name = 'cave',
                            params = {
                                [1] = i,
                            }
                        }
                        ui.send_message(info)
                    end,
                    type = 'button'
                }
            }
            table.insert(self.choose,new_ui)
        end
        local bx = 49
        local by = 228
        local gap = 22
        --9个存档装备
        for i=1,9 do 
            local line = math.ceil(i/3)
            local col = math.ceil(i%3)
            col = col == 0 and 3 or col
            local new_ui = class.panel:builder
            {
                x = bx +(col-1)*(gap+72),
                y = by +(line-1)*(gap+72),
                w = 72,
                h = 72,
                type = 'button',
                parent = self.choose[1].bg_button,
                bt = {
                    -- hover_image= [[image\贪婪魔窟\gaoguang.tga]],
                    normal_image = [[image\贪婪魔窟\kecundangbeibao.blp]],
                    on_button_mouse_leave =function(self)
                        -- if self.hover_bg then 
                        --     self.hover_bg:hide()
                        -- end
                    end,
                    -- tip =[[预设tip]],
                    -- title =[[预设title]],
                    on_button_mouse_enter = function(self)
                        -- if not self.hover_bg then 
                        --     -- print('打印长宽高',self.x,self.y,self.w,self.h)
                        --     local off_x = self.w * 0.1
                        --     local off_y = self.h * 0.1
                        --     self.hover_bg = self:add_button([[image\贪婪魔窟\gaoguang.tga]],-off_x,-off_y,self.w*1.2,self.h*1.2)
                        -- else
                        --     self.hover_bg:show()
                        -- end
                        
                        local tip = self.tip
                        local title = self.title
                        if tip then 
                            self:tooltip(title,tip,0,400,84,10)
                        end
                    end,  
                    type = 'button',
                }
            }
            table.insert(self.save_item,new_ui)
        end

    end,
    award_list = {
        
    },
    award_data = {
        --贪婪魔窟
        ['贪婪魔窟-普通'] =  {{ rand = 1.5, name = {{ rand = 75,   name = '1级物品'},{ rand = 20,   name = '2级物品'},{ rand = 5,   name = '3级物品'},{ rand = 0,   name = '4级物品'}}}},
        ['贪婪魔窟-噩梦'] =  {{ rand = 1.5, name = {{ rand = 30,   name = '1级物品'},{ rand = 40,   name = '2级物品'},{ rand = 25,   name = '3级物品'},{ rand = 5,   name = '4级物品'}}}},
        ['贪婪魔窟-地狱'] =  {{ rand = 1.5, name = {{ rand = 0,   name = '1级物品'},{ rand = 40,   name = '2级物品'},{ rand = 40,   name = '3级物品'},{ rand = 20,   name = '4级物品'}}}},

        ['存档物品'] = {
            { rand = 15,      name = '白'},
            { rand = 15,      name = '蓝'},
            { rand = 50,      name = '金'},
            { rand = 20,      name = '暗金'},
        },

    },
    
    give_award = function(self)
        --先清空
        self.award_list = {}
        local index = type(ac.creep['贪婪魔窟'])=='table' and ac.creep['贪婪魔窟'].index or 1
        local rand = 5 * get_player_count() + 1.5 * index + 5
        local rand_list = self.award_data[ac.g_game_degree_name]
        if rand_list then 
            rand_list[1].rand = rand 
        end
        --开始摇奖 
        for i=1,9 do 
            local rand_name = ac.get_reward_name(rand_list)
            -- print(rand_list,rand_name)  
            if  rand_name then 
                local str = rand_name
                local lv = tonumber(string.sub(str,1,1))
                local color = ac.get_reward_name(self.award_data['存档物品'])
                if color then 
                    local rand = math.random(#ac.save_item[lv][color])
                    local name = ac.save_item[lv][color][rand]  
                    table.insert(self.award_list,name)  
                end     
            end
        end
    end,
    clear = function(self)
        for i,panel in ipairs(self.save_item) do 
            panel.tip = nil
            panel.title = nil
            panel:set_normal_image([[image\贪婪魔窟\kecundangbeibao.blp]])
        end
    end,
    fresh = function(self)
        -- self:fresh_save_coin()
        self:clear()
        for i,name in ipairs(self.award_list) do 
            -- local skl = ac.table.ItemData[name]
            local skl = ac.dummy:add_item(name)
            if skl.map_level_tip then 
                -- print(type(skl),type(ac.skill['你是大傻逼sdfe']))
                -- print(skl.name,skl.color_name,skl.title,skl.tip,skl.art)
                local title = skl.color_name or skl.title or skl.name
                local tip = skl.get_tip and skl:get_tip() or skl.tip
                local art = skl:get_art()

                self.save_item[i].bt.title = title
                self.save_item[i].bt.tip = tip
                self.save_item[i].bt:set_normal_image(art)
                skl:item_remove()
            end
            -- self.save_item[i].btn.on_button_mouse_enter = function(self)
            --     self:tooltip(title,tip,0,400,84,10)
            -- end   
            -- self.btns[i].text:set_text(title)
        end
        --更新文字 
        local index = type(ac.creep['贪婪魔窟']) == 'table' and ac.creep['贪婪魔窟'].index or 1
        local max_index = type(ac.creep['贪婪魔窟']) == 'table' and ac.creep['贪婪魔窟'].max_index or 999999999
        index = index + 1
        if index > max_index then 
            self.choose[2].text:set_text('|cffffff00    恭喜达到顶层！|n    更深层数在高难度开放！')
        else
            self.choose[2].text:set_text('|cffffff00继续挑战，失败则|cffff0000一无所有')
            --第'..index..'层|n|cffff0000（
        end
        
        --更新计时器
        self:fresh_remain_time()
        
    end,
    fresh_remain_time = function(self)
        local time = 99
        if self.timer then 
            self.timer:remove()
        end
        -- local
        self.timer = ac.timer(1000,time,function(t)
            local str = string.format('%02d',t.count)
            --设置图片
            -- print('改变时间图片',str)
            local i = 1 
            for num in string.gmatch(str, "%w") do
                -- print(i,num)
                self.remain_time[i]:set_normal_image([[image\贪婪魔窟\n]]..num..[[.tga]])
                i = i + 1
            end
            --移除
            if t.count <= 0 then 
                t:remove()
                self.timer = nil

                local max_zdl_player = get_max_zdl()
                if ac.player.self ~= max_zdl_player then 
                    -- ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ff00玩家 |cff00ffff'..max_zdl_player:get_name()..' |cff00ff00正在选择',5) 
                    return 
                end

                --时间到 获得存档装备离开游戏
                local info = {
                    type = 'cave',
                    func_name = 'cave',
                    params = {
                        [1] = 1,
                    }
                }
                ui.send_message(info)
            end
        end)


    end,
    
    --初始化
    new = function(self)
        local pannel = self
        self:create_time()
        self:create_choose()
    end,    
    show1 = function(self)
        self:fade(-0.5)
        self:show()
        ac.player.self:clearMsg()
    end

}
ac.ui.cave = new_ui
ac.wait(10,function()
    new_ui:new()
    -- new_ui:show1()
end)

-- local game_event = {}
-- game_event.on_key_down = function (code)

--     if code == KEY.F9 then 
--         if new_ui == nil then return end 
--         new_ui:show()
--     elseif code == KEY.ESC then 
--         new_ui:hide()
--     end 
-- end 
-- game_event.on_key_up = function (code)

--     if code == KEY.F9 then 
--         if new_ui == nil then return end 
--         new_ui:hide()
--     end 
-- end 
-- game.register_event(game_event)

local function give_item(player)
    ac.wait(1.5*1000,function()
        for i,name in ipairs(new_ui.award_list) do 
            local point = ac.rect.j_rect('moku5'):get_random_point()
            print('创建了：',name,point)
            ac.item.create_item(name,point)
        end
        print_r(new_ui.award_list)
        local tip = '|cffebb608【系统】|cff00ffff'..player:get_name()..' |cff00ff00选择了|cffffff00 【结束挑战】|cff00ff00，2分钟后游戏结束！'
        --游戏结束
        ac.game:event_notify('游戏-结束',true,tip)
    end)
end
local ui = require 'ui.server.util'
--处理同步请求
local event = {
    cave = function (index)  
        local player = ui.player 
        local hero = player.hero
        if new_ui.timer then
            new_ui.timer:remove()
            new_ui.timer = nil
        end
        new_ui:hide()

        if index == 1 then 
            print('创建物品，准备游戏结束')
            give_item(player)

        else
            local index = ac.creep['贪婪魔窟'].index 
            index = index + 1
            local max_index = ac.creep['贪婪魔窟'].max_index 
            if index > max_index then 
                --游戏结束
                print('满层')
                give_item(player)
            end
            
            print('继续下一波')
            ac.player.self:sendMsg('|cffebb608【系统】|cff00ffff'..player:get_name()..' |cff00ff00选择了|cffffff00 【继续挑战】|cff00ff00，祝君好运！',5)
            ac.wait(3*1000,function()
                ac.creep['贪婪魔窟']:next()
            end)
        end

    end,
}
ui.register_event('cave',event)


