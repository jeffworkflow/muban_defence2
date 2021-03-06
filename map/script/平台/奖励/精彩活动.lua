local mt = ac.skill['魔灵精品粽']
mt{
--等级
level = 1, --要动态插入
max_level = 5, --要动态插入
--图标
art = [[mljpz.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff端午节活动获得 |cffff0000重复完成可升级成就|r |cff00ffff最大等级=5

|cffFFE799【成就属性】：|r
|cff00ff00+%全属性%   |cff00ff00全属性|r
|cff00ff00+%攻击减甲%   |cff00ff00攻击减甲|r
|cff00ff00+%每秒加护甲%   |cff00ff00每秒加护甲|r
|cff00ff00+%全伤加深% |cffffff00%  |cff00ff00全伤加深|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['全属性'] = {200000,250000,300000,350000,500000},
['攻击减甲'] = {20,25,30,35,50},
['每秒加护甲'] = {2,3,4,5,6},
['全伤加深'] = {10,12.5,15,17.5,25},
need_map_level = 5,
}


local mt = ac.skill['真正的学霸']
mt{
--等级
level = 1, --要动态插入
max_level = 5, --要动态插入
--图标
art = [[xueba.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff暑假活动获得 |cffff0000重复完成可升级成就|r |cff00ffff最大等级=5

|cffFFE799【成就属性】：|r
|cff00ff00+%全属性%   |cff00ff00全属性|r
|cff00ff00+%攻击减甲%   |cff00ff00攻击减甲|r
|cff00ff00+%每秒加护甲%   |cff00ff00每秒加护甲|r
|cff00ff00+%技能伤害加深% |cffffff00%  |cff00ff00技能伤害加深|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['全属性'] = {200000,250000,300000,350000,500000},
['攻击减甲'] = {20,25,30,35,50},
['每秒加护甲'] = {2,3,4,5,6},
['技能伤害加深'] = {20,25,30,35,50},
need_map_level = 5,
}

local mt = ac.skill['魔灵麒麟瓜']
mt{
--等级
level = 1, --要动态插入
max_level = 5, --要动态插入
--图标
art = [[xigua.blp]],
--说明

tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff暑假活动获得 |cffff0000重复完成可升级成就|r |cff00ffff最大等级=5

|cffFFE799【成就属性】：|r
|cff00ff00+%全属性%   |cff00ff00全属性|r
|cff00ff00+%攻击减甲%   |cff00ff00攻击减甲|r
|cff00ff00+%每秒加护甲%   |cff00ff00每秒加护甲|r
|cff00ff00+%物理伤害加深% |cffffff00%  |cff00ff00物理伤害加深|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['全属性'] = {200000,250000,300000,350000,500000},
['攻击减甲'] = {20,25,30,35,50},
['每秒加护甲'] = {2,3,4,5,6},
['物理伤害加深'] = {40,50,60,70,100},
need_map_level = 5,
}

local mt = ac.skill['护焰者']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
--图标
art = [[huhuozhe.blp]],
--说明

tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff火把积分≥50%current%

|cffFFE799【成就属性】：|r
|cff00ff00+%杀怪加全属性%   |cff00ff00杀怪加全属性|r
|cff00ff00+%攻击减甲%   |cff00ff00攻击减甲|r
|cff00ff00+%物品获取率% |cff00ff00% |cff00ff00物品获取率|r
|cff00ff00+%全伤加深% |cff00ff00% |cff00ff00全伤加深|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 8.8,
['攻击减甲'] = 8.8,
['物品获取率'] = 8.8,
['全伤加深'] = 8.8,
need_map_level = 5,
current = function(self)
    local p = ac.player.self
    local val = p.server and p.server['火把积分'] or 0
    local str = '|cffdf19d0（当前火把积分：|cffffe799'..val..'|cffdf19d0）'
    return str
end,
}

local mt = ac.skill['火焰杂耍']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
--图标
art = [[hyzs.blp]],
--说明

tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff火把积分≥150%current%

|cffFFE799【成就属性】：|r
|cff00ff00+%杀怪加全属性%   |cff00ff00杀怪加全属性|r
|cff00ff00+%攻击减甲%   |cff00ff00攻击减甲|r
|cff00ff00+%木头加成% |cff00ff00% |cff00ff00木头加成|r
|cff00ff00+%全伤加深% |cff00ff00% |cff00ff00全伤加深|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 16.8,
['攻击减甲'] = 16.8,
['木头加成'] = 16.8,
['全伤加深'] = 16.8,
need_map_level = 6,
current = function(self)
    local p = ac.player.self
    local val = p.server and p.server['火把积分'] or 0
    local str = '|cffdf19d0（当前火把积分：|cffffe799'..val..'|cffdf19d0）'
    return str
end,
}

local mt = ac.skill['木杆热舞']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
--图标
art = [[mgrw.blp]],
--说明

tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff火把积分≥300%current%

|cffFFE799【成就属性】：|r
|cff00ff00+%杀怪加全属性%   |cff00ff00杀怪加全属性|r
|cff00ff00+%攻击减甲%   |cff00ff00攻击减甲|r
|cff00ff00+%魔丸加成% |cff00ff00% |cff00ff00魔丸加成|r
|cff00ff00+%全伤加深% |cff00ff00% |cff00ff00全伤加深|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 26.8,
['攻击减甲'] = 26.8,
['魔丸加成'] = 26.8,
['全伤加深'] = 26.8,
need_map_level = 7,
current = function(self)
    local p = ac.player.self
    local val = p.server and p.server['火把积分'] or 0
    local str = '|cffdf19d0（当前火把积分：|cffffe799'..val..'|cffdf19d0）'
    return str
end,
}

local mt = ac.skill['燃烧之花']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
--图标
art = [[rszh.blp]],
--说明

tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff火把积分≥500%current%

|cffFFE799【成就属性】：|r
|cff00ff00+%杀怪加全属性%   |cff00ff00杀怪加全属性|r
|cff00ff00+%攻击减甲%   |cff00ff00攻击减甲|r
|cff00ff00+%杀敌数加成% |cff00ff00% |cff00ff00杀敌数加成|r
|cff00ff00+%全伤加深% |cff00ff00% |cff00ff00全伤加深|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 32.8,
['攻击减甲'] = 32.8,
['杀敌数加成'] = 32.8,
['全伤加深'] = 32.8,
need_map_level = 8,
current = function(self)
    local p = ac.player.self
    local val = p.server and p.server['火把积分'] or 0
    local str = '|cffdf19d0（当前火把积分：|cffffe799'..val..'|cffdf19d0）'
    return str
end,
}

local mt = ac.skill['艾泽拉斯的火焰']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
--图标
art = [[azlsdhy.blp]],
--说明

tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff火把积分≥750%current%

|cffFFE799【成就属性】：|r
|cff00ff00+%杀怪加全属性%   |cff00ff00杀怪加全属性|r
|cff00ff00+%攻击减甲%   |cff00ff00攻击减甲|r
|cff00ff00+%木头加成% |cff00ff00% |cff00ff00木头加成|r
|cff00ff00+%全伤加深% |cff00ff00% |cff00ff00全伤加深|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 36.8,
['攻击减甲'] = 36.8,
['木头加成'] = 36.8,
['全伤加深'] = 36.8,
need_map_level = 9,
current = function(self)
    local p = ac.player.self
    local val = p.server and p.server['火把积分'] or 0
    local str = '|cffdf19d0（当前火把积分：|cffffe799'..val..'|cffdf19d0）'
    return str
end,
}

local mt = ac.skill['火把节之王']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
--图标
art = [[hbjzw.blp]],
--说明

tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff火把积分≥1000%current%

|cffFFE799【成就属性】：|r
|cff00ff00+%杀怪加全属性%   |cff00ff00杀怪加全属性|r
|cff00ff00+%攻击减甲%   |cff00ff00攻击减甲|r
|cff00ff00+%物品获取率% |cff00ff00% |cff00ff00物品获取率|r
|cff00ff00+%全伤加深% |cff00ff00% |cff00ff00全伤加深|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 66.6,
['攻击减甲'] = 66.6,
['物品获取率'] = 66.6,
['全伤加深'] = 66.6,
need_map_level = 10,
current = function(self)
    local p = ac.player.self
    local val = p.server and p.server['火把积分'] or 0
    local str = '|cffdf19d0（当前火把积分：|cffffe799'..val..'|cffdf19d0）'
    return str
end,
}


local mt = ac.skill['缘定三生']
mt{
--等级
level = 1, --要动态插入
max_level = 5, --要动态插入
--图标
art = [[ydss.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff七夕活动获得 |cffff0000重复完成可升级成就|r |cff00ffff最大等级=5

|cffFFE799【成就属性】：|r
|cff00ff00+%全属性%   |cff00ff00全属性|r
|cff00ff00+%攻击减甲%   |cff00ff00攻击减甲|r
|cff00ff00+%每秒加护甲%   |cff00ff00每秒加护甲|r
|cff00ff00+%技能伤害加深系数% |cffffff00%  |cff00ff00技能伤害加深系数|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['全属性'] = {200000,250000,300000,350000,500000},
['攻击减甲'] = {20,25,30,35,50},
['每秒加护甲'] = {2,3,4,5,6},
['技能伤害加深系数'] = {1,2,3,4,5},
need_map_level = 5,
}


local mt = ac.skill['懂事的孩子']
mt{
--等级
level = 1, --要动态插入
max_level = 5, --要动态插入
--图标
art = [[haizi.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff教师节活动获得 |cffff0000重复完成可升级成就|r |cff00ffff最大等级=5

|cffFFE799【成就属性】：|r
|cff00ff00+%全属性%   |cff00ff00全属性|r
|cff00ff00+%攻击减甲%   |cff00ff00攻击减甲|r
|cff00ff00+%每秒加护甲%   |cff00ff00每秒加护甲|r
|cff00ff00+%技能伤害加深系数% |cffffff00%  |cff00ff00技能伤害加深系数|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['全属性'] = {200000,250000,300000,350000,500000},
['攻击减甲'] = {20,25,30,35,50},
['每秒加护甲'] = {2,3,4,5,6},
['技能伤害加深系数'] = {2,4,6,8,10},
need_map_level = 5,
}


local mt = ac.skill['九洲帝王']
mt{
--等级
level = 1, --要动态插入
max_level = 5, --要动态插入
--图标
art = [[jzdw.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff国庆节活动获得 |cffff0000重复完成可升级成就|r |cff00ffff最大等级=5

|cffFFE799【成就属性】：|r
|cff00ff00+%全属性%   |cff00ff00全属性|r
|cff00ff00+%攻击减甲%   |cff00ff00攻击减甲|r
|cff00ff00+%每秒加护甲%   |cff00ff00每秒加护甲|r
|cff00ff00+%暴击伤害系数% |cffffff00%  |cff00ff00暴击伤害系数|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['全属性'] = {200000,250000,300000,350000,500000},
['攻击减甲'] = {20,25,30,35,50},
['每秒加护甲'] = {2,3,4,5,6},
['暴击伤害系数'] = {2,4,6,8,10},
need_map_level = 5,
}

local mt = ac.skill['第一个吃螃蟹的人']
mt{
--等级
level = 1, --要动态插入
max_level = 20, --要动态插入
--图标
art = [[dygcpxdr.blp]],
--说明
tip = [[
|cffffff00【要求地图等级> %need_map_level%|cffffff00】|r

|cffffe799【成就说明】：|r
|cff00ffff中秋活动期间，每局第一个食用“肥美的螃蟹”的玩家可获得 |cffff0000重复获得成就可升级成就|r |cff00ffff最大等级=20

|cffFFE799【成就属性】：|r
|cff00ff00+%杀怪加全属性%   |cff00ff00杀怪加全属性|r
|cff00ff00+%攻击减甲%   |cff00ff00攻击减甲|r
|cff00ff00+%物品获取率% |cff00ff00% |cff00ff00物品获取率|r
|cff00ff00+%全伤加深% |cff00ff00% |cff00ff00全伤加深|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = {2,40},
['攻击减甲'] = {2,40},
['物品获取率'] = {2,40},
['全伤加深'] = {2,40},
need_map_level = 5,
}


local mt = ac.skill['四海共团圆']
mt{
--等级
level = 1, --要动态插入
max_level = 5, --要动态插入
--图标
art = [[shgty.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff中秋节活动获得 |cffff0000重复完成可升级成就|r |cff00ffff最大等级=5

|cffFFE799【成就属性】：|r
|cff00ff00+%全属性%   |cff00ff00全属性|r
|cff00ff00+%攻击减甲%   |cff00ff00攻击减甲|r
|cff00ff00+%每秒加护甲%   |cff00ff00每秒加护甲|r
|cff00ff00+%技暴伤害系数% |cffffff00%  |cff00ff00技暴伤害系数|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['全属性'] = {200000,250000,300000,350000,500000},
['攻击减甲'] = {20,25,30,35,50},
['每秒加护甲'] = {2,3,4,5,6},
['技暴伤害系数'] = {2,4,6,8,10},
need_map_level = 5,
}

--=======================中秋活动=====================
local mt = ac.skill['秀才']
mt{
--等级
level = 1, 
--图标
art = [[xiucai.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【成就说明】：|r
|cff00ffff通过 中秋活动 获得

|cffFFE799【成就属性】：|r
|cff00ff00+18.8   杀怪加全属性|r
|cff00ff00+18.8   攻击减甲|r
|cff00ff00+18.8%  木头加成|r
|cff00ff00+2.8%  全伤加深系数|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 18.8,
['攻击减甲'] = 18.8,
['木头加成'] = 18.8,
['全伤加深系数'] = 2.8,

need_map_level = 5,
}
local mt = ac.skill['举人']
mt{
--等级
level = 1, 
--图标
art = [[juren.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【成就说明】：|r
|cff00ffff通过 中秋活动 获得

|cffFFE799【成就属性】：|r
|cff00ff00+28.8   杀怪加全属性|r
|cff00ff00+28.8   攻击减甲|r
|cff00ff00+28.8%  木头加成|r
|cff00ff00+4.8%  全伤加深系数|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 28.8,
['攻击减甲'] = 28.8,
['木头加成'] = 28.8,
['全伤加深系数'] = 4.8,

need_map_level = 5,
}
local mt = ac.skill['进士']
mt{
--等级
level = 1, 
--图标
art = [[jinshi.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【成就说明】：|r
|cff00ffff通过 中秋活动 获得

|cffFFE799【成就属性】：|r
|cff00ff00+38.8   杀怪加全属性|r
|cff00ff00+38.8   攻击减甲|r
|cff00ff00+38.8%  木头加成|r
|cff00ff00+6.8%  全伤加深系数|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 38.8,
['攻击减甲'] = 38.8,
['木头加成'] = 38.8,
['全伤加深系数'] = 6.8,

need_map_level = 5,
}

local mt = ac.skill['探花']
mt{
--等级
level = 1, 
--图标
art = [[tanhua.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【成就说明】：|r
|cff00ffff通过 中秋活动 获得

|cffFFE799【成就属性】：|r
|cff00ff00+48.8   杀怪加全属性|r
|cff00ff00+48.8   攻击减甲|r
|cff00ff00+48.8%  木头加成|r
|cff00ff00+8.8%  全伤加深系数|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 48.8,
['攻击减甲'] = 48.8,
['木头加成'] = 48.8,
['全伤加深系数'] = 8.8,

need_map_level = 5,
}
local mt = ac.skill['榜眼']
mt{
--等级
level = 1, 
--图标
art = [[bangyan.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【成就说明】：|r
|cff00ffff通过 中秋活动 获得

|cffFFE799【成就属性】：|r
|cff00ff00+68.8   杀怪加全属性|r
|cff00ff00+68.8   攻击减甲|r
|cff00ff00+68.8%  木头加成|r
|cff00ff00+10.8%  全伤加深系数|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 68.8,
['攻击减甲'] = 68.8,
['木头加成'] = 68.8,
['全伤加深系数'] = 10.8,

need_map_level = 5,
}


local mt = ac.skill['状元']
mt{
--等级
level = 1, 
--图标
art = [[zhuangyuan.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【成就说明】：|r
|cff00ffff通过 中秋活动 获得

|cffFFE799【成就属性】：|r
|cff00ff00+88.8   杀怪加全属性|r
|cff00ff00+88.8   攻击减甲|r
|cff00ff00+88.8%  木头加成|r
|cff00ff00+16.8%  全伤加深系数|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 88.8,
['攻击减甲'] = 88.8,
['木头加成'] = 88.8,
['全伤加深系数'] = 16.8,

need_map_level = 5,
}

local mt = ac.skill['火把节']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[huoba.blp]],
    title = '火把节成就',
    tip = [[

点击查看 |cff00ffff火把节成就|r，通过完成 |cffffff00限时活动|r 获得
    ]],
    
}
mt.skill_name ={
    '护焰者','火焰杂耍','木杆热舞','燃烧之花','艾泽拉斯的火焰','火把节之王','火焰之王'
}

mt.skills = {
    -- '第一个吃螃蟹的人',
}
local mt = ac.skill['有趣的灵魂']
mt{
--等级
level = 1, --要动态插入
max_level = 35, --要动态插入
--图标
art = [[zyj.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff超度灵魂获得 |cffff0000重复完成可升级成就|r |cff00ffff最大等级=35

|cffFFE799【成就属性】：|r
|cff00ff00+%暴击伤害% |cffffff00% |cff00ff00暴击伤害|r
|cff00ff00+%技暴伤害% |cffffff00% |cff00ff00技暴伤害|r
|cff00ff00+%会心伤害% |cffffff00% |cff00ff00会心伤害|r
|cff00ff00+%物理伤害加深% |cffffff00% |cff00ff00物理伤害加深|r
|cff00ff00+%技能伤害加深% |cffffff00% |cff00ff00技能伤害加深|r
|cff00ff00+%全伤加深% |cffffff00% |cff00ff00全伤加深|r
|cff00ff00+%对BOSS额外伤害% |cffffff00% |cff00ff00对BOSS额外伤害|r
]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['暴击伤害'] = {1,35},
['技暴伤害'] = {1,35},
['会心伤害'] = {1,35},
['物理伤害加深'] = {1,35},
['技能伤害加深'] = {1,35},
['全伤加深'] = {1,35},
['对BOSS额外伤害'] = {1,35},
need_map_level = 5,
}

local mt = ac.skill['兽魂之佑']
mt{
--等级
level = 1, --要动态插入
max_level = 10,
--图标
art = [[ruishou.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff春节活动获得 |cffff0000重复完成可升级成就|r |cff00ffff最大等级=10

|cffFFE799【成就属性】：|r
|cff00ff00+%杀怪加全属性%   |cff00ff00杀怪加全属性|r
|cff00ff00+%攻击减甲%   |cff00ff00攻击减甲|r
|cff00ff00+%杀敌数加成% |cff00ff00%  |cff00ff00杀敌数加成|r
|cff00ff00+%暴击伤害系数% |cff00ff00%  |cff00ff00暴击伤害系数|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = {8.8,17.6,26.4,35.2,44,50,55,60,65,75},
['杀敌数加成'] = {8.8,17.6,26.4,35.2,44,50,55,60,65,75},
['攻击减甲'] = {8.8,17.6,26.4,35.2,44,50,55,60,65,75},
['暴击伤害系数'] = {8.8,17.6,26.4,35.2,44,50,55,60,65,75},
need_map_level = 5,
}

local mt = ac.skill['放炮小达人']
mt{
--等级
level = 1, --要动态插入
max_level = 10,
--图标
art = [[zhadanren.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff春节活动获得 |cffff0000重复完成可升级成就|r |cff00ffff最大等级=10

|cffFFE799【成就属性】：|r
|cff00ff00+%杀怪加全属性%   |cff00ff00杀怪加全属性|r
|cff00ff00+%攻击减甲%   |cff00ff00攻击减甲|r
|cff00ff00+%魔丸加成% |cff00ff00%  |cff00ff00魔丸加成|r
|cff00ff00+%技暴伤害系数% |cff00ff00%  |cff00ff00技暴伤害系数|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = {8.8,17.6,26.4,35.2,44,50,55,60,65,75},
['魔丸加成'] = {8.8,17.6,26.4,35.2,44,50,55,60,65,75},
['攻击减甲'] = {8.8,17.6,26.4,35.2,44,50,55,60,65,75},
['技暴伤害系数'] = {8.8,17.6,26.4,35.2,44,50,55,60,65,75},
need_map_level = 5,
}

local mt = ac.skill['五福']
mt{
--等级
level = 1, --要动态插入
max_level = 1,
title ='五福活动奖励',
--图标
art = [[fuqi.blp]],
--说明
tip = [[ 
|cffffe799【成就说明】：|r
|cff00ff00通过|cffffff00“五福四海过福年”活动|cff00ff00获得，|cff00ff00集五福瓜分100亿的可存档全属性

|cffFFE799【成就属性】：|r
|cff00ff00+%全属性% |cff00ff00全属性|r

|cffcccccc您集齐了%wufu%|cffcccccc次五福，世界一共集齐|cffffff004477|cffcccccc次五福]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
wufu = function(self)
    local p = self.owner.owner
    return math.min(p.server['五福'],15*p:Map_GetMapLevel())
end,
['全属性'] = function(self)
    local v = math.floor( 10000000000 / 4477 )
    return self.wufu * v
end,
need_map_level = 5,
}


local mt = ac.skill['归梦五行图']
mt{
--等级
level = 1, 
max_level = 5, 
--图标
art = [[wuxingtu.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff劳动节活动获得 |cffff0000重复完成可升级成就|r |cff00ffff最大等级=5

|cffFFE799【成就属性】：|r
|cff00ff00+%攻击加全属性%   |cff00ff00攻击加全属性|r
|cff00ff00+%每秒加木头%   |cff00ff00每秒加木头|r
|cff00ff00+%减少周围护甲% |cff00ff00减少周围护甲|r
|cff00ff00+%技暴伤害系数% |cffffff00%  |cff00ff00技暴伤害系数|r
 ]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['攻击加全属性'] = {28,58,88,118,148},
['减少周围护甲'] = {100,200,300,400,500},
['技暴伤害系数'] = {8.8,13.8,18.8,23.8,28.8},
['每秒加木头'] = {1,2,3,4,5},
need_map_level = 5,
}

local mt = ac.skill['放了那只猪']
mt{
--等级
level = 1, 
max_level = 5, 
--图标
art = [[mengchong.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff劳动节活动获得 |cffff0000重复完成可升级成就|r |cff00ffff最大等级=5

|cffFFE799【成就属性】：|r
|cff00ff00+%攻击加全属性%   |cff00ff00攻击加全属性|r
|cff00ff00+%每秒加杀敌数%   |cff00ff00每秒加杀敌数|r
|cff00ff00+%攻击减甲% |cff00ff00攻击减甲|r
|cff00ff00+%暴击伤害系数% |cffffff00%  |cff00ff00暴击伤害系数|r
 ]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,


['攻击加全属性'] = {28,58,88,118,148},
['攻击减甲'] = {10,20,30,40,50},
['暴击伤害系数'] = {8.8,23.8,38.8,43.8,58.8},
['每秒加杀敌数'] = {1,2,3,4,5},
need_map_level = 5,
}


local mt = ac.skill['精彩活动']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[BTNhd.blp]],
    title = '活动成就',
    tip = [[

点击查看 |cff00ffff活动成就|r，通过完成 |cffffff00限时活动|r 获得
    ]],
    
}
mt.skill_name ={
    '魔灵精品粽','真正的学霸','魔灵麒麟瓜','缘定三生','懂事的孩子','第一个吃螃蟹的人','四海共团圆','九洲帝王','有趣的灵魂','放炮小达人','兽魂之佑',
    '五福','归梦五行图','放了那只猪'
}

mt.skills = {
    -- '第一个吃螃蟹的人',
    '火把节'
}
local bobing_str = {
    '秀才','举人','进士','探花','榜眼','状元'
}
function mt:on_add()
    local hero = self.owner 
    local player = hero:get_owner()
    -- print('添加精彩活动',#self.skill_name)
    --已经在 最强魔灵处 处理
    -- for i=1,#self.skill_name do 
    --     local name = self.skill_name[i]
    --     local has_mall = player.mall[name] or (player.server and player.server[name])

    --     if has_mall and has_mall > 0 then 
    --         ac.game:event_notify('技能-插入魔法书',hero,'精彩活动',name)
    --         local skl = hero:find_skill(name,nil,true)
    --         skl:set_level(has_mall)
    --     end
    -- end 
    --特殊处理 博饼活动
    local key = 'bobing'
    local server_value = player.server and player.server[ac.server.key2name(key)] or 0
    if server_value > 0 then 
        local name = bobing_str[server_value]
        ac.game:event_notify('技能-插入魔法书',hero,'精彩活动',name)
    end
end    
