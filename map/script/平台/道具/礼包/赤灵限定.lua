local mt = ac.skill['赤灵限定']
mt{
--等久
level = 0,
--图标
art = [[chilingxianding.blp]],
is_order = 1,
--说明
tip = [[

|cffFFE799【激活条件】|r
|cffdf19d0【赤灵传说】的地图等级≥10|r|cffcccccc（如果条件满足却未激活，请进入【赤灵传说】游戏内一分钟后退出，即可激活）

|cffFFE799【奖励属性】|r
|cff00ff00+16.8   杀怪加全属性|r
|cff00ff00+16.8   攻击减甲|r
|cffffff00+1%     会心几率|r
|cffffff00+10%    会心伤害|r
|cffff0000+16.8%  全伤加深|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,

['杀怪加全属性'] = 16.8,
['攻击减甲'] = 16.8,
['会心几率'] = 1,
['会心伤害'] = 10,
['全伤加深'] = 16.8,
}
