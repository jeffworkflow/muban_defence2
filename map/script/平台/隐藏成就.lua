
local mt = ac.skill['我是大魔头']
mt{
--等级
level = 0, --要动态插入
max_level = 10,
title = '魔剑获得（N1）',
--图标
art = [[damotou.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00无限BOSS模式下，通关|cffffff00难1|cff00ff00获得

|cffFFE799【魔剑属性】：|r
|cff00ff00获得一个随从-我是大魔头
|cff00ffff魔剑攻击力=100%英雄攻击力
|cffffff00魔剑攻击5%概率造成范围物理伤害（伤害公式：英雄攻击力*2）
|cffff0000继承英雄暴击几率/加深，会心几率/加深，物伤/全伤加深]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 3,
attack = 100,
attack_gap = 1,
skill_attack = 2,
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
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00 存档值：%server_val% 
激活值：%now_server_val%

获得方式：挖宝图0.2%触发；动态插入最强魔灵-隐藏成就-黄金矿工，
成就可升级，最大等级10级，如果之前的成就未激活，将先激活之前的成就存档），说明，
+7.5W*Lv 全属性
+5%*Lv 木头加成

]],

server_val = function(self)
    local key = ac.server.name2key(self.name)
    local p = self.owner.owner
    return p:Map_GetServerValue(key)
end,
now_server_val = function(self)
    local key = ac.server.name2key(self.name)
    local p = self.owner.owner
    return p.server[self.name]
end,

}

local mt = ac.skill['书呆子']
mt{
--等级
level = 0, --要动态插入
max_level = 10,
title = '书呆子',
--图标
art = [[wbdmg.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00 存档值：%server_val% 
激活值：%now_server_val%

获得方式：挖宝图0.2%触发；动态插入最强魔灵-隐藏成就-书呆子，
成就可升级，最大等级10级，如果之前的成就未激活，将先激活之前的成就存档），说明，
+7.5W*Lv 全属性
+5%*Lv 木头加成

]],

server_val = function(self)
    local key = ac.server.name2key(self.name)
    local p = self.owner.owner
    return p:Map_GetServerValue(key)
end,
now_server_val = function(self)
    local key = ac.server.name2key(self.name)
    local p = self.owner.owner
    return p.server[self.name]
end,

}

local mt = ac.skill['剑瞎子']
mt{
--等级
level = 0, --要动态插入
max_level = 10,
title = '剑瞎子',
--图标
art = [[wbdmg.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00 存档值：%server_val% 
激活值：%now_server_val%

获得方式：挖宝图0.2%触发；动态插入最强魔灵-隐藏成就-剑瞎子，
成就可升级，最大等级10级，如果之前的成就未激活，将先激活之前的成就存档），说明，
+7.5W*Lv 全属性
+5%*Lv 木头加成

]],

server_val = function(self)
    local key = ac.server.name2key(self.name)
    local p = self.owner.owner
    return p:Map_GetServerValue(key)
end,
now_server_val = function(self)
    local key = ac.server.name2key(self.name)
    local p = self.owner.owner
    return p.server[self.name]
end,

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
    '我是大魔头','黄金矿工','书呆子','剑瞎子',
}

mt.skills = {
    -- '第一个吃螃蟹的人',
}

function mt:on_add()
    local hero = self.owner 
    local player = hero:get_owner()
    for i=1,#self.skill_name do 
        local name = self.skill_name[i]
        local has_mall = player.mall[name] or (player.server and player.server[name])
      
        if has_mall and has_mall > 0 then 
            ac.game:event_notify('技能-插入魔法书',hero,'隐藏成就',name)
            local skl = hero:find_skill(name,nil,true)
            skl:set_level(has_mall)
        end
    end 
end   


--隐藏成就 注册获得事件
local task_detail = {
    ['血魔'] = {
        rate = 0.01,
        award = '我是大魔头',
        sendMsg = function(p)
            -- p:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..p:get_name()..'|r|cff00ffff 把魔教弟子杀了个遍|r 获得成就|cffff0000 "大屠杀" |r，奖励 |cffff0000+30w全属性 +25%杀敌数加成|r',5)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..p:get_name()..'|r 把魔教弟子杀了个遍 获得成就|cffff0000 "大屠杀" |r，奖励 |cffff0000+30w全属性 +25%杀敌数加成|r',5)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..p:get_name()..'|r 把魔教弟子杀了个遍 获得成就|cffff0000 "大屠杀" |r，奖励 |cffff0000+30w全属性 +25%杀敌数加成|r',5)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..p:get_name()..'|r 把魔教弟子杀了个遍 获得成就|cffff0000 "大屠杀" |r，奖励 |cffff0000+30w全属性 +25%杀敌数加成|r',5)
        end,
        --存档升级
        sendMsg1 = function(p)
            -- p:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..p:get_name()..'|r|cff00ffff 把魔教弟子杀了个遍|r 获得成就|cffff0000 "大屠杀" |r，奖励 |cffff0000+30w全属性 +25%杀敌数加成|r',5)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..p:get_name()..'|r 把魔教弟子杀了个遍 获得成就|cffff0000 "大屠杀" |r，奖励 |cffff0000+30w全属性 +25%杀敌数加成|r',5)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..p:get_name()..'|r 把魔教弟子杀了个遍 获得成就|cffff0000 "大屠杀" |r，奖励 |cffff0000+30w全属性 +25%杀敌数加成|r',5)
            ac.player.self:sendMsg('|cffffe799【系统消息】|r |cff00ffff'..p:get_name()..'|r 把魔教弟子杀了个遍 获得成就|cffff0000 "大屠杀" |r，奖励 |cffff0000+30w全属性 +25%杀敌数加成|r',5)
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