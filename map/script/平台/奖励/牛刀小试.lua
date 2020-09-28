
local mt = ac.skill['牛刀小试1']
mt{
    level = 0,
art = [[kaituozhe.blp]],
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00贪婪魔窟|cffff0000最高|cff00ff00层数大于|cffffff00 25层 |cff00ff00获得

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+100  杀怪加全属性|r
|cff00ff00+50   攻击减甲|r
|cff00ff00+50% 暴击伤害|r
|cff00ff00+25% 物理伤害加深|r

]],
need_map_level = 10,
['杀怪加全属性'] = 100,
['攻击减甲'] = 50,
['暴击伤害'] = 50,
['物理伤害加深'] = 25,

}



local mt = ac.skill['牛刀小试2']
mt{
    level = 0,
art = [[maoxianjia.blp]],
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00贪婪魔窟|cffff0000最高|cff00ff00层数大于|cffffff00 50层 |cff00ff00获得

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+150  杀怪加全属性|r
|cff00ff00+75   攻击减甲|r
|cff00ff00+50% 技暴伤害|r
|cff00ff00+25% 技能伤害加深|r

]],
need_map_level = 15,
['杀怪加全属性'] = 150,
['攻击减甲'] = 75,
['技暴伤害'] = 50,
['技能伤害加深'] = 25,

}



local mt = ac.skill['牛刀1']
mt{
    level = 0,
art = [[maoxianjia.blp]],
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00贪婪魔窟|cffff0000最高|cff00ff00层数大于|cffffff00 50层 |cff00ff00获得

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+150  杀怪加全属性|r
|cff00ff00+75   攻击减甲|r
|cff00ff00+50% 技暴伤害|r
|cff00ff00+25% 技能伤害加深|r

]],
need_map_level = 15,
['杀怪加全属性'] = 150,
['攻击减甲'] = 75,
['技暴伤害'] = 50,
['技能伤害加深'] = 25,

}
local mt = ac.skill['牛刀2']
mt{
    level = 0,
art = [[maoxianjia.blp]],
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00贪婪魔窟|cffff0000最高|cff00ff00层数大于|cffffff00 50层 |cff00ff00获得

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+150  杀怪加全属性|r
|cff00ff00+75   攻击减甲|r
|cff00ff00+50% 技暴伤害|r
|cff00ff00+25% 技能伤害加深|r

]],
need_map_level = 15,
['杀怪加全属性'] = 150,
['攻击减甲'] = 75,
['技暴伤害'] = 50,
['技能伤害加深'] = 25,

}

local mt = ac.skill['无尽模式']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[dashoucangjia.blp]],
    tip = [[

点击查看 |cff00ffff魔窟成就|r，主要通过 |cffffff00不断挑战魔窟|r 获得
    ]],
    
}
mt.skills = {
    '牛刀小试1','牛刀小试2','牛刀1','牛刀2',
}
