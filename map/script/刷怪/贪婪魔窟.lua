local force_cool = 60
if global_test then 
    force_cool = 60
end    

local mobing = {}
for name,data in pairs(ac.table.UnitData) do 
    if finds(name,'魔兵') then 
        table.insert(mobing,name)
    end     
end 
--排序 
table.sort(mobing,function(a,b)
    return a < b
end)
ac.mobing = mobing
-- print_r(mobing)

local skill_list = {}
for name,data in pairs(ac.skill) do 
    if type(data) == 'table' then 
        if data.skill_type =='野怪' then 
            table.insert(skill_list,name)
        end     
    end
end 
--排序 
table.sort(skill_list,function(a,b)
    return a < b
end)
ac.creep_skill_list = skill_list
-- print_r(skill_list)

--无尽怪物改变所有属性
local base_attr = {
    ['攻击'] = 4249976192,
    ['护甲'] = 381932,
    ['魔抗'] = 381932,
    ['生命上限'] = 15560193899,
    ['魔法上限'] = 1000000,
    ['移动速度'] = 519,
    ['攻击间隔'] = 0.75,
    ['生命恢复'] = 74096161,
    ['攻击减甲'] = 5,
    ['魔法恢复'] = 10000,
    ['攻击距离'] = 250,
    ['攻击速度'] = 450,
    ['韧性'] = 30,
    ['暴击几率'] = 20,
    ['暴击伤害'] = 15500,
    ['会心几率'] = 20,
    ['会心伤害'] = 900,
}
local boss_attr = {
    ['攻击'] = 8499952384,
    ['护甲'] = 763864,
    ['魔抗'] = 763864,
    ['生命上限'] = 31120387798,
    ['魔法上限'] = 1000000,
    ['移动速度'] = 519,
    ['攻击间隔'] = 0.6,
    ['生命恢复'] = 148192322,
    ['攻击减甲'] = 10,
    ['魔法恢复'] = 10000,
    ['攻击距离'] = 450,
    ['攻击速度'] = 700,
    ['韧性'] = 50,
    ['暴击几率'] = 20,
    ['暴击伤害'] = 31000,
    ['会心几率'] = 20,
    ['会心伤害'] = 900,
    ['每秒回血'] = 1,
}
local function change_attr(unit,index,is_boss)
    --设置搜敌范围 因子
    unit:set_search_range(6000)
    local degree_attr_mul = ac.get_difficult(ac.g_game_degree_attr)
    local endless_attr_mul = ac.get_difficult(index,1.05)
    local renxing_attr_mul = ac.get_difficult(index,1.01)

    -- local boss_mul = 1
    --设置属性
    if not is_boss then 
        for key,value in sortpairs(base_attr) do 
            if finds('攻击 护甲 魔抗 生命上限 暴击伤害 攻击减甲',key) then 
                unit:set(key, value * degree_attr_mul * endless_attr_mul)
            elseif finds('韧性',key) then 
                unit:set(key, value * degree_attr_mul * renxing_attr_mul)
            else
                unit:set(key, value)
            end    
        end 
    else  
    --boss改变属性     
        for key,value in sortpairs(boss_attr) do 
            if finds('攻击 护甲 魔抗 生命上限 暴击伤害 攻击减甲',key) then 
                unit:set(key, value * degree_attr_mul * endless_attr_mul)
            elseif finds('韧性 每秒回血',key) then 
                unit:set(key, value * degree_attr_mul * renxing_attr_mul)
            else
                unit:set(key, value)
            end    
        end  
    end
    -- unit:set('移动速度', base_attr['移动速度'] + index*10) 
    if unit:get_name() =='虚空诺亚' then 
        unit:set('攻击减甲',0)
    end    
    
    --掉落概率
    unit.fall_rate = 0
    --掉落金币和经验
    unit.gold = 0
    unit.exp = 467
end

ac.game:event '选择难度' (function(_,g_game_degree_name,degree)
    if not finds(g_game_degree_name,'贪婪魔窟') then 
        return
    end    
    local max_index
    if finds(g_game_degree_name , '普通') then 
        max_index = 25
    end
    if finds(g_game_degree_name , '噩梦') then 
        max_index = 50
    end
    if finds(g_game_degree_name , '地狱') then 
        max_index = 100
    end
    if finds(g_game_degree_name , '绝望') then 
        max_index = 150
    end

    if finds(g_game_degree_name , '修罗') then 
        max_index = 200
    end
    
    local mt = ac.creep['贪婪魔窟']{    
        region = 'moku1 moku2 moku3 moku4',
        creeps_datas = '',
        creep_player = ac.player(12),
        create_unit_cool = 0.05,
        is_random = true,
        max_index = max_index,
        cool_count = 75, --剩余30只时
        -- tip ="|cffff0000怪物开始进攻！！！|r"

    }
    --进攻怪刷新时的初始化
    function mt:on_start()
    end

    function mt:on_next()
    
        -- ac.player.self:sendMsg("|cffebb608【系统】|r|cff00ff00 开始挑战 |cffff0000魔窟第"..self.index.."层！|r",5)
        -- local index = self.index
        self.creeps_datas = mobing[math.random(#mobing)]..'*150'
        -- self.creeps_datas = '火凤凰*20'
        self:set_creeps_datas()
        --难度 12 （斗破苍穹） 增加技能
        self.skill_name = skill_list[math.random(#skill_list)]
        if self.skill_name then 
            ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ff00当前挑战 |cffffff00魔窟第'..self.index..'层|cff00ff00，怪物特性： |cffff0000'..self.skill_name)
        end   

        -- 每回合开始 都会先检查计时器是否还存在，存在则清空，重新计时。
        if self.timer_ex2 then 
            self.timer_ex2:remove()
        end   
        if self.timer_ex3 then 
            self.timer_ex3:remove()
            self.timer_ex3 = nil
        end  
        if self.timer_ex4 then 
            self.timer_ex4:remove()
            self.timer_ex4 = nil
        end  

        local time = 180
        -- time = 20
        self.timer_ex2 = ac.timer_ex 
        {
            time = time,
            title = "游戏失败 倒计时",
            func = function ()
                print('魔窟挑战失败，请再接再厉，2分钟后结束游戏！！！',5)
                local tip ='|cffebb608【系统】|cffff0000魔窟挑战失败，请再接再厉，2分钟后结束游戏！！！'
                ac.game:event_notify('游戏-结束',true,tip)
                self:finish()
            end,
        }
        self.timer_ex3 = ac.wait((time-15)*1000,function()
            self.timer_ex4 = ac.timer(1*1000,15,function(t)
                ac.player.self:sendMsg('|cffebb608【系统】|cff00ff00本层挑战倒计时 |cffff0000'..t.count..' 秒|cff00ff00,请尽快清理场上怪物！！！',5)
               
                if t.count<=0 then 
                    t:remove()
                    self.timer_ex4 = nil
                end
            end)
        end)

    end
    --改变怪物
    function mt:on_change_creep(unit,lni_data)
        change_attr(unit,self.index)
        --加技能
        if self.skill_name  then 
            unit:add_skill(self.skill_name,'隐藏')
        end
    end
    --每3秒刷新一次攻击目标 原地不动才发起攻击
    -- function mt:attack_hero() 
    --     self.attack_hero_timer = ac.loop(3 * 1000 ,function ()
    --         -- print('野怪区的怪数量',#mt.group)
    --         local point = ac.map.rects['主城']:get_point()
    --         for _, unit in ipairs(self.group) do
    --             if unit:is_alive() then 
    --                 if unit.last_point then 
    --                     local distance =  unit.last_point * unit:get_point()
    --                     local hero = ac.find_hero(unit)
    --                     local hero_distance = 0
    --                     if hero then 
    --                         hero_distance = hero:get_point() * unit:get_point()
    --                     end    
    --                     if hero_distance <= 10 then
    --                         --1500码内，优先攻击英雄，英雄死亡则攻向基地点
    --                         unit:issue_order('attack',point)
    --                     elseif hero_distance <= 1500  then
    --                         unit:issue_order('attack',hero)  
    --                     else    
    --                         unit:issue_order('attack',point)
    --                     end      
    --                 end  
    --                 unit.last_point = unit:get_point()
    --             end   
    --         end 
    --     end) 
    --     self.attack_hero_timer:on_timer()
    -- end    

    --刷怪结束
    function mt:on_finish()  
        if self.key_unit_trg then 
            self.key_unit_trg:remove()
        end    
        if self.mode_timer then 
            self.mode_timer:remove()
        end    
        if self.attack_hero_timer then 
            self.attack_hero_timer:remove()
        end  
        if self.timer_ex2 then 
            self.timer_ex2:remove()
            self.timer_ex2 = nil
        end   
        if self.timer_ex3 then 
            self.timer_ex3:remove()
            self.timer_ex3 = nil
        end  
        if self.timer_ex4 then 
            self.timer_ex4:remove()
            self.timer_ex4 = nil
        end  
    end   
end)

local function create_boss(creep)
    local point = creep.region:get_point()
    --最后一波时，发布最终波数
    local boss = ac.player.com[2]:create_unit('大魔王',point)
    boss.unit_type = 'boss'
    change_attr(boss,creep.index,true) --普通怪倍数

    boss:add_buff '攻击英雄' {}
    boss:add_buff '无敌' {
        time = 1.5
    }
    boss:add_skill('净化','英雄')
    boss:add_skill('金色莲花','英雄')
    boss:add_skill('金色鎏金','英雄')
    print('boss 出现啦。',boss,boss:get_point())
    return boss
end


ac.game:event '游戏-回合结束'(function(trg,index, creep) 
    if creep.name ~= '贪婪魔窟' then
        return
    end    
    --加入boss
    local self = creep  
    local boss = create_boss(self)
    --boss打死了显示ui
    boss:event '单位-死亡' (function(_,unit,killer) 
        --展示ui
        print('boos死亡了，展示了ui',unit)
        local new_ui = ac.ui.cave 
        new_ui:give_award()
        new_ui:fresh()
        new_ui:show1()
        -- self:next()
    end)  
    --终止下回合开始
    return true
end)    



--传送到贪婪魔窟  倒计时（文字提醒）
local function blink_tlmk(start_time)
    local start_time = start_time or 60 
    ac.timer_ex 
    {
        time = start_time,
        title = '进入 贪婪魔窟 倒计时： ' ,
        func = function ()
            ac.wait(10*1000,function()
                ac.creep['贪婪魔窟']:start()
            end)
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
            ac.player.self:sendMsg('|cffebb608【系统】|r|cffff0000 '..t_time..' |r |cff00ff00秒后进入|cffffff00贪婪魔窟|cff00ff00，请做好战前准备！',2)
    
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
                    text = '秒后进入贪婪魔窟',
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
                    ac.player.self:sendMsg("|cffebb608【系统】|r|cff00ff00在|cffffff00 3分钟 |cff00ff00内杀死本层所有怪物，否则魔窟坍塌，|cffff0000游戏失败！")
                    ac.player.self:sendMsg("|cffebb608【系统】|r|cff00ff00通过每一层的挑战后，战斗力最强的玩家，可选择|cffffff00【获得装备并终止挑战】|cff00ff00或|cffffff00【继续挑战下一层】|cffff0000（挑战失败则一无所有，请量力而行！）")

                end)
            end
        end        
    end )
    
end    


ac.game:event '游戏-贪婪魔窟开始'(function(trg,time) 
    --清理地图的东西
    ac.clear_map()

    --游戏开始后 刷怪时间  
    local time = time or 120
    ac.player.self:sendMsg("|cffebb608【系统】|r|cff00ff00恭喜通关！|cffff00002分钟|cff00ff00后传送至|cffffff00贪婪魔窟|r，|cff00ff00请做好战前准备！|cff00ffff因为里面有着强大的怪物守护着|cffff0000超级宝藏")
    ac.player.self:sendMsg("|cffebb608【系统】|r|cff00ff00恭喜通关！|cffff00002分钟|cff00ff00后传送至|cffffff00贪婪魔窟|r，|cff00ff00请做好战前准备！|cff00ffff因为里面有着强大的怪物守护着|cffff0000超级宝藏")
    ac.player.self:sendMsg("|cffebb608【系统】|r|cff00ff00恭喜通关！|cffff00002分钟|cff00ff00后传送至|cffffff00贪婪魔窟|r，|cff00ff00请做好战前准备！|cff00ffff因为里面有着强大的怪物守护着|cffff0000超级宝藏")
    --启动 传送计时器
    blink_tlmk(time)

    --设置地板颜色
    for i = 1,12 do
        ac.player[i]:set_day(nil)
    end
    --设置光影
    ac.light(3)
end)


--保存数据到自定义服务器
ac.game:event '游戏-回合开始'(function(trg,index, creep)
    if creep.name ~= '贪婪魔窟' then
        return
    end     

    for i=1,6 do 
        local p = ac.player(i)
        if p:is_player() then 
            local key = ac.server.name2key('贪婪魔窟')
            if index > (p.cus_server['贪婪魔窟'] or 0) then
                p:SetServerValue(key,index) 
            end   
            if index > (p.server['贪婪魔窟'] or 0) then
                p:Map_SaveServerValue(key,index) --网易服务器
            end   
            --今日最榜
            if index > (p.cus_server['今日贪婪魔窟']  or 0) then
                p:SetServerValue('today_'..key,index)  
            end

            --累计相关
            local key = ac.server.name2key('贪婪魔窟累计')
            p:Map_AddServerValue(key,1) --网易服务器
            

        end
    end


end)