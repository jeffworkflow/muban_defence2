local mt = ac.skill['肝帝']
mt{
--等久
level = 0,
--图标
art = [[gandi.blp]],
is_order = 1,
--说明
tip = [[

|cffFFE799【领取条件】|r|cffff0000地图等级=60|r自动激活

|cffFFE799【肝帝奖励】|r
|cff00ff00杀怪加全属性+888 攻击加全属性+888 每秒加全属性+888
|cff00ffff攻击减甲+888 减少周围护甲+1888
|cffffff00暴击伤害+488% 技暴伤害+488% 会心伤害+488%
|cffff0000物理伤害加深+488% 技能伤害加深+488% 全伤加深+488%

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 888,
['攻击加全属性'] = 888,
['每秒加全属性'] = 888,
['攻击减甲'] = 888,
['减少周围护甲'] = 1888,
['暴击伤害'] = 488,
['技暴伤害'] = 488,
['会心伤害'] = 488,
['物理伤害加深'] = 488,
['技能伤害加深'] = 488,
['全伤加深'] = 488,
}
