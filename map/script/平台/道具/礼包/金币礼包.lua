local mt = ac.skill['金币礼包']
mt{
--等久
level = 0,
--图标
art = [[jblb.blp]],
is_order = 1,
is_skill =true ,
content_tip = '',
--说明
tip = [[

|cffFFE799【领取条件】|r商城购买|cffff0000金币礼包|r

|cffFFE799【礼包奖励】|r|cff00ff00每秒加1000金币，杀怪+1000金币，攻击+1000金币
开局赠送一本黄阶功法书（四选一），发放英雄背包|r
 ]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--每秒金币
per_gold = 1000,
--杀怪加金币
kill_gold = 1000,
--攻击加金币
attack_gold = 1000,
}

function mt:on_cast_start()
    local hero = self.owner
    local target = self.target
    local items = self
    local p = hero:get_owner()
    -- 宠物可以帮忙吃
    hero = hero:get_owner().hero
    local name = self.name
    if p.mall[name] and not p.mall_flag[name] then 
        --添加给英雄
        hero:add('每秒加金币',self.per_gold)
        hero:add('杀怪加金币',self.kill_gold)
        hero:add('攻击加金币',self.attack_gold)
        hero:add_item('随机技能书',true)
        p.mall_flag[name] = true
        
        local tip = '|cffFFE799【系统消息】|r|cff00ff00自动激活 |cff00ffff金币礼包|r|cff00ff00 礼包属性可在最强魔灵-礼包中查看'
        p:sendMsg(tip,3)
    else
        p:sendMsg('条件不足或已领取过',2)    
    end    
end
mt.on_add = mt.on_cast_start