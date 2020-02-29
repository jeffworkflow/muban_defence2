--物品名称
local mt = ac.skill['随机功法']
mt{
--等久
level = 1,
is_order = 2,
--图标
art = [[other\suijijineng.blp]],
--价格随购买次数增加而增加，|cff00ff00且买且珍惜|r
--说明
tip = [[|n获得 |cffff0000随机技能|r，价格随购买次数增加而增加，|cff00ff00且买且珍惜|r|n]],

content_tip = '|cffFFE799【说明】：|r|n',
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 0,
--购买价格
rec_ex = 1,
--物品技能
is_skill = true,
}

function mt:on_cast_start()
    -- print('施法-随机技能',self.name)
    local hero = self.owner
    local shop_item = ac.item.shop_item_map[self.name]
    if not shop_item.player_rec_ex then 
        shop_item.player_rec_ex = {}
    end
    --改变商店物品物价
    shop_item.player_rec_ex[hero:get_owner()] =  (shop_item.player_rec_ex[hero:get_owner()] or self.rec_ex) * 2
    shop_item.player_rec_ex[hero:get_owner()] = math.min(shop_item.player_rec_ex[hero:get_owner()],5000) --上限5000
    --给英雄随机添加物品
    local rand_list = ac.unit_reward['商店随机技能']
    local rand_name = ac.get_reward_name(rand_list)
    if not rand_name then 
        return
    end    
    local list = ac.quality_skill[rand_name]
    --添加给购买者
    local name = list[math.random(#list)]
    ac.item.add_skill_item(name,hero)

end

function mt:on_remove()
end