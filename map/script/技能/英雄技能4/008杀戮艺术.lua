local mt = ac.skill['杀戮艺术']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    --最大等级
   max_level = 20,
    --触发几率
   chance = function(self) return 5*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 500,
	--技能品阶
	color = "神阶",
	--技能类型
	skill_type = "被动，叠伤",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 1,
	--忽略技能冷却
	ignore_cool_save = true,
	--属性加成
['杀怪加敏捷'] = {500,10000},
['攻击加敏捷'] = {500,10000},
['每秒加敏捷'] = {500,10000},
	--介绍
	tip = [[|cffffff00【杀怪加敏捷】+500*Lv
【攻击加敏捷】+500*Lv
【每秒加敏捷】+500*Lv

|cff00bdec【被动效果】攻击5%几率造成范围技能伤害，并叠加一层持续时间为5秒的“影割”
【伤害公式】（敏捷*12.5*Lv*影割层数）|r
 ]],
	--技能图标
	art = [[shanuyishu.blp]],
	--特效
	effect = [[effect2_az_jingzi_jiansheng01_e1.mdx]],
	--特效4
	effect4 = [[目标位置播放特效，特效朝向：从英雄往敌人的方向，伤害范围100*1200]],
	--被动事件
	event_name = "造成伤害效果",
	damage = function(self)
		return self.owner:get('敏捷')*12.5* self.level
	end,
	distance = 1200,
	hit_area = 100,
	time =5
}
function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
    local target = damage.target
	if not damage:is_common_attack()  then 
		return 
	end 
	local angle = damage.source:get_point() / damage.target:get_point()
	--创建特效
	ac.effect_ex{
		model = self.effect,
		angle = angle,
		point = hero:get_point()
	}:remove()

	for i, u in ac.selector()
		: in_line(hero, angle, self.distance, self.hit_area) --	起点--	角度--	长度--	宽度
		: of_not_building()
		: is_enemy(hero) --测试
		: ipairs()
	do
		u:add_buff '影割' {
			time = self.time
		}
		local buf_stack = u:find_buff_stack('影割') or 1
		-- print(u:get_name(),'影割层数：',buf_stack)
		--敏捷*12.5*Lv*影割层数
		u:damage
		{
			source = hero,
			damage = skill.damage*buf_stack ,
			skill = skill,
			damage_type = '法术'
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

local mt = ac.buff['影割']
mt.cover_type = 1 --共享型 
mt.cover_max = 5  

function mt:on_add()
	-- self.target:add('额外受到伤害',self.val)
	-- self:add_stack
end

function mt:on_remove() 
	-- self.target:add('额外受到伤害',-self.val)
end
