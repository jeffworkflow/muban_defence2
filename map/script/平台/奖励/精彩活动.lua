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


local mt = ac.skill['精彩活动']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[huodongchengjiu.blp]],
    title = '活动成就',
    tip = [[

点击查看 |cff00ffff活动成就|r，通过完成 |cffffff00限时活动|r 获得
    ]],
    
}
mt.skill_name ={
    '魔灵精品粽','真正的学霸','魔灵麒麟瓜',
}

mt.skills = {
    -- '第一个吃螃蟹的人',
    '火把节'
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
end    
