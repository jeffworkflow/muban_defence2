local mt = ac.skill['超级分身']
mt{
--施法信息
cast_start_time = 0,
--施法时长
cast_channel_time = 0.5, 
cast_shot_time = 0,
cast_finish_time = 0.0,
--初始等级
level = 1,
--技能图标
art = [[icon\card\2\card2_3.blp]],
--技能说明
title = '超级分身',
tip = [[
    每隔180秒触发一次技能（boss出现后，等待180秒后才施放第一次技能）

触发次数限制=游戏难度/2（难1触发0次，难2触发1次，难3触发1次（向下取整），难4触发2次，类推）

触发效果：第一次触发，创建1个分身；第二次创建2个分身；第三次创建4个分身；第四次创建8个分身；第五次创建16个分身

分身属性：继承主体触发技能时的全部属性
]],

cnt = function(self)
	local v = ac.g_game_degree_attr and math.floor(ac.g_game_degree_attr/2) or 0 
	v = math.min(v,6) --最大为6次
	return v
end, 
has_cnt = 0,
--冷却
cool = 150,
-- cool = 1,
}
-- mt.effect1 = [[Abilities\Spells\Other\ANrm\ANrmTarget.mdl]]

function mt:on_add()
	ac.wait(0,function()
		self:active_cd()
	end)
end
function mt:on_ai()
	local hero = self.owner
	local skill =self
	if self.cnt > self.has_cnt then 
		self:set('has_cnt',self.has_cnt+1)
		return true
    end
end

function mt:boss_skill_shot(old_point)
	-- print('1开始分身啦：',self.cnt)
	local hero = self.owner
	local skill =self
	local cnt = 2^(self.has_cnt-1)
	for i=1,cnt do 
		-- print('2开始分身啦：',self.cnt)
		local point = hero:get_point() - {math.random(360),math.random(100,300)}
		local u =  hero:create_illusion(point)
		if not u then 
			print('无法创造出镜像')
			return 
		end
		
		-- print('3开始分身啦：',u)
		local attribute ={
			['攻击'] = hero:get('攻击') ,
			['护甲'] = hero:get('护甲') ,
			['攻击间隔'] = hero:get('攻击间隔'),
			['攻击速度'] = hero:get('攻击速度'),
			['生命上限'] = hero:get('生命上限'),
			['魔法上限'] = hero:get('魔法上限'),
			['生命恢复'] = hero:get('生命恢复'),
			['魔法恢复'] = hero:get('魔法恢复'),
			['移动速度'] = hero:get('移动速度'),

			['暴击几率'] = hero:get('暴击几率'),
			['暴击伤害'] = hero:get('暴击伤害'),
			['会心几率'] = hero:get('会心几率'),
			['会心伤害'] = hero:get('会心伤害'),
		}
		
		for k,v in pairs(ac.unit.attribute) do 
			attribute[k] = hero:get(k)
		end

		u:remove_ability 'AInv'

		--模型
		local model = hero:get_slk 'file'
		if not getextension(model) then 
			model = model..'.mdl'
		end	
		u:add_buff "召唤物"{
			model = model,
			attribute = attribute,
			-- attr_mul=self.attr_mul,
			remove_target = true,
			skill = self,
			search_area = 800, --搜敌路径
		}
		
		local where = ac.zqmd and ac.rect.j_rect('moku'):get_point()

		u:add_buff '攻击英雄' {
			where = where
		}
	end

end

function mt:on_cast_start()
	local hero = self.owner
	local skill =self
	local target = self.target
	
	--预警圈
	-- ac.warning_effect_ring
	-- {
	-- 	point = target:get_point(),
	-- 	area = self.area,
	-- 	time = self.time,
	-- }
end

function mt:on_cast_shot()
    self:boss_skill_shot()
end

function mt:on_cast_stop()
    if self.eft then
        self.eft:remove()
	end

end

function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
	end
	
    if self.timer then
        self.timer:remove()
        self.timer = nil
	end
end



