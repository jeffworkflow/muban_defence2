--物品名称
--随机技能添加给英雄貌似有点问题。
local mt = ac.skill['真·神魂修炼']
mt{
--等久
level = 1,
is_order = 1,
--图标
art = [[zshxl.blp]],
--价格随购买次数增加而增加，|cff00ff00且买且珍惜|r
--说明
tip = [[

消耗 |cffff0000四本天阶功法|r 兑换 |cff00ff00一本神阶功法|r

|cffcccccc最大兑换次数12次]],

content_tip = '|cffFFE799【说明】：|r|n',
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 0,
--最大购买次数
max_buy_cnt = 12,
--物品技能
is_skill = true,
}

function mt:on_cast_start()
    -- print('施法-随机技能',self.name)
    local hero = self.owner
    local p = hero:get_owner()
    local player = hero:get_owner()

    local red_cnt = 0
    local temp_item = {}
    for i=1,6 do 
        local item = hero:get_slot_item(i)
        if item and item.color == '天阶' and red_cnt < 4 then 
            red_cnt = red_cnt +1
            table.insert(temp_item,item)
        end    
    end    
    if red_cnt < 4 then 
        p:sendMsg('材料不足')
        return 
    end    
    
    --删除物品
    for i,item in ipairs(temp_item) do 
        if item._count > 1 then 
            item:add_item_count(-1)
        else    
            item:item_remove()
        end    
    end    

    --添加 神阶功法 未处理
    local list = ac.quality_skill['神阶'] 
    local name = list[math.random(#list)]
    --满时，掉在地上 神阶功法 未处理
    ac.item.add_skill_item(name,hero)
    p:sendMsg('|cff00ff00兑换成功|r')
end

function mt:on_remove()
end