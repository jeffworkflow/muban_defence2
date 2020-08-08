local mt = ac.skill['盘古开天斧']
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
	art = [[pgktf.blp]],
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
['力量%'] = 35,
['攻击%'] = 100,
['分裂伤害'] = 500,
['减少周围护甲'] = 10000,
['全伤加深'] = 200,
['对BOSS额外伤害'] = 100,
	--介绍
	tip = [[

|cffcccccc|cffcccccc十大神器之一，具有毁天灭地之能，相传为盘古大神所持破开天地之物，性能不详。
]],
	--备注
	effect4 = [[强力量]],
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
