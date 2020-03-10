local mt = ac.skill['X射线']
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
	color = "黄阶",
	--技能类型
	skill_type = "主动,智力",
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 20,
	--伤害
	damage = function(self)
  return (self.owner:get('智力')*1+10000)* self.level*5
end,
	--施法范围
	area = 500,
	--属性加成
['杀怪加智力'] = {10,200},
['攻击加智力'] = {10,200},
['每秒加智力'] = {10,200},
	--介绍
	tip = [[

|cffffff00【杀怪加智力】+10*Lv
【攻击加智力】+10*Lv
【每秒加智力】+10*Lv

|cff00bdec【主动施放】对周围敌人造成范围技能伤害
【伤害公式】(智力*4+1w)*Lv*5|r

]],
	--技能图标
	art = [[jineng032.blp]],
	--特效
	effect = [[gx.mdx]],
	--特效4
	effect4 = [[参考赤灵的X射线]],
	--持续时间
	pulse_time = 0.4,
	--角度
	angle = 20,
	--每次最大数量
	count = 3,
	--X射线距离
	distance = 1600,
	--X射线速度
	speed = 1600,
	--碰撞范围
	hit_area = 100,
}

function mt:on_cast_shot()
    local skill = self
	local hero = self.owner
    --X射线
    --角度
    local function damage_shot(skill,angle)
        local skill = skill
        local hero = skill.owner
        -- print('射线距离',skill.distance,skill.speed,angle)
        --X射线
        local mvr = ac.mover.line
        {
            source = hero,
            distance = skill.distance,
            speed = skill.speed,
            skill = skill,
            angle = angle,
            high = 110,
            model = skill.effect, 
            hit_area = skill.hit_area,
            hit_type = ac.mover.HIT_TYPE_ENEMY,
            size = 1
        }
        if not mvr then 
            return
        end
        function mvr:on_hit(dest)
            dest:damage
            {
                source = skill.owner,
                damage = skill.damage,
                skill = skill,
                missile = skill.mover,
                damage_type = '法术'
            }
        end	
    end
	--在目标区域创建特效
	self.trg = hero:timer(self.pulse_time * 1000,5,function(t)
		local angle = hero:get_facing()
		if t.cnt <=2 then 
			--然后发射3枚射线
			for i = 1,skill.count do
				--计算角度
				local angle = angle + (skill.count / 2 - skill.count - 0.5 + i) * skill.angle
				damage_shot(skill,angle)
			end	
		else
			damage_shot(skill,angle)
		end	
	end)

end

function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
