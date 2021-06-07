local mt = ac.skill['一键拾取']
mt{
	--初始等级
	level = 1,
	is_order = 1,
	title = function(self)
		return '拾取'
	end,	
	tip = [[ 
|cff00ff00拾取地上的物品
 ]],
	
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNPickUpItem.blp]],

    ignore_cool_save = true, --忽略技能冷却
	--技能目标类型 无目标
	target_type = ac.skill.TARGET_TYPE_POINT,
	--施法范围
	area = 250,
	--cd
	cool = 0.1,	
	--施法距离
	range = 99999,
}


function mt:on_add()
	local hero = self.owner 
end	

function mt:on_cast_shot()
    local skill = self
	local hero = self.owner
	local p = hero:get_owner()
	local target = self.target
	-- local slot = hero:get_nil_slot()
	-- --满格
	-- if not slot then 
	-- 	p:sendMsg('物品栏已满',5)
	-- 	return 
	-- end	
	local flag
    --开始选择物品
    for _,v in sortpairs(ac.item.item_map) do 
        -- 没有所有者 ，视为在地图上
        -- 在地图上 被隐藏的，一般为默认切换背包时的装备 或者 为添加物品给英雄，没有添加成功
        if not v.owner  then 
			-- print(v.name,v._eff)
			if v._eff then 
				local slot = hero:get_nil_slot()
				local has_item = hero:has_item(v:get_name())
				local item_point = v:get_point()
				if item_point then 
					if item_point:is_in_range(target,self.area) then 
						if slot or (not slot and v.item_type =='消耗品' and has_item)  then
							if v.name =='学习技能' then 
								ac.item.add_skill_item(v,hero)
							else 
								hero:add_item(v)
							end
						else
							if not flag then 
								p:sendMsg('物品栏已满',5)
								flag = true
							end
							v:set_point(hero:get_point())
						end
					end    
				end    
			end	
        end	
    end
	


end

function mt:on_remove()

end

