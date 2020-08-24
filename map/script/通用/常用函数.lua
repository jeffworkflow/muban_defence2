--获取区域内随机单位
ac.get_random_unit = function(loc,unit,range)
	local target
	local group = {}
	for _,u in ac.selector()
		: in_range(loc,range)
		: is_enemy(unit)
		: ipairs()
	do
		table.insert(group,u)
	end
	if #group > 0 then
		target = group[math.random(1,#group)]
	end

	return target
end

--创建通用警示圈
local ring_model = [[F2_model\warming_ring_red.mdl]]
local rect_model = [[F2_model\warming_rect.mdl]]
--外到内
local circle_model = [[F2_model\warming_ring_red2.mdx]]
--太丑，不用
ac.warning_effect_rect = function(data)
	local point = data.point
	local time = data.time
	local rotate = {0,0,data.angle}
	local scale = {data.len/200,data.wid/200,0}
	local effect = ac.effect_ex
	{
		rotate = rotate,
		point = point,
		model = rect_model,
		speed = 1/time,
		scale = scale,
		high = 50,
		time = data.time,
	}
	return effect
end
ac.warning_effect_circle = function(data)
	local point = data.point
	local size = data.area/200
	local time = data.time
	-- print(size)
	--角度
	if data.angle then
		local rotate = {0,0,data.angle} or nil
	end
	local effect = ac.effect_ex
	{
		rotate = rotate,
		point = point,
		model = circle_model,
		size = size,
		speed = 1/time,
		time = data.time,
		item_show = true, --关闭特效时，预警圈也不关闭
	}

	-- if time then
	-- 	ac.timer(time*1000,1,function()
	-- 		if effect then
	-- 			effect:remove()
	-- 		end
	-- 	end)
	-- end

	return effect
end

ac.warning_effect_ring = function(data)
	local point = data.point
	local size = data.area/200
	local time = data.time
	-- print(size)
	--角度
	if data.angle then
		local rotate = {0,0,data.angle} or nil
	end
	local effect = ac.effect_ex
	{
		rotate = rotate,
		point = point,
		model = ring_model,
		size = size,
		speed = 1/time,
		time = data.time,
		item_show = true, --关闭特效时，预警圈也不关闭
	}
	if data.func and data.time then 
		data:func()
	end
	-- if time then
	-- 	ac.timer(time*1000,1,function()
	-- 		if effect then
	-- 			effect:remove()
	-- 		end
	-- 	end)
	-- end

	return effect
end

ac.warning_lightning = function(data)
	local hero = data.hero
	local target = data.target
	local time = data.time
	local lt = ac.lightning('FFAA',hero,target,50,50)
	lt:setColor(100,0,0)
	
	if time then
		hero:wait(time* 1000,function()
			if lt then
				lt.speed = -10
				lt:remove()
			end
		end)
	end
	return lt
end