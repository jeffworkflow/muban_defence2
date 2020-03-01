local mt = ac.skill['朱雀羽']
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
	color = "金",
	--图标
	art = [[item\jineng307.blp]],
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
 ['技能基础伤害'] = 10000000,
 ['技能伤害加深'] = 20,
 ['每秒回血'] = 5,

v1 = {6,20},
v2 = {1000000,15000000},
v3 = {20,300},
	--介绍
	tip = [[|cffffff00+%技能基础伤害%|r 技能基础伤害
|cffffff00+%技能伤害加深%|r 技能伤害加深
|cffffff00+%每秒回血%|r 每秒回血

|cffffff00【被动-朱雀炎】|r攻击 %v1% %几率对敌人造成 %v2% +%v3% *智力的范围技能伤害]],
	--特效
	effect = [[Abilities\Spells\Other\BreathOfFire\BreathOfFireMissile.mdl]],
	--备注
	effect4 = [[参考 火焰呼吸；]],
	--业务技能代码
    damage = function(self)
		return self.v2 + self.v3*self.owner:get('智力')
	end,
}
mt.event_name = '造成伤害效果'
mt.chance = mt.v1
function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
    local target = damage.target

	if not damage:is_common_attack()  then 
		return 
	end 
	
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
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end