local mt = ac.skill['真·毁灭之刃']
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
	art = [[item\jineng503.blp]],
	--售价
	gold = 1000,
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 1,
	--忽略技能冷却
	ignore_cool_save = true,
	--伤害
	damage = function(self)
  return (self.owner:get('攻击')*20+100000000)* self.level
end,
	--施法范围
	area = 500,
	--属性加成
 ['攻击'] = 210000000,
 ['技能基础伤害'] = 210000000,
 ['全伤加深'] = 100,

v1 = {6,20},
v2 = {100000000,1500000000},
v3 = {20,300},
	--介绍
	tip = [[|cffcccccc 世界有生就有灭，代表生的盘古斧诞生时，代表灭的毁灭之刃也同时诞生。

|cffffff00+%攻击%|r 攻击
|cffffff00+%技能基础伤害%|r 技能基础伤害
|cffffff00+%全伤加深% |cffffff00%|r 全伤加深

|cffffe799【被动-毁灭】|r
攻击 %v1% %几率对敌人造成 %v2% + |cffffe799攻击力*%v3%|r 的范围技能伤害
]],
	--特效
	effect = [[AA_bwaxec.mdx]],
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
