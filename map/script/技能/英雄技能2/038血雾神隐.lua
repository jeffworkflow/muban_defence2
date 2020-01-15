local mt = ac.skill['血雾神隐']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    --最大等级
   max_level = 20,
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 500,
	--技能品阶
	color = "地阶",
	--技能类型
	skill_type = "被动,无敌",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 2.5,
	--忽略技能冷却
	ignore_cool_save = true,
	--属性加成
['护甲%'] = 10,
	--介绍
	tip = [[

|cffffff00【护甲】+10%

|cff00bdec【唯一被动】被攻击（45-Lv）次后开启一下技能|r|cffffff00（0.5秒内免疫任何伤害）|r

]],
	--技能图标
	art = [[xwsy.blp]],
    wtf_cnt = function(self)
        return 45-self.level
    end,
    time = 0.5,
	--特效4
	effect4 = [[唯一被动]],
}
function mt:on_upgrade()
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
    self.trg = hero:add_buff '唯一免伤几率' {
        value = skill.wtf_cnt,
        skill = skill
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
