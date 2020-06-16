local slk = require 'jass.slk'
local ui  = require 'ui.client.util'

class.wjphb_panel = extends(class.panel){
    create = function ()
        local hero = ac.player.self.hero
        local panel = class.panel.create('image\\排行榜\\phb_bg.tga',372,176,1193,593)
        panel.__index = class.wjphb_panel 

        panel:add_button('',0,0,panel.w,panel.h)

        --左边菜单 
        panel.menu_titles = {
            -- '深渊乱斗无尽','无限乱斗无尽','无上之境无尽','斗破苍穹无尽',
            '挖宝','看书','打造','种树','白嫖','摇骰子',
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
            elseif panel.menu_titles[i] =='挖宝' then 
                text:set_color(0xffA9A6F7)
            else    
                text:set_color(0xffA9A6F7)
            end        
            --增加下划线
            button:add_texture(menu_line,0,40,106,5)
            button.name = name

            function button:on_button_clicked()
                --更换按钮状态
                panel.last_button:set_normal_image('')
                if panel.last_button.text:get_text() == '挖宝' then 
                    panel.last_button.text:set_color(0xffA9A6F7)
                else     
                    panel.last_button.text:set_color(0xffA9A6F7)
                end    
                
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
        local img_phb_df = 'image\\排行榜\\tt1.tga'
        local img_phb_tgsc = 'image\\排行榜\\tt2.tga'
        local img_title = 'image\\排行榜\\titile_bg.tga'
        local img_tip1 = panel:add_button(img_phb_df,180+menu_width+off_left, 20+off_top,148.2,47) 
        -- panel:add_texture(img_phb_df,256,20,183,47) 
        local img_tip2 = panel:add_button(img_phb_tgsc,180+menu_width+main_box_width+off_left ,20+off_top,148.2,47) 
        -- panel:add_texture(img_phb_tgsc,689,20,183,47) 
        --说明 
        
        local more_tip1 = panel:add_button([[image\排行榜\icon_wenhao.blp]],440+menu_width+off_left, off_top,32,32) 
        local more_tip2 = panel:add_button([[image\排行榜\icon_wenhao.blp]],440+menu_width+main_box_width+off_left ,off_top,32,32) 
        local info = {
            name ='',
            -- tip = '每小时刷新一次'
            tip = '|cff00ff00每小时刷新一次\n|cffcccccc赛季结束将清空排行榜'
            
        }
        function more_tip1:on_button_mouse_enter()
            if info then 
                self:tooltip(info.name,info.tip,-1,200,84,10)
            end
        end    
        local info = {
            name ='',
            tip = [[|r|cff00ff00每小时刷新一次|cffffe799（上榜奖励|cffdf19d0【称号】江山代有才人出|cffffe799）
|cffcccccc每天清空一次排行榜]]
--             tip = [[|r|cffcccccc每小时刷新一次

-- 上榜奖励:|r |cffff0000独孤求败|r (刷新后自动激活)
-- ]]


        }
        function more_tip2:on_button_mouse_enter()
            if info then 
                self:tooltip(info.name,info.tip,-1,200,140,10)
            end
        end    

        local texture = panel:add_texture(img_title,54+menu_width+off_left,65+off_top,366,48) 
        local text = texture:add_text('名次',30,0,30,34,10,'left')
        text:set_color(0xffA9A6F7)
        local text = texture:add_text('玩家昵称',139,0,30,34,10,'left')
        text:set_color(0xffA9A6F7)
        local text = texture:add_text('最高',276,0,30,34,10,'left')
        text:set_color(0xffA9A6F7)
        local texture = panel:add_texture(img_title,54+menu_width+main_box_width+off_left,65+off_top,366,48) 
        local text =  texture:add_text('名次',30,0,30,34,10,'left')
        text:set_color(0xffA9A6F7)
        local text = texture:add_text('玩家昵称',139,0,30,34,10,'left')
        text:set_color(0xffA9A6F7)
        local text = texture:add_text('最高',276,0,30,34,10,'left')
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
            self.df_star[i]:set_text(data.value)
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

        self:set_df_data(self.rank[name])
        self:set_tgsc_data(self.rank['今日'..name])
    end,


    on_button_clicked = function (self,button)
        if button == self.close_button then 
            self:hide()
        end 
    end,

    
}

local panel

ac.wait(10,function ()
    panel = class.wjphb_panel.get_instance()
end)

local game_event = {}
game_event.on_key_down = function (code)
    -- if code == KEY.F5 then 
    --     ac.player(ac.player.self.id):sendMsg('排行榜还在努力制作中，敬请期待',5)
    -- end
    if code == KEY.F6 then 
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
    {'cntwb','挖宝'},
    {'cntks','看书'},
    {'cntdz','打造'},
    {'cntzs','种树'},
    {'cntbp','白嫖'},
    {'cntytz','摇骰子'},
    
    {'today_cntwb','今日挖宝'},
    {'today_cntks','今日看书'},
    {'today_cntdz','今日打造'},
    {'today_cntzs','今日种树'},
    {'today_cntbp','今日白嫖'},
    {'today_cntytz','今日摇骰子'},
}
--处理,显示排行榜数据
--取前10名数据
ac.wait(5*1000,function() 
    for i,content in ipairs(rank) do
        local p = ac.player(1);
        ac.wait(200*i,function()
            p:sp_get_rank2(content[1],function(data)
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
                        table.insert(panel.rank[content[2]],data[i])
                    end  


                    --发起同步请求
                    local tab_str = ui.encode(panel.rank[content[2]])  
                    -- print('数据长度',#tab_str) 
                    ac.wait(10,function()
                        local info = {
                            type = 'sync_rank_wj',
                            func_name = 'sync_rank_wj',
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
    sync_rank_wj = function (tab_str,str)
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
ui.register_event('sync_rank_wj',event)




-- local content ={ 
-- }

--保存今日榜
local function save_wb()
    for i=1,10 do
        local p = ac.player[i]
        if p:is_player() then 
            if not p.cus_server3 then 
                p.cus_server3 = {}
            end   
            for i,data in ipairs(rank) do 
                local key = data[1]
                local name = data[2]
                if p.cus_server3[name] then 
                    p.cus_server3['总'..name] = (p.cus_server3['总'..name] or 0) + p.cus_server3[name]
                    --自定义服务器 保存总积分 
                    p:AddServerValue(key,p.cus_server3[name])  
                    --自定义服务器 保存今日最高积分
                    if p.cus_server3['总'..name] >= (p.cus_server['今日'..name] or 0 ) then 
                        p:SetServerValue('today_'..key,p.cus_server3['总'..name])  
                    end
                    --保存完需要清空，下次保存时才能正确增加上去
                    p.cus_server3[name] = 0 
                end    
            end
        end
    end   
end  
ac.game:event '选择难度' (function() 
    local time =60 * 1
    save_wb()
    ac.loop(time*1000,function()
        save_wb()
    end)
end)

ac.game:event '挖图成功'(function(trg,hero)
    local p = hero.owner
    p.cus_server3['挖宝'] = (p.cus_server3['挖宝'] or 0) + 1
end)
ac.game:event '触发羊皮无字事件'(function(trg,skill,hero)
    local p = hero.owner
    p.cus_server3['看书'] = (p.cus_server3['看书'] or 0) + 1
end)

ac.game:event '触发锻造事件'(function(trg,skill,hero)
    local p = hero.owner
    p.cus_server3['打造'] = (p.cus_server3['打造'] or 0) + 1
end)

ac.game:event '触发一颗神奇的种子事件'(function(trg,skill,hero)
    local p = hero.owner
    p.cus_server3['种树'] = (p.cus_server3['种树'] or 0) + 1
end)

ac.game:event '单位-触发抵用券' (function(_,seller,u,__it,__u_raffle)
    if not finds(__u_raffle.name,'扭蛋券') then 
        return 
    end    
    --__it 为神符类，已经被销毁
    local self = __u_raffle
    local hero = u
    local p = hero.owner
    p.cus_server3['白嫖'] = (p.cus_server3['白嫖'] or 0) + 1
end)

ac.game:event '触发黑暗骰子事件'(function(trg,skill,hero)
    local p = hero.owner
    p.cus_server3['摇骰子'] = (p.cus_server3['摇骰子'] or 0) + 1
end)


local mt = ac.skill['风骚']
mt{
--等级
level = 1, --要动态插入
max_level = 1,
-- cool = 1,
--图标
art = [[huolinger.blp]],
--说明
tip = [[

|cffFFE799【单位属性】：|r
|cff00ff00点击获得/收回一个随从
|cff00ffff单位攻击力=400%英雄攻击力
|cffffff00单位攻击10%概率让她的敌人神魂颠倒，晕眩敌人1.5秒，并造成范围物理伤害（伤害公式：英雄攻击力*15）
|cffff0000继承英雄暴击几率/伤害，会心几率/伤害，物伤/全伤加深

|cff00ffff进入|cffffff00今日排行榜前十名（按F6查看）|cff00ffff即可获得|r
|cffcccccc（非永久存档称号，掉出排行榜将失去称号）|r
]],

}
function mt:on_upgrade()
    local skill =self
    local hero = self.owner
    local p = hero:get_owner()
    if p.id >10 then return end 
    local attribute ={
        ['攻击'] = function() return hero:get('攻击')*4 end,
        ['攻击间隔'] = function() return hero:get('攻击间隔') end,
        ['攻击速度'] = function() return hero:get('攻击速度') end,
        ['生命上限'] = function() return hero:get('生命上限') end,
        ['魔法上限'] = function() return hero:get('魔法上限') end,
        ['生命恢复'] = function() return hero:get('生命恢复') end,
        ['魔法恢复'] = function() return hero:get('魔法恢复') end,
        ['移动速度'] = 522,

        ['暴击几率'] = function() return hero:get('暴击几率') end,
        ['暴击伤害'] = function() return hero:get('暴击伤害') end,
        ['会心几率'] = function() return hero:get('会心几率') end,
        ['会心伤害'] = function() return hero:get('会心伤害') end,
        ['物理伤害加深'] = function() return hero:get('物理伤害加深') end,
        ['全伤加深'] = function() return hero:get('全伤加深') end,

        ['物品获取率'] = function() return hero:get('物品获取率') end,
        ['木头加成'] = function() return hero:get('木头加成') end,
        ['金币加成'] = function() return hero:get('金币加成') end,
        ['杀敌数加成'] = function() return hero:get('杀敌数加成') end,
        ['魔丸加成'] = function() return hero:get('魔丸加成') end,
    }
    if not p.unit_fs then 
        p.unit_fs = p:create_unit('风骚',hero:get_point()-{math.random(360),100})
        p.unit_fs:remove_ability 'AInv'
        p.unit_fs:add_ability 'Aloc'
        p.unit_fs:add_restriction '无敌'
        p.unit_fs:add_buff "召唤物"{
            attribute = attribute,
            skill = self,
            follow = true,
            search_area = 500, --搜敌路径    
        }
    end   
    
    --技能相关
    local skl = p.unit_fs:find_skill('神魂颠倒',nil)
    if not skl then 
        skl = p.unit_fs:add_skill('神魂颠倒','隐藏')
    end   
end
function mt:on_cast_start()
    local p=self.owner.owner
    if p.unit_fs then 
        p.unit_fs:remove()
        p.unit_fs = nil
    else
        self:on_upgrade()
    end
end


--魔剑技能
local mt = ac.skill['神魂颠倒'] 
mt{
--等级
level = 1,
--图标
art = [[huolinger.blp]],
--说明
tip = [[

|cffFFE799【能力说明】：|r
|cff00ff00攻击10%概率让她的敌人神魂颠倒，晕眩敌人1.5秒，并造成范围物理伤害（伤害公式：英雄攻击力*15）
 ]],
event_name = '造成伤害效果',
chance = 10,
damage_area = 600,
skill_attack = 15,
effect = [[MXXXT28 -  F.mdx]],
effect2 = [[ZHeart.MDX]]
}

function mt:damage_start(damage)
    local source =self.owner
    local p = source.owner
    local hero = source
    local skill =self
    local target = damage.target

	if not damage:is_common_attack()  then 
		return 
    end 
    for i, u in ac.selector()
		: in_range(target,self.damage_area)
		: is_enemy(source)
		: ipairs()
	do
        u:damage
        {
            source = source,
            skill = skill,
            damage = source:get('攻击')*skill.skill_attack,
            damage_type = '物理'
        }
        u:add_buff '晕眩'{
            time = 1.5,
            model = skill.effect2,
            size = 1.5
        }
	end	
end
