
local mt = ac.skill['士兵勋章']
mt{
    level = 0,
art = [[dengfengzaoji.blp]],
tip = [[

|cffffe799【获得方式】：|r
|cff00ff00通关难度-|cffffff00新的征程（一）-（五）|cff00ff00获得

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+350   杀怪加全属性|r
|cff00ff00+175   攻击减甲|r
|cff00ff00+100%  暴击伤害|r
|cff00ff00+50%   物理伤害加深|r
|cff00ff00+1      多重暴击|r

]],
['杀怪加全属性'] = 350,
['攻击减甲'] = 350,
}
local mt = ac.skill['骑士勋章']
mt{
    level = 0,
art = [[dengfengzaoji.blp]],
tip = [[

|cffffe799【获得方式】：|r
|cff00ff00通关难度-|cffffff00新的征程（一）-（五）|cff00ff00获得

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+350   杀怪加全属性|r
|cff00ff00+175   攻击减甲|r
|cff00ff00+100%  暴击伤害|r
|cff00ff00+50%   物理伤害加深|r
|cff00ff00+1      多重暴击|r

]],
['杀怪加全属性'] = 350,
['攻击减甲'] = 350,
}


local mt = ac.skill['主教勋章']
mt{
    level = 0,
art = [[dengfengzaoji.blp]],
tip = [[

|cffffe799【获得方式】：|r
|cff00ff00通关难度-|cffffff00新的征程（一）-（五）|cff00ff00获得

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+350   杀怪加全属性|r
|cff00ff00+175   攻击减甲|r
|cff00ff00+100%  暴击伤害|r
|cff00ff00+50%   物理伤害加深|r
|cff00ff00+1      多重暴击|r

]],
['杀怪加全属性'] = 350,
['攻击减甲'] = 350,
}


-- tgxz

local mt = ac.skill['通关勋章']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[fabao10.blp]],
    tip = [[

点击查看 |cff00ffff法宝|r，主要通过 |cffffff00不断挖宝|r 获得
    ]],
    
}
mt.skills = {
    '士兵勋章','骑士勋章','主教勋章'
}


local function save(tab)
    local index = tab[1]
    local rate = tab.rate
    for i=1,6 do 
        local p = ac.player(i)
        if p:is_player() then 
            index = 2^(index-1)
            --没有这个数据
            if not has_flag((p.server['通关勋章'] or 0),index) then
                --概率 受通关次数影响
                rate = rate + (p.server[ac.g_game_degree_name] or 0) * 5
                print('获得通关勋章1：',index,rate,tab[1],ac.g_game_degree_name)
                if math.random(100000)/1000 < rate then
                    local key = ac.server.name2key('通关勋章')
                    print('获得通关勋章2：',index,tab[1],ac.g_game_degree_name)
                    p:Map_AddServerValue(key,index)  
                end
            end
        end
    end
end

--注册获得
ac.game:event '游戏-结束' (function(trg,flag)
    if not flag then 
        return 
    end         
    if finds(ac.g_game_degree_name,'贪婪魔窟') then 
        return 
    end   
    if ac.g_game_degree_attr > 11 then 
        return 
    end
    local list = ac.server.get_tab('通关勋章')[3]
    -- local name = 
    local tab = list[ac.g_game_degree_name..'勋章']
    if tab then 
        -- print('勋章：',ac.g_game_degree_name..'勋章')
        save(tab)
    end
end)