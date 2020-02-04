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
+15% 练功房资源加成|r

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

local mt = ac.skill['挖宝达人']
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
    art = [[wbdr.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+1000W 全属性
+50%  物品获取率
+5%   每秒回血|r

]],
    ['物品获取率'] = 50,
    ['每秒回血'] = 5,
    ['全属性'] = 10000000,
}

local mt = ac.skill['鉴宝大师']
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
    art = [[jianbaodashi.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+1000W 全属性
+50%  魔丸加成|r

]],
    ['魔丸加成'] = 50,
    ['全属性'] = 10000000,
}

local mt = ac.skill['鬼斧神工']
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
    art = [[guifushengong.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+1000W 全属性
+50%  木头加成
+2.5%  强化成功概率|r

]],
    ['全属性'] = 10000000,
    ['强化成功概率'] = 2.5,
    ['木头加成'] = 50,
}

local mt = ac.skill['园艺大师']
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
    art = [[yyds.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+1000W 全属性
+50%  杀敌数加成|r

]],
    ['全属性'] = 10000000,
    ['杀敌数加成'] = 50,
}

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
|cff00ff00+2500W 全属性
+5%     全伤加深
+5%     减伤|r

]],
    ['全伤加深'] = 5,
    ['减伤'] = 5,
    ['全属性'] = 25000000,
}

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
        if not hero then return end
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