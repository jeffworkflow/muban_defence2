local slk = require 'jass.slk'
local ui  = require 'ui.client.util'

class.phb_panel = extends(class.panel){
    create = function ()
        local hero = ac.player.self.hero
        local panel = class.panel.create('image\\排行榜\\phb_bg.tga',372,176,1193,593)
        panel.__index = class.phb_panel 

        panel:add_button('',0,0,panel.w,panel.h)

        --左边菜单 
        panel.menu_titles = {
            '超绝群伦', 
            '冠世一绝', '超凡入圣','万古流芳','传奇','皇后','国王','堡垒','主教','骑士','士兵',
        }
        local menu_press_status = 'image\\排行榜\\menu.tga'
        local menu_line = 'image\\排行榜\\menu_line.tga'
        for i=1,#panel.menu_titles do 
            local name = panel.menu_titles[i]
            local button 
            button = panel:add_button('',10,20 + 48*(i-1),106,40,true)
            --预设优先展示与难度相挂钩的数据
            if i == 1 then 
                button:set_normal_image(menu_press_status)
                panel.last_button = button
            end    
            local text = button:add_text(name,10,0,106,40,10,'left')
            button.text = text
            if i == 1 then 
                text:set_color(0xff744726)
            else
                text:set_color(0xffA9A6F7)
            end        
            --增加下划线
            button:add_texture(menu_line,0,40,106,5)
            button.name = name

            function button:on_button_clicked()
                --更换按钮状态
                panel.last_button:set_normal_image('')
                panel.last_button.text:set_color(0xffA9A6F7)
                
                self:set_normal_image(menu_press_status) 
                self.text:set_color(0xff744726)
                panel.last_button = self

                --刷新排行榜数据 title_background:set_alpha(0xff*0.1)
                panel:fresh(button.name)
            end    

        end 

        --右边排行榜数据
        --巅峰排行榜
        local off_left = 70
        local off_top = 30
        local mul_width = 1.2
        local line_height = 42
        panel.off_left = off_left
        panel.off_top = off_top
        panel.mul_width = mul_width
        panel.line_height = line_height
        
        local main_box_width = 508
        panel.main_box_width = 508
        local menu_width = 106
        panel.menu_width = 106
        local img_phb_df = 'image\\排行榜\\phb_df.tga'
        local img_phb_tgsc = 'image\\排行榜\\phb_tgsc.tga'
        local img_title = 'image\\排行榜\\titile_bg.tga'
        local img_tip1 = panel:add_button(img_phb_df,150+menu_width+off_left, 20+off_top,183,47) 
        -- panel:add_texture(img_phb_df,256,20,183,47) 
        local img_tip2 = panel:add_button(img_phb_tgsc,150+menu_width+main_box_width+off_left ,20+off_top,183,47) 
        -- panel:add_texture(img_phb_tgsc,689,20,183,47) 
        
        local more_tip1 = panel:add_button([[image\排行榜\icon_wenhao.blp]],440+menu_width+off_left, off_top,32,32) 
        local more_tip2 = panel:add_button([[image\排行榜\icon_wenhao.blp]],440+menu_width+main_box_width+off_left ,off_top,32,32) 
        local info = {
            name ='',
            -- tip = '每小时刷新一次,地图等级>=3才能上榜'
            tip = '|cff00ff00每小时刷新一次\n|cffcccccc赛季结束将清空排行榜'
            
        }
        function more_tip1:on_button_mouse_enter()
            if info then 
                self:tooltip(info.name,info.tip,-1,200,84,10)
            end
        end   
        function more_tip2:on_button_mouse_enter()
            if info then 
                self:tooltip(info.name,info.tip,-1,200,84,10)
            end
        end      

        local texture = panel:add_texture(img_title,54+menu_width+off_left,65+off_top,366,48) 
        local text = texture:add_text('名次',30,0,30,34,10,'left')
        text:set_color(0xffA9A6F7)
        local text = texture:add_text('玩家昵称',139,0,30,34,10,'left')
        text:set_color(0xffA9A6F7)
        local text = texture:add_text('战斗力',276,0,30,34,10,'left')
        text:set_color(0xffA9A6F7)
        local texture = panel:add_texture(img_title,54+menu_width+main_box_width+off_left,65+off_top,366,48) 
        local text =  texture:add_text('名次',30,0,30,34,10,'left')
        text:set_color(0xffA9A6F7)
        local text = texture:add_text('玩家昵称',139,0,30,34,10,'left')
        text:set_color(0xffA9A6F7)
        local text = texture:add_text('通关次数',276,0,30,34,10,'left')
        text:set_color(0xffA9A6F7)

        --巅峰数据
        panel.df_rank = {}
        panel.df_player = {}
        panel.df_star = {}
        panel.df_line_bg = {}
        for i=1,10 do 
            local y = 102 + line_height*(i-1) +off_top
            local text = panel:add_text('',94+menu_width+off_left,y,20,line_height,10,'left')
            table.insert(panel.df_rank,text)
            if i == 1 then
                text:set_color(0xffff0000)
            elseif i == 2 then    
                text:set_color(0xffffff00)
            elseif i == 3 then
                text:set_color(0xff00bdec)
            else
                text:set_color(0xffF4F4D3)    
            end    

            local text = panel:add_text('',174+menu_width+off_left,y,80,line_height,10,'left')
            table.insert(panel.df_player,text)
            if i == 1 then
                text:set_color(0xffff0000)
            elseif i == 2 then    
                text:set_color(0xffffff00)
            elseif i == 3 then
                text:set_color(0xff00bdec)
            else
                text:set_color(0xffF4F4D3)    
            end    
            local text = panel:add_text('',349+menu_width+off_left,y,20,line_height,10,'center')
            table.insert(panel.df_star,text)
            if i == 1 then
                text:set_color(0xffff0000)
            elseif i == 2 then    
                text:set_color(0xffffff00)
            elseif i == 3 then
                text:set_color(0xff00bdec)
            else
                text:set_color(0xffF4F4D3)    
            end    
        end    

        --通关时长数据
        panel.tgsc_rank = {}
        panel.tgsc_player = {}
        panel.tgsc_time = {}
        panel.tgsc_line_bg = {}
        for i=1,10 do 
            local y = 102 + line_height*(i-1) +off_top
            local text = panel:add_text('',94+menu_width+main_box_width+off_left,y,20,line_height,10,'left')
            table.insert(panel.tgsc_rank,text)
            if i == 1 then
                text:set_color(0xffff0000)
            elseif i == 2 then    
                text:set_color(0xffffff00)
            elseif i == 3 then
                text:set_color(0xff00bdec)
            else
                text:set_color(0xffF4F4D3)    
            end    

            local text = panel:add_text('',174+menu_width+main_box_width+off_left,y,80,line_height,10,'left')
            text:set_color(0xffF4F4D3)
            table.insert(panel.tgsc_player,text)
            if i == 1 then
                text:set_color(0xffff0000)
            elseif i == 2 then    
                text:set_color(0xffffff00)
            elseif i == 3 then
                text:set_color(0xff00bdec)
            else
                text:set_color(0xffF4F4D3)    
            end    

            local text = panel:add_text('',349+menu_width+main_box_width+off_left,y,20,line_height,10,'center')
            text:set_color(0xffF4F4D3)
            table.insert(panel.tgsc_time,text)
            if i == 1 then
                text:set_color(0xffff0000)
            elseif i == 2 then    
                text:set_color(0xffffff00)
            elseif i == 3 then
                text:set_color(0xff00bdec)
            else
                text:set_color(0xffF4F4D3)    
            end    
        end   

        -- panel.hero_img = panel:add_texture('image\\hero.blp',35,25,158,194) 
        -- local title_background = panel:add_texture('image\\角色信息\\line.tga',213,25,586,22)
        -- title_background:set_alpha(0xff*0.1)

        -- local skl = hero and hero:find_skill(hero:get_name()..'天赋') 
        -- local tip = skl and skl:get_tip() or ''
        -- local tf_text = '|cffcccccc'.. (hero and hero:get_name()..'天赋' or '')..'|r'
        -- panel.hero_tf = panel:add_text(tf_text,213,25,586,194,12,'auto_newline')
        -- panel.hero_tip = panel:add_text(tip,213,55,586,170,10,'auto_newline')
        -- --属性加背景
        -- for i=1,7 do 
        --     local y = 241 + 30*(i*2-1) -30
        --     local title_background = panel:add_texture('image\\角色信息\\line.tga',35,y,767,30)
        --     title_background:set_alpha(0xff*0.1)
        -- end    
        panel.close_button = panel:add_button('image\\操作栏\\cross.blp',panel.w - 32-5,5,32,32,true)
        

        panel:hide()

        return panel
    end,
    
    set_df_data = function (self,list)
        --先清空
        for i=1,10 do 
            self.df_rank[i]:set_text('')
            self.df_player[i]:set_text('')
            self.df_star[i]:set_text('')
            -- print(self.df_line_bg[i])
            if self.df_line_bg[i] then 
                self.df_line_bg[i]:destroy() 
                self.df_line_bg[i] = nil 
            end
        end
        if not list then return end
        for i,data in ipairs(list) do 
            -- print_r(data)
            --隔行加背景
            if i % 2 == 0 then 
                local y = 102 + self.line_height*(i-1) +self.off_top
                local title_background = self:add_texture('image\\角色信息\\line.tga',54+self.menu_width+self.off_left,y,366,self.line_height)
                title_background:set_alpha(0xff*0.1)
                table.insert(self.df_line_bg,title_background)
            end    

            --设置数据
            self.df_rank[i]:set_text(data.rank)
            self.df_player[i]:set_text(data.player_name)
            local val = tonumber(data.value)
            if type(val) == 'string' then 
                return 
            end	
            if val < 100000 then
                val =  math.tointeger(val) or ('%.2f'):format(val)
            elseif val < 1000000000 then
                val =  ('%.0f'):format(val/10000)..'万'
            else
                val =  ('%.0f'):format(val/100000000)..'亿' 
            end
            self.df_star[i]:set_text(val)
        end 
    end,
    set_tgsc_data = function (self,list)
        for i=1,10 do 
            self.tgsc_rank[i]:set_text('')
            self.tgsc_player[i]:set_text('')
            self.tgsc_time[i]:set_text('')
            if self.tgsc_line_bg[i] then 
                self.tgsc_line_bg[i]:destroy() 
                self.tgsc_line_bg[i] = nil 
            end
        end        
        if not list then return end
        for i,data in ipairs(list) do 
            --隔行加背景
            if i % 2 == 0 then 
                local y = 102 + self.line_height*(i-1) +self.off_top
                local title_background = self:add_texture('image\\角色信息\\line.tga',54+self.menu_width+self.main_box_width+self.off_left,y,366,self.line_height)
                title_background:set_alpha(0xff*0.1)
                table.insert(self.tgsc_line_bg,title_background)
            end    
            --设置数据
            self.tgsc_rank[i]:set_text(data.rank)
            self.tgsc_player[i]:set_text(data.player_name)
            -- local str = os.date("!%H:%M:%S",tonumber(data.value)) 
            self.tgsc_time[i]:set_text(data.value)
        end 
    end,

    fresh = function(self,name)
        if not self.rank then 
            self.rank = {}
        end    
        -- self.rank[name],self.rank[name..'时长']

        self:set_df_data(self.rank[name..'战斗力'])
        self:set_tgsc_data(self.rank[name])
    end,


    on_button_clicked = function (self,button)
        if button == self.close_button then 
            self:hide()
        end 
    end,

    
}

local panel

ac.wait(10,function ()
    panel = class.phb_panel.get_instance()
end)

local game_event = {}
game_event.on_key_down = function (code)
    -- if code == KEY.F5 then 
    --     ac.player(ac.player.self.id):sendMsg('排行榜还在努力制作中，敬请期待',5)
    -- end
    if code == KEY.F5 then 
        if panel == nil then return end 
        if panel.is_show then 
            panel:hide()
        else 
            panel:show()
        end 
    elseif code == KEY.ESC then 
        panel:hide()
    end 
end 

game.register_event(game_event)



local rank = {
    {'cntsb','士兵'},
    {'cntqs','骑士'},
    {'cntzj','主教'},
    {'cntbl','堡垒'},
    {'cntgw','国王'},
    {'cnthh','皇后'},
    {'cntcq','传奇'},
    {'cntwglf','万古流芳'},
    {'cntcfrs','超凡入圣'},
    {'cntgsyj','冠世一绝'},
    {'cntcjql','超绝群伦'},
    -- {'cntdpcq','斗破苍穹'},
    -- {'cntwszj','无上之境'},
    -- {'cntwxld','无限乱斗'},
    -- {'cntsyld','深渊乱斗'},

    {'zdlsb','士兵战斗力'},
    {'zdlqs','骑士战斗力'},
    {'zdlzj','主教战斗力'},
    {'zdlbl','堡垒战斗力'},
    {'zdlgw','国王战斗力'},
    {'zdlhh','皇后战斗力'},
    {'zdlcq','传奇战斗力'},
    {'zdlwglf','万古流芳战斗力'},
    {'zdlcfrs','超凡入圣战斗力'},
    {'zdlgsyj','冠世一绝战斗力'},
    {'zdlcjql','超绝群伦战斗力'},

}
--处理,显示排行榜数据
--取前10名数据
ac.wait(30*1000,function() 
    for i,content in ipairs(rank) do
        local p = ac.player(1);
        ac.wait(200*i,function()
            p:sp_get_rank3(content[1],function(data)
                -- print_r(data)
                ac.wait(10,function()
                    if not panel.rank then 
                        panel.rank = {}
                    end    
                    if not panel.rank[content[2]] then 
                        panel.rank[content[2]]  = {}
                    end
                    for i = 1, #data do
                        data[i].player_name =  ZZBase64.encode(data[i].player_name)
                        data[i].rank = i
                        table.insert(panel.rank[content[2]],data[i])
                    end  

                    --首次刷新最强王者
                    -- if finds(content[2] ,'深渊乱斗') then 
                    --     panel:fresh('深渊乱斗')
                    -- end   

                    --发起同步请求
                    local tab_str = ui.encode(panel.rank[content[2]])  
                    -- print('数据长度',#tab_str) 
                    ac.wait(10,function()
                        local info = {
                            type = 'sync_rank',
                            func_name = 'sync_rank',
                            params = {
                                [1] = tab_str,
                                [2] = content[2],
                            }
                        }
                        ui.send_message(info)
                    end)  
                end)
            end);
        end)
    end    
end)


local ui = require 'ui.server.util'
--处理同步请求
local event = {
    --从自定义服务器读取数据
    sync_rank = function (tab_str,str)
        local player = ui.player 
        if not panel.rank then 
            panel.rank = {}
        end    
        local data = ui.decode(tab_str)    
        for i = 1, #data do
            data[i].player_name =  ZZBase64.decode(data[i].player_name)
        end 
        panel.rank[str] = data 
        -- print(panel.rank[str])
        -- player:event_notify('读取存档数据')

    end,
}
ui.register_event('sync_rank',event)


