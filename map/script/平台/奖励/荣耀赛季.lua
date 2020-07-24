local mt = ac.skill['精英版奖励1']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
--图标
art = [[mljpz.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

挖宝熟练度+5000

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='挖宝熟练度',
award_cnt = 5000,
need_map_level = 5,
}

local mt = ac.skill['精英版奖励2']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
--图标
art = [[mljpz.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

挖宝熟练度+5000

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
}


local mt = ac.skill['进阶版奖励1']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
--图标
art = [[xueba.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
看书熟练度+5000

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='看书熟练度',
award_cnt = 5000,
need_map_level = 5,
}
function mt:on_add()
    local hero = self.owner
    local p = hero.owner
    local name = ac.server.key2name('s0jj')
    local flag = p.server[name] or 0
    local cnt = tonumber(self.name:sub(16,-1))
    print('奖励n',self.name,cnt)
    if flag >= cnt then 
        return 
    end

    local key = ac.server.name2key(self.award)
    p:Map_AddServerValue(key,self.award_cnt)
    --保存标识
    p:Map_AddServerValue('s0jj',1)

end


local mt = ac.skill['进阶版奖励2']
mt{
--等级
level = 1, --要动态插入
max_level = 1, --要动态插入
--图标
art = [[xueba.blp]],
--说明
tip = [[
|cffffff00【要求地图等级>%need_map_level%|cffffff00】|r

|cffffe799【获得方式】：|r
看书熟练度+5000

]],
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
award ='爱心积分',
award_cnt = 1000,
need_map_level = 5,
}
mt.on_add = ac.skill['进阶版奖励1'].on_add

for i,name in ipairs({'精英版奖励1','精英版奖励2','精英版奖励3'}) do 
    local mt = ac.skill[name]
    function mt:on_add()
        local hero = self.owner
        local p = hero.owner
        local name = self.name:gsub('精英版','进阶版') 
        -- print('动态插入数据1:',name)
        if (p.mall['S0赛季通行证'] or 0 ) > 0 then 
            -- print('动态插入数据2:',name)
            ac.game:event_notify('技能-插入魔法书',hero,'荣耀赛季',name)
        end
    end
end

local mt = ac.skill['荣耀赛季']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[huodongchengjiu.blp]],
    title = '赛季成就',
    tip = [[

点击查看 |cff00ffff赛季成就|r，通过完成 |cffffff00限时活动|r 获得
    ]],
    
}
mt.skill_name ={
    '精英版奖励1','精英版奖励2','精英版奖励3',
    -- '进阶版本奖励1','进阶版本奖励2','进阶版本奖励3',
}

mt.skills = {
    -- '第一个吃螃蟹的人',
}

