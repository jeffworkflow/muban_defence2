local mt = ac.skill['新的征程']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[BTNzc.blp]],
    title = '新的征程',
    tip = [[

点击查看 |cff00ffff新的征程|r，通过通关 |cffffff00超高难度|r 获得
    ]],
    
}
mt.skills = {
    '新的征程1','新的征程2','新的征程3','新的征程4','新的征程5','新的征程6','新的征程7','新的征程8',
} 
function mt:on_add()
    local hero = self.owner 
    local p = hero:get_owner()
    --黑名单和反作弊处理 有26则视为
    local flag_val = 26
    if has_flag(p.server['新的征程奖励'],2^(flag_val-1)) or not ac.flag_use_mall then
        return 
    end
    for index,skill in ipairs(self.skill_book) do 
        local min = tonumber(string.sub(skill.name,13, -1))
        local page_count = 3
        min =  (min -1)*page_count+1
        local max = min + page_count - 1
         
        local content = ''
        local ok_cnt = 0 
        for i = min,max do 
            --有毕业 则 cid ac.peon_list
            if has_flag(p.server['新的征程奖励'],2^(i-1)) then 
                content = content ..'|cff00ff00通关难度-新的征程（'..formatNumber(i)..'）|r \n'
                ok_cnt = ok_cnt + 1
            else
                content = content ..'|cffcccccc通关难度-新的征程（'..formatNumber(i)..'）|r \n'
            end        
        end    
        skill:set('content',content)
        skill:fresh_tip()
        if ok_cnt == page_count then 
            skill:set_level(1)
        end    
    end     
end    

--所有属性
local mt = ac.skill['新的征程1']
mt['杀怪加全属性'] = 350
mt['攻击减甲'] = 175
mt['暴击伤害'] = 100
mt['物理伤害加深'] = 50
mt['多重暴击'] = 1

mt{
title = '登峰造极',
art = [[dengfengzaoji.blp]],
tip = [[

%content%
|cffffe799【获得方式】：|r
|cff00ff00通关难度-|cffffff00新的征程（一）-（三）|cff00ff00获得

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+350   杀怪加全属性|r
|cff00ff00+175   攻击减甲|r
|cff00ff00+100%  暴击伤害|r
|cff00ff00+50%   物理伤害加深|r
|cff00ff00+1      多重暴击|r

]],
content = '',
}

local mt = ac.skill['新的征程2']
mt['杀怪加全属性'] = 450
mt['攻击减甲'] = 225
mt['技暴伤害'] = 100
mt['技能伤害加深'] = 50
mt['对BOSS额外伤害'] = 25
mt{
title = '返璞归真',
art = [[fanpuguizhen.blp]],
tip = [[

%content%
|cffffe799【获得方式】：|r
|cff00ff00通关难度-|cffffff00新的征程（四）-（六）|cff00ff00获得

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+450   杀怪加全属性|r
|cff00ff00+225   攻击减甲|r
|cff00ff00+100%  技暴伤害|r
|cff00ff00+50%   技能伤害加深|r
|cff00ff00+25%   对BOSS额外伤害|r

]],
content = '',
}



local mt = ac.skill['新的征程3']
mt['杀怪加全属性'] = 550
mt['攻击减甲'] = 275
mt['会心伤害'] = 100
mt['全伤加深'] = 50
mt{
title = '破碎虚空',
art = [[posuixukong.blp]],
tip = [[

%content%
|cffffe799【获得方式】：|r
|cff00ff00通关难度-|cffffff00新的征程（七）-（九）|cff00ff00获得

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+550   杀怪加全属性|r
|cff00ff00+275   攻击减甲|r
|cff00ff00+100%  会心伤害|r
|cff00ff00+50%   全伤加深|r

]],
content = '',
}

local mt = ac.skill['新的征程4']
mt['杀怪加全属性'] = 600
mt['攻击减甲'] = 300
mt['暴击伤害'] = 200
mt['物理伤害加深'] = 100
mt['多重暴击'] = 1
mt{
title = '万界破灭',
art = [[wjpm.blp]],
tip = [[

%content%
|cffffe799【获得方式】：|r
|cff00ff00通关难度-|cffffff00新的征程（十）-（十二）|cff00ff00获得

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+600   杀怪加全属性|r
|cff00ff00+300   攻击减甲|r
|cff00ff00+200%  暴击伤害|r
|cff00ff00+100%  物理伤害加深|r
|cff00ff00+1     多重暴击|r

]],
content = '',
}

local mt = ac.skill['新的征程5']
mt['杀怪加全属性'] = 650
mt['攻击减甲'] = 325
mt['技暴伤害'] = 200
mt['技能伤害加深'] = 100
mt['对BOSS额外伤害'] = 50
mt{
title = '神界初现',
art = [[sjcx.blp]],
tip = [[

%content%
|cffffe799【获得方式】：|r
|cff00ff00通关难度-|cffffff00新的征程（十三）-（十五）|cff00ff00获得

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+650   杀怪加全属性|r
|cff00ff00+325   攻击减甲|r
|cff00ff00+200%  技暴伤害|r
|cff00ff00+100%  技能伤害加深|r
|cff00ff00+50%   对BOSS额外伤害|r

]],
content = '',
}




local mt = ac.skill['新的征程6']
mt['杀怪加全属性'] = 700
mt['攻击减甲'] = 350
mt['会心伤害'] = 200
mt['全伤加深'] = 100

mt{
title = '与神之战',
art = [[yszz.blp]],
tip = [[

%content%
|cffffe799【获得方式】：|r
|cff00ff00通关难度-|cffffff00新的征程（十六）-（十八）|cff00ff00获得

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+700   杀怪加全属性|r
|cff00ff00+350   攻击减甲|r
|cff00ff00+200%  会心伤害|r
|cff00ff00+100%  全伤加深|r

]],
content = '',
}


local mt = ac.skill['新的征程7']
mt['杀怪加全属性'] = 750
mt['攻击减甲'] = 375
mt['暴击伤害'] = 400
mt['物理伤害加深'] = 200
mt['多重暴击'] = 1
mt{
title = '踏破神界',
art = [[tpsj.blp]],
tip = [[

%content%
|cffffe799【获得方式】：|r
|cff00ff00通关难度-|cffffff00新的征程（十九）-（二十一）|cff00ff00获得

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+750   杀怪加全属性|r
|cff00ff00+375   攻击减甲|r
|cff00ff00+400%  暴击伤害|r
|cff00ff00+200%  物理伤害加深|r
|cff00ff00+1     多重暴击|r

]],
content = '',
}

local mt = ac.skill['新的征程8']
mt['杀怪加全属性'] = 800
mt['攻击减甲'] = 400
mt['技暴伤害'] = 400
mt['技能伤害加深'] = 200
mt['对BOSS额外伤害'] = 100
mt{
title = '洞天真相',
art = [[dtzx.blp]],
tip = [[

%content%
|cffffe799【获得方式】：|r
|cff00ff00通关难度-|cffffff00新的征程（二十二）-（二十四）|cff00ff00获得

|cffffe799【成就属性】|r:|cff00ff00
|cff00ff00+800   杀怪加全属性|r
|cff00ff00+400   攻击减甲|r
|cff00ff00+400%  技暴伤害|r
|cff00ff00+200%  技能伤害加深|r
|cff00ff00+100%  对BOSS额外伤害|r

]],
content = '',
}




for i=1,10 do 
    local mt = ac.skill['新的征程'..i]
    mt{
    --等级
    level = 0,
    max_level = 1,
    strong_hero = 1, --作用在人身上
    --图标
    -- art = [[ReplaceableTextures\CommandButtons\BTNStormEarth&Fire.blp]],
    --说明
    -- tip = [[

-- %content%
-- %attr_tip%|r]],
    content = '',
    attr_tip = function(self)
        local tip = '|cff00ffff集齐后激活【赏金猎人】，增加属性:\n|cff00ff00'
        for key,val in sortpairs(ac.unit.attribute) do 
            if self[key] then  
                local per_str = finds(ac.base_attr,key)  and '' or '%'
                if self[key] < 0 then 
                    tip = tip  ..""..bignum2string(self[key])..per_str..' '.. key ..'\n'
                else     
                    tip = tip  .."+"..bignum2string(self[key])..per_str..' '.. key ..'\n'
                end    
            end
        end        
        return tip
    end
    }
end    


local function save_cwjnc() 
    for i=1,6 do 
        local p = ac.player(i)
        if p:is_player() then 
            local val = 2^(p.peon.data.cid -1)
            local key = ac.server.name2key('新的征程')
            if not has_flag(p.server['新的征程'],val) then 
                -- print('宠物毕业:',p.peon.data.cid,p.peon:get_name())
                p:Map_AddServerValue(key,val)
            end    
        end
    end
end
--注册获得方式 难二以上，游戏胜利激活
ac.game:event '游戏-结束' (function(trg,flag)
    if not flag then 
        return 
    end   
    if ac.g_game_degree_attr < 2 then 
        return 
    end   
    save_cwjnc() 
end)
--无尽开始
ac.game:event '游戏-无尽开始'(function(trg) 
    save_cwjnc()
end)


