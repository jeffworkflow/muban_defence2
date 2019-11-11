local mt = ac.skill['灵魂镣铐']
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
	--伤害
	damage = function(self)
  return (self.owner:get('智力')*20+10009)* self.level
end,
	--施法范围
	area = 500,
	--属性加成
 ['每秒加木头'] = {5,100},
 ['每秒加魔丸'] = {5,100},
 ['物品获取率'] = 100,
 ['吸血'] = 25,
	--介绍
	tip = [[|cffffff00【每秒加木头】+5*Lv
【每秒加魔丸】+5*Lv
【物品获取率】+100%
【吸血】+25%

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害，每0.5秒造成一次伤害，持续时间2秒
【伤害公式】（智力*20+10000）*Lv

|cff00ff00【月球漫步】按D向鼠标方向飘逸500码距离]],
	--技能图标
	art = [[lhjs.blp]],
	--特效
	effect = [[desecrate.mdx]],
	--特效4
	effect4 = [[目标位置播放特效，伤害范围500码]],
    time = 2,
    pulse_time = 0.5,
    cool = 2,
}

function mt:atk_pas_shot(target)
    local skill = self
    local hero = self.owner

	local source = hero:get_point()

    for i=1,2 do 
        if i==2 then 
            ac.wait(0.1*1000,function()
                ac.effect_ex{
                    point = target:get_point(),
                    model = skill.effect,
                }:remove()
            end)
        else
            ac.effect_ex{
                point = target:get_point(),
                model = skill.effect,
            }:remove()  
        end      
    end    
	--计时器
	self.trg1 = hero:timer(self.pulse_time * 1000,math.floor(self.time/self.pulse_time),function()
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
