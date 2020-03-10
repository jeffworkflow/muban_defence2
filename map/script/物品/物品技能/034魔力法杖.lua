local mt = ac.skill['魔力法杖']
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
	art = [[item\jineng207.blp]],
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
	--属性加成
 ['技能基础伤害'] = 3000000,
 ['技能伤害加深'] = 10,

v1 = {6,20},
v2 = {100000,1500000},
v3 = {10,150},
	--介绍
	tip = [[|cffffff00+%技能基础伤害%|r 技能基础伤害
|cffffff00+%技能伤害加深% |cffffe799%|r 技能伤害加深

|cffffe799【被动-法力反馈】|r
攻击 %v1% %几率对敌人造成 %v2% +|cffffe799智力*%v3%|r 的范围技能伤害

]],
	--备注
	effect4 = [[对目标周围500码随机选择5个敌人造成伤害，闪电链效果，路径lightnings\drainmanalightning.blp]],
	--业务技能代码
    damage = function(self)
		return self.v2 + self.v3*self.owner:get('智力')
	end,
	cnt =5, --闪电链个数
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

	if not damage:is_common_attack()  then 
		return 
	end 
	
	for i, u in ac.selector()
		: in_range(target,self.damage_area)
		: is_enemy(hero)
		: random_int(5)
	do
		local ln = ac.lightning('LN08', hero, u,get_hith(hero),get_hith(u))
		ln:fade(-5)
		u:damage
		{
			source = hero,
			skill = skill,
			damage = skill.damage,
			damage_type = '法术'
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
