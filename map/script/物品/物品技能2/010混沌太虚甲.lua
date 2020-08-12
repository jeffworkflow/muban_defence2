local mt = ac.skill['混沌太虚甲']
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
	art = [[hdtxj.blp]],
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
['每秒加护甲'] = 200,
['护甲%'] = 35,
['减伤'] = 15,
['免伤几率'] = 15,
['闪避'] = 15,
['每秒回血'] = 25,
	--介绍
	tip = [[

|cffcccccc十大神器之一，相传为盘古大神破开天地之后，天地胎膜所化，性能不详。
]],
	--备注
	effect4 = [[强护甲]],
	v1 = {1,1},
	--业务技能代码
}
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
