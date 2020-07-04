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
print_r(mobing)

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
print_r(skill_list)

--无尽怪物改变所有属性
local base_attr = {
    ['攻击'] = 1000000000,
    ['护甲'] = 45000,
    ['魔抗'] = 45000,
    ['生命上限'] = 2800000000,
    ['魔法上限'] = 1000000,
    ['移动速度'] = 519,
    ['攻击间隔'] = 0.75,
    ['生命恢复'] = 281902,
    ['魔法恢复'] = 10000,
    ['攻击距离'] = 200,
    ['攻击速度'] = 300,
    ['暴击几率'] = 20,
    ['暴击伤害'] = 20000,
    ['会心几率'] = 20,
    ['会心伤害'] = 200,
}
local function change_attr(unit,index,factor)
    --设置搜敌范围 因子
    unit:set_search_range(6000)
    local degree_attr_mul = ac.get_difficult(ac.g_game_degree_attr)
    local endless_attr_mul = ac.get_difficult(index,1.15)
    local boss_mul = factor or 1
    --设置属性
    for key,value in sortpairs(base_attr) do 
        if finds('攻击 护甲 魔抗 生命上限 暴击伤害',key) then 
            unit:set(key, value * degree_attr_mul * endless_attr_mul*boss_mul)
        else
            unit:set(key, value)
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
        max_index = 2
    end
    if finds(g_game_degree_name , '噩梦') then 
        max_index = 5
    end
    local mt = ac.creep['贪婪魔窟']{    
        region = 'moku1 moku2 moku3 moku4',
        creeps_datas = '',
        creep_player = ac.player(12),
        create_unit_cool = 0.2,
        is_random = true,
        max_index = max_index,
        cool_count = 30, --剩余30只时
        -- tip ="|cffff0000怪物开始进攻！！！|r"

    }
    --进攻怪刷新时的初始化
    function mt:on_start()
    end

    function mt:on_next()
    
        ac.player.self:sendMsg("|cffff0000 （无尽） 第"..self.index.."波 怪物开始进攻！！！|r",5)
        -- local index = self.index
        self.creeps_datas = mobing[math.random(#mobing)]..'*60'
        -- self.creeps_datas = '火凤凰*20'
        self:set_creeps_datas()
        --难度 12 （斗破苍穹） 增加技能
        self.skill_name = skill_list[math.random(#skill_list)]
        if self.skill_name then 
            ac.player.self:sendMsg('本波怪物特性： '..self.skill_name)
        end   

        -- 每回合开始 都会先检查计时器是否还存在，存在则清空，重新计时。
        if self.timer_ex2 then 
            self.timer_ex2:remove()
        end    
        self.timer_ex2 = ac.timer_ex 
        {
            time = 60,
            title = "游戏失败 倒计时",
            func = function ()
                ac.game:event_notify('游戏-结束')
                self:finish()
            end,
        }

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
    end   
end)

local function create_boss(creep)
    local point = creep.region:get_point()
    --最后一波时，发布最终波数
    local boss = ac.player.com[2]:create_unit('大魔王',point)
    boss.unit_type = 'boss'
    change_attr(boss,creep.index,1.5) --普通怪倍数

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

    if self.timer_ex2 then 
        self.timer_ex2:remove()
        self.timer_ex2 = nil
    end    
    --终止下回合开始
    return true
end)    



--传送到贪婪魔窟  倒计时（文字提醒）
local function blink_tlmk(start_time)
    local start_time = start_time or 60 
    ac.timer_ex 
    {
        time = start_time,
        title = '距离 贪婪魔窟 开始： ' ,
        func = function ()
            ac.wait(5*1000,function()
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
            ac.player.self:sendMsg('|cffffe799【系统消息】|r贪婪魔窟|cffff0000 '..t_time..' |r秒后开始，请做好准备',5)
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
                    p:setCameraBounds(minx, miny-300, maxx, maxy+300)  --创建镜头区域大小，在地图上为固定区域大小，无法超出。
                    p:setCamera(hero:get_point())
                    
                    --每个玩家添加传送动画（倒计时）
                    hero:add_buff '时停'
                    {
                        time = 5,
                        skill = '贪婪魔窟',
                        source = hero,
                        zoffset = 220,
                        show = true,
                    }
                end)
            end
        end        
    end )
    
end    


ac.game:event '游戏-贪婪魔窟开始'(function(trg) 
    --清理地图的东西
    ac.clear_map()

    --游戏开始后 刷怪时间  
    local time = 15
    ac.player.self:sendMsg("|cffebb608【系统】|r|cffff0000无尽挑战开始|r |cff00ffff 第一波妖怪 |r|cff00ff00在".. time .. "秒后开始进攻！|r|cffff0000(部分精英怪对所有真伤型技能免疫)",10)
    --启动 传送计时器
    blink_tlmk(time)

    --设置地板颜色
    for i = 1,12 do
        ac.player[i]:set_day(nil)
    end
    --设置光影
    ac.light(3)
end)