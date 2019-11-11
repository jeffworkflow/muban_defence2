local mt = ac.skill['天外飞弹']
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
	color = "天赋",
	--技能类型
	skill_type = "天赋",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 5,
	--伤害
	damage = function(self)
  return (self.owner:get('敏捷')*30+10010)* self.level
end,
	--施法范围
	area = 500,
	--属性加成
 ['杀怪加敏捷'] = {120,2400},
 ['攻击减甲'] = 50,
 ['攻击速度'] = 50,
 ['多重射'] = 2
,
	--介绍
	tip = [[|cffffff00【杀怪加敏捷】+120*Lv
【攻击速度】+50%
【攻击减甲】+50
【多重射】+2

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害，造成2次，每1秒造成一次伤害
【伤害公式】（敏捷*30+10000）*Lv

|cff00ff00【月球漫步】按D向鼠标方向飘逸500码距离]],
	--技能图标
	art = [[zhfd.blp]],
	--特效
	effect = [[calldown_4.mdx]],
	--特效1
	effect1 = [[calldown_flydown.mdx]],
	--特效2
	effect2 = [[calldown_flyup.mdx]],
	--特效4
	effect4 = [[伤害范围500码
1.目标位置先播放瞄准特效
2.英雄头顶位置再播放导弹上升特效
3.目标位置最后播发导弹下降特效
4.英雄头顶位置再播放导弹上升特效
5.目标位置最后播发导弹下降特效

瞄准特效：calldown_4.mdx
导弹上升特效：calldown_flyup.mdx
导弹下降特效：calldown_flydown.mdx]],
}
function mt:atk_pas_shot(target)
    local skill = self
	local hero = self.owner

	local function start_damage()
		--导弹上升特效
		ac.effect_ex{
			point = hero:get_point(),
			model = skill.effect2,
			size = 2
		}:remove()  
		--导弹下降特效
		ac.wait(800,function()
			ac.effect_ex{
				point = target:get_point(),
				model = skill.effect1,
				size = 2
			}:remove() 
			ac.wait(500,function()
				for i, u in ac.selector()
				: in_range(target,skill.area)
				: is_enemy(hero)
				: ipairs()
				do 
					u:damage
					{
						source = hero,
						skill = self,
						damage = skill.damage,
						damage_type = '法术'
					}
				end	
			end)
		end)
	end	

	local source = hero:get_point()
	--瞄准特效
	ac.effect_ex{
		point = target:get_point(),
		model = skill.effect,
		time = 3
	}

	start_damage()
	ac.wait(1000,function()
		start_damage()
	end)

    
end

function mt:on_add()
    local skill = self
    local hero = self.owner
    
	self.trg = hero:event '造成伤害效果' (function(_,damage)
		if not damage:is_common_attack()  then 
			return 
		end 
		--技能是否正在CD
        if skill:is_cooling() then
			return 
		end
        --触发时修改攻击方式
		if math.random(100) <= self.chance then
            self:atk_pas_shot(damage.target)
            --激活cd
            skill:active_cd()
        end
    end)

end    

function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
    if self.trg1 then
        self.trg1:remove()
        self.trg1 = nil
    end
end

