local mt = ac.skill['火焰呼吸']
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
	color = "玄阶",
	--技能类型
	skill_type = "被动,力量",
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
  return (self.owner:get('力量')*10+100000)* self.level
end,
	--施法范围
	area = 500,
	--属性加成
['杀怪加力量'] = {20,400},
	--介绍
	tip = [[|cffffff00【杀怪加力量】+20*Lv

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（力量*10+100000）*Lv
 ]],
	--技能图标
	art = [[hyhx.blp]],
	--特效
	effect = [[jn_tf3.mdx]],
	--特效4
	effect4 = [[类似火焰呼吸，从英雄位置播放特效，特效朝向"攻击目标"，伤害范围为扇形，长度800码，角度120]],
}
function mt:atk_pas_shot(target)
    local skill = self
    local hero = self.owner
	--创建特效
	local angle = hero:get_point() / target:get_point()
	ac.effect(hero:get_point(),skill.effect,angle,1,'origin'):remove()
	--计算伤害
	for _,unit in ac.selector()
	: in_sector(hero:get_point(),self.damage_area,angle,120 )
	: is_enemy(hero)
	: ipairs()
	do 
		unit:damage
		{
			source = hero,
			damage = skill.damage,
			skill = skill,
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
            hero:event_notify('单位-触发被动', hero,self,damage.target,damage)
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
end
