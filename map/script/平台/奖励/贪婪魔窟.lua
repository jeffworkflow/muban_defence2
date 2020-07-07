
local mt = ac.skill['开拓者']
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
local mt = ac.skill['冒险家']
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

local mt = ac.skill['拾荒者']
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

local mt = ac.skill['贪婪魔窟']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[fabao10.blp]],
    tip = [[

点击查看 |cff00ffff法宝|r，主要通过 |cffffff00不断挖宝|r 获得
    ]],
    
}
mt.skills = {
    '开拓者','冒险家','大冒险家','冒险大师',
    '拾荒者','拾荒狂魔','收藏家','大收藏家',
}
