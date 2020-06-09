local mt = ac.skill['首充礼包']
mt{
--等久
level = 0,
--图标
art = [[sffl.blp]],
is_order = 1,
--说明
tip = [[

|cffFFE799【领取条件】|r|cffff0000商城购买|r后自动激活

|cffFFE799【礼包奖励】|r
|cff00ff00全属性加成+5%
初始全属性+150万 
初始护甲+1万
初始金币+80万
初始杀敌数+1500|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['全属性'] = 1500000,
['护甲'] = 10000,
['力量%'] = 5,
['敏捷%'] = 5,
['智力%'] = 5,
--初始金币和杀敌数
init_gold = 800000,
init_kill_count = 1500,
}
function mt:on_add()
    local hero = self.owner
    hero:addGold(self.init_gold)
    hero:add_kill_count(self.init_kill_count)
end
