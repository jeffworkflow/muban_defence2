local mt = ac.skill['真·安东尼的法杖']
mt{
    --初始等级
    level = 1,
    --最大等级
   max_level = 15,
    --触发几率
   chance = function(self) return self.level+5 end,
    --伤害范围
   damage_area = 500,
	--类型
	item_type = "装备",
	--品质
	color = "黑",
	--图标
	art = [[item\jineng507.blp]],
	--售价
	gold = 1000,
	--被动
	passive = true,
	--耗蓝
	cost = 1,
	--冷却时间
	cool = 3,
	--忽略技能冷却
	ignore_cool_save = true,
	--属性加成
 ['技能基础伤害'] = 300000000,
 ['技能伤害加深'] = 200,
 ['每秒回血'] = 10,

v1 = {6,20},
v2 = {100000000,1500000000},
v3 = {32,480},
v4 = {20,35},
	--介绍
	tip = [[

|cffcccccc苍穹之下，高塔之上，魔法阵在安东尼的脚下亮起，四方元素精灵开始唱和

|cffffff00+%技能基础伤害%|r 技能基础伤害
|cffffff00+%技能伤害加深% |cffffe799%|r 技能伤害加深
|cffffff00+%每秒回血% |cffffe799%|r 每秒回血

|cffffe799【被动-冰晶突刺】|r
攻击 %v1% %几率对敌人造成 %v2% +|cffffe799智力*%v3%|r 的范围技能伤害，并减少 %v4% %的移动速度
 ]],
	--特效
	effect = [[Abilities\Spells\Undead\FrostNova\FrostNovaTarget.mdl]],
	--备注
	effect4 = [[模型放目标敌人身上，伤害范围500

减少移动速度持续时间0.75秒，不可叠加]],
	--业务技能代码
	--业务技能代码
    damage = function(self)
		return self.v2 + self.v3*self.owner:get('智力')
	end 
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
	ac.effect_ex{
		model = skill.effect,
		size = 4.3,
	    point = target:get_point(),
	}:remove()
	
	for i, u in ac.selector()
		: in_range(target,self.damage_area)
		: is_enemy(hero)
		: ipairs()
	do
		u:damage
		{
			source = hero,
			skill = skill,
			damage = skill.damage,
			damage_type = '法术'
		}
		u:add_buff '减速'{
			move_speed_rate = self.v4,
			time = 0.75
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
