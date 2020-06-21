local mt = ac.skill['凤凰之怒']
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
	color = "红",
	--图标
	art = [[item\jineng404.blp]],
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
 ['敏捷'] = 54000000,
 ['攻击距离'] = 65,
['触发概率加成'] = 5,
['多重射'] = 1,

v1 = {6,20},
v2 = {-0.2,-0.5},
v3 = 0.5,
	--介绍
	tip = [[|cffffff00+%敏捷%|r 敏捷
|cffffff00+%攻击距离%|r 攻击距离
|cffffff00+%触发概率加成% |cffffff00%|r 触发概率加成
|cffffff00+%多重射%|r 多重射

|cffffe799【被动-风速】|r
攻击 %v1% %几率 %v2% |cffffe799%|r的攻击间隔，持续 |cffffe7990.5|r 秒
]],
	--特效
	effect = [[Abilities\Spells\Undead\UnholyFrenzy\UnholyFrenzyTarget.mdl]],
	--备注
	effect4 = [[模型放英雄头上]],
	--业务技能代码
}
mt.event_name = '造成伤害效果'
mt.chance = mt.v1
mt.attr = '攻击间隔'
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
