local mt = ac.skill['真神觉醒']
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
	cool = 1.5,
	--伤害
	damage = function(self)
  return (self.owner:get('敏捷')*40+10012)* self.level
end,
	--施法范围
	area = 500,
	--属性加成
 ['杀怪加敏捷'] = {320,6400},
 ['移动速度'] = 200,
 ['全伤加深'] = 250,
 ['敏捷%'] = 50,
	--介绍
	tip = [[|cffffff00【杀怪加敏捷】+320*Lv
【敏捷】+50%
【移动速度】+200
【全伤加深】+250%
【强大的永生系统】

|cff00ffff【被动效果】攻击10%几率造成多次突袭伤害
【伤害公式】（敏捷*40+10000）*Lv

|cff00ff00【月球漫步】按D向鼠标方向飘逸500码距离]],
	--技能图标
	art = [[zsjx.blp]],
	--特效
	effect = [[Valiant Charge Royal.mdx]],
	--特效1
	effect1 = [[hero_hc04.mdx]],
	--特效2
	effect2 = [[Mx_yetiliujing.mdx]],
	--特效4
	effect4 = [[1.英雄在球里冲锋

冲锋模型：Valiant Charge Royal.mdx

2.英雄死亡时在原地同时创建英雄模型和冰晶模型，英雄重生后消失

英雄模型hero_hc04.mdx
冰晶模型Mx_yetiliujing.mdx]],
	max_cnt =5,
	time = 0.1
}

function mt:atk_pas_shot(target)
	local skill = self
	local hero = self.owner

	local source = hero:get_point()
	local mvr = ac.mover.target
	{
		source = hero,
		target = target,
		model = skill.effect,
		skill = skill,
		mover =  hero,
		speed = 5000,
		do_reset_high = true, --还原高度
		size = 1,
		on_finish = function(self)
			--晕眩
			target:add_buff '晕眩'
			{
				time = skill.time,
				skill = skill,
				source = hero,
			}
			--技能伤害
			target:damage
			{
				source = hero,
				skill = skill,
				damage = skill.damage,
				damage_type = '法术'
			}
			skill:set('cnt',(skill.cnt or 0) + 1)
			--
			if skill.cnt < skill.max_cnt then 
				--重新选择周围500码内的敌人
				ac.wait(0.1*1000,function()
					local target = ac.selector():in_range(target:get_point(),skill.area):is_enemy(hero):random()
					if target then
						skill:atk_pas_shot(target)
					else
						skill:set('cnt',0)
					end	
				end)
			else 
				skill:set('cnt',0)
			end	
		end	
	}

end

function mt:on_add()
    local skill = self
	local hero = self.owner
	
	--添加重生技能
	self.skl1 = hero:add_skill('重生','隐藏')
	if self.skl1 then 
		self.skl1.cnt = 99999999
		self.skl1.time = 2
		self.skl1.effect = skill.effect1
		self.skl1.effect1 = skill.effect2
	end	 
	--注册即将死亡伤害事件
	self.trg1=hero:event '单位-即将死亡' (function (_,unit,killer)
		for _, u in ac.selector()
			:in_range(hero,500)
			:is_enemy(hero)
			:ipairs() 
		do
			u:damage{
				source = hero,
				skill = skill,
				damage = skill.damage,
				damage_type = '法术'
			}
		end
	end)
	
    --被动触发伤害事件
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
    if self.skl1 then
        self.skl1:remove()
        self.skl1 = nil
    end
end
