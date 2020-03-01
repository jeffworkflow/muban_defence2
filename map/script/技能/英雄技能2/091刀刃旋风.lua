local mt = ac.skill['刀刃旋风']
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
	skill_type = "主动,敏捷",
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 20,
	--伤害
	damage = function(self)
  return (self.owner:get('敏捷')*4+10000)* self.level*5
end,
	--施法范围
	area = 500,
	--属性加成
['杀怪加敏捷'] = {10,200},
['攻击加敏捷'] = {10,200},
['每秒加敏捷'] = {10,200},
	--介绍
	tip = [[

|cffffff00【杀怪加敏捷】+10*Lv
【攻击加敏捷】+10*Lv
【每秒加敏捷】+10*Lv

|cff00bdec【主动施放】对周围敌人造成范围技能伤害
【伤害公式】(敏捷*4+1w)*Lv*5|r

]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNFanOfKnives.blp]],
	--特效
    effect = [[Abilities\Spells\NightElf\FanOfKnives\FanOfKnivesMissile.mdl]],
	--特效4
	effect4 = [[参考赤灵的刀刃旋风]],
}
function mt:on_cast_shot()
    local skill = self
	local hero = self.owner
	local target = self.target
	local function start_damage()
		local angle_base = 0
		local num = 3
		for i = 1, num do
			local mvr = ac.mover.line
			{
				source = hero,
				skill = skill,
				start = hero:get_point(),
				model =  skill.effect,
				speed = 800,
				angle = angle_base + 360/num * i,
				distance = skill.area  ,
				size = 2,
				height = 120
			}
			if not mvr then
				return
			end
		end	

		for i, u in ac.selector()
		: in_range(hero,self.area)
		: is_enemy(hero)
		: of_not_building()
		: ipairs()
		do
			u:damage
			{
				source = hero,
				damage = skill.damage ,
				skill = skill,
				damage_type ='法术'
			}	
		end 
	end	 
	--先释放一次，再释放4次
	start_damage()
	-- if self.casting_cnt >1 then 
	-- 	hero:timer(0.3*1000,self.casting_cnt-1,function(t)
	-- 		start_damage()
	-- 	end)
	-- end	
end	
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
