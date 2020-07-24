local mt = ac.skill['精英版奖励1']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
title = '挖宝熟练度',
--图标
art = [[chanzi.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00累计获得|cff00ffff一个荣耀战令|cff00ff00后获得 

|cffFFE799【成就属性】：|r
|cff00ff00+5000   |cff00ff00挖宝熟练度|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['全属性'] = 200000,
need_map_level = 5,
}


local mt = ac.skill['进阶版奖励1']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
--图标
art = [[fadajing.blp]],
title = '看书熟练度',
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ff00购买商城道具|cffffff00【赛季通行证】
|cff00ff00累计获得|cff00ffff一个荣耀战令|cff00ff00后获得 

|cffFFE799【成就属性】：|r
|cff00ff00+5000   |cff00ff00看书熟练度|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['全属性'] = 200000,
need_map_level = 5,
}

for i,name in ipairs({'精英版奖励1','精英版奖励2','精英版奖励3'}) do 
    local mt = ac.skill[name]
    function mt:on_add()
        local hero = self.owner
        local p = hero.owner
        local name = self.name:gsub('精英版','进阶版') 
        print('动态插入数据1:',name)
        if (p.mall['S0赛季通行证'] or 0 ) > 0 then 
            print('动态插入数据2:',name)
            ac.game:event_notify('技能-插入魔法书',hero,'荣耀赛季',name)
        end
    end
end

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
    '精英版奖励1','精英版奖励2','精英版奖励3',
    -- '进阶版本奖励1','进阶版本奖励2','进阶版本奖励3',
}

mt.skills = {
    -- '第一个吃螃蟹的人',
}

