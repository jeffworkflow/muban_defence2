local slk = require 'jass.slk'

class.player_info_panel = extends(class.panel){
    create = function ()
        local hero = ac.player.self.hero
        local panel = class.panel.create('image\\提示框\\BJ.tga',541,123,838,666)
        panel.__index = class.player_info_panel 

        panel:add_button('',0,0,panel.w,panel.h)
        -- local title_text = panel:add_text('棋子图鉴',0,0,panel.w,100,25,'center')
        -- title_text:set_color(243,246,4,1)

        -- local line = panel:add_texture('image\\提示框\\line.tga',45,90,panel.w - 90,2)
        -- line:set_alpha(0xff*0.6)
        
        panel.hero_img = panel:add_texture('image\\hero.blp',35,25,158,194) 
        local title_background = panel:add_texture('image\\角色信息\\line.tga',213,25,586,22)
        title_background:set_alpha(0xff*0.1)

        local skl = hero and hero:find_skill(hero:get_name()..'天赋') 
        local tip = skl and skl:get_tip() or ''
        local tf_text = '|cffcccccc天赋:'.. (hero and hero:get_name()..'天赋' or '')..'|r'
        panel.hero_tf = panel:add_text(tf_text,213,25,586,194,12,'auto_newline')
        panel.hero_tip = panel:add_text(tip,213,55,586,170,10,'auto_newline')
        --属性加背景
        for i=1,7 do 
            local y = 241 + 30*(i*2-1) -30
            local title_background = panel:add_texture('image\\角色信息\\line.tga',35,y,767,30)
            title_background:set_alpha(0xff*0.1)
        end    
        -- panel.close_button = panel:add_button('image\\操作栏\\cross.blp',panel.w - 32-5,5,32,32,true)
        panel.titles = {
            '地图等级',
            -- '评论数',
            '签到',
            '宠物等级',
            '宠物毕业数量',
            '装备总评分',
            '爱心积分',
            '杀戮值',
            '挖宝熟练度',
            '看书熟练度',
            '打造熟练度',
            '种树熟练度',
            '白嫖熟练度',
            '摇骰子熟练度',
            -- '勇士徽章',
            -- '比武积分',
            -- '杀猴次数',
            -- '神奇的五分钟',
            -- '深渊乱斗',
            -- '无限乱斗','无上之境','斗破苍穹','修罗模式',
            '士兵','骑士','主教','堡垒',
            '国王','皇后','传奇','万古流芳',
            '超凡入圣','冠世一绝','超绝群伦','新的征程',
            '贪婪魔窟',
            
            
            
            

            
            

        }
        
        panel.titles2 = {
            '贪婪魔窟累计','火把积分',
            '牛刀小试无尽累计','牛刀小试无尽',
            '驾轻就熟无尽累计','驾轻就熟无尽',
            -- '斗破(无尽-最高)','修罗(无尽-最高)',
            -- '深渊(无尽-累计)','乱斗(无尽-累计)','无上(无尽-累计)','斗破(无尽-累计)','修罗(无尽-累计)',

            -- '耐瑟龙碎片','Pa碎片','冰龙碎片','小龙女碎片','霸王莲龙锤碎片','梦蝶仙翼碎片','关羽碎片','精灵龙碎片', '奇美拉碎片',
            -- '魅影碎片',
            -- '紫霜幽幻龙鹰碎片',
            -- '庆生蟠桃',
            
    
        }
        panel.page = 1 
        local next_button = panel:add_button('image\\right.blp',773,371,64,64)
        function next_button:on_button_clicked()
            if panel.page == 1  then 
                panel.page = 2
                self:set_normal_image('image\\left.blp')
            else
                panel.page = 1
                self:set_normal_image('image\\right.blp')
            end    
            panel:fresh()
        end 
        --属性列数
        local col ={
            --x,y,w,h,字体大小，对齐方式
            {35,241,250,30,12,'right'},
            {319,241,106,30,12,'left'},
            {428,241,111,30,12,'right'},
            {577,241,224,30,12,'left'},
        }
        local cre_height = 30
        local base_y = 0
        local ix = 1 
        panel.attrs = {}
        for i=1,#panel.titles do 
            local name = panel.titles[i]
            if not name then break end
            --颜色相关   
            local value = 0
            -- if hero then
            --     value = hero:get(name)
            -- end 

            local x1,y1,w1,h1,line_height1,align1 = table.unpack(col[ix])
            local x2,y2,w2,h2,line_height2,align2 = table.unpack(col[ix+1])
            y1 = y1 + (i-1)*cre_height - base_y
            y2 = y2 + (i-1)*cre_height - base_y

            local attr_name = panel:add_text(name,x1,y1,w1,h1,line_height1,align1)
            --颜色代码
            if i <=5 then 
                attr_name:set_color(0xffF2F200)
            elseif i<=9 then 
                attr_name:set_color(0xff00ABE9)
            elseif i<=13 then 
                attr_name:set_color(0xff00B04F)
            elseif i<=18 then 
                attr_name:set_color(0xffF30101)
            elseif i<=22 then 
                attr_name:set_color(0xffFFC100)
            else
                attr_name:set_color(0xffF2F200)
            end  

            local attr_value = panel:add_text(value,x2,y2,w2,h2,line_height2,align2)
            table.insert(panel.attrs,{attr_name,attr_value}) 
            if i % 13 == 0 then 
                ix = ix + 2
                base_y = cre_height *13
            end 
            
        end 

        panel:hide()

        return panel
    end,

    fresh = function(self)
        local player = ac.player.self
        local hero = ac.player.self.hero
        local peon = ac.player.self.peon
        -- if not hero then return end
        -- if not peon then return end

        local skl = hero and hero:find_skill(hero.skill_names) 
        if skl then
            local tip = skl and skl:get_tip() or ''
            self.hero_tf:set_text('|cffcccccc'..skl.name..'|r')
            self.hero_tip:set_text(tip)
        end    
        if hero and hero.tab_art then 
            self.hero_img:set_normal_image(hero.tab_art)
        end    

        for i,data in ipairs(self.attrs) do
            local name_text,value_text = table.unpack(data) 
            local name

            local function set_all(name)
                if name then 
                    local new_value = 0
                    local show_name = name
                    if name =='地图等级' then 
                        new_value = player:Map_GetMapLevel()
                    elseif name =='宠物等级' then
                        new_value = peon and peon:find_skill('宠物技能') and peon:find_skill('宠物技能').level or 0
                    elseif name =='宠物毕业数量' then
                        for i=1,64 do 
                            if has_flag((player.server['宠物纪念册'] or 0),2^(i-1)) then 
                                new_value = new_value + 1  
                            end
                        end
                    elseif name =='装备总评分' then
                        new_value = player.pf
                    elseif finds(name,'深渊乱斗','无限乱斗','无上之境','斗破苍穹','修罗模式','最强王者','王者','星耀','钻石','铂金','黄金','白银','青铜') then
                        new_value = string.format("%.f",player.server[name] or 0)
                        new_value = new_value..' 星'
                    elseif name =='新的征程' then
                        new_value = string.format("%.f",player.cus_server[name] or 0)  --自定义服务器
                    elseif name =='杀戮值' then
                        new_value = string.format("%.f",player.server['魔灵争霸'] or 0)  --网易服务器
                    elseif name =='签到' then
                        new_value = string.format("%.f",player.server[name] or 0)
                        new_value = new_value ..' |cffff0000(改名会清零)|r'
                        
                    else
                        new_value = string.format("%.f",player.server[name] or 0)
                    end    
                    name_text:set_text(show_name) 
                    value_text:set_text(new_value)
                else 
                    name_text:set_text('')  
                    value_text:set_text('')
                end    
            end    
            if self.page == 1 then 
                name = self.titles[i] 
            else
                name = self.titles2[i] 
            end    
            set_all(name)
        end  
    end,
    set_chess_list = function (self,list)
        for index,unit in ipairs(self.list) do 
            local name = list[index]
            if name then 
                unit:set_name(name)
            else 
                unit:hide()
            end 
        end 
    end,


    on_button_clicked = function (self,button)
        if button == self.close_button then 
            self:hide()
        end 
    end,

    on_button_mouse_enter = function (self,button)
        if button == self.close_button then 
            button:tooltip("关闭","暂时关闭棋子图鉴,按F3可以再次打开",-1,nil,64)
        end 
    end,
    
}

local panel

ac.wait(1000,function ()
    panel = class.player_info_panel.get_instance()
end)
game.loop(2*1000,function() 
    panel:fresh()
end)



local game_event = {}
game_event.on_key_down = function (code)

    if code == KEY.F4 then 
        if panel == nil then return end 
        panel:show()
    elseif code == KEY.ESC then 
        panel:hide()
    end 
end 
game_event.on_key_up = function (code)

    if code == KEY.F4 then 
        if panel == nil then return end 
        panel:hide()
    end 
end 

game.register_event(game_event)