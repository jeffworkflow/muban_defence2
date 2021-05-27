local mt = ac.skill['真·潜行者的手段']
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
	color = "真天阶",
	--技能类型
	skill_type = "被动,攻速",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 3,
	--忽略技能冷却
	ignore_cool_save = true,
	--属性加成
['杀怪加攻击'] = {2000,40000},
['攻击速度'] = {15,300},
['攻击间隔'] = {-0.16,-0.35},
	--介绍
	tip = [[

|cffffff00【杀怪加攻击】+2000*Lv|r
|cffffff00【攻击速度】+15%*Lv|r
|cffffff00【攻击间隔】-（0.15+0.01*Lv）|r

]],
	--技能图标
	art = [[kuangzhanshi.blp]],
}
function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
    local target = damage.target
end
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
