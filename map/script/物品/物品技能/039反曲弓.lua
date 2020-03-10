local mt = ac.skill['反曲弓']
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
	color = "蓝",
	--图标
	art = [[item\jineng208.blp]],
	--售价
	gold = 1000,
	--被动
	passive = true,
	--耗蓝
	cost = 1,
	--冷却时间
	cool = 1,
	--忽略技能冷却
	ignore_cool_save = true,
	--伤害
	damage = function(self)
  return (500000)* self.level
end,
	--属性加成
 ['敏捷'] = 3000000,
 ['攻击距离'] = 25,

v1 = {6,20},
v2 = {4,9},
	--介绍
	tip = [[|cffffff00+%敏捷%|r 敏捷
|cffffff00+%攻击距离%|r 攻击距离

|cffffe799【被动-多重箭】|r
攻击 %v1% %几率向周围 %v2% 个单位额外射出一只的魔法箭，造成 %damage% 的真实伤害
]],
	--备注
	effect4 = [[闪电链效果，路径lightnings\DrainLightning.blp]],
	--业务技能代码
	unique_name ='多重箭',
	cover = function(self)
		return self.v2
	end
}
mt.event_name = '造成伤害效果'
mt.chance = mt.v1

--计算高度
local function get_hith(u)
    local weapon_launch = u.weapon and u.weapon['弹道出手']
    local launch_z = weapon_launch and weapon_launch[3] or u:get_slk('launchZ', 0)
    launch_z = u:get_high() + launch_z
    return launch_z
end

function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
    local target = damage.target
	self.cnt = self.v2
	if not damage:is_common_attack()  then 
		return 
	end 
	
	for i, u in ac.selector()
		: in_range(target,self.damage_area)
		: is_enemy(hero)
		: random_int(self.cnt)
	do
		local ln = ac.lightning('LN09', hero, u,get_hith(hero),get_hith(u))
		ln:fade(-5)
		u:damage
		{
			source = hero,
			skill = skill,
			damage = skill.damage,
			real_damage = true,
		}
	end	
end
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end