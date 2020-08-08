local mt = ac.skill['真·灵魂出窍']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    --最大等级
   max_level = 20,
    --触发几率
   chance = function(self) return 0.8*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 500,
	--技能品阶
	color = "真神阶",
	--技能类型
	skill_type = "被动，全属性",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 1,
	--忽略技能冷却
	ignore_cool_save = true,
	--属性加成
['杀怪加全属性'] = {300,6000},
['攻击加全属性'] = {300,6000},
['每秒加全属性'] = {300,6000},
	--介绍
	tip = [[|cffffff00【杀怪加全属性】+300*Lv
【攻击加全属性】+300*Lv
【每秒加全属性】+300*Lv

|cff00bdec【被动效果】杀怪 1% 几率获得|cffffff00【0.04%当前属性值】|cff00bdec的属性
 ]],
	--技能图标
	art = [[rizhaowuhua.blp]],
	--特效
	effect = [[az_juli01.mdx]],
	--特效4
	effect4 = [[触发时，每隔0.05秒在英雄身上播放一次特效，持续3次]],
	--被动事件
	event_name = "单位-杀死单位",
	val =0.04
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
function mt:damage_start(source,target)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
	local target = target
	
    hero:add('力量',math.min(hero:get('力量')*self.val/100,10000000000))  
    hero:add('敏捷',math.min(hero:get('敏捷')*self.val/100,10000000000))  
    hero:add('智力',math.min(hero:get('智力')*self.val/100,10000000000))  

	self:play_eff()
	
end