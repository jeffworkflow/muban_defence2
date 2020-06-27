--物品名称
--随机技能添加给英雄貌似有点问题。
local mt = ac.skill['魔神的合成']
mt{
--等久
level = 1,
is_order = 1,
--图标
art = [[mszw.blp]],
--价格随购买次数增加而增加，|cff00ff00且买且珍惜|r
--说明
tip = [[

消耗 |cffff00004个红色物品|r 兑换 |cff00ff001个黑色物品|r

|cffcccccc最大兑换次数12次]],

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
