local mt = ac.skill['赤灵限定']
mt{
--等久
level = 0,
--图标
art = [[chilingxianding.blp]],
is_order = 1,
--说明
tip = [[

|cffFFE799【领取条件】|r|cffff0000商城购买|r后自动激活

|cffFFE799【礼包奖励】|r
|cff00ff00杀怪加188全属性，攻击加688全属性，每秒加1888全属性
|cff00ffff杀敌数加成+75% 木头加成+75% 
物品获取率+75% 魔丸加成+75% |r
|cffff0000攻击减甲+50 减少周围护甲1000|r
|cffff0000每秒加护甲+20|r

|cffffff00地图等级>=5，效果翻倍|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

['杀怪加全属性'] = 16.8,
['攻击减甲'] = 16.8,
['会心几率'] = 1,
['会心伤害'] = 10,
['全伤加深'] = 16.8,
}
