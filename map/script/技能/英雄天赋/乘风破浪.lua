local mt = ac.skill['乘风破浪']
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
	cool = 3,
	--伤害
	damage = function(self)
  return (self.owner:get('智力')*5+10000)* self.level
end,
	--施法范围
	area = 500,
	--属性加成
 ['每秒加木头'] = {1.5,30},
 ['每秒加魔丸'] = {1.5,30},
 ['物品获取率'] = 35,
	--介绍
	tip = [[|cffffff00【每秒加木头】+1.5*Lv
【每秒加魔丸】+1.5*Lv
【物品获取率】+35%

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害，并短暂晕眩敌人
【伤害公式】（智力*5+10000）*Lv

|cff00ff00【月球漫步】按D向鼠标方向飘逸500码距离]],
	--技能图标
	art = [[cfpl.blp]],
	--特效
	effect = [[ShellCharge.mdx]],
	--特效4
	effect4 = [[类似船长的大招，从自身到敌人的方向，播放乌龟特效，特效移动距离1200，伤害范围300

乌龟特效：ShellCharge.mdx]],
	hit_area = 300,
	distance = 1200
}

function mt:atk_pas_shot(target)
    local skill = self
    local hero = self.owner

	local source = hero:get_point()

	local mvr = ac.mover.line
	{
		source = hero,
		skill = skill,
		model =  skill.effect,
		speed = 800,
		angle = hero:get_point()/target:get_point() ,
		hit_area = skill.hit_area,
		distance = skill.distance,
		high = 120,
		size = 2,
		on_hit = function(self,u)
            --技能伤害
            u:damage
            {
                source = hero,
                skill = skill,
                damage = skill.damage,
                damage_type = '法术'
            }
		end	
	}

end

function mt:on_add()
    local skill = self
    local hero = self.owner
	local p = hero:get_owner()
	
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
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
