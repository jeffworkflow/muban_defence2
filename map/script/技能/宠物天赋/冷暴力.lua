local mt = ac.skill['冷暴力']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
	is_order= 1,
    --最大等级
   max_level = 1,
	--流派
	skill_type = "技能触发类",
	--耗蓝
	cost = 0,
	--忽略技能冷却
	ignore_cool_save = true,
	--作用在人身上
	strong_hero = true,
	--属性加成
 ['多重暴击几率'] = 2.5,
	--介绍
tip = [[ 
|cffffe799多重暴击几率+2.5%

|cff00ff00当有英雄死亡时，所有玩家|cffff0000全伤加深+1%

]],
	--技能图标
    art = [[qingyang.blp]],
    --全伤加深
	damage_rate = 1
}
function mt:on_add()
	local hero = self.owner 
	local p = hero.owner
	self.trg = ac.game:event '单位-死亡'(function(_,unit,killer)
		if not unit:is_hero() then 
			return 
		end
		for i=1,6 do 
			local p = ac.player(i)
			if p:is_player() and p.hero then 
				p.hero:add('全伤加深',self.damage_rate)
			end
		end
		--发送文字
		ac.player.self:sendMsg('|cffebb608【系统】|r |cff00ffff'..self.owner.owner:get_name()..' |cff00ff00的宠物【阿青的羊】非常愤怒，所有玩家|cffff0000全伤加深+1%',5)
	
	end)
end

function mt:on_remove()
	if self.trg then 
		self.trg:remove()
		self.trg = nil
	end
end



