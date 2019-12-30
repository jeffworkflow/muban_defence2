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
    art = [[shuaishen.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+16888 木头
+16888 火灵
+16888 杀敌数|r

]],
  ['金币加成'] = 15, 
  ['木头加成'] = 15,
  ['经验加成'] = 15,
  ['魔灵加成'] = 15,
}
function mt:on_add()
    local hero  = self.owner
    local p = hero:get_owner()
    hero = p.hero
    p:sendMsg('【系统消息】玩家XXX 抽取铭文时与铭文经常失之交臂，惊喜获得隐藏彩蛋',5)
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


local task_detail = {
    ['血魔'] = {
        rate = 0.2,
        award = '大屠杀',
        sendMsg = function(p)
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

    local rate =task_detail[name].rate
    local award = task_detail[name].award
    local sendMsg = task_detail[name].sendMsg
    if math.random(10000)/100 < rate then 
        local p = killer.owner
        local hero = p.hero
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
end)    