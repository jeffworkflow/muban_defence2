--物品名称
--随机技能添加给英雄貌似有点问题。
local mt = ac.skill['魔神之石']
mt{
--等久
level = 1,
is_order = 1,
--图标
art = [[tianyu.blp]],
--价格随购买次数增加而增加，|cff00ff00且买且珍惜|r
--说明
tip = [[

消耗 |cffff000010个强化石|r 兑换 |cff00ff001个天谕|r

|cffcccccc最大兑换次数50次]],

content_tip = '|cffFFE799【说明】：|r|n',
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 0,
--物品技能
is_skill = true,
}

function mt:on_cast_start()
    -- print('施法-随机技能',self.name)
    local first_u = self.owner
    local p = first_u:get_owner()
    local player = first_u:get_owner()
    local peon = p.peon
    local second_u = first_u == peon and p.hero or peon
    
    --先扣当前消费者的勋章数，不足的话扣除单位下的另一个人的勋章
    local first_item = first_u:has_item('强化石')
    local second_item = second_u:has_item('强化石')

    local first_cnt = first_item and first_item:get_item_count() or 0 
    local second_cnt = second_item and second_item:get_item_count() or 0 
    local need_cnt = 10
    if first_cnt + second_cnt < need_cnt  then 
        p:sendMsg('|cffFFE799【系统消息】|r|cffff0000材料不足')
        return 
    end    
    if first_cnt < need_cnt then 
        p:sendMsg('当前单位的强化石不够，一并扣除了宠物/英雄身上的',5)
    end
    
    if first_cnt > 0 then 
        if first_cnt>= need_cnt then 
            first_item:add_item_count(-need_cnt)
        else
            local dis_cnt = need_cnt - first_cnt
            first_item:add_item_count(-first_cnt)
            second_item:add_item_count(-dis_cnt)
        end
    else
        second_item:add_item_count(-need_cnt)
    end
    
    --给物品
    first_u:add_item('天谕')
    p:sendMsg('|cff00ff00兑换成功|r')
end

function mt:on_remove()
end