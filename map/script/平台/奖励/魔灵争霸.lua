
local mt = ac.skill['嗜血狂魔']
mt{
    level = 0,
art = [[jjhz.blp]],
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff爱心积分≥1000%current%

|cffFFE799【成就属性】：|r
|cff00ff00+50  杀怪加全属性|r
|cff00ff00+25  攻击减甲|r
|cff00ff00+5   每秒加护甲|r
|cff00ff00+10% 对BOSS额外伤害|r

]],
need_map_level = 10,
current = function(self)
    local p = ac.player.self
    local val = p.server and p.server['爱心积分'] or 0
    local str = '|cffdf19d0（当前爱心积分：|cffffe799'..val..'|cffdf19d0）'
    return str
end,

['杀怪加全属性'] = 50,
['攻击减甲'] = 25,
['每秒加护甲'] = 5,
['对BOSS额外伤害'] = 10,

}



local mt = ac.skill['小魔灵']
mt{
    level = 0,
art = [[mengxin.blp]],
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff爱心积分≥2500%current%

|cffFFE799【成就属性】：|r
|cff00ff00+100  杀怪加全属性|r
|cff00ff00+50  攻击减甲|r
|cff00ff00+10   每秒加护甲|r
|cff00ff00+20% 对BOSS额外伤害|r

]],
need_map_level = 12,
current = function(self)
    local p = ac.player.self
    local val = p.server and p.server['爱心积分'] or 0
    local str = '|cffdf19d0（当前爱心积分：|cffffe799'..val..'|cffdf19d0）'
    return str
end,

['杀怪加全属性'] = 100,
['攻击减甲'] = 50,
['每秒加护甲'] = 10,
['对BOSS额外伤害'] = 20,

}



local mt = ac.skill['魔灵争霸成就']
mt{
    is_spellbook = 1,
    is_order = 2,
    title = '魔灵争霸',
    art = [[mengxin.blp]],
    tip = [[

点击查看 |cff00ffff关爱萌新成就|r，主要通过 |cffffff00不断带萌新通关|r 获得

|cffebb608【说明】|r
|cff00ff00老司机|cffffff00（地图等级≥10的玩家）|cff00ff00带萌新|cffffff00（地图等级≤5的玩家）|cff00ff00通关，能获得可存档的爱心积分

|cffff0000当爱心积分达到一定值，能自动解锁可存档成就
    
|cffcccccc（萌新数量越多、游戏难度越高，获得的爱心积分越多）]],
    
}
mt.skills = {
    '嗜血狂魔','小魔灵',
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