local mt = ac.skill['真·碎魂天袭']
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
	skill_type = "被动,降敌护甲",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 2,
	--忽略技能冷却
	ignore_cool_save = true,
	--被动事件
	event_name = "造成伤害效果",
	--施法范围
	area = 500,
	--属性加成
['减少周围护甲'] = {850,1800},
	--介绍
	tip = [[

|cffffff00【减少周围护甲】+（800+50*Lv）

|cffffff00【唯一效果】攻击10%几率触发， 降低周围敌人（19+0.8*lv）护甲，持续1秒|r

]],
	--技能图标
	art = [[qhazly.blp]],
	--特效4
	effect4 = [[参考赤灵的暗之领域]],
    value = {19.8,35},
    time = 1
}
function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
	local target = damage.target
	
	if not damage:is_common_attack()  then 
		return 
	end 

    for _,u in ac.selector()
        : in_range(damage.target,skill.damage_area)
        : is_enemy(hero)
        : ipairs()
    do  
        u:add_buff('暗之领域')
        {
            value = self.value,
            source = hero,
            time = self.time,
            skill = self,
        }
    end
end
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
