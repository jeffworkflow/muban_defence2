local mt = ac.skill['宙天珠']
mt{
    --初始等级
    level = 1,
    --最大等级
   max_level = 15,
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 500,
	--类型
	item_type = "装备",
	--品质
	color = "黑",
	--图标
	art = [[ztz.blp]],
	--售价
	gold = 1000,
	--被动
	passive = true,
	--耗蓝
	cost = 1,
	--冷却时间
	cool = 30,
	--忽略技能冷却
	ignore_cool_save = true,
	--伤害
	damage = function(self)
		return self.v1*self.owner:get('力量')+self.v1*self.owner:get('敏捷')+self.v1*self.owner:get('智力')
	end,
	--属性加成
 ['力量%'] = 10,
 ['敏捷%'] = 10,
 ['智力%'] = 10,
['攻击距离'] = 150,
['攻击距离极限'] = 150,

v1 = {30,450},
	--介绍
	tip = [[

|cffcccccc作为七大玄天至宝之一，它所掌控的空间法则是逆天的存在

|cffffff00+%智力%%|r |cffffff00%|r 全属性
|cffffff00+%攻击距离%|r  攻击距离（无视攻击距离上限）

|cff00ffff【被动-自爆】|r当生命值低于10% 时，对周围敌人造成全属性*%v1%范围技能伤害并晕眩3秒
 ]],
	--特效
	effect = [[FrostNova.mdx]],
	--业务技能代码
	time = 3,
}
function mt:damage_shot()
	local hero = self.owner 
	local skill = self
	for i, u in ac.selector()
		: in_range(hero,self.damage_area)
		: is_enemy(hero)
		: ipairs()
	do
		u:add_buff '晕眩'{
			time =self.time
		}
		u:damage
		{
			source = hero,
			skill = skill,
			damage = skill.damage,
		}
	end	
end
function mt:on_add()
	local hero = self.owner 
	local skill = self
	self.trg = hero:event '受到伤害效果'(function(_,damage)
		if skill:is_cooling() then 
			return 
		end
		local rate = hero:get('生命') /hero:get('生命上限')
		if rate <=10 then 
			self:damage_shot()
			self:active_cd()
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
