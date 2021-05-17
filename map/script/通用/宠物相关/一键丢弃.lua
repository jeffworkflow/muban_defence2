local mt = ac.skill['一键丢弃']
mt{
	--初始等级
	level = 1,
	is_order = 1,
	title = '丢弃',
	tip = [[ 
|cff00ff00将身上的物品扔到|cffffff00指定位置|r

]],
	
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNUnLoad.blp]],
    ignore_cool_save = true, --忽略技能冷却
	--技能目标类型 无目标
	target_type = ac.skill.TARGET_TYPE_POINT,
	force = 1,
    --目标允许
	-- target_data = '玩家单位 物品 地面 空中 自己 无敌 可攻击的',
	--施法范围
	-- area = 500,
	--cd
	cool = 0.1,
	--施法距离
	range = 3000,
	cast_smart_type = 1, --只能施法
}


function mt:on_add()
	local hero = self.owner 
end	

function mt:on_cast_start()
    local skill = self
	local hero = self.owner
	local gold = 0 
	local target = self.target
	for i=1,6 do
		local it = hero:get_slot_item(i)
		if it then 
			-- print(it.name,it.handle)
			if it.name ~= '勇士徽章' then 
				hero:remove_item(it)
				it:set_point(target:get_point())
			end	
		end
	end


end

function mt:on_remove()

end
