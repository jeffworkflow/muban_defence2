local mt = ac.skill['诸葛神弩']
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
	color = "神",
	--图标
	art = [[zgln.blp]],
	--售价
	gold = 1000,
	--被动
	passive = true,
	--耗蓝
	cost = 1,
	--冷却时间
	cool = 0.5,
	--忽略技能冷却
	ignore_cool_save = true,
	--属性加成
['攻击%'] = 100,
['杀怪加攻击'] = 40000,
['每秒加攻击'] = 40000,
['会心伤害'] = 300,
['多重射'] = 5,

v1 = {9,3},
	--介绍
	tip = [[

|cffcccccc三国时期诸葛亮制作的一种连弩，可多重射击，可连续射击

|cffffff00+%攻击%%|r |cffffff00%|r 攻击
|cffffff00+%杀怪加攻击%|r 杀怪加攻击
|cffffff00+%每秒加攻击%|r 每秒加攻击
|cffffff00+%会心伤害%|r |cffffff00%|r 会心伤害
|cffffff00+%多重射%|r 多重射

|cffffff00【唯一被动-连射】|r每攻击%v1%次，可以进行额外的一次普通攻击
]],
	--备注
	effect4 = [[连击，唯一]],
	--业务技能代码
}
function mt:on_upgrade()
    local skill = self
    local hero = self.owner
	local p = hero:get_owner()
	if self.bff then 
		self.bff:remove()
	end
	self.bff = hero:add_buff('诸葛神弩'){
		skill = skill,
		val = skill.v1
	}
end

function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.bff then
        self.bff:remove()
        self.bff = nil
    end
end

local mt = ac.buff['诸葛神弩']
mt.cover_type = 0
-- mt.cover_max = 1
-- 攻击速度-250%，移动速度-50%
function mt:on_add()
	local skill = self.skill
	self.trg = self.target:event '造成伤害效果'(function(_,damage)
		if not damage:is_common_attack()  then 
			return 
		end 
		if skill:is_cooling() then 
			return 
		end
		skill.lx = (skill.lx or 0) + 1
		skill:set('lx',skill.lx)
		-- print('造成伤害效果',skill.lx,math.floor(skill.v1) )
		if skill.lx >= math.floor(skill.v1) then
			skill:set('lx',0)
			--再发起一次攻击
			self.target:attack_start(damage.target)
			skill:active_cd()
		end

	end)
end

function mt:on_remove()
	if self.trg then 
		self.trg:remove()
		self.trg = nil 
	end
end
function mt:on_cover(new)
	return new.val < self.val
end
