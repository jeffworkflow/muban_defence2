local mt = ac.skill['邪婴万劫轮']
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
	art = [[xywjl.blp]],
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
 ['攻击%'] = 20,
 ['暴击几率'] = 10,
 ['暴击伤害'] = 800,
 ['物理伤害加深'] = 400,

v1 = {1,3},
v2 = {5,10},
	--介绍
	tip = [[

|cffcccccc由至恶之力所生，拥有最极致的毁灭之力

|cffffff00+%攻击%%|r |cffffff00%|r 攻击
|cffffff00+%暴击几率%|r |cffffff00%|r 暴击几率
|cffffff00+%暴击伤害%|r |cffffff00%|r 暴击伤害
|cffffff00+%物理伤害加深%|r |cffffff00%|r 物理伤害加深

|cff00ffff【唯一被动-万劫无生】|r攻击%v1% % 几率对范围的敌人，造成当前最大生命值%v2% %的伤害
]],
	--特效
	effect = [[AZ_Leviathan_V2.mdx]],
	--备注
	effect4 = [[降低敌人的生命百分比]],
	--业务技能代码
	unique_name ='万劫无生',
	cover = function(self)
		return self.v2
	end
}
mt.event_name = '造成伤害效果'
mt.chance = mt.v1

function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
    local target = damage.target
    self.value = self.v2
	if not damage:is_common_attack()  then 
		return 
	end 
	
	for i, u in ac.selector()
		: in_range(target,self.damage_area)
		: is_enemy(hero)
		: ipairs()
	do
		u:damage
		{
			source = hero,
			skill = skill,
			damage = u:get('生命')*skill.v2/100, --当前生命上限的百分比
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
