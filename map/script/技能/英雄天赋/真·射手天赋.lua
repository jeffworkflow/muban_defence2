local mt = ac.skill['真·射手天赋']
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
	cool = 1,
	--伤害
	damage = function(self)
  return (self.owner:get('敏捷')*5+10000)* self.level
end,
	--施法范围
	area = 500,
	--属性加成
 ['杀怪加敏捷'] = {20,400},
 ['攻击速度'] = 20,
 ['攻击速度'] = 20,
	--介绍
tip = [[|cffffff00【杀怪加敏捷】+20*Lv
【攻击速度】+20%
【攻击减甲】+20

|cff00ffff【被动效果】攻击10%几率提升自身攻速 （20%*LV）和攻击减甲（20*LV）

|cff00ff00【月球漫步】按D向鼠标方向飘逸500码距离]],
	--技能图标
	art = [[sheshoutianfu.blp]],
	--特效4
	effect4 = [[持续两秒]],
    value = function(self)
        return 20 * self.level 
    end ,
    time = 2
        
}
function mt:atk_pas_shot(target)
    local skill = self
    local hero = self.owner

	local source = hero:get_point()
    hero:add_buff '射手天赋'{
        time = skill.time,
        skill = skill,
        value = skill.value
    }

	
    
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