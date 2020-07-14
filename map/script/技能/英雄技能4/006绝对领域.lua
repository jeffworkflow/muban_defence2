local mt = ac.skill['绝对领域']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    --最大等级
   max_level = 20,
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 500,
	--技能品阶
	color = "神阶",
	--技能类型
	skill_type = "主动，增伤",
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 20,
	--施法范围
	area = 500,
	--属性加成
['杀怪加力量'] = {500,10000},
['攻击加力量'] = {500,10000},
['每秒加力量'] = {500,10000},
	--介绍
	tip = [[|cffffff00【杀怪加力量】+500*Lv
【攻击加力量】+500*Lv
【每秒加力量】+500*Lv

|cff00bdec【主动施放】参考虚空假面的大招，在目标点创建一个由小到大的绝对领域，（0.2秒变到最大，最大时候直径500码），持续3秒；
3秒内，碰到绝对领域的所有敌人，会立刻不动并更加虚弱（额外受到(5%+1%*Lv)伤害），持续至绝对领域消失

虚弱效果唯一]],
	--技能图标
	art = [[jueduilingyu.blp]],
	--特效
    effect = [[blackhole0.mdx]],
    target_type = ac.skill.TARGET_TYPE_POINT,
    range = 1000,
    time = 3,
    val = function(self)
        return 5+1*self.level+100000
    end
}
function mt:on_cast_start()
    local skill = self
    local hero = self.owner

	local source = hero:get_point()
	local target = self.target

	self.eff = ac.effect(target:get_point(),skill.effect,0,2,'origin')
	-- self.eff.unit:add_buff '缩放'{
    --     source_size = 0.1,
    --     target_size = 2,
    -- }

	for i, u in ac.selector()
		: in_range(target,skill.area)
		: is_enemy(hero)
		: of_not_building()
		: ipairs()
	do
		--时停buff 无法进入移除，不知道为啥。
		u:add_buff '时停'
		{
			time = skill.time,
			skill = skill,
			source = hero,
        }
        u:add_buff '虚弱'{
            time = skill.time,
            val = skill.val

        }
	end	
	--移除特效
	ac.wait(skill.time * 1000,function()
		if self.eff then
			self.eff:remove()
			self.eff = nil
		end
	end)
    -- 额外受到伤害
end	
function mt:on_remove()
    local hero = self.owner
    if self.eff then
        self.eff:remove()
        self.eff = nil
    end
end
local mt = ac.buff['虚弱']
mt.cover_type = 0 

function mt:on_add()
	self.target:add('额外受到伤害',self.val)
end

function mt:on_remove() 
	self.target:add('额外受到伤害',-self.val)
end

function mt:on_cover(new)
	return new.val > self.val
end 