local mt = ac.skill['小剑']
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
	color = "白",
	--图标
	art = [[item\jineng104.blp]],
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
	--属性加成
 ['敏捷'] = 1000000,

v1 = {6,20},
v2 = {75,150},
v3 = 0.5,
	--介绍
	tip = [[|cffffff00+%敏捷%|r 敏捷

|cffffe799【被动-风速】|r
攻击 %v1% %几率提高 %v2% |cffffe799%|r的攻击速度，持续 |cffffe7990.5|r 秒
]],
	--特效
	effect = [[Abilities\Spells\Undead\UnholyFrenzy\UnholyFrenzyTarget.mdl]],
	--备注
	effect4 = [[模型放英雄头上]],
	--业务技能代码
}
mt.event_name = '造成伤害效果'
mt.chance = mt.v1
mt.attr = '攻击速度'
mt.time = mt.v3
function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
    local target = damage.target
    self.value = self.v2
	if not damage:is_common_attack()  then 
		return 
	end 
	
	hero:add_buff('属性_'..self.attr) {
		time = self.time,
		value= self.value,
		cover_type = 0, --独占
		ref = 'overhead',
		model = self.effect,
	}
end
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
