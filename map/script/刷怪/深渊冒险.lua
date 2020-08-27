
--恢复地图设置
local function reset_all()    
    for i=1,10 do 
        local p = ac.player(i)
        local hero = p.hero
        local peon = p.peon

        if p:is_player() and hero then 
            --恢复镜头
            local minx, miny, maxx, maxy = ac.map_area:get()
            p:setCameraBounds(minx, miny, maxx, maxy)  --创建镜头区域大小，在地图上为固定区域大小，无法超出。
            -- hero:blink(ac.map.rects['主城'],true,false) 
            -- peon:blink(ac.map.rects['主城'],true,false)
            ac.wait(10,function()
                p:setCamera(hero:get_point())
            end)
            
            --恢复F2,F3
            local skl = hero:find_skill('F2回城',nil,true)
            if skl then skl:enable() end 
            local skl = hero:find_skill('F3小黑屋',nil,true)
            if skl then skl:enable() end 
        end    
    end    
end
local boss = {
    '一棒男',
    '戴瑟提克','格里弗','克尔苏加德','太阳神',
    '鼠天瞳',
    '牛金刚',
    '武伯都'
}
local boss_skill  ={
    ['一棒男'] = {'净化','给你一棒','再来一棒'},
    ['戴瑟提克'] = {'净化','织网'},
    ['格里弗'] = {'净化','地狱噬咬'},
    ['克尔苏加德'] = {'净化','冰河爆裂'},
    ['太阳神'] = {'净化','金色鎏金'},
    -- ['鼠天瞳'] = {'净化','昼伏夜出','神出鬼没'},
    -- ['牛金刚'] = {'净化','金刚不坏','重生'},
    -- ['武伯都'] = {'净化','百兽之王','群星陨落1'},
    
} 
local function change_attr(unit,index)
    --设置搜敌范围 因子
    unit:set_search_range(6000)
    local attr_mul = ac.get_difficult(ac.g_game_degree_attr)
    local data = ac.table.UnitData['第'..formatNumber(index)..'只BOSS']
    --根据难度增强属性 
    if data.attribute then  
        unit:set('攻击',(data.attribute['攻击']or 1) * (attr_mul or 1))
        unit:set('生命上限',(data.attribute['生命上限']or 1) * (attr_mul or 1))
        unit:set('魔法上限',(data.attribute['魔法上限']or 1))
        unit:set('生命恢复',(data.attribute['生命恢复']or 0))
        unit:set('魔法恢复',(data.attribute['魔法恢复']or 0))
        unit:set('护甲',(data.attribute['护甲']or 1) *  (attr_mul or 1))
        unit:set('魔抗',(data.attribute['护甲']or 1) *  (attr_mul or 1))

        unit:set('暴击伤害',(data.attribute['暴击伤害'] or 0) * (attr_mul or 1))
    end  
    if unit:get_name() =='虚空诺亚' then 
        unit:set('攻击减甲',0)
    end    
    --增加 技能冷却
    unit:add('技能冷却',50)
    --怪物技能
    local skl_list = boss_skill[unit:get_name()]
    if skl_list then 
        for i,name in ipairs(skl_list) do 
            unit:add_skill(name,'英雄')
        end
    end
    --第三只boss 加 重生技能
    if index == 3 then 
        local skl = unit:add_skill('重生','英雄')
        skl.cnt = 99999999
        skl.time = 2
        skl.cool = 60*5
        print('添加了重生技能')
    end
    unit:add_buff '攻击英雄'{
        where = ac.rect.j_rect('moku'):get_point()
    }
    --掉落概率
    unit.fall_rate = 0
    --掉落金币和经验
    unit.gold = 0
    unit.exp = 467
end


--奖品
local award_list = { 
    ['进攻BOSS'] =  {
        { rand = 0, name = '随机符文'},
        { rand = 0, name = '随机物品'},
        { rand = 0, name = '随机功法'},
        { rand = 0, name = '强化石'},
        { rand = 0, name = '天谕'},
        { rand = 0, name = '功法升级书'},
        { rand = 0, name = '功法连升书'},
        { rand = 0, name = '黑暗骰子'},
        { rand = 0, name = '神奇的令牌'},
        { rand = 100, name = '无'},
    },
}
local shenfu = {
    '杀怪加木头+1','杀怪加木头+5','杀怪加木头+10',
    '杀怪加魔丸+2','杀怪加魔丸+10','杀怪加魔丸+20',
}

local function add_content(rand_name,unit,killer)
    local p = killer:get_owner()
    local player = killer:get_owner()
    local hero = player.hero 
    
    -- print('使用了命运花')
    -- local rand_list = award_list['进攻BOSS']
    -- local rand_name,rand_rate = ac.get_reward_name(rand_list)
    -- -- print(rand_list,rand_name) 
    -- if not rand_name then 
    --     return true
    -- end  

    if  rand_name == '随机物品' then
        local cnt = get_player_count()*2
        for i=1,cnt do 
            local name = ac.all_item[math.random( 1,#ac.all_item)]
            ac.item.create_item(name,unit:get_point())
        end
    elseif rand_name == '随机功法' then
        local cnt = get_player_count()*2
        for i=1,cnt do 
            local name = ac.all_skill[math.random( 1,#ac.all_skill)]
            ac.item.create_skill_item(name,unit:get_point())
        end
    elseif finds(rand_name,'强化石','功法升级书')then
        local cnt = get_player_count() * 5
        for i=1,cnt do 
            ac.item.create_item(rand_name,unit:get_point())
        end
    elseif finds(rand_name,'天谕','功法连升书','神奇的令牌')then
        local cnt = get_player_count() * 1
        for i=1,cnt do 
            ac.item.create_item(rand_name,unit:get_point())
        end
    elseif finds(rand_name,'黑暗骰子')then
        local cnt = get_player_count() * 10
        for i=1,cnt do 
            ac.item.create_item(rand_name,unit:get_point())
        end
    elseif finds(rand_name,'随机符文')then
        local cnt = get_player_count() * 2
        for i=1,cnt do 
            local name = shenfu[math.random( 1,#shenfu)]
            ac.item.create_item(name,unit:get_point())
        end
    end   
        
end
    
    

local mt = ac.creep['深渊冒险']{    
    region = 'saijiboss2',
    creeps_datas = '',
    creep_player = ac.player(12),
    force_cool = 600,
    -- force_cool = 20,
    max_index = 5,

}
--进攻怪刷新时的初始化
function mt:on_start()
    self.timer_ex_title ='BOSS'
end

function mt:on_next()

    -- ac.player.self:sendMsg("|cffebb608【系统】|r|cff00ff00 开始挑战 |cffff0000魔窟第"..self.index.."层！|r",5)
    -- local index = self.index
    self.creeps_datas = boss[math.random(#boss)]..'*1'
    self:set_creeps_datas()

    --设置下一波 boss 到来时间
    self.timer_ex_title ='BOSS'
    
    -- self.force_cool = 10*60

    -- 每回合开始 都会先检查计时器是否还存在，存在则清空，重新计时。
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

    local time = 180
    -- time = 20
    self.timer_ex2 = ac.timer_ex 
    {
        time = time,
        title = "游戏失败 倒计时",
        func = function ()
            print('魔窟挑战失败，请再接再厉，2分钟后结束游戏！！！',5)
            local tip ='|cffebb608【系统】|cffff0000深渊挑战失败，请再接再厉，2分钟后结束游戏！！！'
            ac.game:event_notify('游戏-结束',true,tip)
            self:finish()
        end,
    }
    self.timer_ex3 = ac.wait((time-15)*1000,function()
        self.timer_ex4 = ac.timer(1*1000,15,function(t)
            ac.player.self:sendMsg('|cffebb608【系统】|cff00ff00挑战倒计时 |cffff0000'..t.count..' 秒|cff00ff00,请尽快杀死BOSS！',5)
           
            if t.count<=0 then 
                t:remove()
                self.timer_ex4 = nil
            end
        end)
    end)

    --第四波时，
    if self.index == 4 then 
        --等待3秒
        print('第四波设置force_cool1',self.force_cool)
        self.first_wait_time = 3
        --移除timerdialog
        self:set_force_cool(0)
        print('第四波设置force_cool2',self.force_cool)
        if self.timerdialog then 
            self.timerdialog:remove()
            self.timerdialog = nil
        end
    end

end
local award_list = {
    '随机符文','随机物品','随机功法','强化石','天谕','功法升级书','功法连升书','黑暗骰子','神奇的令牌'
}
--改变怪物
function mt:on_change_creep(unit,lni_data)
    change_attr(unit,self.index)
    --显示boss 血条
    if ac.ui and ac.ui.blood_bar then 
        ac.ui.blood_bar:add_unit(unit)
    end
    unit:event '单位-死亡'(function(_,u,killer)
        -- 掉落奖励
        local rate = 50
        for i,name in ipairs(award_list) do 
            if math.random(100000)/1000 <=rate then 
                add_content(name,u,killer)
            end
        end

        -- 每回合开始 都会先检查计时器是否还存在，存在则清空，重新计时。
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
        --重设 地图设置 （镜头等）
        reset_all()  
    end)

    
    if self.index == 5 then 
        
        unit:add_buff '无敌'{
            time = 3
        }

        unit:event '单位-死亡'(function(_,u,killer)
            print('深渊冒险成功',5)
            -- ac.game:event_notify('深渊冒险成功')
            --存档
            for i=1,10 do
                local player = ac.player[i]
                local p = ac.player[i]
                if player:is_player() then
                    local key = 'symx'
                    if ac.g_game_degree > (player.server['深渊冒险'] or 0) then
                        player:Map_SaveServerValue(key,ac.g_game_degree) --网易服务器
                    end 
        
                    local degree = ac.g_game_degree
                    degree = 2^(degree-1)
                    if not has_flag((p.server['深渊冒险奖励'] or 0),degree) then
                        local key = ac.server.name2key('深渊冒险奖励')
                        player:Map_AddServerValue(key,degree)  
                    end
                    
                    local ok = ac.get_save_flag('深渊冒险')
                    if ok then 
                        --处理排行榜相关
                        local key = ac.server.name2key('深渊冒险')
                        local degree = ac.g_game_degree
                        if degree > (player.cus_server['深渊冒险'] or 0) then
                            -- print('保存新的征程到服务器2',player,degree,player.cus_server['新的征程'])
                            player:SetServerValue(key,degree) 
                        end    
                        --今日最榜
                        if degree > (player.cus_server['今日深渊冒险']  or 0) then
                            player:SetServerValue('today_'..key,degree)  
                        end
                    end
                end
            end
        
            local tip ='|cffebb608【系统】|cffff0000深渊冒险成功，2分钟后结束游戏！！！'
            ac.game:event_notify('游戏-结束',true,tip)
        end)
    end
   

end

--刷怪结束
function mt:on_finish()    
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
   
--回合开始时
ac.game:event '游戏-回合开始'(function(trg,index, creep) 
    if creep.name ~= '深渊冒险' then
        return
    end    
    --设置重生地点
    ac.flag_symx = true 
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
    --传送+锁定镜头
    for i=1,10 do 
        local p = ac.player(i)
        local hero = p.hero
        local peon = p.peon
        if p:is_player() and hero then 
            local point = ac.rect.j_rect('moku'):get_point()
            hero:blink(point,true,false)
            peon:blink(point,true,false)
            --锁定镜头
            local minx, miny, maxx, maxy = ac.rect.j_rect('moku5'):get()
            p:setCameraBounds(minx, miny-300, maxx, maxy+300+704)  --创建镜头区域大小，在地图上为固定区域大小，无法超出。
            p:setCamera(hero:get_point())  
        end
    end  

end)
--回合结束时
ac.game:event '游戏-回合开始'(function(trg,index, creep) 
    if creep.name ~= '深渊冒险' then
        return
    end    
    --设置重生地点
    ac.flag_symx = false 
end)



--删除npc
local npc = {'基地','火焰利刃','夭夭','套装熔炼','灵鹤'}
local function del_npc()
    for i,name in ipairs(npc) do 
        for ix =1,6 do
            local shop = ac.find_unit(name)
            if shop then 
                shop:remove()
            end
        end
    end 

end

local temp_award = {
    '装备','功法','强化物品的石头','升级功法的书籍',
    '卡片','稀有的物品','全属性','力量',
    '敏捷','智力','熔炼石',
}
--给boss奖励
local function add_content2(hero)
    local p = hero.owner
    local award_list = p:random2(temp_award,3)
    local list ={}
    for i,name in ipairs(award_list) do 
        local temp = {name,'',name}
        table.insert(list,temp)
    end
    local info = {
        '取消','Esc',"取消 (Esc)",
    }
    table.insert(list,info)
    table.insert(list,1,'选择奖励')

    local dialog = p:dialog(list)
    function dialog:onClick(name)
        if name == '装备' then 
            local cnt = math.random(3)
            for i=1,cnt do 
                local name = ac.all_item[math.random(#ac.all_item)]
                hero:add_item(name)
                p:sendMsg('|cffebb608【系统】|r|cff00ff00恭喜获得'..name,5)
            end
        elseif name == '功法' then 
            local cnt = math.random(3)
            for i=1,cnt do 
                local name = ac.all_skill[math.random(#ac.all_skill)]
                hero:add_skill_item(name)
                p:sendMsg('|cffebb608【系统】|r|cff00ff00恭喜获得'..name,5)
            end
        elseif name == '强化物品的石头' then 
            local temp = {
                ['强化物品的石头'] =  {
                    { rand = 80, name = '强化石'},
                    { rand = 20, name = '天谕'},
                }
            }
            local rand_list = temp['强化物品的石头']
            local rand_name,rand_rate = ac.get_reward_name(rand_list)
            -- print(rand_list,rand_name)  
            if not rand_name then 
                return true
            end
            local cnt = math.random(6)
            for i=1,cnt do 
                hero:add_item(rand_name)
            end
            p:sendMsg('|cffebb608【系统】|r|cff00ff00恭喜获得'..rand_name..'*'..cnt,5)

        elseif name == '升级功法的书籍' then 
            local temp = {
                ['升级功法的书籍'] =  {
                    { rand = 80, name = '功法升级书'},
                    { rand = 20, name = '功法连升书'},
                }
            }
            local rand_list = temp['升级功法的书籍']
            local rand_name,rand_rate = ac.get_reward_name(rand_list)
            -- print(rand_list,rand_name)  
            if not rand_name then 
                return true
            end
            local cnt = math.random(2)
            for i=1,cnt do 
                hero:add_item(rand_name)
            end
            p:sendMsg('|cffebb608【系统】|r|cff00ff00恭喜获得'..rand_name..'*'..cnt,5)
        elseif name == '卡片' then 
            local cnt = math.random(1)
            for i=1,cnt do 
                local name = ac.all_card[math.random(#ac.all_card)]
                hero:add_item(name)
                p:sendMsg('|cffebb608【系统】|r|cff00ff00恭喜获得'..name,5)
            end
        elseif name == '稀有的物品' then  
            local temp = {
                ['稀有的物品'] =  {
                    { rand = 33, name = '吞噬丹'},
                    { rand = 33, name = '龙之血珠'},
                    { rand = 34, name = '无谓因果'},
                }
            }
            local rand_list = temp['稀有的物品']
            local rand_name,rand_rate = ac.get_reward_name(rand_list)
            -- print(rand_list,rand_name)  
            if not rand_name then 
                return true
            end
            local cnt = math.random(1)
            for i=1,cnt do 
                hero:add_item(rand_name)
            end
            p:sendMsg('|cffebb608【系统】|r|cff00ff00恭喜获得'..rand_name..'*'..cnt,5)
        elseif finds(name,'力量','敏捷','智力','全属性') then  
            hero:add(name,20000000)
            p:sendMsg('|cffebb608【系统】|r|cff00ff00恭喜获得2000W'..name,5)
        elseif name == '熔炼石' then 
            local index = math.random(6)
            local name = formatNumber(index)..'号熔炼石'
            hero:add_item(name)
            p:sendMsg('|cffebb608【系统】|r|cff00ff00恭喜获得'..name,5)

        end

    end
end

--创建boss
local function create_boss(name,where,index,owner_ship)
    local boss = ac.player(12):create_unit(name..'BOSS1',where)
    boss:addSize(0.01*(index-1))
    boss.owner_ship = owner_ship
    --1, 1.4 ,1.4*1.4
    --改变boss 属性
    if index > 1 then 
        boss:set('攻击', boss:get('攻击')*1.35^(index-1) )
        boss:set('护甲', boss:get('护甲')*1.35^(index-1) )
        boss:set('魔抗', boss:get('魔抗')*1.35^(index-1) )
        boss:set('生命上限', boss:get('生命上限')*1.35^(index-1) )
        boss:set('暴击伤害', boss:get('暴击伤害')*1.35^(index-1) )
    end

    local eff = boss:add_effect('origin',[[[AKE]11.mdx]])
    boss:add_buff '召唤物'{
        skill = self,
        time = 30,
        texttag = true
    }
    boss:add_buff '无敌'{
        time = 3
    }
    boss:event '单位-死亡' (function(_,unit,killer)
        eff:remove()
        --给奖励
        local p = owner_ship
        add_content2(p.hero)
    end)
end



--删除NPC
ac.game:event '选择难度' (function(_,g_game_degree_name,degree)
    if not finds(g_game_degree_name,'深渊冒险') then 
        return
    end    
    --删除npc  
    del_npc()

    --改变掉落物品
    local temp = {
        { rand = 0.1,      name = '杀怪加木头+1'},
        { rand = 0.05,      name = '杀怪加木头+5'},
        { rand = 0.01,      name = '杀怪加木头+10'},

        { rand = 0.1,      name = '杀怪加魔丸+2'},
        { rand = 0.05,      name = '杀怪加魔丸+10'},
        { rand = 0.01,      name = '杀怪加魔丸+20'},
    }
    for i,tab in ipairs(temp) do 
        table.insert(ac.unit_reward['进攻怪'],tab)
    end

    --禁用泻药卡
    ac.skill['泻药卡'].tip = [[禁用]]
    ac.skill['泻药卡'].on_cast_start = function() end
    --扭蛋券直接使用
    for i,name in ipairs({'扭蛋券','扭蛋券(十连抽)','超级扭蛋券','超级扭蛋券(十连抽)'}) do
        local mt = ac.skill[name]
        mt.no_use = false
        mt.cool = 0
        function mt:on_cast_start() 
            local hero = self.owner
            local new_name = self.name:gsub('券','')
            hero:add_item(new_name)
        end
    end

    local temp = {
        '血魔','藏宝阁','藏经阁','剑冢','百花宫','龙宫','城堡'
    }
    --血魔等野怪的300只事件
    ac.game:event '单位-杀死单位' (function(trg, killer, target)
        local p = killer.owner 
        p.unit_kill_cnt = p.unit_kill_cnt or {}
        p.boss_kill_succ = p.boss_kill_succ or {}
        local u_name = target:get_name()
        
        for i,name in ipairs(temp) do 
            if finds(u_name,name) then 
                p.unit_kill_cnt[name] = (p.unit_kill_cnt[name] or 0) +1
                p.boss_kill_succ[name] = p.boss_kill_succ[name] or 0
                --取商
                -- local boss_index = math.floor(p.unit_kill_cnt[name]/300)
                -- local flag = p.unit_kill_cnt[name] % 300
                if p.unit_kill_cnt[name] == 400 then
                    p.unit_kill_cnt[name] = 0 
                    local boss_index = p.boss_kill_succ[name] + 1
                    --创建boss
                    local point = p.hero:get_point() - {math.random(360),200}
                    create_boss(name,point,boss_index,p)
                end
            end
        end

    end)

end) 
ac.game:event '玩家-注册英雄' (function(trg, player, hero)
    if not finds(ac.g_game_degree_name,'深渊冒险') then 
        return
    end  
    --自动挖宝
    hero.wabao_auto = true 
    --自动种树
    player.auto_plant = true
    --增加物品获取率
    hero:add('物品获取率',150)
    hero:add('每秒加金币',10000)
    --提示玩家属性
    player:add('藏宝图再一次概率',50)
    player:add('羊皮无字再一次概率',50)
    player:add('强化石天谕再一次概率，',50)
    player:add('神奇的种子再一次概率，',50)
    player:add('扭蛋券再一次概率',50)
    player:add('黑暗骰子再一次概率',50)
end)
--创建商店时，就删除对应商店或 商品
ac.game:event '单位-创建商店'(function(trg,shop)
    if not ac.g_game_degree_name then 
        return 
    end
    if not finds(ac.g_game_degree_name,'深渊冒险') then 
        return
    end  
    local str = table.concat(npc,',')
    if finds(str,shop:get_name()) then 
        shop:remove()
    end
    if shop:get_name() == '武学功法' then 
        shop:remove_sell_item('黄阶练功')
        shop:remove_sell_item('玄阶练功')
        shop:remove_sell_item('地阶练功')
    end
end)


ac.game:event '游戏-开始' (function()
    --深渊模式下，不进行普通刷怪
    if not finds(ac.g_game_degree_name,'深渊冒险') then 
        return 
    end
    --删除npc  
    del_npc()

    --游戏开始后 刷怪时间
    local time = 5*60
    -- time = 10
    ac.player.self:sendMsg("|cffebb608【系统】|cff00ff00"..time .. "秒后，挑战首只深渊BOSS",10)
    ac.timer_ex 
    {
        time = time,
        title = "BOSS",
        func = function ()
            --开始刷怪
            print('开始刷兵啦') 
            local creep = ac.creep['深渊冒险'] 
            if type(creep) == 'table' then 
                creep:start()
            end
        end,
    }
end)