local mt = ac.skill['一键合成']

mt{
	--目标类型 = 单位
	target_type = ac.skill.TARGET_TYPE_POINT,
	level = 1,
	is_order= 1,
	title = function(self)
		return '一键合成'
	end,	
	max_level = 5,
	tip = [[

|cffFFE799【使用说明】：|r
|cff00ff00对指定范围的内物品，进行|cff00ffff自动合成

]],

	ignore_cool_save = true, --忽略技能冷却
	--技能图标
	art = [[yijianhecheng.blp]],
	--施法范围
	area = 400,
	--cd
	cool = 0.5,
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
	
	local selected_item = {}
    for _,v in sortpairs(ac.item.item_map) do 
        -- 没有所有者 ，视为在地图上
        -- 在地图上 被隐藏的，一般为默认切换背包时的装备 或者 为添加物品给英雄，没有添加成功
        if not v.owner  then 
			-- print(v.name,v._eff)
			if v._eff then 
				local item_point = v:get_point()
				if item_point then 
					if item_point:is_in_range(self.target ,self.area) then 
						--finds(v.item_type,'装备','消耗品') and
						if finds(v.item_type,'装备','消耗品') and v.color and finds(v.color,'白','蓝','金','黄阶','玄阶','地阶')  then 
							table.insert(selected_item,v)
						end	
					end
				end
			end
		end
	end		
	local hecheng = {
		['白'] ={},
		['蓝'] ={},
		['金'] ={},
		['红'] ={},
		['黄阶'] ={},
		['玄阶'] ={},
		['地阶'] ={},
		['天阶'] ={},
	}	
	local hecheng1 = {
		['物品'] = {'白','蓝','金','红'},
		['技能'] ={'黄阶','玄阶','地阶','天阶'}
	}
	local function get_next_color(color)
		local res
		local type = finds(color,'阶') and '技能' or '物品'
		for i,name in ipairs(hecheng1[type]) do 
			if name == color then 
				res = hecheng1[type][i+1]
				break
			end
		end
		return res,type
	end	
	--进行合成，
	-- selected_item 白，蓝，金，红
	for i=1,#selected_item+#selected_item do 
		local item = selected_item[i]
		if item and item.color then 
			table.insert(hecheng[item.color],i)
			local ok = #hecheng[item.color] == (finds(item.color,'阶') and 3 or 4) 
			-- print(item.color,ok)
			if ok then 
				--删物品
				for i,index in ipairs(hecheng[item.color]) do 
					--优先处理消耗品
					if selected_item[index]._count > 1 then 
						-- local type = finds(item.color,'阶') and '技能' or '物品'
						-- local new_item
						-- if type =='技能' then 
						-- 	new_item= ac.item.create_skill_item(selected_item[index].name,self.target) --创建物品
						-- else 
						-- 	new_item = ac.item.create_item(selected_item[index].name,self.target) --创建物品
						-- end
						-- print('删除物品1：',selected_item[index].name,selected_item[index].color)
						selected_item[index]:add_item_count(-1)
						table.insert(selected_item,selected_item[index])
					else
						-- print('删除物品2：',selected_item[index].name,selected_item[index].color)
						selected_item[index]:item_remove()
					end	
					selected_item[index] = nil
				end	
				--清空表
				hecheng[item.color] = {}

				--增加新物品
				local next_color,next_type = get_next_color(item.color)
				local list
				if next_type =='技能' then 
					list = ac.quality_skill[next_color] 
				else
					list = ac.quality_item[next_color] 
				end

				if list then 
					local name = list[math.random(#list)]
					local new_item
					if next_type =='技能' then  
						new_item= ac.item.create_skill_item(name,self.target) --创建物品
						-- print('合成物品：',new_item.name,new_item.color)
					else
						new_item= ac.item.create_item(name,self.target) --创建物品
					end
					
					if finds(new_item.item_type,'装备','消耗品') and new_item.color and finds(new_item.color,'白','蓝','金','黄阶','玄阶','地阶')  then 
						table.insert(selected_item,new_item)
					end
				end 
			end	
		end	
	end	

		



end

function mt:on_remove()

end
