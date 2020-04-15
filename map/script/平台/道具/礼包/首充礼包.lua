local mt = ac.skill['首充礼包']
mt{
--等久
level = 0,
--图标
art = [[scdlb.blp]],
is_order = 1,
--说明
tip = [[

|cffFFE799【领取条件】|r|cffff0000商城购买|r后自动激活

|cffFFE799【礼包奖励】|r
|cff00ff00杀怪加38全属性，攻击加68全属性，每秒加108全属性 
|cff00ffff杀敌数加成+15% 木头加成+15% 
物品获取率+15% 魔丸加成+15% |r
|cffff0000对BOSS额外伤害+5%|r

|cffffff00地图等级>=7，首充大礼包的资源属性效果翻倍|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['全属性'] = 1000000,
['力量%'] = 5,
['敏捷%'] = 5,
['智力%'] = 5,
--初始金币和杀敌数
init_gold = 800000,
init_kill_count = 3000,
}
function mt:on_add()
    local hero = self.owner
    hero:addGold(self.init_gold)
    hero:add_kill_count(self.init_kill_count)
end
