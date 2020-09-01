local mt = ac.skill['荣耀赛季']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[sjjl.blp]],
    -- title = '荣耀赛季',
    tip = [[

点击查看 |cff00ffff赛季成就|r，通过完成 |cffffff00赛季活动|r 获得
|cffffff00（按F7可打开赛季说明）
    ]],
    
}
mt.skill_name ={
    -- 'S1精英版奖励1','S1精英版奖励2','S1精英版奖励3',
    -- '进阶版本奖励1','进阶版本奖励2','进阶版本奖励3',
}

mt.skills = {
    -- '第一个吃螃蟹的人',
    'S0赛季','S1赛季','S2赛季'
}

local mt = ac.skill['S0赛季王者']
mt{
--等级
level = 1, --要动态插入
--图标
art = [[s0sjwz.blp]],
--说明
tip = [[

|cffFFE799【获得方式】：|r
|cff00ff00赛季结束时，所有在 |cffff0000F5/F6排行榜 |cff00ff00上面的玩家，均可获得|cffdf19d0（获得后切勿改名，改名会清零）|r

|cffFFE799【成就属性】：|r
|cff00ff00+88.8   杀怪加全属性|r
|cff00ff00+88.8   攻击减甲|r
|cff00ff00+1%     会心几率|r
|cff00ff00+20%   会心伤害|r
|cff00ff00+38.8% 全伤加深|r
|cffff0000局内地图等级+1

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 88.8,
['攻击减甲'] = 88.8,
['会心几率'] = 1,
['会心伤害'] = 20,
['全伤加深'] = 38.8
}


local mt = ac.skill['S0赛季']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[S0saijitxz.blp]],
    -- title = 'S0赛季',
    tip = [[

点击查看 |cff00ffffS0赛季成就|r
    ]],
    
}
mt.skill_name ={
    'S0赛季王者','精英版奖励1','精英版奖励2','精英版奖励3',
    -- '进阶版本奖励1','进阶版本奖励2','进阶版本奖励3',
}
mt.skills = {
    -- '第一个吃螃蟹的人',
}

local mt = ac.skill['S1赛季']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[s1sjwz.blp]],
    -- title = 'S0赛季',
    tip = [[

点击查看 |cff00ffffS1赛季成就|r
    ]],
    
}
mt.skill_name ={
    'S1赛季王者',
    'S1精英版奖励1','S1精英版奖励2','S1精英版奖励3','S1精英版奖励4',
    'S1精英版奖励5','S1精英版奖励6','S1精英版奖励7','S1精英版奖励8',
    'S1精英版奖励9','S1精英版奖励10','S1精英版奖励11','S1精英版奖励12',
    'S1精英版奖励13','S1精英版奖励14','S1精英版奖励15',
}
mt.skills = {
    -- '第一个吃螃蟹的人',
}

local mt = ac.skill['S2赛季']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[s2sjwz.blp]],
    -- title = 'S0赛季',
    tip = [[

点击查看 |cff00ffffS2赛季成就|r
    ]],
    
}
mt.skill_name ={
    'S2赛季王者',
    'S2精英版奖励1','S2精英版奖励2','S2精英版奖励3','S2精英版奖励4',
    'S2精英版奖励5','S2精英版奖励6','S2精英版奖励7','S2精英版奖励8',
    'S2精英版奖励9','S2精英版奖励10','S2精英版奖励11','S2精英版奖励12',
    'S2精英版奖励13','S2精英版奖励14','S2精英版奖励15',
}
mt.skills = {
    -- '第一个吃螃蟹的人',
}