local mt = ac.skill['家里有矿']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    --最大等级
   max_level = 5,
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 500,
	--流派
	skill_type = "资源",
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 120,
	--作用在人身上
	strong_hero = true,
	--属性加成
 ['生命上限%'] = 20,
	--介绍
	tip = [[|cff00ff00在基地掉下大量金币]],
	--技能图标
	art = [[jinkuang.blp]],
	--特效
	effect = [[UAcoin.mdx]],
}
function mt:on_add()
    local skill = self
    local hero = self.owner
end
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
