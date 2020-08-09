local mt = ac.skill['乾坤刺']
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
	art = [[cqc.blp]],
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

['敏捷%'] = 35,
 ['暴击几率'] = 10,
 ['暴击伤害'] = 1500,
 ['多重暴击几率'] = 5,
 ['多重暴击'] = 1,

v1 = {6,20},
v2 = {-8,-20},
v3 = 0.5,
	--介绍
	tip = [[

|cffcccccc可穿刺空间，瞬间到达混沌空间的任意角落

|cffffff00+%敏捷%%|r |cffffff00%|r 敏捷
|cffffff00+%暴击几率%|r |cffffff00%|r 暴击几率
|cffffff00+%暴击伤害%|r |cffffff00%|r 暴击伤害
|cffffff00+%多重暴击几率%|r |cffffff00%|r 多重暴击几率
|cffffff00+%多重暴击%|r 多重暴击

|cff00ffff【唯一被动-锋锐】|r
攻击 %v1% %几率减少敌人 %v2% % 的护甲，持续 %v3% 秒
]],
	--业务技能代码
	
	--特效
	effect = [[Abilities\Spells\NightElf\FaerieFire\FaerieFireTarget.mdl]],
}
mt.event_name = '造成伤害效果'
mt.chance = mt.v1
mt.attr = '护甲%'
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
	
	target:add_buff('属性_'..self.attr) {
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
