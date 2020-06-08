local mt = ac.skill['穿透炮弹']
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
	art = [[item\jineng201.blp]],
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
 ['攻击'] = 15000000,
 ['攻击速度'] = 50,
 ['对BOSS额外伤害'] = 5,
v1 = {6,20},
v2 = {-3.5,-7.5},
v3 = 0.5,
	--介绍
	tip = [[|cffffff00+%攻击%|r 攻击
|cffffff00+%攻击速度% |cffffff00%|r 攻击速度
|cffffff00+%对BOSS额外伤害% |cffffff00%|r 对BOSS额外伤害

|cffffe799【唯一被动-锋锐】|r
攻击 %v1% %几率减少敌人 %v2% % 的护甲，持续 %v3% 秒
]],
	--特效
	effect = [[Abilities\Spells\NightElf\FaerieFire\FaerieFireTarget.mdl]],
	--备注
	effect4 = [[模型放怪物头上

唯一被动-锋锐，不叠加

当怪物同时只会受到一个锋锐的效果]],
	--业务技能代码
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
