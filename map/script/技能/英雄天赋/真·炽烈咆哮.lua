local mt = ac.skill['真·炽烈咆哮']
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
   damage_area = 800,
	--技能品阶
	color = "真天赋",
	--技能类型
	skill_type = "天赋",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 1,
	--伤害
	damage = function(self)
  return (self.owner:get('力量')*25+10000)* self.level
end,
	--施法范围
	area = 500,
	--属性加成
 ['杀怪加力量'] = {120,2400},
 ['分裂伤害'] = 50,
 ['攻击减甲'] = 150,
 ['护甲%'] = 15,
	--介绍
	tip = [[|cffffff00【杀怪加力量】+120*Lv
【护甲】+15%
【分裂伤害】+50%
【攻击减甲】+150

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（力量*25+10000）*Lv

|cff00ff00【月球漫步】按D向鼠标方向飘逸500码距离]],
	--技能图标
	art = [[crpx.blp]],
	--特效
	effect = [[Hero_Axe_N3S_E_Source.mdx]],
	--特效4
	effect4 = [[类似大喝，英雄头顶播放，伤害范围750

模型Hero_Axe_N3S_E_Source.mdx]],
}
function mt:atk_pas_shot(target)
    local skill = self
    local hero = self.owner

	local source = hero:get_point()
	local target = hero --英雄
	--特效
	hero:add_effect('overhead',skill.effect):remove()

	for i, u in ac.selector()
	: in_range(target,skill.area)
	: is_enemy(hero)
	: ipairs()
	do 
		--技能伤害
		u:damage
		{
			source = hero,
			skill = self,
			damage = skill.damage,
			damage_type = '法术'
		}
	end	
    
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
