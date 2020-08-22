--通关难度
local mt = ac.skill['深渊一层']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[lvbu.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00士兵1段

|cffFFE799【天赋属性】：|r
|cffffff00【杀怪加力量】+80*Lv
【吸血】+10%
【攻击距离】+50
【物理伤害加深】+50%

|cff00ffff【被动效果】攻击10%几率变身魔神，持续8秒

|cffff0000【点击可更换英雄外观，天赋属性开局选取后无法更换】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 2,
}


local mt = ac.skill['深渊二层']
mt{
--等级
level = 0,
is_order = 1,
--图标
art = [[lvbu.blp]],
--说明
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00士兵1段

|cffFFE799【天赋属性】：|r
|cffffff00【杀怪加力量】+80*Lv
【吸血】+10%
【攻击距离】+50
【物理伤害加深】+50%

|cff00ffff【被动效果】攻击10%几率变身魔神，持续8秒

|cffff0000【点击可更换英雄外观，天赋属性开局选取后无法更换】|r]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
need_map_level = 2,
}


local mt = ac.skill['深渊冒险奖励']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[nandu.blp]],
    title = '深渊冒险奖励',
    tip = [[

点击查看|cff00ffff深渊冒险奖励|r，每通关一次即可获得|cffffff00对应难度的1段|r
    ]],
    
}
mt.skills ={
    '深渊一层','深渊二层','深渊三层','深渊四层',
    '深渊五层','深渊六层','深渊七层','深渊八层',
    '深渊九层','深渊十层',
}

