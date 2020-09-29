local force_cool = 30
if global_test then 
    force_cool = 30
end    

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


for i =1,3 do 
    local mt = ac.creep['刷怪-无尽'..i]{    
        region = 'cg'..i,
        creeps_datas = '',
        force_cool = force_cool,
        creep_player = ac.player(i+6),
        create_unit_cool = 0.5,
        -- tip ="|cffff0000怪物开始进攻！！！|r"

    }
    --进攻怪刷新时的初始化
    function mt:on_start()
        local rect = require 'types.rect'
        if i == 1 then 
            self.timer_ex_title ='（无尽）距离 第'..(self.index+2)..'波 怪物进攻'
         end   
    end

    function mt:on_next()
        if i == 1 then 
           self.timer_ex_title ='（无尽）距离 第'..(self.index+2)..'波 怪物进攻'
           ac.creep_skill_name1 = ac.creep_skill_list[math.random(#ac.creep_skill_list)]
           ac.mobing_name = ac.mobing[math.random(#ac.mobing)]
        end   
        --小地图ping
        ac.player.self:pingMinimap(self.region,3,255,0,0)
        ac.player.self:pingMinimap(self.region,3,255,0,0)
        -- if ac.ui then ac.ui.kzt.up_jingong_title(' 第 '..self.index..' 波 ') end

        ac.player.self:sendMsg("|cffff0000 （无尽） 第"..self.index.."波 怪物开始进攻！！！|r",5)
        -- local index = self.index
        self.creeps_datas = ac.mobing_name..'*20'
        self:set_creeps_datas()
        --难度 12 （斗破苍穹） 增加技能
        self.skill_name = ac.creep_skill_name1
        if self.skill_name then 
            ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ff00当前挑战 |cffffff00无尽第'..self.index..'波|cff00ff00，怪物特性： |cffff0000'..self.skill_name)
        end     
    end
    --改变怪物
    function mt:on_change_creep(unit,lni_data)
        change_attr(unit,self.index) 

        unit:set_search_range(1000)
        local point = ac.map.rects['主城']:get_point()
        unit:issue_order('attack',point)
        --加技能
        if self.skill_name  then 
            unit:add_skill(self.skill_name,'隐藏')
        end

    end
    --每3秒刷新一次攻击目标 原地不动才发起攻击
    function mt:attack_hero() 
        self.attack_hero_timer = ac.loop(3 * 1000 ,function ()
            -- print('野怪区的怪数量',#mt.group)
            local point = ac.map.rects['主城']:get_point()
            for _, unit in ipairs(self.group) do
                if unit:is_alive() then 
                    if unit.last_point then 
                        local distance =  unit.last_point * unit:get_point()
                        local hero = ac.find_hero(unit)
                        local hero_distance = 0
                        if hero then 
                            hero_distance = hero:get_point() * unit:get_point()
                        end    
                        if hero_distance <= 10 then
                            --1500码内，优先攻击英雄，英雄死亡则攻向基地点
                            unit:issue_order('attack',point)
                        elseif hero_distance <= 1500  then
                            unit:issue_order('attack',hero)  
                        else    
                            unit:issue_order('attack',point)
                        end      
                    end  
                    unit.last_point = unit:get_point()
                end   
            end 
        end) 
        self.attack_hero_timer:on_timer()
    end    

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

end    



--注册boss进攻事件
ac.game:event '游戏-回合开始'(function(trg,index, creep) 
    if not finds(ac.g_game_degree_name,'无尽模式')  then
        return
    end    
    if creep.name ~= '刷怪-无尽1' then
        return
    end    

    local point = ac.map.rects['进攻点']:get_point()
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

end)   
--清理地图上面的 商店等
local function clear_map()
    --删除商店
    local del_shop = [[火焰利刃]]
    for key,unit in pairs(ac.shop.unit_list) do 
		if finds(del_shop,unit:get_name()) then 
			unit:remove()
        end	
        
        if unit:get_name() == '武学功法' then 
            unit:remove_sell_item('黄阶练功')
            unit:remove_sell_item('玄阶练功')
            unit:remove_sell_item('地阶练功')
        end
    end	
    
    -- --练功房 自动刷怪停止
    for i=1,10 do 
        local p = ac.player(i)
        if p:is_player() then 
            p.current_creep = nil  
        end
    end     

    -- 关闭所有刷怪并清除怪物
    for name,crep in  pairs(ac.all_creep) do 
        if crep and crep.has_started then 
            crep:finish(true)
        end    
    end    
    -- 野怪刷新开关 ，true 关闭,清理所有场上敌对怪物
    ac.flag_endless = true 
    for key,unit in pairs(ac.unit.all_units) do 
		if unit:is_alive() and unit.category =='进攻怪' then 
			unit:remove()
		end	
    end	

    --无尽后，地上技能120秒自动消失
    local mt = ac.skill['学习技能']
    mt.time_removed = 60 --自动消失时间
    local t_time = 15 --倒计时

    ac.wait(5*1000,function()
        ac.player.self:sendMsg('|cffebb608【系统】|r|cffff0000'..mt.time_removed..'秒|r|cff00ff00后，清理地上技能',10)
        --倒计时清理地上技能
        ac.wait((mt.time_removed-t_time)*1000,function()
            ac.timer(1*1000,t_time,function(t)
                t_time = t_time -1
                ac.player.self:sendMsg('|cffebb608【系统】|r|cffff0000'..t_time..'秒|r|cff00ff00后，清理地上技能',2)
            
                if t_time <= 0 then 
                    --开始清理
                    for _,v in pairs(ac.item.item_map) do
                        if not v.owner and v.cus_type =='技能' then 
                            v:item_remove()
                        end
                    end    
                end    
            end)
        end)
    end)
end
ac.clear_map = clear_map

ac.game:event '游戏-无尽开始'(function(trg) 
    --清理地图上的东西
    clear_map()
    --游戏开始后 刷怪时间  
    local time = force_cool
    ac.player.self:sendMsg("|cffebb608【系统】|r|cffff0000无尽挑战开始|r |cff00ffff 第一波妖怪 |r|cff00ff00在".. time .. "秒后开始进攻！|r|cffff0000(部分精英怪对所有真伤型技能免疫)",10)
    ac.timer_ex 
    {
        time = time,
        title = "（无尽）距离第一波怪物进攻",
        func = function ()
            --开始进行无尽刷怪
            for i=1 ,3 do 
                local creep = ac.creep['刷怪-无尽'..i] 
                creep:start()
                creep:attack_hero() 
            end  
        end,
    }

    --特殊处理卡怪问题
    ac.loop(1000,function(t)
        for i=1,3 do 
            local crep = ac.creep['刷怪-无尽'..i]
            for i,u in ipairs(crep.group) do 
                if u:is_in_range(ac.point(0,0),500) then 
                    print(u:get_name(),'是否活着：',u:is_alive(),u:get_point())
                    u:kill()
                end	
            end	
        end	
    end)   

end)    

--保存数据到自定义服务器
ac.game:event '游戏-回合开始'(function(trg,index, creep)
    if not finds(ac.g_game_degree_name,'无尽模式') then
        return
    end     
    local record_name = string.gsub( ac.g_game_degree_name,'无尽模式%-','')
    record_name = record_name..'无尽'
    for i=1,6 do 
        local p = ac.player(i)
        if p:is_player() then 
            local key = ac.server.name2key(record_name)
            if index > (p.cus_server[record_name] or 0) then
                p:SetServerValue(key,index) 
            end   
            if index > (p.server[record_name] or 0) then
                p:Map_SaveServerValue(key,index) --网易服务器
            end   
            --今日最榜
            if index > (p.cus_server['今日'..record_name]  or 0) then
                p:SetServerValue('today_'..key,index)  
            end

            --累计相关
            local key = ac.server.name2key(record_name..'累计')
            p:Map_AddServerValue(key,1) --网易服务器
            
        end
    end
end)