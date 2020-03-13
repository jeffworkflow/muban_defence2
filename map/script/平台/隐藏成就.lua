
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
+5%*Lv  杀敌数加成

|cffcccccc杀死血魔获得，获得概率与通关难度/地图等级相关]],

['全属性'] = {75000,750000},
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
+5%*Lv  木头加成

|cffcccccc挖藏宝图获得，获得概率与通关难度/地图等级相关]],
['全属性'] = {75000,750000},
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
+5%*Lv  魔丸加成

|cffcccccc使用羊皮纸/无字天书获得，获得概率与通关难度/地图等级相关]],
['全属性'] = {75000,750000},
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
+5%*Lv  物品获取率

|cffcccccc使用强化石/天谕获得，获得概率与通关难度/地图等级相关]],
['全属性'] = {75000,750000},
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
+5%*Lv  杀敌数加成

|cffcccccc砍掉一颗神奇的树获得，获得概率与通关难度/地图等级相关]],
['全属性'] = {75000,750000},
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
+5%*Lv  木头加成

|cffcccccc兑换扭蛋券获得，获得概率与通关难度/地图等级相关]],
['全属性'] = {75000,750000},
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
+5%*Lv  物品获取率

|cffcccccc使用黑暗骰子获得，获得概率与通关难度/地图等级相关]],
['全属性'] = {75000,750000},
['物品获取率'] = {5,50},

}



local mt = ac.skill['隐藏成就']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[yincangchengjiu.blp]],
    title = '隐藏成就',
    tip = [[

查看隐藏成就
    ]],
    
}
mt.skill_name ={
    '我是大魔头','黄金矿工','书呆子','剑瞎子','采蘑菇的小姑娘','扭蛋人生','du徒'
}

mt.skills = {
    -- '第一个吃螃蟹的人',
}

-- function mt:on_add()
--     local hero = self.owner 
--     local player = hero:get_owner()
--     for i=1,#self.skill_name do 
--         local name = self.skill_name[i]
--         local has_mall = player.mall[name] or (player.server and player.server[name])
      
--         if has_mall and has_mall > 0 then 
--             ac.game:event_notify('技能-插入魔法书',hero,'隐藏成就',name)
--             local skl = hero:find_skill(name,nil,true)
--             skl:set_level(has_mall)
--         end
--     end 
-- end   


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