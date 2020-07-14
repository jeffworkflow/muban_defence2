local mt = ac.skill['真·绝对领域']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    --最大等级
   max_level = 20,
    --触发几率
   chance = function(self) return 2*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 500,
	--技能品阶
	color = "真神阶",
	--技能类型
	skill_type = "被动，增伤",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 4,
	--忽略技能冷却
	ignore_cool_save = true,
	--属性加成
['杀怪加力量'] = {600,12000},
['攻击加力量'] = {600,12000},
['每秒加力量'] = {600,12000},
	--介绍
	tip = [[|cffffff00【杀怪加力量】+600*Lv
【攻击加力量】+600*Lv
【每秒加力量】+600*Lv

|cff00bdec【被动效果】攻击2%几率在目标点创建一个由小到大的绝对领域，（0.2秒变到最大，最大时候直径500码），持续3秒；
3秒内，碰到绝对领域的所有敌人，会立刻不动并更加虚弱（额外受到(5%+1%*Lv)伤害），持续至绝对领域消失

虚弱效果唯一]],
	--技能图标
	art = [[jueduilingyu.blp]],
	--特效
	effect = [[blackhole0.mdx]],
	--被动事件
	event_name = "造成伤害效果",
    time = 3,
    val = function(self)
        return 5+1*self.level+100000
    end
}
function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
    local target = damage.target
	if not damage:is_common_attack()  then 
		return 
	end 
	--创建特效
	ac.effect_ex{
		model = self.effect,
        size = 2,
        point = target:get_point(),
        time = skill.time
    }
    
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
end
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end