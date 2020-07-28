
local mt = ac.skill['完美的士兵勋章']
mt{
    level = 0,
art = [[shibing.blp]],
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00通关|cff00ffff士兵|cff00ff00有概率召唤|cffffff00最强魔帝|cff00ff00，击败后可获得

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+50 杀怪加全属性|r
|cff00ff00+25 攻击减甲|r
|cff00ff00+25% 攻击速度|r
|cff00ff00+25% 分裂伤害|r

]],
need_map_level = 5,
['杀怪加全属性'] = 50,
['攻击减甲'] = 25,
['分裂伤害'] = 25,
['攻击速度'] = 25,

}
local mt = ac.skill['完美的骑士勋章']
mt{
    level = 0,
art = [[qishi.blp]],
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00通关|cff00ffff骑士|cff00ff00有概率召唤|cffffff00最强魔帝|cff00ff00，击败后可获得

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+75 杀怪加全属性|r
|cff00ff00+50 攻击减甲|r
|cff00ff00+500 减少周围护甲|r
|cff00ff00+25% 物理伤害加深|r

]],
need_map_level = 6,
['杀怪加全属性'] = 75,
['攻击减甲'] = 50,
['减少周围护甲'] = 500,
['物理伤害加深'] = 25,

}

local mt = ac.skill['完美的主教勋章']
mt{
    level = 0,
art = [[zhujiao.blp]],
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00通关|cff00ffff主教|cff00ff00有概率召唤|cffffff00最强魔帝|cff00ff00，击败后可获得

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+100 杀怪加全属性|r
|cff00ff00+50 攻击减甲|r
|cff00ff00+5  每秒加木头|r
|cff00ff00+5 每秒加魔丸|r

]],
need_map_level = 7,
['杀怪加全属性'] = 100,
['攻击减甲'] = 50,
['每秒加木头'] = 5,
['每秒加魔丸'] = 5,

}


local mt = ac.skill['完美的堡垒勋章']
mt{
    level = 0,
art = [[baolei.blp]],
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00通关|cff00ffff堡垒|cff00ff00有概率召唤|cffffff00最强魔帝|cff00ff00，击败后可获得

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+125 杀怪加全属性|r
|cff00ff00+75 攻击减甲|r
|cff00ff00+5% 攻击|r
|cff00ff00+5  每秒加护甲|r

]],
need_map_level = 8,
['杀怪加全属性'] = 125,
['攻击减甲'] = 75,
['攻击%'] = 5,
['每秒加护甲'] = 5,

}

local mt = ac.skill['完美的国王勋章']
mt{
    level = 0,
art = [[guowang.blp]],
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00通关|cff00ffff国王|cff00ff00有概率召唤|cffffff00最强魔帝|cff00ff00，击败后可获得

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+150 杀怪加全属性|r
|cff00ff00+75  攻击减甲|r
|cff00ff00+5%  护甲|r
|cff00ff00+5%  每秒回血|r

]],
need_map_level = 9,
['杀怪加全属性'] = 150,
['攻击减甲'] = 75,
['护甲%'] = 5,
['每秒回血'] = 5,

}

local mt = ac.skill['完美的皇后勋章']
mt{
    level = 0,
art = [[huanghou.blp]],
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00通关|cff00ffff皇后|cff00ff00有概率召唤|cffffff00最强魔帝|cff00ff00，击败后可获得

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+175  杀怪加全属性|r
|cff00ff00+100  攻击减甲|r
|cff00ff00+1000 减少周围护甲|r
|cff00ff00-0.05 攻击间隔|r

]],
need_map_level = 10,
['杀怪加全属性'] = 175,
['攻击减甲'] = 100,
['减少周围护甲'] = 1000,
['攻击间隔'] = -0.05,

}

local mt = ac.skill['完美的传奇勋章']
mt{
    level = 0,
art = [[chuanqi.blp]],
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00通关|cff00ffff传奇|cff00ff00有概率召唤|cffffff00最强魔帝|cff00ff00，击败后可获得

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+200 杀怪加全属性|r
|cff00ff00+100 攻击减甲|r
|cff00ff00+5% 敏捷|r
|cff00ff00+50 攻击距离|r

]],
need_map_level = 11,
['杀怪加全属性'] = 200,
['攻击减甲'] = 100,
['敏捷%'] = 5,
['攻击距离'] = 50,

}

local mt = ac.skill['完美的万古流芳勋章']
mt{
    level = 0,
art = [[wanguliufang.blp]],
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00通关|cff00ffff万古流芳|cff00ff00有概率召唤|cffffff00最强魔帝|cff00ff00，击败后可获得

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+225 杀怪加全属性|r
|cff00ff00+125 攻击减甲|r
|cff00ff00+10% 攻击|r
|cff00ff00+2   多重射|r

]],
need_map_level = 12,
['杀怪加全属性'] = 225,
['攻击减甲'] = 125,
['攻击%'] = 10,
['多重射'] = 2,

}

local mt = ac.skill['完美的超凡入圣勋章']
mt{
    level = 0,
art = [[chaofanrusheng.blp]],
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00通关|cff00ffff超凡入圣|cff00ff00有概率召唤|cffffff00最强魔帝|cff00ff00，击败后可获得

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+250 杀怪加全属性|r
|cff00ff00+125 攻击减甲|r
|cff00ff00+5%  智力|r
|cff00ff00+25% 技能伤害加深|r

]],
need_map_level = 13,
['杀怪加全属性'] = 250,
['攻击减甲'] = 125,
['技能伤害加深'] = 25,
['智力%'] = 5,

}

local mt = ac.skill['完美的冠世一绝勋章']
mt{
    level = 0,
art = [[guanshiyijue.blp]],
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00通关|cff00ffff冠世一绝|cff00ff00有概率召唤|cffffff00最强魔帝|cff00ff00，击败后可获得

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+275 杀怪加全属性|r
|cff00ff00+150 攻击减甲|r
|cff00ff00+25  每秒加护甲|r
|cff00ff00+5%  力量|r
|cff00ff00+25% 全伤加深|r

]],
need_map_level = 14,
['杀怪加全属性'] = 275,
['攻击减甲'] = 150,
['力量%'] = 5,
['每秒加护甲'] = 25,
['全伤加深'] = 25,

}

local mt = ac.skill['完美的超绝群伦勋章']
mt{
    level = 0,
art = [[chaojuequnlun.blp]],
tip = [[|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00通关|cff00ffff超绝群伦|cff00ff00有概率召唤|cffffff00最强魔帝|cff00ff00，击败后可获得

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+300 杀怪加全属性|r
|cff00ff00+150 攻击减甲|r
|cff00ff00+25  移动速度|r
|cff00ff00+15% 对BOSS额外伤害|r
|cff00ff00+1   多重暴击|r

]],
need_map_level = 15,
['杀怪加全属性'] = 300,
['攻击减甲'] = 150,
['移动速度'] = 25,
['对BOSS额外伤害'] = 15,
['多重暴击'] = 1,

}



-- tgxz

local mt = ac.skill['完美的通关勋章']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[shibing.blp]],
    tip = [[

点击查看|cff00ffff完美的通关勋章|r|cffffff00（每次通关有概率召唤最强魔帝，击败后可获得对应难度的完美勋章）
 ]],
    
}
mt.skills = {
    '完美的士兵勋章','完美的骑士勋章','完美的主教勋章','完美的堡垒勋章',
    '完美的国王勋章','完美的皇后勋章','完美的传奇勋章','完美的万古流芳勋章',
    '完美的超凡入圣勋章','完美的冠世一绝勋章','完美的超绝群伦勋章'
}


local function save(tab)
    for i=1,6 do 
        local p = ac.player(i)
        if p:is_player() then 
            local index = tab[1]
            local rate = tab.rate
            index = 2^(index-1)
            --没有这个数据
            if not has_flag((p.server['完美的通关勋章'] or 0),index) then
                local key = ac.server.name2key('完美的通关勋章')
                print('获得完美的通关勋章2：',p,index,rate,tab[1],ac.g_game_degree_name)

                p:sendMsg('|cffebb608【系统】|r|cffff0000运气爆棚！！！恭喜获得本难度的勋章！|cff00ff00勋章的属性可在最强魔灵-通关难度奖励-通关勋章中查看！',8)

                p:Map_AddServerValue(key,index)  
            end
        end
    end
end

--注册获得
ac.game:event '杀死最强魔帝' (function(trg,flag)
    -- if not flag then 
    --     return 
    -- end         
    if finds(ac.g_game_degree_name,'贪婪魔窟') then 
        return 
    end   
    if ac.g_game_degree_attr > 11 then 
        return 
    end
    local list = ac.server.get_tab('完美的通关勋章')[3]
    -- local name = 
    local tab = list['完美的'..ac.g_game_degree_name..'勋章']
    if tab then 
        -- print('完美的勋章：',ac.g_game_degree_name..'勋章')
        -- print_r(tab)
        save(tab)
    end
end)