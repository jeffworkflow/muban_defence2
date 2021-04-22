local mt = ac.skill['手长']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
	is_order= 1,
    --最大等级
   max_level = 1,
	--流派
	skill_type = "技能触发类",
	--耗蓝
	cost = 0,
	--作用在人身上
	strong_hero = true,
	passive = true,
	--属性加成
 ['多重射'] = 2,
	--介绍

tip = [[ 
|cffffe799多重射+2

|cff00ff00杀怪1% 概率永久提高2点攻击距离（已增加 %has_val% |cff00ff00攻击距离）
 ]],
	--技能图标
	art = [[changbiyuan.blp]],
    --触发几率
    chance = 1,
	max_val = 1500,
	attr_name = '攻击距离',
	value = 2,
	has_val = function(self)
		return self.spell_stack * self.value
	end,
}
function mt:on_add()
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
	local target = target
	hero = p.hero

	self.trg = hero:event '单位-杀死单位' (function(_,source,target)
		--技能是否正在CD
        if skill:is_cooling() then
			return 
		end 
		if math.random(100) <= self.chance then
			if self.spell_stack * self.value < self.max_val then 
				hero:add(skill.attr_name,skill.value)
				skill:add_stack(1) 
				-- print('叠加1',skill.spell_stack,self.has_val,self:get_key('has_val'))
			end
		end
	end)

end
function mt:on_remove()
	local hero = self.owner
	local skill = self
	local p = hero:get_owner()
	hero = p.hero
	--移除时，扣除属性
	-- print('移除属性时的值',skill.has_val,)
	hero:add(skill.attr_name,-skill.spell_stack*skill.value)

    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end