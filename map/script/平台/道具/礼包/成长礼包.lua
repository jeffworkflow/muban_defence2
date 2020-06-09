local mt = ac.skill['成长礼包']
mt{
--等久
level = 0,
--图标
art = [[chengzhanglibao.blp]],
is_order = 1,
--说明
tip = [[

|cffFFE799【领取条件】|r|cffff0000商城购买|r后自动激活

|cffFFE799【礼包奖励】|r
|cff00ff00杀怪加68全属性，攻击加188全属性，每秒加688全属性 
|cff00ff00每秒加护甲+15
|cff00ffff杀敌数加成+15% 木头加成+15% 
物品获取率+15% 魔丸加成+15% |r
|cffff0000全伤加深+地图等级*10%|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 68,
['攻击加全属性'] = 188,
['每秒加全属性'] = 688,
['每秒加护甲'] = 15,
['杀敌数加成'] = 15,
['木头加成'] = 15,
['物品获取率'] = 15,
['魔丸加成'] = 15,


['全伤加深'] = function(self)
    local p = self.owner:get_owner()
    local map_level = p:Map_GetMapLevel()
    return 10 * map_level
end,
}
