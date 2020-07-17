
local mt = ac.skill['嗜血狂魔']
mt{
    level = 0,
art = [[sxkm.blp]],
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff杀戮值≥250%current%

|cffFFE799【成就属性】：|r
|cff00ff00+10% 暴击伤害|r
|cff00ff00+10% 技暴伤害|r
|cff00ff00+10% 会心伤害|r
|cff00ff00+10% 物理伤害加深|r
|cff00ff00+10% 技能伤害加深|r
|cff00ff00+10% 全伤加深|r
|cff00ff00+10% 对BOSS额外伤害|r

]],
need_map_level = 6,
current = function(self)
    local p = ac.player.self
    local val = p.server and p.server['魔灵争霸'] or 0
    local str = '|cffdf19d0（当前杀戮值：|cffffe799'..val..'|cffdf19d0）'
    return str
end,

['暴击伤害'] = 10,
['技暴伤害'] = 10,
['会心伤害'] = 10,
['物理伤害加深'] = 10,
['技能伤害加深'] = 10,
['全伤加深'] = 10,
['对BOSS额外伤害'] = 10,

}

local mt = ac.skill['小魔灵']
mt{
    level = 0,
art = [[mozhu.blp]],
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff杀戮值≥500%current%

|cffFFE799【成就属性】：|r
|cff00ff00+20% 暴击伤害|r
|cff00ff00+20% 技暴伤害|r
|cff00ff00+20% 会心伤害|r
|cff00ff00+20% 物理伤害加深|r
|cff00ff00+20% 技能伤害加深|r
|cff00ff00+20% 全伤加深|r
|cff00ff00+20% 对BOSS额外伤害|r

]],
need_map_level = 9,
current = function(self)
    local p = ac.player.self
    local val = p.server and p.server['魔灵争霸'] or 0
    local str = '|cffdf19d0（当前杀戮值：|cffffe799'..val..'|cffdf19d0）'
    return str
end,

['暴击伤害'] = 20,
['技暴伤害'] = 20,
['会心伤害'] = 20,
['物理伤害加深'] = 20,
['技能伤害加深'] = 20,
['全伤加深'] = 20,
['对BOSS额外伤害'] = 20,

}

local mt = ac.skill['魔灵之星']
mt{
    level = 0,
art = [[molingzx.blp]],
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff杀戮值≥1000%current%

|cffFFE799【成就属性】：|r
|cff00ff00+30% 暴击伤害|r
|cff00ff00+30% 技暴伤害|r
|cff00ff00+30% 会心伤害|r
|cff00ff00+30% 物理伤害加深|r
|cff00ff00+30% 技能伤害加深|r
|cff00ff00+30% 全伤加深|r
|cff00ff00+30% 对BOSS额外伤害|r

]],
need_map_level = 12,
current = function(self)
    local p = ac.player.self
    local val = p.server and p.server['魔灵争霸'] or 0
    local str = '|cffdf19d0（当前杀戮值：|cffffe799'..val..'|cffdf19d0）'
    return str
end,

['暴击伤害'] = 30,
['技暴伤害'] = 30,
['会心伤害'] = 30,
['物理伤害加深'] = 30,
['技能伤害加深'] = 30,
['全伤加深'] = 30,
['对BOSS额外伤害'] = 30,

}

local mt = ac.skill['绝世魔灵']
mt{
    level = 0,
art = [[mlzx.blp]],
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff杀戮值≥1500%current%

|cffFFE799【成就属性】：|r
|cff00ff00+40% 暴击伤害|r
|cff00ff00+40% 技暴伤害|r
|cff00ff00+40% 会心伤害|r
|cff00ff00+40% 物理伤害加深|r
|cff00ff00+40% 技能伤害加深|r
|cff00ff00+40% 全伤加深|r
|cff00ff00+40% 对BOSS额外伤害|r

]],
need_map_level = 15,
current = function(self)
    local p = ac.player.self
    local val = p.server and p.server['魔灵争霸'] or 0
    local str = '|cffdf19d0（当前杀戮值：|cffffe799'..val..'|cffdf19d0）'
    return str
end,

['暴击伤害'] = 40,
['技暴伤害'] = 40,
['会心伤害'] = 40,
['物理伤害加深'] = 40,
['技能伤害加深'] = 40,
['全伤加深'] = 40,
['对BOSS额外伤害'] = 40,

}

local mt = ac.skill['威震三界']
mt{
    level = 0,
art = [[sanjiaomo.blp]],
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff杀戮值≥2500%current%

|cffFFE799【成就属性】：|r
|cff00ff00+50% 暴击伤害|r
|cff00ff00+50% 技暴伤害|r
|cff00ff00+50% 会心伤害|r
|cff00ff00+50% 物理伤害加深|r
|cff00ff00+50% 技能伤害加深|r
|cff00ff00+50% 全伤加深|r
|cff00ff00+50% 对BOSS额外伤害|r

]],
need_map_level = 18,
current = function(self)
    local p = ac.player.self
    local val = p.server and p.server['魔灵争霸'] or 0
    local str = '|cffdf19d0（当前杀戮值：|cffffe799'..val..'|cffdf19d0）'
    return str
end,

['暴击伤害'] = 50,
['技暴伤害'] = 50,
['会心伤害'] = 50,
['物理伤害加深'] = 50,
['技能伤害加深'] = 50,
['全伤加深'] = 50,
['对BOSS额外伤害'] = 50,

}

local mt = ac.skill['灭世魔星']
mt{
    level = 0,
art = [[moxing.blp]],
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff杀戮值≥3500%current%

|cffFFE799【成就属性】：|r
|cff00ff00+60% 暴击伤害|r
|cff00ff00+60% 技暴伤害|r
|cff00ff00+60% 会心伤害|r
|cff00ff00+60% 物理伤害加深|r
|cff00ff00+60% 技能伤害加深|r
|cff00ff00+60% 全伤加深|r
|cff00ff00+60% 对BOSS额外伤害|r

]],
need_map_level = 21,
current = function(self)
    local p = ac.player.self
    local val = p.server and p.server['魔灵争霸'] or 0
    local str = '|cffdf19d0（当前杀戮值：|cffffe799'..val..'|cffdf19d0）'
    return str
end,

['暴击伤害'] = 60,
['技暴伤害'] = 60,
['会心伤害'] = 60,
['物理伤害加深'] = 60,
['技能伤害加深'] = 60,
['全伤加深'] = 60,
['对BOSS额外伤害'] = 60,

}



local mt = ac.skill['魔灵争霸成就']
mt{
    is_spellbook = 1,
    is_order = 2,
    title = '魔灵争霸',
    art = [[molingzhengba.blp]],
    tip = [[

点击查看 |cff00ffff魔灵争霸成就|r，主要通过 |cffffff00不断PK|r 获得

|cffebb608【说明】|r
|cff00ff00在魔灵争霸模式中，|cff00ffff击杀其它玩家|cff00ff00，能获得|cffffff00可存档的杀戮值

|cffff0000当杀戮值达到一定值，能自动解锁可存档成就
 ]],
    
}
mt.skills = {
    '嗜血狂魔','小魔灵','魔灵之星','绝世魔灵','威震三界','灭世魔星',
}
local function get_player_cnt_bylv(lv)
    local lv = lv or 1 
    local cnt = 0
    for i=1,10 do 
        local p = ac.player(i)
        if p:is_player() then 
            if p:Map_GetMapLevel() < lv then 
                cnt = cnt + 1
            end
        end
    end
    return cnt
end