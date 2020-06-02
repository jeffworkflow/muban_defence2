local mt = ac.skill['错臂之交']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[cbzj.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+50万 全属性
+15%  练功房资源加成|r

]],
['全属性'] = 500000, 
  ['金币加成'] = 15, 
  ['木头加成'] = 15,
  ['经验加成'] = 15,
  ['魔灵加成'] = 15,
}
function mt:on_add()
    local hero  = self.owner
    
    local player = hero:get_owner()
    hero = player.hero
    ac.player.self:sendMsg('|cffffe799【系统消息】|cff00ffff'..player:get_name()..'|r |cff00ff00抽取铭文时与铭文经常失之交臂，获得成就|cffff0000“错臂之交”|cff00ff00,奖励|cffffff00全属性50万，练功房资源加成+15%',5)
    ac.player.self:sendMsg('|cffffe799【系统消息】|cff00ffff'..player:get_name()..'|r |cff00ff00抽取铭文时与铭文经常失之交臂，获得成就|cffff0000“错臂之交”|cff00ff00,奖励|cffffff00全属性50万，练功房资源加成+15%',5)
    ac.player.self:sendMsg('|cffffe799【系统消息】|cff00ffff'..player:get_name()..'|r |cff00ff00抽取铭文时与铭文经常失之交臂，获得成就|cffff0000“错臂之交”|cff00ff00,奖励|cffffff00全属性50万，练功房资源加成+15%',5)
end   

local mt = ac.skill['大屠杀']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[datusha.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+30W 全属性
+25% 杀敌数加成|r

]],
  ['全属性'] = 300000, 
  ['杀敌数加成'] = 25,
}
function mt:on_add()
    local hero  = self.owner
    local p = hero:get_owner()
    hero = p.hero
    -- p:sendMsg('【系统消息】获得大屠杀',5)
end 




 
  

  









local mt = ac.skill['倒霉蛋']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[shuaishen.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+16888 木头
+16888 魔丸
+16888 杀敌数|r

]],
    add_wood = 16888,
    add_fire = 16888,
    add_kill = 16888,
}
function mt:on_add()
    local hero  = self.owner
    local player = hero:get_owner()
    hero = player.hero
    
    hero:add_wood(self.add_wood)
    hero:add_rec_ex(self.add_fire)
    hero:add_kill_count(self.add_kill)
end    

local mt = ac.skill['游戏王']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[yxw.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+1E   全属性
+10% 减伤
+5%  多重暴击几率
+1   多重暴击
+25% 全伤加深|r

]],
    ['全伤加深'] = 25,
    ['减伤'] = 10,
    ['全属性'] = 50000000,
    ['多重暴击几率'] = 5,
    ['多重暴击'] = 1,
}

local mt = ac.skill['八个技能的男人']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[jdbys.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+100W 全属性
+15%  魔丸加成
+15   攻击减甲

]],
    ['魔丸加成'] = 15,
    ['攻击减甲'] = 15,
    ['全属性'] = 1000000,
}

local mt = ac.skill['五道杠少年']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[wdgsn.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+1000W 全属性
+5   杀怪加木头
+35% 木头加成|r

]],
    ['木头加成'] = 35,
    ['杀怪加木头'] = 5,
    ['全属性'] = 10000000,
}


local mt = ac.skill['实在是菜']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --冷却
    cool = 0,
    content_tip = '',
    item_type_tip = '',
    --物品技能
    is_skill = true,
    --商店名词缀
    store_affix = '',
    art = [[shizaishicai.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+5000 护甲
+1000W  生命上限|r

]],
    ['护甲'] = 5000,
    ['生命上限'] = 10000000,
}

local mt = ac.skill['至尊赌神']
mt{
    is_spellbook = 1,
    level = 1,
    is_order = 2,
    art = [[zhizundushen.blp]],
    tip = [[

|cffFFE799【成就属性】：|r
|cff00ff00+7500万 全属性
+100%  杀敌数加成
+100%  物品获取率
+100%  木头加成
+100%  魔丸加成
    ]],
    ['全属性'] = 75000000,
    ['杀敌数加成'] = 100,
    ['木头加成'] = 100,
    ['魔丸加成'] = 100,
    ['物品获取率'] = 100
}

local mt = ac.skill['大胃王']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 5,
    --最大等级
   max_level = 5,
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   area = 800,
	--技能类型
	skill_type = "被动,力量",
	--被动
	passive = true,
	--冷却时间
	cool = 1,
	--伤害
	damage = function(self)
        return (self.owner:get('力量')+self.owner:get('敏捷')+self.owner:get('智力'))*125
end,
	--介绍
	tip = [[

|cffFFE799【成就属性】：|r
|cff00ff00攻击10%几率造成范围全属性*125的技能伤害

]],
	--特效
    effect = [[Hero_Axe_N3S_E_Source.mdx]],
    art = [[daweiwang.blp]],
    damage_type = '法术',
}
function mt:on_add()
    local skill = self
    local hero = self.owner
    self.trg = hero:event '造成伤害效果' (function(_,damage)
		if not damage:is_common_attack()  then 
			return 
		end 
		--技能是否正在CD
        if skill:is_cooling() then
			return 
		end
        --触发时修改攻击方式
        if math.random(100) <= self.chance then
            ac.effect(hero:get_point(), self.effect, 270, 1,'origin'):remove()
         
            for i, u in ac.selector()
                : in_range(hero,self.area)
                : is_enemy(hero)
                : of_not_building()
                : ipairs()
            do
                -- u:add_buff '晕眩'
                -- {
                --     source = hero,
                --     time = self.time,
                -- }
                u:damage
                {
                    source = hero,
                    damage = self.damage,
                    skill = self,
                    damage_type = self.damage_type
                }
            end	
            
            --激活cd
            skill:active_cd()
    
        end
    end)

end
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end


local mt = ac.skill['第六根柱子']
mt{
    is_spellbook = 1,
    level = 1,
    is_order = 2,
    art = [[dlgzz.blp]],
    tip = [[

|cffFFE799【成就属性】：|r
|cff00ff00+1500万 全属性
+1W  木头
+1   练功房数量
    ]],
    ['全属性'] = 15000000,
    ['木头'] = 10000,
    ['练功房怪'] = 1,
    add_wood = 10000,
}
function mt:on_add()
    local hero  = self.owner
    local player = hero:get_owner()
    hero = player.hero
    
    hero:add_wood(self.add_wood)
    hero:add_rec_ex(self.add_fire)
    hero:add_kill_count(self.add_kill)
end    



local task_detail = {
    ['血魔'] = {
        rate = 0.1,
        award = '大屠杀',
        sendMsg = function(p)
            -- p:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..p:get_name()..'|r|cff00ffff 把魔教弟子杀了个遍|r 获得成就|cffff0000 "大屠杀" |r，奖励 |cffff0000+30w全属性 +25%杀敌数加成|r',5)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..p:get_name()..'|r 把魔教弟子杀了个遍 获得成就|cffff0000 "大屠杀" |r，奖励 |cffff0000+30w全属性 +25%杀敌数加成|r',5)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..p:get_name()..'|r 把魔教弟子杀了个遍 获得成就|cffff0000 "大屠杀" |r，奖励 |cffff0000+30w全属性 +25%杀敌数加成|r',5)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..p:get_name()..'|r 把魔教弟子杀了个遍 获得成就|cffff0000 "大屠杀" |r，奖励 |cffff0000+30w全属性 +25%杀敌数加成|r',5)
        end,
    },
    
    ['藏宝阁阁主、藏经阁少阁主、剑魔、苏若颜、哪吒、牛头马面'] = {
        rate = 2,
        award = function(killer, target)
            local p = killer.owner
            if not p.flag_dlgzz then 
                p.flag_dlgzz = true
                local point = target:get_point()
                local u = ac.player(12):create_unit('爱我你就爆了我6',point)
                u:add_restriction '定身'
                u:add_restriction '缴械'
                u:add_buff '无敌'{
                    time = 2
                }
                u.owner_ship = p
            end
        end,
        sendMsg = function(p)
            -- p:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..p:get_name()..'|r|cff00ffff 把魔教弟子杀了个遍|r 获得成就|cffff0000 "大屠杀" |r，奖励 |cffff0000+30w全属性 +25%杀敌数加成|r',5)
            -- ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..p:get_name()..'|r 把魔教弟子杀了个遍 获得成就|cffff0000 "大屠杀" |r，奖励 |cffff0000+30w全属性 +25%杀敌数加成|r',5)
        end,
    },
    
    ['爱我你就爆了我6'] = {
        rate = 100,
        award = '第六根柱子',
        sendMsg = function(p)
            -- p:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..p:get_name()..'|r|cff00ffff 把魔教弟子杀了个遍|r 获得成就|cffff0000 "大屠杀" |r，奖励 |cffff0000+30w全属性 +25%杀敌数加成|r',5)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..p:get_name()..'|r 挑战副本时 击败了传说中的|cffff0000 "第六根柱子" |r，奖励 |cffff0000+1500W全属性 +1W木头 +1练功房数量|r',5)
        end,
    },
}
--第六根柱子
ac.game:event '单位-杀死单位' (function(trg, killer, target) 
    local name = target:get_name()
    local ok
    for k,v in pairs(task_detail) do    
        -- print(k,name) 
        if finds(k,name) then
            ok = true
            name = k
            break
        end
    end  
    if not ok then 
        return 
    end
    local rate =task_detail[name].rate
    local award = task_detail[name].award
    local sendMsg = task_detail[name].sendMsg
    if math.random(10000)/100 < rate then 
        local p = killer.owner
        local hero = p.hero
        --死亡单位如果有所有者，则奖励为所有者的。
        if target.owner_ship then 
            hero = target.owner_ship.hero
        end
        if not hero then return end
        if type(award) =='function' then 
            award(killer, target)
        else
            local skl = hero:find_skill(award,nil,true) 
            if not skl  then 
                ac.game:event_notify('技能-插入魔法书',hero,'彩蛋',award)
                if type(sendMsg) == 'function' then 
                    sendMsg(p)
                elseif sendMsg[3] then 
                    ac.player.self:sendMsg(sendMsg[1],sendMsg[2])
                    ac.player.self:sendMsg(sendMsg[1],sendMsg[2])
                    ac.player.self:sendMsg(sendMsg[1],sendMsg[2])
                    
                else 
                    p:sendMsg(sendMsg[1],sendMsg[2])
                    p:sendMsg(sendMsg[1],sendMsg[2])
                    p:sendMsg(sendMsg[1],sendMsg[2])
                end
            end   
        end
    end    
end)    


--实在是菜
ac.game:event '单位-死亡'(function(_,unit,killer)
    if not unit:is_hero() then 
        return 
    end 
    local player = unit:get_owner()
    player.dead_cnt = (player.dead_cnt or 0) +1
    local hero = unit
    if player.dead_cnt == 10 then 
        local skl = hero:find_skill('实在是菜',nil,true)
        if not skl  then 
            ac.game:event_notify('技能-插入魔法书',hero,'彩蛋','实在是菜')
            player.is_show_nickname = '实在是菜'
            --给全部玩家发送消息
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r|cff00ffff 怎么一直送？ |r 获得成就|cffff0000 "实在是菜" |r，奖励 |cffff0000+5000护甲 +1000W生命上限|r',6)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r|cff00ffff 怎么一直送？ |r 获得成就|cffff0000 "实在是菜" |r，奖励 |cffff0000+5000护甲 +1000W生命上限|r',6)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r|cff00ffff 怎么一直送？ |r 获得成就|cffff0000 "实在是菜" |r，奖励 |cffff0000+5000护甲 +1000W生命上限|r',6)
        end
    end    

end)