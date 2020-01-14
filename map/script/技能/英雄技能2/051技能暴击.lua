local mt = ac.skill['技能暴击']
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
	color = "黄阶",
	--技能类型
	skill_type = "被动,技暴",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 1,
	--忽略技能冷却
	ignore_cool_save = true,
	--属性加成
['攻击加智力'] = {60,1200},
['技暴几率'] = {2.1,4},
['技暴伤害'] = {2,40},
	--介绍
	tip = [[|cffffff00【攻击加智力】+60*Lv|r
|cffffff00【技暴几率】+（2+0.1*Lv)%|r
【技暴伤害】+2%*Lv|r]],
	--技能图标
	art = [[jibao.blp]],
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
