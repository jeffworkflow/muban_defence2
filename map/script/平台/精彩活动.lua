local mt = ac.skill['魔灵精品粽']
mt{
--等级
level = 1, --要动态插入
max_level = 5, --要动态插入
--图标
art = [[mljpz.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff端午节活动获得 |cffff0000重复完成可升级成就|r |cff00ffff最大等级=5

|cffFFE799【成就属性】：|r
|cff00ff00+%全属性%   |cff00ff00全属性|r
|cff00ff00+%攻击减甲%   |cff00ff00攻击减甲|r
|cff00ff00+%每秒加护甲%   |cff00ff00每秒加护甲|r
|cff00ff00+%全伤加深% |cffffff00%  |cff00ff00全伤加深|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['全属性'] = {200000,250000,300000,350000,500000},
['攻击减甲'] = {20,25,30,35,50},
['每秒加护甲'] = {2,3,4,5,6},
['全伤加深'] = {10,12.5,15,17.5,25},
need_map_level = 5,
}


local mt = ac.skill['精彩活动']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[huodongchengjiu.blp]],
    title = '活动成就',
    tip = [[

查看 |cff00ffff活动成就|r，通过完成 |cffffff00限时活动|r 获得
    ]],
    
}
mt.skill_name ={
    '魔灵精品粽',
}

mt.skills = {
    -- '第一个吃螃蟹的人',
}

function mt:on_add()
    local hero = self.owner 
    local player = hero:get_owner()
    -- print('添加精彩活动',#self.skill_name)
    --已经在 最强魔灵处 处理
    -- for i=1,#self.skill_name do 
    --     local name = self.skill_name[i]
    --     local has_mall = player.mall[name] or (player.server and player.server[name])

    --     if has_mall and has_mall > 0 then 
    --         ac.game:event_notify('技能-插入魔法书',hero,'精彩活动',name)
    --         local skl = hero:find_skill(name,nil,true)
    --         skl:set_level(has_mall)
    --     end
    -- end 
end    
