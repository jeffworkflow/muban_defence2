local mt = ac.skill['灼热之刃']
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
	color = "金",
	--图标
	art = [[ReplaceableTextures\CommandButtons\BTNArcaniteMelee.blp]],
	--售价
	gold = 1000,
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 3,
	--忽略技能冷却
	ignore_cool_save = true,
	--伤害
	damage = function(self)
  return (self.owner:get('攻击')*12+1000000)* self.level
end,
	--施法范围
	area = 500,
	--属性加成
 ['攻击'] = 25000000,
 ['技能基础伤害'] = 25000000,
 ['全伤加深'] = 10,

v1 = {6,20},
v2 = {1000000,15000000},
v3 = {8,120},
	--介绍
	tip = [[|cffffff00+%攻击%|r 攻击
|cffffff00+%技能基础伤害%|r 技能基础伤害
|cffffff00+%全伤加深% |cffffff00%|r 全伤加深

|cffffe799【被动-附魔】|r
攻击 %v1% %几率对敌人造成 %v2% + |cffffe799攻击力*%v3%|r 的范围技能伤害
]],
	--特效
	effect = [[Tx_shenpan.mdx]],
	--备注
	effect4 = [[在目标点释放模型，范围500]],
	--业务技能代码
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
