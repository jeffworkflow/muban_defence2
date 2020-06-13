local mt = ac.skill['凌波微步']
--还是有问题，阻断器还是冲的过去。
mt{
    --等级
    level = 1,
	tip = [[
按D向鼠标方向飘逸500码距离，消耗100蓝，内置CD1S，不可穿越障碍物
	]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNBlink.blp]],
	cool = 1,
	cost = 1,

	target_type = ac.skill.TARGET_TYPE_POINT,

	--施法动作
    cast_animation = '',
    cast_animation_speed = 1.5,

    --施法前摇后摇
    cast_start_time = 0.0,
	cast_finish_time = 0.0,
	--忽略技能冷却
    ignore_cool_save = true, 

	--施法距离
	range = 99999,
	--移动距离
	blink_range = 550,
	--新目标点
	new_point =nil,
	is_skill = true,
	--是否开启智能施法 0关闭 1开启 2开启并显示施法指示圈
	-- smart_type = 1,
	effect = function(self)
		local hero = self.owner
		local model_path = hero:get_slk 'file'
		if not getextension(model_path) then 
			model_path = model_path..'.mdl'
		end	
		return model_path
	end,

	--技能id
	ability_id = 'AX21',
    --目标数据
	cus_target_data = '按键',
	--图标是否可见 0可见 1隐藏
    -- hide_count = 1,
}


function mt:on_add()
	self:hide()
	local hero = self.owner
	local skill = self
	local i = self.slotid
	if not hero.smart_cast_type then
		hero.smart_cast_type = {}
	end
	hero.smart_cast_type[i] = self.smart_type
end

function mt:on_can_cast()
    local hero = self.owner:get_point()
	local target = self.target:get_point()
	           
	local angle = hero/target  --计算两点之间角度
	-- print(angle)
	
	local distance = target*hero  --计算两点之间的距离
	-- print(distance)
	self.new_point = target
	if distance >= self.blink_range then
		local data = {}
		data[1]=angle
		data[2]=self.blink_range
		self.new_point = hero - data  --计算新点
	end	
	-- print(new_point,target) 
	self.new_point =  self.new_point:findMoveablePoint(300,angle) or self.new_point --附近寻找一个可通行的点。
	-- print(self.new_point,self.new_point:is_block())
	if self.new_point:is_block()  then
		return false
	end	
	return true
	
	
end

function mt:on_cast_start()
    local hero = self.owner
	local target = self.target
	local new_point = self.new_point

end

function mt:on_cast_shot()
    local hero = self.owner
	local target = self.target
	local new_point = self.new_point
	local skill = self
	local source_point = hero:get_point()
	
	if not hero:has_restriction '缴械' then 
		hero:add_restriction '缴械'
	end	
	if not hero:has_restriction '定身' then 
		hero:add_restriction '定身'
	end	
	-- print('释放凌波微步啦：',self.mvr)
	if self.mvr then 
		self.mvr:remove()
		self.mvr = nil 
	end
	local model_size = hero:get_slk 'modelScale'
	--开始跳跃
	local mvr = ac.mover.target
	{
		source = hero,
		target = new_point,
		mover = hero,
		-- missile = true,
		speed = 2000,
		skill = skill,
		block = true,
		-- mover_type ='unit',
		do_reset_high = true, --还原高度
		turn_speed =360, --立即转身
		--高度
		-- height = 250,
		-- on_move_skip =2,
	}
	if not mvr then
		return
	end
	self:set('mvr',mvr)
	function mvr:on_move()
		local total_distance = new_point *source_point
		
		local eff= ac.effect(self.mover:get_point(),skill.effect,self.mover:get_facing(),model_size,'chest',self.high)
		eff.unit:setColor(10,10,10)
		-- eff.unit:setAlpha(70)

		-- 老版本
		-- ac.wait(0.2*1000,function()
		-- 	eff:remove()
		-- 	eff.unit:remove() --特效马上删除，不播放死亡动作
		-- end)
		
		-- 新版本
		eff.unit:add_buff '淡化'
		{
			time = 0.3,
			on_finish_ex = function()
				eff:remove()
			end
		}

	end	
	function mvr:on_block()
		if  hero:has_restriction '缴械' then 
			hero:remove_restriction '缴械'
		end	
		if  hero:has_restriction '定身' then 
			hero:remove_restriction '定身'
		end	
		return true
	end	
	function mvr:on_finish()
		if  hero:has_restriction '缴械' then 
			hero:remove_restriction '缴械'
		end	
		if  hero:has_restriction '定身' then 
			hero:remove_restriction '定身'
		end	
		hero:issue_order('attack',hero:get_point())
	end	
                    
   
end
function mt:on_cast_finish()
	local hero = self.owner
	-- hero:remove_restriction '缴械'
	hero:issue_order('stop')
	-- print('222222222222222',hero:get_point())
	
end	


function mt:on_cast_break()


end	


function mt:on_remove()

	if self.mvr then 
		self.mvr:remove()
		self.mvr = nil 
	end
end






