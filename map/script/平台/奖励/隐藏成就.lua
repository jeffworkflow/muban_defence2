--隐藏成就 系统说明 强悍之人
local function active_yccj(p,name,sendmsg,sendmsg2)
    -- print(p,name,sendmsg,sendmsg2)
    p.flag_yccj = p.flag_yccj or {} 
    local hero = p.hero
    if not p.flag_yccj[name] then 
        p.flag_yccj[name] = true
        local key = ac.server.name2key(name)
        if ac.g_game_degree_attr > p:Map_GetServerValue(key) then 
             --加存档值
            p:Map_AddServerValue(key,1)
            --升级技能
            local skl = hero:find_skill(name,nil,true) 
            if not skl  then 
                ac.game:event_notify('技能-插入魔法书',hero,'隐藏成就',name)
                local msg = sendmsg or ('|cffebb608【系统】|cff00ff00恭喜 '..p:get_name()..' 激活 |cffff0000【可存档成就】'..name..'|cff00ff00 属性可在最强魔灵-隐藏成就中查看')
                local msg = sendmsg or ('|cffebb608【系统】|cff00ff00恭喜 '..p:get_name()..' 激活 |cffff0000【可存档成就】'..name..'|cff00ff00 属性可在最强魔灵-隐藏成就中查看')
                local msg = sendmsg or ('|cffebb608【系统】|cff00ff00恭喜 '..p:get_name()..' 激活 |cffff0000【可存档成就】'..name..'|cff00ff00 属性可在最强魔灵-隐藏成就中查看')
                ac.player.self:sendMsg(msg,5)
            else 
                skl:upgrade(1)  
                local msg = sendmsg2 or ('|cffebb608【系统】|cff00ff00恭喜 '..p:get_name()..'  |cffff0000【可存档成就】'..name..'得到升级，|cff00ff00 升级后的属性可在最强魔灵-隐藏成就中查看')
                local msg = sendmsg2 or ('|cffebb608【系统】|cff00ff00恭喜 '..p:get_name()..'  |cffff0000【可存档成就】'..name..'得到升级，|cff00ff00 升级后的属性可在最强魔灵-隐藏成就中查看')
                local msg = sendmsg2 or ('|cffebb608【系统】|cff00ff00恭喜 '..p:get_name()..'  |cffff0000【可存档成就】'..name..'得到升级，|cff00ff00 升级后的属性可在最强魔灵-隐藏成就中查看')
                
                ac.player.self:sendMsg(msg,5)
            end    
        else
            p:sendMsg('',5)
        end
    end    
end
ac.active_yccj = active_yccj

local mt = ac.skill['我是大魔头']
mt{
--等级
level = 1, --要动态插入
max_level = 15,
title = '我是大魔头',
--图标
art = [[damotou.blp]],
--说明
tip = [[

|cffffe799【成就属性】：|r
|cff00ff00+10W*Lv 全属性
+5%*Lv  分裂伤害
+5%*Lv  杀敌数加成

|cffcccccc杀死血魔获得，获得概率与通关难度/地图等级相关]],

['全属性'] = {100000,1500000},
['分裂伤害'] = {5,75},
['杀敌数加成'] = {5,75},

--目标类型
-- target_type = ac.skill.TARGET_TYPE_NONE,
-- need_map_level = 3,
-- attack = 100,
-- attack_gap = 1,
-- skill_attack = 2,
}

local mt = ac.skill['黄金矿工']
mt{
--等级
level = 1, --要动态插入
max_level = 15,
title = '黄金矿工',
--图标
art = [[wbdmg.blp]],
--说明
tip = [[

|cffffe799【成就属性】：|r
|cff00ff00+10W*Lv 全属性
+5*Lv   移动速度
+5%*Lv  木头加成

|cffcccccc挖藏宝图获得，获得概率与通关难度/地图等级相关]],
['全属性'] = {100000,1500000},
['移动速度'] = {5,75},
['木头加成'] = {5,75},



}

local mt = ac.skill['书呆子']
mt{
--等级
level = 1, --要动态插入
max_level = 15,
title = '书呆子',
--图标
art = [[shudaizi.blp]],
--说明
tip = [[

|cffffe799【成就属性】：|r
|cff00ff00+10W*Lv 全属性
+3*Lv   每秒加魔丸
+5%*Lv  魔丸加成

|cffcccccc使用羊皮纸/无字天书获得，获得概率与通关难度/地图等级相关]],
['全属性'] = {100000,1500000},
['每秒加魔丸'] = {5,75},
['魔丸加成'] = {5,75},


}

local mt = ac.skill['剑瞎子']
mt{
--等级
level = 1, --要动态插入
max_level = 15,
title = '剑瞎子',
--图标
art = [[jianxiazi.blp]],
--说明
tip = [[

|cffffe799【成就属性】：|r
|cff00ff00+10W*Lv 全属性
+1%*Lv  强化成功概率
+5%*Lv  物品获取率

|cffcccccc使用强化石/天谕获得，获得概率与通关难度/地图等级相关]],
['全属性'] = {100000,1500000},
['强化成功概率'] = {1,15},
['物品获取率'] = {5,75},


}

local mt = ac.skill['采蘑菇的小姑娘']
mt{
--等级
level = 1, --要动态插入
max_level = 15,
title = '采蘑菇的小姑娘',
--图标
art = [[cmgdxgn.blp]],
--说明
tip = [[

|cffffe799【成就属性】：|r
|cff00ff00+10W*Lv 全属性
+1%*Lv  每秒回血
+5%*Lv  杀敌数加成

|cffcccccc砍掉一颗神奇的树获得，获得概率与通关难度/地图等级相关]],
['全属性'] = {100000,1500000},
['每秒回血'] = {1,15},
['杀敌数加成'] = {5,75},



}

local mt = ac.skill['扭蛋人生']
mt{
--等级
level = 1, --要动态插入
max_level = 15,
title = '扭蛋人生',
--图标
art = [[niudanrensheng.blp]],
--说明
tip = [[

|cffffe799【成就属性】：|r
|cff00ff00+10W*Lv 全属性
+1*Lv  每秒加木头
+5%*Lv  木头加成

|cffcccccc兑换扭蛋券获得，获得概率与通关难度/地图等级相关]],
['全属性'] = {100000,1500000},
['每秒加木头'] = {2,30},
['木头加成'] = {5,75},

}

local mt = ac.skill['du徒']
mt{
--等级
level = 1, --要动态插入
max_level = 15,
title = 'du徒',
--图标
art = [[dutu.blp]],
--说明
tip = [[

|cffffe799【成就属性】：|r
|cff00ff00+10W*Lv 全属性
+1*Lv 每秒加杀敌数
+1*Lv 每秒加木头
+2*Lv 每秒加魔丸

|cffcccccc使用黑暗骰子获得，获得概率与通关难度/地图等级相关]],
['全属性'] = {100000,1500000},
['每秒加杀敌数'] = {1,15},
['每秒加木头'] = {2,30},
['每秒加魔丸'] = {3,45},

}

local mt = ac.skill['强悍之人']
mt{
--等级
level = 1, --要动态插入
max_level = 15,
title = '强悍之人',
--图标
art = [[qianghan.blp]],
--说明
tip = [[

|cffffe799【成就属性】：|r
|cff00ff00+%力量%% |cffffff00% |cff00ff00力量

|cffcccccc获得概率与死亡次数/通关难度/地图等级相关]],
['力量%'] = {3,45},

}

local mt = ac.skill['血牛']
mt{
--等级
level = 1, --要动态插入
max_level = 15,
--图标
art = [[xieniu.blp]],
--说明
tip = [[

|cffffe799【成就属性】：|r
|cff00ff00+%生命上限%% |cffffff00% |cff00ff00生命上限

|cffcccccc获得概率与生命上限/通关难度/地图等级相关]],
['生命上限%'] = {5,75},

}

local mt = ac.skill['一出门就被秒']
mt{
--等级
level = 1, --要动态插入
max_level = 15,
--图标
art = [[beimiao.blp]],
--说明
tip = [[

|cffffe799【成就属性】：|r
|cff00ff00+10W*Lv 全属性
+%减少复活时间% |cff00ff00秒 减少复活时间

|cffcccccc获得概率与死亡次数/通关难度/地图等级相关]],
['全属性'] = {100000,1500000},
['减少复活时间'] = {1,3},

}

--魔剑技能
local mt = ac.skill['魔剑卡片'] 
mt{
--等级
level = 1,
--图标
art = [[jueshimojian.blp]],

title = '魔剑召唤',
content_tip= '|cffffe799使用说明：|r',
--说明
tip = [[


|cff00ff00激活 |cffff0000可存档战宠【魔剑】|cff00ff00
并在基地召唤出一只强大无比的|cffff0000魔剑守卫！
]],



item_type = '消耗品'

}

function mt:on_cast_start()
    local hero = self.owner 
    local p = hero.owner
    --创建 可控制单位 魔剑
    local u = p:create_unit('魔剑',ac.map.rects['出生点']:get_point())
    u:add_skill('魔剑击','英雄')

    --激活隐藏成就
    ac.active_yccj(p,'绝世魔剑')
end

--魔剑技能
local mt = ac.skill['魔剑击'] 
mt{
--等级
level = 1,
--图标
art = [[jueshimojian.blp]],
--说明
tip = [[

攻击10%概率造成范围物理伤害（伤害公式：攻击力*10）
 ]],
event_name = '造成伤害效果',
chance = 10,
cool = 1,
damage_area = 600,
skill_attack = 10,

effect = [[Hero_Slayer_N5S_T_Blast.mdx]]
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
    -- print('释放: ',self.name,source)
    ac.effect_ex{
        model = skill.effect,
        size = 0.8,
        point = target:get_point()
    }:remove()
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
	end	
end

--魔剑技能
local mt = ac.skill['神剑击'] 
mt{
--等级
level = 1,
--图标
art = [[jueshishenjian.blp]],
--说明
tip = [[

攻击10%概率造成范围物理伤害（伤害公式：攻击力*10）
 ]],
event_name = '造成伤害效果',
chance = 10,
cool = 1,
damage_area = 600,
skill_attack = 10,

effect = [[Tx_shenpan.mdx]]
}
mt.damage_start = ac.skill['魔剑击'].damage_start

local mt = ac.skill['绝世魔剑']
mt{
--等级
level = 1, --要动态插入
max_level = 15,
-- cool= 1,
--图标
art = [[jueshimojian.blp]],
--说明
tip = [[

|cffFFE799【魔剑属性】：|r
|cff00ff00点击获得/收回一个随从
|cff00ffff魔剑攻击力=%attack% |cff00ffff%英雄攻击力
|cffffff00魔剑攻击10%概率造成范围物理伤害（伤害公式：攻击力*10）
|cffff0000继承英雄暴击几率/伤害，会心几率/伤害，物伤/全伤加深

|cffffe799【魔神之剑】（拥有神剑+魔剑后激活）
|cffdf19d0攻击20% 概率造成范围物理伤害（伤害公式：攻击力*30+1%敌人的最大生命值）

|cffcccccc集齐万分之一空气获得，获得概率与通关难度/地图等级相关]],

need_map_level = 3,
attack = {100,650},
skill_attack = {10,10},
attack_gap = {1,0.5}
}
function mt:on_upgrade()
    local skill =self
    local hero = self.owner
    local p = hero:get_owner()
    if p.id >10 then return end 
    
    local attribute ={
        ['攻击'] = function() return hero:get('攻击')*skill.attack*0.01 end,
        ['攻击间隔'] = function() return skill.attack_gap end,
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
    if  not p.unit_mojian then 
        p.unit_mojian = p:create_unit('绝世魔剑',hero:get_point()-{math.random(360),100})
        p.unit_mojian:remove_ability 'AInv'
        p.unit_mojian:add_ability 'Aloc'
        p.unit_mojian:add_restriction '无敌'
        p.unit_mojian:add_buff "召唤物"{
            attribute = attribute,
            skill = self,
            follow = true,
            search_area = 500, --搜敌路径    
        }
    end   
    
    --技能相关
    local skl = p.unit_mojian:find_skill('魔剑击',nil)
    if not skl then 
        skl = p.unit_mojian:add_skill('魔剑击','英雄')
        skl.skill_attack = self.skill_attack
    else 
        skl.skill_attack = self.skill_attack
    end  
    --如果拥有魔剑，则添加魔神之剑
    if p.server['绝世魔剑']>=1 and p.server['绝世神剑']>=1 then 
        local skl = p.unit_mojian:find_skill('魔神之剑',nil)
        if not skl then
            p.unit_mojian:add_skill('魔神之剑','英雄')
        end
    end
end
function mt:on_cast_start()
    local p=self.owner.owner
    if p.unit_mojian then 
        p.unit_mojian:remove()
        p.unit_mojian = nil
    else
        self:on_upgrade()
    end
end

local mt = ac.skill['绝世神剑']
mt{
--等级
level = 1, --要动态插入
max_level = 15,
-- cool= 1,
--图标
art = [[jueshishenjian.blp]],
--说明
tip = [[

|cffFFE799【神剑属性】：|r
|cff00ff00点击获得/收回一个随从
|cff00ffff神剑攻击力=%attack% |cff00ffff%英雄攻击力
|cffffff00神剑攻击10%概率造成范围物理伤害（伤害公式：攻击力*10）
|cffff0000继承英雄暴击几率/伤害，会心几率/伤害，物伤/全伤加深

|cffffe799【魔神之剑】（拥有神剑+魔剑后激活）
|cffdf19d0攻击20% 概率造成范围物理伤害（伤害公式：攻击力*30+1%敌人的最大生命值）

|cffcccccc进入万象天宫获得，获得概率与通关难度/地图等级相关]],

need_map_level = 3,
attack = {100,650},
skill_attack = {10,10},
attack_gap = {1,0.5}
}
function mt:on_upgrade()
    local skill =self
    local hero = self.owner
    local p = hero:get_owner()
    if p.id >10 then return end 
    
    local attribute ={
        ['攻击'] = function() return hero:get('攻击')*skill.attack*0.01 end,
        ['攻击间隔'] = function() return skill.attack_gap end,
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
    if  not p.unit_shenjian then 
        p.unit_shenjian = p:create_unit(self.name,hero:get_point()-{math.random(360),100})
        p.unit_shenjian:remove_ability 'AInv'
        p.unit_shenjian:add_ability 'Aloc'
        p.unit_shenjian:add_restriction '无敌'
        p.unit_shenjian:add_buff "召唤物"{
            attribute = attribute,
            skill = self,
            follow = true,
            search_area = 500, --搜敌路径    
        }
    end   
    
    --技能相关
    local skl = p.unit_shenjian:find_skill('神剑击',nil)
    if not skl then 
        skl = p.unit_shenjian:add_skill('神剑击','英雄')
        skl.skill_attack = self.skill_attack
    else 
        skl.skill_attack = self.skill_attack
    end   

    --如果拥有魔剑，则添加魔神之剑
    if p.server['绝世魔剑']>=1 and p.server['绝世神剑']>=1 then 
        local skl = p.unit_shenjian:find_skill('魔神之剑',nil)
        if not skl then
            p.unit_shenjian:add_skill('魔神之剑','英雄')
        end
    end
    
end
function mt:on_cast_start()
    local p=self.owner.owner
    if p.unit_shenjian then 
        p.unit_shenjian:remove()
        p.unit_shenjian = nil
    else
        self:on_upgrade()
    end
end

--魔剑技能
local mt = ac.skill['魔神之剑'] 
mt{
--等级
level = 1,
--图标
art = [[jueshishenjian.blp]],
--说明
tip = [[

    伤害公式：攻击力*20+1%敌人的最大生命值
 ]],
event_name = '造成伤害效果',
chance = 20,
cool = 1,
damage_area = 600,
skill_attack = 30,
effect = [[MXXXT28 -  F.mdx]]
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
    ac.effect_ex{
        model = skill.effect,
        
        point = target:get_point()
    }:remove()
    -- print('释放魔神之剑',source)
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
        u:damage
        {
            source = source,
            skill = skill,
            damage = u:get('生命上限')/100*1,
            real_damage = true
        }
	end	
end

local mt = ac.skill['香港脚']
mt{
--等级
level = 1, --要动态插入
max_level = 15,
--图标
art = [[xieniu.blp]],
--说明
tip = [[

|cffffe799【成就属性】：|r
|cff00ff00+%生命上限%% |cffffff00% |cff00ff00生命上限

|cffcccccc获得概率与生命上限/通关难度/地图等级相关]],
['生命上限%'] = {5,75},

}
local mt = ac.skill['人间大炮']
mt{
--等级
level = 1, --要动态插入
max_level = 15,
--图标
art = [[xieniu.blp]],
--说明
tip = [[

|cffffe799【成就属性】：|r
|cff00ff00+%生命上限%% |cffffff00% |cff00ff00生命上限

|cffcccccc获得概率与生命上限/通关难度/地图等级相关]],
['生命上限%'] = {5,75},

}

local mt = ac.skill['天选之子']
mt{
--等级
level = 1, --要动态插入
max_level = 15,
--图标
art = [[xieniu.blp]],
--说明
tip = [[

|cffffe799【成就属性】：|r
|cff00ff00+%生命上限%% |cffffff00% |cff00ff00生命上限

|cffcccccc获得概率与生命上限/通关难度/地图等级相关]],
['生命上限%'] = {5,75},

}


local mt = ac.skill['隐藏成就']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[yincangchengjiu.blp]],
    title = '隐藏成就',
    tip = [[

点击查看 |cff00ffff隐藏成就|r，通过完成 |cffffff00隐藏任务|r 获得
    ]],
    
}
mt.skill_name ={
    '我是大魔头','黄金矿工','书呆子','剑瞎子','采蘑菇的小姑娘','扭蛋人生','du徒',
    '强悍之人','血牛','一出门就被秒','绝世魔剑','绝世神剑',
    '香港脚','人间大炮','天选之子'
}

mt.skills = {
    -- '第一个吃螃蟹的人',
}

--隐藏成就 注册获得事件
local task_detail = {
    ['血魔'] = {
        rate = 0.02,
        -- rate = 10,
        award = '我是大魔头',
        sendMsg = function(p)
            -- p:sendMsg('|cffebb608【系统】|r |cff00ffff'..p:get_name()..'|r|cff00ffff 把魔教弟子杀了个遍|r 获得成就|cffff0000 "大屠杀" |r，奖励 |cffff0000+30w全属性 +25%杀敌数加成|r',5)
            ac.player.self:sendMsg('|cffebb608【系统】|r |cff00ff00这也太残忍了！！！谁才是真正的大魔头？？？|cff00ffff'..p:get_name()..'|r |cff00ff00获得|cffff0000【可存档成就】"我是大魔头" |r|cff00ff00，属性可在最强魔灵-隐藏成就中查看',5)
            ac.player.self:sendMsg('|cffebb608【系统】|r |cff00ff00这也太残忍了！！！谁才是真正的大魔头？？？|cff00ffff'..p:get_name()..'|r |cff00ff00获得|cffff0000【可存档成就】"我是大魔头" |r|cff00ff00，属性可在最强魔灵-隐藏成就中查看',5)
            ac.player.self:sendMsg('|cffebb608【系统】|r |cff00ff00这也太残忍了！！！谁才是真正的大魔头？？？|cff00ffff'..p:get_name()..'|r |cff00ff00获得|cffff0000【可存档成就】"我是大魔头" |r|cff00ff00，属性可在最强魔灵-隐藏成就中查看',5)

        end,
        --存档升级
        sendMsg1 = function(p)
            -- p:sendMsg('|cffebb608【系统】|r |cff00ffff'..p:get_name()..'|r|cff00ffff 把魔教弟子杀了个遍|r 获得成就|cffff0000 "大屠杀" |r，奖励 |cffff0000+30w全属性 +25%杀敌数加成|r',5)
            ac.player.self:sendMsg('|cffebb608【系统】|r |cff00ff00简直！惨不忍睹！|cff00ffff'..p:get_name()..'|r |cff00ff00的|cffff0000【可存档成就】"我是大魔头" |r|cff00ff00得到升级，升级后的属性可在最强魔灵-隐藏成就中查看',5)
            ac.player.self:sendMsg('|cffebb608【系统】|r |cff00ff00简直！惨不忍睹！|cff00ffff'..p:get_name()..'|r |cff00ff00的|cffff0000【可存档成就】"我是大魔头" |r|cff00ff00得到升级，升级后的属性可在最强魔灵-隐藏成就中查看',5)
            ac.player.self:sendMsg('|cffebb608【系统】|r |cff00ff00简直！惨不忍睹！|cff00ffff'..p:get_name()..'|r |cff00ff00的|cffff0000【可存档成就】"我是大魔头" |r|cff00ff00得到升级，升级后的属性可在最强魔灵-隐藏成就中查看',5)
        end,
    },
    
}
ac.game:event '单位-杀死单位' (function(trg, killer, target) 
    local name = target:get_name()
    if not task_detail[name] then return end 

    local p = killer.owner
    local hero = p.hero
    if not hero then 
        print('没有玩家英雄，可能是玩家7-16单位杀死的。')
        return 
    end
    if not p.flag_yccj then 
        p.flag_yccj = {} 
    end    
    if p.flag_yccj[task_detail[name]] then 
        return 
    end    

    local rate =task_detail[name].rate
    local award = task_detail[name].award
    local sendMsg = task_detail[name].sendMsg
    local sendMsg1 = task_detail[name].sendMsg1
    local condition = task_detail[name].condition
    if math.random(10000)/100 < rate then 
        p.flag_yccj[task_detail[name]] = true --一局只能获得一次
        --存档
        local key = ac.server.name2key(award)
        if ac.g_game_degree_attr > p:Map_GetServerValue(key) then 
            --加存档值
            p:Map_AddServerValue(key,1)
            --升级技能
            local skl = hero:find_skill(award,nil,true) 
            if not skl  then 
                ac.game:event_notify('技能-插入魔法书',hero,'隐藏成就',award)
                sendMsg(p)
            else 
                skl:upgrade(1)    
                sendMsg1(p)
            end    
        end    

    end    
end)    

-- 万分之一空气
-- local function check_air(p,name)
--     local temp = {'挖图','超级扭蛋','黑暗骰子','羊皮无字','一颗神奇的种子'}
--     local ok =true
--     local has_cnt = 0
--     for i,name in pairs(temp) do 
--         if p.air[name] then 
--             has_cnt = has_cnt + 1
--         else
--             ok = false 
--         end
--     end
--     p:sendMsg('|cffebb608【系统】|r|cff00ff00恭喜获得|cffff0000 万分之一空气 |cff00ff00！当前集齐进度：'..has_cnt..'/'..#temp,5)
--     --激活隐藏成就、魔剑
--     if ok then 
--         --激活
--         p.hero:add_item('魔剑卡片')
--         ac.player.self:sendMsg('恭喜 '..p:get_name()..' 集齐万分之一空气,获得魔剑卡片',5)
--     end
-- end
local function check_air(p)
    if p.flag_air then 
        return 
    end
    local all_cnt = 7
    if p.air >= all_cnt then 
        p.flag_air = true
        p:sendMsg('|cffebb608【系统】|r|cff00ff00恭喜获得|cffff0000 万分之一空气 |cff00ff00！当前集齐进度：'..p.air..'/'..all_cnt,5)
        --激活隐藏成就、魔剑
        local it = p.hero:add_item('魔剑卡片')
        it.owner_ship = p
        ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ff00功夫不负有心人，|cff00ffff '..p:get_name()..' |cff00ff00集齐了七份万分之一空气，获得了|cffff0000召唤魔剑|cff00ff00的权利！',5)
    else
        p:sendMsg('|cffebb608【系统】|r|cff00ff00恭喜获得|cffff0000 万分之一空气 |cff00ff00！当前集齐进度：'..p.air..'/'..all_cnt,5)
    end
end
-- local rate = 50.01
ac.game:event '挖图成功'(function(trg,hero)
    local p = hero.owner
    local rate = 0.95 * (1 + p:get('万分之一空气概率')/100)
    if math.random(100000)/1000 < rate then 
        p.air =(p.air or 0) + 1
        check_air(p)
    end
end)

ac.game:event '触发超级扭蛋事件'(function(trg,skill,hero)
    local p = hero.owner
    local rate = 0.1 * (1 + p:get('万分之一空气概率')/100)
    -- print('触发万分之一空气概率，',rate)
    if math.random(100000)/1000 < rate then 
        p.air =(p.air or 0) + 1
        check_air(p)
    end
end)

ac.game:event '触发黑暗骰子事件'(function(trg,skill,hero)
    local p = hero.owner
    local rate = 0.95 * (1 + p:get('万分之一空气概率')/100)
    if math.random(100000)/1000 < rate then 
        p.air =(p.air or 0) + 1
        check_air(p)
    end
end)

ac.game:event '触发羊皮无字事件'(function(trg,skill,hero)
    local p = hero.owner
    local rate = 0.95 * (1 + p:get('万分之一空气概率')/100)
    if math.random(100000)/1000 < rate then 
        p.air =(p.air or 0) + 1
        check_air(p)
    end
end)

ac.game:event '触发一颗神奇的种子事件'(function(trg,skill,hero)
    local p = hero.owner
    local rate = 0.95 * (1 + p:get('万分之一空气概率')/100)
    if math.random(100000)/1000 < rate then 
        p.air =(p.air or 0) + 1
        check_air(p)
    end
end)

--香港脚
ac.game:event '进球门' (function(trg,skill,hero)
    local p = hero.owner
    local rate = 0.3
    rate = 40
    if math.random(100000)/1000 < rate then 
        active_yccj(p,'香港脚')
    end
end)
