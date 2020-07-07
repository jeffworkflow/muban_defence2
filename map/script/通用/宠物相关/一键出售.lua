local mt = ac.skill['一键出售']
mt{
	--初始等级
	level = 1,
	tip = [[

|cffFFE799【使用说明】：|r
可以将宠物身上的物品|cff00ff00全部出售|r

]],
	--技能图标
	art = [[yijianchushou.blp]],
    ignore_cool_save = true, --忽略技能冷却
	--技能目标类型 无目标
	target_type = ac.skill.TARGET_TYPE_NONE,
	--施法范围
	-- area = 400,
	--cd
	cool = 0.5,
	--施法距离
	-- range = 1000,
}

function mt:on_add()
	local hero = self.owner 
end	

function mt:on_cast_shot()
    local skill = self
	local hero = self.owner
	local gold = 0 
	local wood = 0 
	local kill_count = 0 
	local rec_ex = 0 
	for i=1,6 do
		local items = hero:get_slot_item(i)
		if items then 
			-- print(items.name,items.handle)
			if (items.color and finds(items.color,'红','黑','天阶','神阶')) or finds(items.name,'无谓因果','龙之血珠','吞噬丹') then 
			else
				gold = gold + items:sell_price()
				wood = wood + items:sell_wood()
				kill_count = kill_count + items:sell_kill_count()
				rec_ex = rec_ex + items:sell_rec_ex()
				
				items:item_remove()
			end	
		end
	end
	if gold > 0 then 
		hero:addGold(gold)
	end	
	if wood > 0 then 
		hero:add_wood(wood)
	end	
	if kill_count > 0 then 
		hero:add_kill_count(kill_count)
	end	
	if rec_ex > 0 then 
		hero:add_rec_ex(rec_ex)
	end	


end

