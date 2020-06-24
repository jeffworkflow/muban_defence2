local mt = ac.skill['魔灵精品粽']
mt{
--等级
level = 1, --要动态插入
max_level = 5, --要动态插入
--图标
art = [[ydss.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
|cff00ffff消耗 |cffff0000三十根喜鹊翎毛|r |cff00ffff兑换获得

|cffFFE799【成就属性】：|r
|cff00ff00+13.8   杀怪加全属性|r
|cff00ff00+13.8   攻击减甲|r
|cff00ff00+13.8%  木头加成|r
|cff00ff00+13.8%  会心伤害|r

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
['杀怪加全属性'] = 13.8,
['木头加成'] = 13.8,
['攻击减甲'] = 13.8,
['会心伤害'] = 13.8,
need_map_level = 5,
}


local mt = ac.skill['精彩活动']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[jchd.blp]],
    title = '精彩活动',
    tip = [[

查看精彩活动
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
    for i=1,#self.skill_name do 
        local name = self.skill_name[i]
        local has_mall = player.mall[name] or (player.server and player.server[name])

        if has_mall and has_mall > 0 then 
            ac.game:event_notify('技能-插入魔法书',hero,'精彩活动',name)
            local skl = hero:find_skill(name,nil,true)
            skl:set_level(has_mall)
        end
    end 
end    
