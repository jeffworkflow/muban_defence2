local mt = ac.skill['一点成金']
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
	--技能目标
	target_type = ac.skill.TARGET_TYPE_UNIT,
	--施法距离
	range = 1000,
	--属性加成
 ['攻击速度'] = 50,
	--介绍
    tip = [[|cff00ff00可以秒杀小怪并额外获得|cffffff00250木]],
    ex_wood = 250,
	--技能图标
	art = [[dianjinshou.blp]],
}
function mt:on_add()
    local skill = self
    local hero = self.owner
end
function mt:on_cast_start()
    local skill = self
    local hero = self.owner
    local target = self.target 
    target:kill()
    hero:add_wood(self.ex_wood)

end
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
