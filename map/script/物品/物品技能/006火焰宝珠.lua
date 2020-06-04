local mt = ac.skill['火焰宝珠']
mt{
    --初始等级
    level = 1,
    --最大等级
   max_level = 15,
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 400,
	--类型
	item_type = "装备",
	--品质
	color = "白",
	--图标
	art = [[ReplaceableTextures\CommandButtons\BTNOrbOfFire.blp]],
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
  return (150000)* self.level
end,
	--施法范围
	area = 800,
	--属性加成
 ['力量'] = 2000000,
v1 = {1,0.5},
	--介绍
	tip = [[|cffffff00+%力量%|r 力量

|cffffe799【唯一被动-献祭】|r
每隔 %v1% 秒能对周围敌人造成 %damage% 点真实伤害
]],
	--特效
	effect = [[Abilities\Spells\NightElf\Immolation\ImmolationTarget.mdl]],
	--备注
	effect4 = [[宠物携带无效

模型放怪物身上

唯一被动-献祭，不叠加，真实伤害

当怪物同时只会受到一个献祭的效果]],
	--业务技能代码
}
function mt:on_add()
    local skill = self
    local hero = self.owner 
    if not hero:is_hero() then return end
    self.trg = hero:loop(1000,function ()
		if not hero:is_alive() then return end 
        for i, u in ac.selector()
            : in_range(hero,self.area)
            : is_enemy(hero)
			: of_not_building()
			: ipairs()
        do 
            u:add_buff('火焰')
			{
				source = hero,
				skill = skill,
				time =  self.v1,
				pulse = self.v1,
				is_damage_on_add = false,
                damage = self.damage,
			}
        end
    end)
end
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
