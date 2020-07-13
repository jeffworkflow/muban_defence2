
local mt = ac.skill['救救孩子']
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



local mt = ac.skill['关爱萌新']
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


local mt = ac.skill['关爱萌新成就']
mt{
    is_spellbook = 1,
    is_order = 2,
    title = '关爱萌新成就',
    art = [[dashoucangjia.blp]],
    tip = [[

点击查看 |cff00ffff关爱萌新就|r，主要通过 |cffffff00不断挑战魔窟|r 获得
    ]],
    
}
mt.skills = {
    '救救孩子','关爱萌新',
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
                p:sendMsg('恭喜获得关爱萌新积分: '..val)
                print('恭喜获得关爱萌新积分: '..val)
            end
        end
    end
end)