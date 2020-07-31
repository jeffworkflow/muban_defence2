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
    'S0赛季','S1赛季'
}

for i=0,10 do 
local mt = ac.skill['S'..i..'赛季王者']
mt{
--等级
level = 1, --要动态插入
--图标
art = [[sj02.blp]],
--说明
tip = [[

|cffFFE799【获得方式】：|r
|cff00ff00赛季结束时，所有在 |cffff0000F5-巅峰排行榜、F5-通关时长排行榜、 F6-无尽总排行榜、F6-挖宝总排行榜 |cff00ff00上面的玩家，均可获得

|cffFFE799【成就属性】：|r
|cff00ff00+36.8   杀怪加全属性|r
|cff00ff00+36.8   攻击减甲|r
|cff00ff00+1%     会心几率|r
|cff00ff00+10%    会心伤害|r
|cff00ff00+16.8%  全伤加深|r
|cffff0000局内地图等级+1

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 36.8,
['攻击减甲'] = 36.8,
['会心几率'] = 1,
['会心伤害'] = 10,
['全伤加深'] = 16.8
}
end


local mt = ac.skill['S0赛季']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[sjjl.blp]],
    -- title = 'S0赛季',
    tip = [[

点击查看 |cff00ffff赛季成就|r，通过完成 |cffffff00赛季活动|r 获得
|cffffff00（按F7可打开赛季说明）
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
    art = [[sjjl.blp]],
    -- title = 'S0赛季',
    tip = [[

点击查看 |cff00ffff赛季成就|r，通过完成 |cffffff00赛季活动|r 获得
|cffffff00（按F7可打开赛季说明）
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
