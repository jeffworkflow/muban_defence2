local mt = ac.skill['毁灭轰击']
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
	color = "天阶",
	--技能类型
	skill_type = "被动,敏捷",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 1,
	--忽略技能冷却
	ignore_cool_save = true,
	--伤害
	damage = function(self)
  return (self.owner:get('敏捷')*40+10000)* self.level
end,
	--施法范围
	area = 500,
	--属性加成
['攻击加敏捷'] = {480,9600},
	--介绍
	tip = [[|cffffff00【攻击加敏捷】+480*Lv

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（敏捷*40+10000）*Lv]],
	--技能图标
	art = [[hlqk.blp]],
	--特效
	effect = [[E_MissileCluster.mdx]],
	--特效4
	effect4 = [[参考赤灵的火力全开，同一方向再发射三枚导弹]],
	--被动，第几次攻击触发特殊攻击
	attack_stack = 5,
	--被动，距离1600
	distance = 1600,
	--被动，撞击范围
	hit_area = 250,
	damage_type = '法术',
	count =3
}

local function on_texttag(self,hero)
	local target = hero
	local x, y,z = target:get_point():get()
	-- local z = target:get_point():getZ()
	local tag = ac.texttag
	{
		string = self:get_stack(),
		size = 10,
		position = ac.point(x , y, z + 100),
		speed = 250,
		angle = 90,
		red = 238,
		green = 31,
		blue = 39,
		crit_size = 0,
		life = 1,
		fade = 0.5,
		time = ac.clock(),
	}
	
	if tag then 
		local i = 0
		ac.timer(10, 25, function()
			i = i + 1
			if i < 10 then
				tag.crit_size = tag.crit_size + 1

			else if i < 20 then
					tag.crit_size = tag.crit_size	
				else 
					tag.crit_size = tag.crit_size - 1
				end
			end	
			tag:setText(nil, tag.size + tag.crit_size)
		end)
	end	
end
-- 攻击第5下发射的导弹
local function beidong_damage(self,damage_target)
	local skill = self
	local hero = self.onwer
	-- print(hero,self.owner)
	local mvr = ac.mover.line
	{
		source = self.owner,
		model = self.effect,
		speed = 1200,
		angle = self.owner:get_point()/damage_target:get_point(),
		distance = self.distance,
		high = 100,
		skill = self,
		size = 3,
		hit_area = self.hit_area,
		hit_type = ac.mover.HIT_TYPE_ENEMY,
		per_moved = 0
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
			damage_type = skill.damage_type
		}
		
	end	

end	


function mt:on_add()
	local hero = self.owner 
	local skill = self

	self.trg = hero:event '单位-发动攻击'  (function(trg, damage)

		local damage_target = damage.target

		self:add_stack(1)
		on_texttag(self,hero)

		if self:get_stack() >= self.attack_stack then 
			self:set_stack(0)
			beidong_damage(self,damage_target)
			ac.timer(100,skill.count - 1 ,function()
				beidong_damage(self,damage_target)
			end)
			hero:event_notify('单位-触发被动', hero,self)
		end		
	end)	

end	

function mt:on_remove()
    local hero = self.owner 
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end    

end
