local mt = ac.skill['新手辅导员']
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
	skill_type = "攻速",
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 180,
	--作用在人身上
	strong_hero = true,
	--技能目标
	target_type = ac.skill.TARGET_TYPE_UNIT,
	--施法距离
	range = 1000,
	--目标允许  
	target_data = "联盟 玩家单位",
	--属性加成
 ['全属性%'] = 5,
	--介绍
	tip = [[ 
|cffffe799【全属性】+5%

|cff00ff00可以对最菜的队友辅导，让之获得|cffffff0050%攻速
|cff00ff00如果对自己主人施放，|cffffff00效果减半

]],
	--技能图标
	art = [[shilaimu.blp]],
	value = 50,
}
function mt:on_add()
    local skill = self
    local hero = self.owner
end
function mt:on_cast_start()
    local skill = self
    local p = self.owner.owner
    local peon = self.owner
    local hero = p.hero
	local target = self.target
	if target == hero then 
		target:add('攻击速度',self.value/2)
	else 
		target:add('攻击速度',self.value)
	end		
end
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
