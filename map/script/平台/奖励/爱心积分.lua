
local mt = ac.skill['救救孩子']
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



local mt = ac.skill['关爱萌新']
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

local mt = ac.skill['新人辅导员']
mt{
    level = 0,
art = [[xrfdy.blp]],
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff爱心积分≥5000%current%

|cffFFE799【成就属性】：|r
|cff00ff00+150  杀怪加全属性|r
|cff00ff00+75  攻击减甲|r
|cff00ff00+15   每秒加护甲|r
|cff00ff00+30% 对BOSS额外伤害|r

]],
need_map_level = 14,
current = function(self)
    local p = ac.player.self
    local val = p.server and p.server['爱心积分'] or 0
    local str = '|cffdf19d0（当前爱心积分：|cffffe799'..val..'|cffdf19d0）'
    return str
end,

['杀怪加全属性'] = 150,
['攻击减甲'] = 75,
['每秒加护甲'] = 15,
['对BOSS额外伤害'] = 30,

}

local mt = ac.skill['无私奉献']
mt{
    level = 0,
art = [[wsfx.blp]],
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff爱心积分≥10000%current%

|cffFFE799【成就属性】：|r
|cff00ff00+200  杀怪加全属性|r
|cff00ff00+100  攻击减甲|r
|cff00ff00+20   每秒加护甲|r
|cff00ff00+40% 对BOSS额外伤害|r

]],
need_map_level = 16,
current = function(self)
    local p = ac.player.self
    local val = p.server and p.server['爱心积分'] or 0
    local str = '|cffdf19d0（当前爱心积分：|cffffe799'..val..'|cffdf19d0）'
    return str
end,

['杀怪加全属性'] = 200,
['攻击减甲'] = 100,
['每秒加护甲'] = 20,
['对BOSS额外伤害'] = 40,

}

local mt = ac.skill['爱心之星']
mt{
    level = 0,
art = [[axzx.blp]],
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff爱心积分≥20000%current%

|cffFFE799【成就属性】：|r
|cff00ff00+250  杀怪加全属性|r
|cff00ff00+125  攻击减甲|r
|cff00ff00+25   每秒加护甲|r
|cff00ff00+50% 对BOSS额外伤害|r

]],
need_map_level = 18,
current = function(self)
    local p = ac.player.self
    local val = p.server and p.server['爱心积分'] or 0
    local str = '|cffdf19d0（当前爱心积分：|cffffe799'..val..'|cffdf19d0）'
    return str
end,

['杀怪加全属性'] = 250,
['攻击减甲'] = 125,
['每秒加护甲'] = 25,
['对BOSS额外伤害'] = 50,

}

local mt = ac.skill['爱心大使']
mt{
    level = 0,
art = [[axds.blp]],
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff爱心积分≥30000%current%

|cffFFE799【成就属性】：|r
|cff00ff00+300  杀怪加全属性|r
|cff00ff00+150  攻击减甲|r
|cff00ff00+30   每秒加护甲|r
|cff00ff00+60% 对BOSS额外伤害|r

]],
need_map_level = 20,
current = function(self)
    local p = ac.player.self
    local val = p.server and p.server['爱心积分'] or 0
    local str = '|cffdf19d0（当前爱心积分：|cffffe799'..val..'|cffdf19d0）'
    return str
end,

['杀怪加全属性'] = 300,
['攻击减甲'] = 150,
['每秒加护甲'] = 30,
['对BOSS额外伤害'] = 60,

}


local mt = ac.skill['关爱萌新成就']
mt{
    is_spellbook = 1,
    is_order = 2,
    title = '关爱萌新',
    art = [[mengxin.blp]],
    tip = [[

点击查看 |cff00ffff关爱萌新成就|r，主要通过 |cffffff00不断带萌新通关|r 获得

|cffebb608【说明】|r
|cff00ff00老司机|cffffff00（地图等级≥10的玩家）|cff00ff00带萌新|cffffff00（地图等级≤7的玩家）|cff00ff00通关，能获得可存档的爱心积分

|cffff0000当爱心积分达到一定值，能自动解锁可存档成就
    
|cffcccccc（萌新数量越多、游戏难度越高，获得的爱心积分越多）]],
    
}
mt.skills = {
    '救救孩子','关爱萌新','新人辅导员','无私奉献','爱心之星','爱心大使',
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
--注册 获得关爱萌新 积分
ac.game:event '游戏-结束' (function(trg,flag)
    if not flag then 
        return 
    end         
    --地图等级>5的玩家数
    local name = '爱心积分'
    local key = ac.server.name2key(name)
    local cnt = get_player_cnt_bylv(5)
    local val = cnt *100 * (0.2*ac.g_game_degree_attr+0.8)
    --保存
    if val <=0 then 
        return 
    end
    for i=1,10 do 
        local p = ac.player(i)
        if p:is_player() then 
            if p:Map_GetMapLevel() >= 10 then 
                --网易服务器
                p:Map_AddServerValue(key,val)

                --保存到自己的服务器    
                --凌晨数据弄为0 
                p:clear_key('today_'..key)
                --今日累计榜
                p:AddServerValue('today_'..key,val) 
                --累计总榜
                p:AddServerValue(key,val) 
                p:sendMsg('|cffebb608【系统】|r|cff00ff00本次通关获得爱心积分: |cffff0000'..val)
                print('恭喜获得关爱萌新积分: '..val)
            end
        end
    end
end)