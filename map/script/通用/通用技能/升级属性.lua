
ac.game:event '技能-升级' (function (_,hero,self)
    --如果技能在宠物身上，加强效果在人身上
    if self.strong_hero then 
        hero = hero:get_owner().hero
    end    
    -- print('技能升级：',self.name,self.item_type,self.slot_type)
	if not hero or self.item_type =='消耗品' then 
		return
    end	
    local p = hero:get_owner()
    local name = self.name
    -- if self.level == 1 then 
    self.old_status =  self.old_status or {} 
	--单位的属性表
	local data = ac.unit.attribute
    for key in sortpairs(data) do 
        --处理基础值
        local value = self[key]
        local old_value = self.old_status[key]
        if old_value then 
            hero:add_tran(key,-old_value)
		end 
		if value then 
            hero:add_tran(key,value)
        end 
        self.old_status[key] = value
        --处理%值
		key = key..'%'
		value = self[key]
        old_value = self.old_status[key]
		if old_value then 
            hero:add_tran(key,-old_value)
		end 
		if value then 
            hero:add_tran(key,value)
        end 
        self.old_status[key] = value

        -- self:set('old_status',self.old_status)
    end
    
	--玩家的属性表
    for i,key in ipairs(ac.player_attr) do 
        -- print('玩家属性',key,self[key])
        if key ~='局内地图等级' then
            --处理基础值
            local value = self[key]
            local old_value = self.old_status[key]
            if old_value then 
                p:add_tran(key,-old_value)
            end 
            if value then 
                p:add_tran(key,value)
            end 
            self.old_status[key] = value
            --处理%值
            key = key..'%'
            value = self[key]
            old_value = self.old_status[key]
            if old_value then 
                p:add_tran(key,-old_value)
            end 
            if value then 
                p:add_tran(key,value)
            end 
            self.old_status[key] = value
        end
        -- self:set('old_status',self.old_status)
    end
    
end)

--神符类的技能获取时会自动失去，所以要排除在外，属性才能加上
ac.game:event '技能-失去' (function (_,hero,self)
    -- print(hero,self.name) or not hero:is_type('英雄')
    --如果技能在宠物身上，加强效果在人身上
    if self.strong_hero then 
        hero = hero:get_owner().hero
    end    
    if self.old_status then self.old_status = nil end
	if not hero  or self.item_type =='消耗品' or self.item_type =='神符'    then 
		return
    end	
    local p = hero:get_owner()
	--单位的属性表
	local data = ac.unit.attribute
    for key in sortpairs(data) do 
        --处理基础值
        local value = self[key]
		if value then 
            hero:add_tran(key,-value)
        end 

        --处理%值
		key = key..'%'
		value = self[key]
		if value then 
            hero:add_tran(key,-value)
        end 
    end
    
	--玩家的属性表
    for i,key in ipairs(ac.player_attr) do 
        --处理基础值
        local value = self[key]
		if value then 
            p:add_tran(key,value)
        end 
       
        --处理%值
		key = key..'%'
		value = self[key]
		if value then 
            p:add_tran(key,value)
        end 
    end
end)    

-- local mt = ac.skill['bj']
-- mt{
-- 	--必填
-- 	is_skill = true,
-- 	--技能类型
-- 	skill_type = "被动",
-- 	--是否被动
-- 	passive = true,
-- 	--初始等级
-- 	level = 1,
-- 	max_level = 5,
-- 	tip = [[
-- 		|cff00ccff被动|r:
-- 		暴击几率+%暴击几率% % ，暴击伤害+%physical_damage% % 
-- 		会心几率+%physical_rate% % ，会心伤害+%physical_damage% %
-- 		技暴几率+%physical_rate% % ，技暴伤害+%physical_damage% %]],
-- 	--技能图标
-- 	art = [[ReplaceableTextures\PassiveButtons\PASBTNCriticalStrike.blp]],
-- 	['暴击几率'] = {2,4,6,8,10},
-- }


