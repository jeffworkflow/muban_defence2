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
                local msg = sendmsg or ('恭喜获得隐藏成就 '..name)
                p:sendMsg(msg,5)
            else 
                skl:upgrade(1)  
                local msg = sendmsg2 or ('恭喜隐藏成就 '..name..' +1')
                p:sendMsg(msg,5)
            end    
        else
            p:sendMsg('请在更高难度时激活或升级',5)
        end
    end    
end
ac.active_yccj = active_yccj

local mt = ac.skill['我是大魔头']
mt{
--等级
level = 0, --要动态插入
max_level = 10,
title = '我是大魔头',
--图标
art = [[damotou.blp]],
--说明
tip = [[

|cffffe799【成就属性】：|r
|cff00ff00+7.5W*Lv 全属性
+5%*Lv  分裂伤害
+5%*Lv  杀敌数加成

|cffcccccc杀死血魔获得，获得概率与通关难度/地图等级相关]],

['全属性'] = {75000,750000},
['分裂伤害'] = {5,50},
['杀敌数加成'] = {5,50},

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
level = 0, --要动态插入
max_level = 10,
title = '黄金矿工',
--图标
art = [[wbdmg.blp]],
--说明
tip = [[

|cffffe799【成就属性】：|r
|cff00ff00+7.5W*Lv 全属性
+5*Lv   移动速度
+5%*Lv  木头加成

|cffcccccc挖藏宝图获得，获得概率与通关难度/地图等级相关]],
['全属性'] = {75000,750000},
['移动速度'] = {5,50},
['木头加成'] = {5,50},



}

local mt = ac.skill['书呆子']
mt{
--等级
level = 0, --要动态插入
max_level = 10,
title = '书呆子',
--图标
art = [[shudaizi.blp]],
--说明
tip = [[

|cffffe799【成就属性】：|r
|cff00ff00+7.5W*Lv 全属性
+5*Lv   每秒加魔丸
+5%*Lv  魔丸加成

|cffcccccc使用羊皮纸/无字天书获得，获得概率与通关难度/地图等级相关]],
['全属性'] = {75000,750000},
['每秒加魔丸'] = {5,50},
['魔丸加成'] = {5,50},


}

local mt = ac.skill['剑瞎子']
mt{
--等级
level = 0, --要动态插入
max_level = 10,
title = '剑瞎子',
--图标
art = [[jianxiazi.blp]],
--说明
tip = [[

|cffffe799【成就属性】：|r
|cff00ff00+7.5W*Lv 全属性
+1%*Lv  强化成功概率
+5%*Lv  物品获取率

|cffcccccc使用强化石/天谕获得，获得概率与通关难度/地图等级相关]],
['全属性'] = {75000,750000},
['强化成功概率'] = {1,10},
['物品获取率'] = {5,50},


}

local mt = ac.skill['采蘑菇的小姑娘']
mt{
--等级
level = 0, --要动态插入
max_level = 10,
title = '采蘑菇的小姑娘',
--图标
art = [[cmgdxgn.blp]],
--说明
tip = [[

|cffffe799【成就属性】：|r
|cff00ff00+7.5W*Lv 全属性
+1%*Lv  每秒回血
+5%*Lv  杀敌数加成

|cffcccccc砍掉一颗神奇的树获得，获得概率与通关难度/地图等级相关]],
['全属性'] = {75000,750000},
['每秒回血'] = {1,10},
['杀敌数加成'] = {5,50},



}

local mt = ac.skill['扭蛋人生']
mt{
--等级
level = 0, --要动态插入
max_level = 10,
title = '扭蛋人生',
--图标
art = [[niudanrensheng.blp]],
--说明
tip = [[

|cffffe799【成就属性】：|r
|cff00ff00+7.5W*Lv 全属性
+2.5*Lv 每秒加木头
+5%*Lv  木头加成

|cffcccccc兑换扭蛋券获得，获得概率与通关难度/地图等级相关]],
['全属性'] = {75000,750000},
['每秒加木头'] = {2.5,25},
['木头加成'] = {5,50},

}

local mt = ac.skill['du徒']
mt{
--等级
level = 0, --要动态插入
max_level = 10,
title = 'du徒',
--图标
art = [[dutu.blp]],
--说明
tip = [[

|cffffe799【成就属性】：|r
|cff00ff00+7.5W*Lv 全属性
+1*Lv 每秒加杀敌数
+2*Lv 每秒加木头
+3*Lv 每秒加魔丸

|cffcccccc使用黑暗骰子获得，获得概率与通关难度/地图等级相关]],
['全属性'] = {75000,750000},
['每秒加杀敌数'] = {1,10},
['每秒加木头'] = {2,20},
['每秒加魔丸'] = {3,30},

}

local mt = ac.skill['强悍之人']
mt{
--等级
level = 0, --要动态插入
max_level = 10,
title = '强悍之人',
--图标
art = [[qianghan.blp]],
--说明
tip = [[

|cffffe799【成就属性】：|r
|cff00ff00+%力量%% |cffffff00% |cff00ff00力量

|cffcccccc获得概率与死亡次数/通关难度/地图等级相关]],
['力量%'] = {2,20},

}

local mt = ac.skill['血牛']
mt{
--等级
level = 0, --要动态插入
max_level = 10,
--图标
art = [[xieniu.blp]],
--说明
tip = [[

|cffffe799【成就属性】：|r
|cff00ff00+%生命上限%% |cffffff00% |cff00ff00生命上限

|cffcccccc获得概率与生命上限/通关难度/地图等级相关]],
['生命上限%'] = {5,50},

}

local mt = ac.skill['一出门就被秒']
mt{
--等级
level = 0, --要动态插入
max_level = 10,
--图标
art = [[beimiao.blp]],
--说明
tip = [[

|cffffe799【成就属性】：|r
|cff00ff00+7.5W*Lv 全属性
+%减少复活时间% |cff00ff00秒 减少复活时间

|cffcccccc获得概率与死亡次数/通关难度/地图等级相关]],
['全属性'] = {75000,750000},
['减少复活时间'] = {1,5},

}

--魔剑技能
local mt = ac.skill['魔剑卡片'] 
mt{
--等级
level = 1,
--图标
art = [[sbkd.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff挖宝熟练度超过 2K 自动获得，已拥有积分：|r%wabao_cnt% 或者
|cff00ffff消耗勇士徽章 15 兑换获得

|cffFFE799【称号属性】：|r
|cff00ff00+50   杀怪加攻击|r
|cff00ff00+500  护甲|r
|cff00ff00+10% 物品获取率|r

|cffff0000【点击可更换称号外观，所有称号属性可叠加】|r]],
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
art = [[sbkd.blp]],
--说明
tip = [[

]],
event_name = '造成伤害效果',
chance = 5,
damage_area = 500,
attack = 5,
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
    for i, u in ac.selector()
		: in_range(source,self.damage_area)
		: is_enemy(source)
		: ipairs()
	do
        u:damage
        {
            source = source,
            skill = skill,
            damage = source:get('攻击')*skill.attack,
            damage_type = '物理'
        }
	end	
end
local mt = ac.skill['绝世魔剑']
mt{
--等级
level = 0, --要动态插入
max_level = 10,
--图标
art = [[jueshimojian.blp]],
--说明
tip = [[

|cffFFE799【魔剑属性】：|r
|cff00ff00获得一个随从-绝世魔剑
|cff00ffff魔剑攻击力=%attack% |cff00ffff%英雄攻击力
|cffffff00魔剑攻击5%概率造成范围物理伤害（伤害公式：攻击力*5）
|cffff0000继承英雄暴击几率/加深，会心几率/加深，物伤/全伤加深

|cffcccccc集齐万分之一空气获得，获得概率与通关难度/地图等级相关]],

need_map_level = 3,
attack = {100,550},
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
    if not p.unit_mojian then 
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
        skl = p.unit_mojian:add_skill('魔剑击','隐藏')
        skl.attack = self.attack
    else 
        -- print('魔剑击倍数：',skl.skill_attack,self.skill_attack)
        skl.attack = self.attack
    end   
    --  
end


local mt = ac.skill['隐藏成就']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[yincangchengjiu.blp]],
    title = '隐藏成就',
    tip = [[

点击查看 |cff00ffff隐藏成就
    ]],
    
}
mt.skill_name ={
    '我是大魔头','黄金矿工','书呆子','剑瞎子','采蘑菇的小姑娘','扭蛋人生','du徒',
    '强悍之人','血牛','一出门就被秒','绝世魔剑'
}

mt.skills = {
    -- '第一个吃螃蟹的人',
}

--隐藏成就 注册获得事件
local task_detail = {
    ['血魔'] = {
        rate = 0.01,
        -- rate = 10,
        award = '我是大魔头',
        sendMsg = function(p)
            -- p:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..p:get_name()..'|r|cff00ffff 把魔教弟子杀了个遍|r 获得成就|cffff0000 "大屠杀" |r，奖励 |cffff0000+30w全属性 +25%杀敌数加成|r',5)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ff00这也太残忍了！！！谁才是真正的大魔头？？？|cff00ffff'..p:get_name()..'|r |cff00ff00获得|cffff0000【可存档成就】"我是大魔头" |r|cff00ff00，属性可在最强魔灵-隐藏成就中查看',5)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ff00这也太残忍了！！！谁才是真正的大魔头？？？|cff00ffff'..p:get_name()..'|r |cff00ff00获得|cffff0000【可存档成就】"我是大魔头" |r|cff00ff00，属性可在最强魔灵-隐藏成就中查看',5)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ff00这也太残忍了！！！谁才是真正的大魔头？？？|cff00ffff'..p:get_name()..'|r |cff00ff00获得|cffff0000【可存档成就】"我是大魔头" |r|cff00ff00，属性可在最强魔灵-隐藏成就中查看',5)

        end,
        --存档升级
        sendMsg1 = function(p)
            -- p:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..p:get_name()..'|r|cff00ffff 把魔教弟子杀了个遍|r 获得成就|cffff0000 "大屠杀" |r，奖励 |cffff0000+30w全属性 +25%杀敌数加成|r',5)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ff00简直！惨不忍睹！|cff00ffff'..p:get_name()..'|r |cff00ff00的|cffff0000【可存档成就】"我是大魔头" |r|cff00ff00得到升级，升级后的属性可在最强魔灵-隐藏成就中查看',5)
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
--     p:sendMsg('|cffffe799【系统消息】|r|cff00ff00恭喜获得|cffff0000 万分之一空气 |cff00ff00！当前集齐进度：'..has_cnt..'/'..#temp,5)
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
        p:sendMsg('|cffffe799【系统消息】|r|cff00ff00恭喜获得|cffff0000 万分之一空气 |cff00ff00！当前集齐进度：'..p.air..'/'..all_cnt,5)
        --激活隐藏成就、魔剑
        p.hero:add_item('魔剑卡片')
        ac.player.self:sendMsg('恭喜 '..p:get_name()..' 集齐万分之一空气,获得魔剑卡片',5)
    else
        p:sendMsg('|cffffe799【系统消息】|r|cff00ff00恭喜获得|cffff0000 万分之一空气 |cff00ff00！当前集齐进度：'..p.air..'/'..all_cnt,5)
    end
end
--统一概率
local rate = 30
ac.game:event '挖图成功'(function(trg,hero)
    local p = hero.owner
    if math.random(100000)/1000 < rate then 
        p.air =(p.air or 0) + 1
        check_air(p)
    end
end)

ac.game:event '触发超级扭蛋事件'(function(trg,skill,hero)
    local p = hero.owner
    if math.random(100000)/1000 < rate then 
        p.air =(p.air or 0) + 1
        check_air(p)
    end
end)

ac.game:event '触发黑暗骰子事件'(function(trg,skill,hero)
    local p = hero.owner
    if math.random(100000)/1000 < rate then 
        p.air =(p.air or 0) + 1
        check_air(p)
    end
end)

ac.game:event '触发羊皮无字事件'(function(trg,skill,hero)
    local p = hero.owner
    if math.random(100000)/1000 < rate then 
        p.air =(p.air or 0) + 1
        check_air(p)
    end
end)

ac.game:event '触发一颗神奇的种子事件'(function(trg,skill,hero)
    local p = hero.owner
    if math.random(100000)/1000 < rate then 
        p.air =(p.air or 0) + 1
        check_air(p)
    end
end)
