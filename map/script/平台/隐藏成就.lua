
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
    '我是大魔头',
}

mt.skills = {
    -- '第一个吃螃蟹的人',
}

function mt:on_add()
    local hero = self.owner 
    local player = hero:get_owner()
    for i=1,#self.skill_name do 
        local name = self.skill_name[i]
        local has_mall = player.mall[name] or (player.cus_server and player.cus_server[name])
      
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
        rate = 30,
        award = '我是大魔头',
        sendMsg = {'【系统消息】获得我是大魔头',5},
    },
    
}
ac.game:event '单位-杀死单位' (function(trg, killer, target) 
    local name = target:get_name()
    if not task_detail[name] then return end 

    local p = killer.owner
    local hero = p.hero
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
            p:Map_AddServerValue(key,1)
        end    

        local skl = hero:find_skill(award,nil,true) 
        if not skl  then 
            ac.game:event_notify('技能-插入魔法书',hero,'隐藏成就',award)
            p:sendMsg(sendMsg[1],sendMsg[2])
        else 
            skl:upgrade(1)    
        end    
    end    
end)    