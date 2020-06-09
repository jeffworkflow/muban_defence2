local mt = ac.skill['一键分类']

mt{
	--目标类型 = 单位
	target_type = ac.skill.TARGET_TYPE_POINT,
	level = 1,	
	max_level = 5,
	tip = [[

|cffFFE799【使用说明】：|r
|cff00ff00对指定范围的内物品，进行|cff00ffff自动合成

]],

	ignore_cool_save = true, --忽略技能冷却
	--技能图标
	art = [[yijianfenlei.blp]],
	--施法范围 半径
	area = 750,
	--cd
	cool = 0.5,
	--施法距离
	range = 1000,
}


function mt:on_add()
	local hero = self.owner 
end	

function mt:on_cast_shot()
    local skill = self
	local hero = self.owner
	local p = hero:get_owner()
	-- local target = 
	local lefttop = self.target:get_point() -{135,self.area}
	local leftbuttom = self.target:get_point() -{225,self.area}
	local righttop = self.target:get_point() -{45,self.area}
	local rightbuttom = self.target:get_point() -{315,self.area}

	local selected_item = {}
    for _,v in sortpairs(ac.item.item_map) do 
        -- 没有所有者 ，视为在地图上
		-- 在地图上 被隐藏的，一般为默认切换背包时的装备 或者 为添加物品给英雄，没有添加成功 
		-- '黄阶','玄阶','地阶'
        if not v.owner  then 
			-- print(v.name,v._eff)
			if v._eff then 
				local item_point = v:get_point()
				if item_point then 
					if item_point:is_in_range(self.target ,self.area) then 
						local new_point 
						--装备
						if finds(v.item_type,'装备','消耗品') and v.color and finds(v.color,'白','蓝','金','红','黑')  then 
							new_point = lefttop
							v:set_point(new_point)
						elseif finds(v.item_type,'装备','消耗品') and v.color and finds(v.color,'黄阶','玄阶','地阶','天阶','神阶')  then 
							new_point = righttop
							v:set_point(new_point)
						elseif finds(v.name,'藏宝图','羊皮纸','无字天书','一颗神奇的种子','强化石','天谕','扭蛋券','黑暗骰子') then
							new_point = leftbuttom
							v:set_point(new_point)
						elseif finds(v.name,'功法升级书','功法连升书','龙之血珠','无谓因果','天魂','地魂','三眼','火龙') then 
							new_point = rightbuttom
							v:set_point(new_point)
						end	
					end
				end
			end
		end
	end		
	



end

function mt:on_remove()

end
