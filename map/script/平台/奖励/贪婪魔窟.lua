
local mt = ac.skill['开拓者']
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



local mt = ac.skill['冒险家']
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

local mt = ac.skill['大冒险家']
mt{
level = 0,
art = [[damaoxianjia.blp]],
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00贪婪魔窟|cffff0000最高|cff00ff00层数大于|cffffff00 100层 |cff00ff00获得

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+200  杀怪加全属性|r
|cff00ff00+100  攻击减甲|r
|cff00ff00+50% 会心伤害|r
|cff00ff00+25% 全伤加深|r

]],
need_map_level = 20,
['杀怪加全属性'] = 200,
['攻击减甲'] = 100,
['会心伤害'] = 50,
['全伤加深'] = 25,

}

local mt = ac.skill['冒险大师']
mt{
level = 0,
art = [[maoxiandashi.blp]],
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00贪婪魔窟|cffff0000最高|cff00ff00层数大于|cffffff00 150层 |cff00ff00获得

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+250 杀怪加全属性|r
|cff00ff00+125 攻击减甲|r
|cff00ff00+25  每秒加护甲|r
|cff00ff00+1    多重暴击|r

]],
need_map_level = 25,
['杀怪加全属性'] = 250,
['攻击减甲'] = 125,
['每秒加护甲'] = 25,
['多重暴击'] = 1,

}

local mt = ac.skill['金牌冒险家']
mt{
level = 0,
art = [[jpmxj.blp]],
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00贪婪魔窟|cffff0000最高|cff00ff00层数大于|cffffff00 ？？？层 |cff00ff00获得

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+300 杀怪加全属性|r
|cff00ff00+150 攻击减甲|r
|cff00ff00+30  每秒加护甲|r
|cff00ff00+2%    全伤加深系数|r

]],
need_map_level = 30,
['杀怪加全属性'] = 300,
['攻击减甲'] = 150,
['每秒加护甲'] = 30,
['全伤加深系数'] = 2,

}

local mt = ac.skill['拾荒者']
mt{
level = 0,
art = [[shihuangzhe.blp]],
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00贪婪魔窟|cffff0000累计|cff00ff00层数大于|cffffff00 250层 |cff00ff00获得

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+200 杀怪加全属性|r
|cff00ff00+100 攻击减甲|r
|cff00ff00+5%  减伤|r
|cff00ff00+10   每秒加木头|r

]],
need_map_level = 15,
['杀怪加全属性'] = 200,
['攻击减甲'] = 100,
['减伤'] = 5,
['每秒加木头'] = 10,

}

local mt = ac.skill['拾荒狂魔']
mt{
level = 0,
art = [[shihuangkuangmo.blp]],
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00贪婪魔窟|cffff0000累计|cff00ff00层数大于|cffffff00 500层 |cff00ff00获得

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+300 杀怪加全属性|r
|cff00ff00+150 攻击减甲|r
|cff00ff00+5%  闪避|r
|cff00ff00+20   每秒加魔丸|r

]],
need_map_level = 20,
['杀怪加全属性'] = 300,
['攻击减甲'] = 150,
['闪避'] = 5,
['每秒加魔丸'] = 20,

}

local mt = ac.skill['收藏家']
mt{
level = 0,
art = [[shoucangjia.blp]],
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00贪婪魔窟|cffff0000累计|cff00ff00层数大于|cffffff00 1000层 |cff00ff00获得

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+400 杀怪加全属性|r
|cff00ff00+200 攻击减甲|r
|cff00ff00+5%  免伤几率|r
|cff00ff00+5    每秒加杀敌数|r

]],
need_map_level = 25,
['杀怪加全属性'] = 400,
['攻击减甲'] = 200,
['免伤几率'] = 5,
['每秒加杀敌数'] = 5,

}

local mt = ac.skill['大收藏家']
mt{
level = 0,
art = [[dashoucangjia.blp]],
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00贪婪魔窟|cffff0000累计|cff00ff00层数大于|cffffff00 1500层 |cff00ff00获得

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+500 杀怪加全属性|r
|cff00ff00+250 攻击减甲|r
|cff00ff00+10% 每秒回血|r
|cff00ff00+50% 物品获取率|r

]],
need_map_level = 30,
['杀怪加全属性'] = 500,
['攻击减甲'] = 250,
['每秒回血'] = 10,
['物品获取率'] = 50,

}

local mt = ac.skill['收藏泰斗']
mt{
level = 0,
art = [[sctd.blp]],
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00贪婪魔窟|cffff0000累计|cff00ff00层数大于|cffffff00 ？？？层 |cff00ff00获得

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+600 杀怪加全属性|r
|cff00ff00+300 攻击减甲|r
|cff00ff00+10% 护甲%|r
|cff00ff00+5% 技能伤害加深系数|r

]],
need_map_level = 35,
['杀怪加全属性'] = 600,
['攻击减甲'] = 300,
['护甲%'] = 10,
['技能伤害加深系数'] = 5,

}

local mt = ac.skill['贪婪魔窟']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[BTNmk.blp]],
    tip = [[

点击查看 |cff00ffff魔窟成就|r，主要通过 |cffffff00不断挑战魔窟|r 获得
    ]],
    
}
mt.skills = {
    '开拓者','冒险家','大冒险家','冒险大师','金牌冒险家',
    '拾荒者','拾荒狂魔','收藏家','大收藏家','收藏泰斗',
}
