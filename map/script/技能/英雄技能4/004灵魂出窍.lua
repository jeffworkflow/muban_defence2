local mt = ac.skill['灵魂出窍']
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
	color = "神阶",
	--技能类型
	skill_type = "主动，全属性",
	--耗蓝
	cost = 0,
	--冷却时间
    cool = 550,
    -- cool = 4,
	--属性加成
['杀怪加全属性'] = {250,5000},
['攻击加全属性'] = {250,5000},
['每秒加全属性'] = {250,5000},
	--介绍
	tip = [[|cffffff00【杀怪加全属性】+250*Lv
【攻击加全属性】+250*Lv
【每秒加全属性】+250*Lv

|cff00bdec【主动施放】获得|cffffff00【（3% +0.1%*Lv）当前属性值】|cff00bdec的属性

]],
	--技能图标
	art = [[rizhaowuhua.blp]],
	--特效
	effect = [[az_juli01.mdx]],
	--特效4
    effect4 = [[触发时，每隔0.05秒在英雄身上播放一次特效，持续3次]],
    val = function(self)
        return 3+0.1*self.level
    end
}
function mt:play_eff()
    local hero = self.owner
    hero:add_effect('chest',self.effect):remove()
    ac.wait(0.1*1000,function()
        hero:add_effect('chest',self.effect):remove()
    end)
    ac.wait(0.2*1000,function()
        hero:add_effect('chest',self.effect):remove()
    end)
end
function mt:on_cast_start()
    local skill = self
    local hero = self.owner
    local p = self.owner.owner
    hero:add('力量',hero:get('力量')*self.val/100)  
    hero:add('敏捷',hero:get('敏捷')*self.val/100)  
    hero:add('智力',hero:get('智力')*self.val/100)  
    self:play_eff()
end