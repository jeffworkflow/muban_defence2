local mt = ac.skill['不是一般的鸡']
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
	skill_type = "宠物类",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--忽略技能冷却
	ignore_cool_save = true,
	--作用在人身上
	strong_hero = true,
	--属性加成
 ['技暴几率'] = 5,
    ex_peon_lv = 5,
	--介绍
	tip = [[
|cffffe799【技暴几率】+5%

|cff00ff00宠物等级加|cffffff005级

]],
	--技能图标
	art = [[gaojiji.blp]],
}
function mt:on_add()
    local skill = self
    local hero = self.owner
    local p=hero:get_owner()
    p:add('宠物等级',self.ex_peon_lv)
end
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
    local p=hero:get_owner()
    p:add('宠物等级',-self.ex_peon_lv)
end
