local jass = require("jass.common")

--业务：抽奖 类似 王者荣耀 夺宝
local new_ui = class.panel:builder
{
    x = 372,--假的
    y = 176,--假的 372,176,1193,593
    w = 1193,
    h = 560,
    -- is_show = true,
    is_show = false,
    normal_image = [[image\排行榜\phb_bg.tga]],
    -- alpha = 0.7,
    --关闭按钮
    close_button = {
        type = 'button',
        x = 1193 -32-5,
        y = 5,
        w = 32,
        h = 32,
        level = 5,
        normal_image = 'image\\抽奖\\close.tga',
        has_ani = true,
        on_button_clicked = function (self,button)
            local pannel = self.parent
            pannel:hide()
        end, 
    },
    menus = function(self)
        local panel = self
         --左边菜单 
         panel.menu_titles = {
            -- '深渊乱斗无尽','无限乱斗无尽','无上之境无尽','斗破苍穹无尽',
            'S1赛季','S0赛季'
            
        }
        local menu_press_status = 'image\\排行榜\\menu.tga'
        local menu_line = 'image\\排行榜\\menu_line.tga'
        for i=1,#panel.menu_titles do 
            local name = panel.menu_titles[i]
            print('开始创建菜单',name)
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

                --刷新数据 title_background:set_alpha(0xff*0.1)
                panel:fresh(button.name)
            end    

        end 
    end,
    --中间核心内容
    main_content = {
        x=20+149,
        y=20,
        w=1005,
        h=512,
        normal_image =[[F7UI4.blp]],
        type = 'texture',
        text = {
            x=34,
            y=19,
            w=625,
            h=178,
            type = 'text',
            font_size =14,
            text =[[

            
|cffffe799【赛季时间】|r|cff00ff007月25日-7月31日|r
|cffffe799【赛季说明】|r|cff00ff00通关有概率召唤魔帝，击败可得荣耀战令，解锁大量存档奖励|r|cffffff00（每天只可获得一个荣耀战令）|r
            ]],
            align = 'auto_newline',
        },
        seanson_icon = {
            x=751,
            y=19,
            w=150,
            h=150,
            type = 'button',
            normal_image = [[sjwz.blp]],
            on_button_mouse_enter = function(self)
                local title =self.title or '|cffdf19d0S0赛季王者|r'
                local tip =self.tip or [[
|cffFFE799【获得方式】：|r
|cff00ff00赛季结束时，所有在 |cffff0000F5/F6排行榜 |cff00ff00上面的玩家，均可获得

|cffFFE799【成就属性】：|r
|cff00ff00+88.8   杀怪加全属性|r
|cff00ff00+88.8   攻击减甲|r
|cff00ff00+1%     会心几率|r
|cff00ff00+20%   会心伤害|r
|cff00ff00+38.8% 全伤加深|r
|cffff0000局内地图等级+1

]]
                self:tooltip(title,tip,0,400,200)
            end
        },
        zhanling = {
            x=34,
            y=229,
            w=75,
            h=290,
            normal_image =[[F7UI1.blp]],
            type = 'texture',
            txz = {
                type = 'button',
                on_button_mouse_enter = function(self)
                    local title ='|cffdf19d0进阶说明|r'
                    local tip =[[
|cff00ff00购买|cffffff00【赛季通行证】|cff00ff00后可解锁进阶版奖励！|r
                    ]]
                    self:tooltip(title,tip,0,400,200)
                end,
            },

            white_bg1 = {
                x= 75,
                y=10,
                w=870,
                h=120,
                normal_image =[[image\角色信息\line.tga]],
                type = 'texture',
                alpha = 0.3
            },
            white_bg2 = {
                x= 75,
                y=10+120+10,
                w=870,
                h=120,
                normal_image =[[image\角色信息\line.tga]],
                type = 'texture',
                alpha = 0.3
            },
            content = function(self)
                local max_cnt = 9
                local gap = 30
                local base_x = 30 + 75
                local panel = self.parent.parent
                panel.zhanlings = panel.zhanlings or {}
                for i=1,max_cnt do
                    local new_ui = class.panel:builder
                    {
                        x = base_x + (gap+64)*(i-1),
                        y = -20,--假的 372,176,1193,593
                        w = 64,
                        h = 290,
                        parent = self,
                        normal_image =[[Transparent.tga]],
                        num = {
                            x= 20,
                            y= -10,
                            w= 25,
                            h=40,
                            normal_image ='F7shuzi'..i..'.blp',
                            type = 'texture',
                        },
                        num1 = {
                            x= 35,
                            y= -10,
                            w= 25,
                            h=40,
                            normal_image = [[Transparent.tga]],
                            type = 'texture',
                            
                        },
                        icon_jy = {
                            y= 39+20,
                            w=64,
                            h=64,
                            normal_image ='xigua.blp',
                            type = 'button',
                            complete = {
                                x=25,
                                y=22,
                                w=55,
                                h=55,
                                normal_image ='F7UI3.blp',
                                type = 'texture',
                            },
                            on_button_mouse_enter = function()
                                print('进入了精英奖励')
                            end
                        },

                        icon_jj = {
                            y= 39 + 64 + 64 +20,
                            w=64, 
                            h=64,
                            normal_image ='xigua.blp',
                            type = 'button',
                            complete = {
                                x=25,
                                y=22,
                                w=55,
                                h=55,
                                normal_image ='F7UI3.blp',
                                type = 'texture',
                            },
                            on_button_mouse_enter = function()
                                print('进入了进阶奖励')
                            end
                        },
                    }
                    table.insert(panel.zhanlings,new_ui)
                end
            end
        }
    },
    config = {
      ['S0赛季'] ={
        ['赛季说明'] = [[

            
|cffffe799【赛季时间】|r|cff00ff007月25日-7月31日|r
|cffffe799【赛季说明】|r|cff00ff00通关有概率召唤魔帝，击败可得荣耀战令，解锁大量存档奖励|r|cffffff00（每天只可获得一个荣耀战令）|r
            ]],
        ['赛季王者'] = {
            title ='|cffdf19d0S0赛季王者|r',
            art = [[sjwz.blp]],
            tip = [[
|cffFFE799【获得方式】：|r
|cff00ff00赛季结束时，所有在 |cffff0000F5/F6排行榜 |cff00ff00上面的玩家，均可获得

|cffFFE799【成就属性】：|r
|cff00ff00+88.8   杀怪加全属性|r
|cff00ff00+88.8   攻击减甲|r
|cff00ff00+1%     会心几率|r
|cff00ff00+20%   会心伤害|r
|cff00ff00+38.8% 全伤加深|r
|cffff0000局内地图等级+1
            ]]
        },
        ['精英'] = {'精英版奖励1','精英版奖励2','精英版奖励3'},
        ['进阶'] = {'进阶版奖励1','进阶版奖励2','进阶版奖励3'},
      },
      ['S1赛季'] ={
        ['赛季说明'] = [[

            
|cffffe799【赛季时间】|r|cff00ff008月1日-8月30日|r
|cffffe799【赛季说明】|r|cff00ff00通关有概率召唤魔帝，击败可得荣耀战令，解锁大量存档奖励|r|cffffff00（每天只可获得一个荣耀战令）|r
            ]],
        ['赛季王者'] = {
            title ='|cffdf19d0S1赛季王者|r',
            art = [[sjwz1.blp]],
            tip = [[
|cffFFE799【获得方式】：|r
|cff00ff00赛季结束时，所有在 |cffff0000F5/F6排行榜 |cff00ff00上面的玩家，均可获得

|cffFFE799【成就属性】：|r
|cff00ff00+88.8   杀怪加全属性|r
|cff00ff00+88.8   攻击减甲|r
|cff00ff00+88.8%  会心伤害|r
|cff00ff00+88.8%  全伤加深|r
|cffff0000局内地图等级+1

]]
        },
        ['精英'] = {
            'S1精英版奖励1','S1精英版奖励2','S1精英版奖励3','S1精英版奖励4',
            'S1精英版奖励5','S1精英版奖励6','S1精英版奖励7','S1精英版奖励8',
            'S1精英版奖励9','S1精英版奖励10','S1精英版奖励11','S1精英版奖励12',
            'S1精英版奖励13','S1精英版奖励14','S1精英版奖励15'
        },
        ['进阶'] = {
            'S1进阶版奖励1','S1进阶版奖励2','S1进阶版奖励3','S1进阶版奖励4',
            'S1进阶版奖励5','S1进阶版奖励6','S1进阶版奖励7','S1进阶版奖励8',
            'S1进阶版奖励9','S1进阶版奖励10','S1进阶版奖励11','S1进阶版奖励12',
            'S1进阶版奖励13','S1进阶版奖励14','S1进阶版奖励15'
        },
      },

    },
    clear = function(self)
        for i,ui in ipairs(self.zhanlings) do
            ui.num:set_normal_image([[Transparent.tga]])
            ui.num1:set_normal_image([[Transparent.tga]])

            ui.icon_jy:set_normal_image([[Transparent.tga]])
            ui.icon_jy.complete:set_normal_image([[Transparent.tga]])
            ui.icon_jy.on_button_mouse_enter = nil

            ui.icon_jj:set_normal_image([[Transparent.tga]])
            ui.icon_jj.complete:set_normal_image([[Transparent.tga]])
            ui.icon_jj.on_button_mouse_enter = nil
            
        end
    end,

    init_data = function(self)
        self:menus()
        self:next_button()
        self.main_content.zhanling:content()
        ac.wait(8*1000,function()
            self:fresh('S1赛季')
        end)
    end,
    next_button = function(self)
        local panel = self
        panel.page = 1 
        local nb = panel:add_button('image\\right.blp',1111,250,64,64)
        function nb:on_button_clicked()
            if panel.page == 1  then 
                panel.page = 2
                self:set_normal_image('image\\left.blp')
            else
                panel.page = 1
                self:set_normal_image('image\\right.blp')
            end    
            panel:fresh(panel.now_name,panel.page)
        end
        panel.nb = nb
    end,
    fresh = function(self,name,page)
        if not self.config[name] then 
            return 
        end
        local page = page or 1
        self.now_name = name
        -- print('个数：',#self.config[name]['精英'])
        --下一页显示和隐藏
        if #self.config[name]['精英']>9 then 
            self.nb:show()
        else 
            self.nb:hide()
        end
        self:clear()
        local p=ac.player.self
        --刷新通行证图片
        local has_txz = (p.mall[name..'通行证'] or 0) > 0 
        local img = has_txz and [[F7UI2.blp]] or [[F7UI1.blp]]
        self.main_content.zhanling.txz:set_normal_image(img)
        --刷新赛季说明
        local data = self.config[name]['赛季说明']
        self.main_content.text:set_text(data)
        --刷新赛季王者
        local data = self.config[name]['赛季王者']
        self.main_content.seanson_icon.title = data.title
        self.main_content.seanson_icon.tip = data.tip
        self.main_content.seanson_icon:set_normal_image(data.art)

        --刷新战令相关
        local data = self.config[name]
        for i,ui in ipairs(self.zhanlings) do
            local start_i = (page-1)*9+i
            local jy_name = data['精英'][start_i]
            if jy_name then 
                local tt_i = 0
                for num in string.gmatch(start_i, "%w") do
                    tt_i = tt_i +1
                    if tt_i > 1 then 
                        ui.num1:set_normal_image('F7shuzi'..num..'.blp')
                    else
                        ui.num:set_normal_image('F7shuzi'..num..'.blp')
                    end
                end
                local skl = ac.skill[jy_name]
                local art = skl:get_key('art')
                local tip = skl:get_tip()
                local title = skl:get_title()

                ui.icon_jy:set_normal_image(art)
                --精英版拥有 图片
                if (p.server[jy_name] or 0) > 0 then 
                    ui.icon_jy.complete:set_normal_image([[F7UI3.blp]])
                end
                --进阶版本拥有 图片
                if has_txz and (p.server[jy_name] or 0) > 0 then 
                    ui.icon_jj.complete:set_normal_image([[F7UI3.blp]])
                end
                function ui.icon_jy:on_button_mouse_enter()
                    self:tooltip(title,tip,0,400,200)
                end

                local jy_name = data['进阶'][start_i] or ''
                local skl = ac.skill[jy_name]
                local art = skl:get_key('art')
                local tip = skl:get_tip()
                local title = skl:get_title()

                ui.icon_jj:set_normal_image(art)
                -- ui.icon_jj.complete:set_normal_image([[Transparent.tga]])
                function ui.icon_jj:on_button_mouse_enter()
                    self:tooltip(title,tip,0,400,200)
                end
            end

        end
    
    end

}

new_ui:init_data()

local game_event = {}
game_event.on_key_down = function (code)
    -- if code == KEY.F5 then 
    --     ac.player(ac.player.self.id):sendMsg('排行榜还在努力制作中，敬请期待',5)
    -- end
    if code == KEY.F7 then 
        if new_ui == nil then return end 
        if new_ui.is_show then 
            new_ui:hide()
        else 
            new_ui:show()
        end 
    elseif code == KEY.ESC then 
        new_ui:hide()
    end 
end 

game.register_event(game_event)

local function boss_ani()
    local point = ac.rect.j_rect('saijiboss1'):get_point()
    local u = ac.player(12):create_unit('最强魔帝',point,225)
    u:add_buff '无敌'{
        time = 8,
        model =[[]]
    }
    ac.zqmd = true
    local where = ac.rect.j_rect('moku'):get_point()
    ac.wait(8*1000,function()
		u:set_search_range(500)
        u:add_buff '攻击英雄' {
            where = where
        }
        u:add_skill('净化','英雄')
        u:add_skill('大地崩','英雄')
        u:add_skill('伤害守卫','英雄')
        u:add_skill('boss光子灵枪','英雄')
    
        u:add_skill('金色莲花','英雄')
        u:add_skill('金色鎏金','英雄')

        u:add_skill('给你一棒','英雄')
        u:add_skill('织网','英雄')
        u:add_skill('地狱噬咬','英雄')
        u:add_skill('冰河爆裂','英雄')

        u:add_skill('屠戮_黑夜降临','隐藏')
        u:add_skill('屠戮_神魂一击','隐藏')
        u:add_skill('屠戮_屠戮盛宴','隐藏')
    
        u:add_skill('超级分身','英雄')
        if ac.g_game_degree_attr>=3 then 
            u:add_skill('死亡之指','英雄')
        end
        
        u:add('减伤',1.5 * ac.get_difficult(ac.g_game_degree_attr))
        u:add('物理伤害加深',1.45 * ac.get_difficult(ac.g_game_degree_attr))

        u:add('闪避',50)
    end)
    
    --20分钟没杀死，游戏胜利
    local time = 5*60
    local timer = ac.timer_ex{
        time = time,
        title = '击杀倒计时： ' ,
        func = function ()
            ac.game:event_notify('游戏-结束',true)
            ac.player.self:sendMsg("|cffebb608【系统】|r|cffff0000很遗憾未能完美通关！")
            u:remove()
        end,
    }

    --注册死亡事件
    u:event '单位-死亡'(function(trg,unit,killer)
        timer:remove()

        for i=1,6 do 
            local p = ac.player(i)
            if p:is_player() and (p.cus_server['战令标识'] or 0) <=0 then 
                local hero =p.hero
                local zl_name = 'S1赛季战令'
                local key = ac.server.name2key(zl_name)
                --加战令 s0zl
                local _,max_n = math.frexp(p.server[zl_name] or 0)
                print('S1赛季战令1：',p.server[zl_name],max_n,2^max_n)
                if not has_flag(p.server[zl_name] or 0,2^(max_n)) then 
                    print('S1赛季战令2：',p.server[zl_name],max_n,2^max_n)
                    p:Map_AddServerValue(key,2^(max_n))
                end
                --一次性存档奖励
                local name = 'S1精英版奖励'..(max_n+1)
                local skl = hero:find_skill(name,nil,true)
                if not skl then 
                    -- print('name',name)
                    skl = ac.skill[name]
                    if skl.award then 
                        local key = ac.server.name2key(skl.award)
                        p:Map_AddServerValue(key,skl.award_cnt)
                    end
                end

                --保存到自定义服务器 说今天已经打过战令
                p:SetServerValue('zhanling',1)
                -- p:sendMsg('恭喜获得战令',5)
            end
        end
        ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ff00恭喜完美通关！获得荣耀战令，按F7可查看奖励！|cffffff00（每天只能获得一个荣耀战令）',10)
        ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ff00恭喜完美通关！获得荣耀战令，按F7可查看奖励！|cffffff00（每天只能获得一个荣耀战令）',10)
        ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ff00恭喜完美通关！获得荣耀战令，按F7可查看奖励！|cffffff00（每天只能获得一个荣耀战令）',10)
        --游戏胜利
        ac.game:event_notify('杀死最强魔帝')
        ac.game:event_notify('游戏-结束',true)

    end)


    --设置镜头
    u:set_animation('Morph Alternate')--播放动画
    ac.player(1):CameraSetupApplyForceDuration('Camera_001',true,0)--设置镜头
    
    for i=1,6 do 
        local p = ac.player(i)
        if p:is_player() then
            p:hideInterface(1.5)
		    jass.ClearSelection()
        end
    end

    ac.wait(8*1000,function()
        --所有人重置
        -- ac.player(1):reset_camera()   
        for i=1,6 do 
            local p = ac.player(i)
            if p:is_player() then
                local x,y = p.hero:get_point():get()
				p:setCamera(ac.point(x,y+500))
				p:setCameraField('CAMERA_FIELD_TARGET_DISTANCE', 1000)
				p:setCameraField('CAMERA_FIELD_ANGLE_OF_ATTACK', 304)
				p:setCameraField('CAMERA_FIELD_ZOFFSET', 0)
                p:setCameraField('CAMERA_FIELD_ROTATION', 90)
                
				p:showInterface(1)
                p:setCameraField('CAMERA_FIELD_TARGET_DISTANCE', p.distance,1)
				p:selectUnit(p.hero)
            end
        end
    end)
    
end

--传送到贪婪魔窟  倒计时（文字提醒）
local function blink_tlmk(start_time)
    local start_time = start_time or 60 
    ac.timer_ex 
    {
        time = start_time,
        title = '最强魔帝 出现倒计时： ' ,
        func = function ()
            boss_ani()
            --禁止F2,F3
            for i=1,10 do 
                local p = ac.player(i)
                local hero = p.hero
                local peon = p.peon
                if p:is_player() and hero then 
                    local skl = hero:find_skill('F2回城',nil,true)
                    if skl then skl:disable() end 
                    local skl = hero:find_skill('F3小黑屋',nil,true)
                    if skl then skl:disable() end 
    
                end    
            end 
            ac.flag_tlmt = true
        end,
    }
    --快到时，进行提醒
    local t_time = 15
    ac.wait( (start_time - t_time)*1000,function() 
        ac.timer(1000,t_time,function(t)
            t_time = t_time -1 
            ac.player.self:sendMsg('|cffebb608【系统】|r|cffff0000 '..t_time..' |r |cff00ff00秒开始挑战|cffffff00最强魔帝|cff00ff00，请做好战前准备！',2)
    
            if t_time <=0 then 
                t:remove()
            end    
        end)
    end )

    ac.wait( (start_time - 5)*1000,function() 
        for i=1,10 do 
            local p = ac.player(i)
            local hero = p.hero
            local peon = p.peon
            if p:is_player() and hero then 
                --每个玩家添加传送动画（倒计时）
                hero:add_buff '时停'
                {
                    time = 5,
                    text = '秒后挑战最强魔帝',
                    skill = '贪婪魔窟',
                    source = hero,
                    xoffset = -205,
                    zoffset = 220,
                    show = true,
                    is_god = true,
                }
                ac.wait(5*1000,function()
                    -- print('时停结束，开始进行死亡之环')
                    -- print(hero:get_name())
                    local point = ac.rect.j_rect('moku'):get_point()
                    hero:blink(point,true,false)
                    peon:blink(point,true,false)
                    --锁定镜头
                    local minx, miny, maxx, maxy = ac.rect.j_rect('moku5'):get()
                    p:setCameraBounds(minx, miny-300, maxx, maxy+300+704)  --创建镜头区域大小，在地图上为固定区域大小，无法超出。
                    p:setCamera(hero:get_point())
                    
                    --每个玩家添加传送动画（倒计时）
                    hero:add_buff '时停'
                    {
                        time = 10,
                        skill = '贪婪魔窟',
                        source = hero,
                        zoffset = 220,
                        show = true,
                    }
                    ac.player.self:sendMsg("|cffebb608【系统】|r|cff00ff00在|cffffff00 5分钟 |cff00ff00内杀死最强魔帝！")

                end)
            end
        end        
    end )
end    
--赛季任务
ac.game:event '赛季任务'(function()
    local time = 120
    -- time =15
    ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ff00最强魔帝|cff00ffff2分钟|cff00ff00后出现，它拥有着至高无上的|cffff0000荣耀战令！',5)
    ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ff00最强魔帝|cff00ffff2分钟|cff00ff00后出现，它拥有着至高无上的|cffff0000荣耀战令！',5)
    ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ff00最强魔帝|cff00ffff2分钟|cff00ff00后出现，它拥有着至高无上的|cffff0000荣耀战令！',5)
    blink_tlmk(time)
    
    --创建庄周
    local x,y = ac.rect.j_rect('moku1'):get_point():get()
    local shop = ac.shop.create('庄周',x,y,270,nil) 
    shop:add_sell_item('兑换-神奇的令牌',9)

end)



