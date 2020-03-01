local mt = ac.skill['含沙射影']
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
	skill_type = "主动,降敌命中",
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 20,
	--施法范围
	area = 500,
	--属性加成
['闪避'] = {5.1,7},
	--介绍
	tip = [[

|cffffff00【闪避】+（5+0.1*Lv）%

|cff00bdec【唯一效果】使用后周围敌人攻击有（5+0.5*lv）%几率丢失，持续5秒|r

]],
	--技能图标
	art = [[mzly.blp]],
	--特效4
	effect4 = [[参考赤灵的迷之领域]],
    value = {5.5,15},
    time = 5
}
function mt:on_add()
    local skill = self
    local hero = self.owner
end

function mt:on_cast_start()
    local skill = self
    local hero = self.owner
    
    for _,u in ac.selector()
        : in_range(hero,skill.damage_area)
        : is_enemy(hero)
        : ipairs()
    do  
        u:add_buff('迷之领域')
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
end

local mt = ac.buff['迷之领域']
mt.cover_type = 1
mt.cover_max = 1
-- mt.keep = true

function mt:on_add()
    local target = self.target
    local hero = self.target
    target:add('攻击丢失',self.value)   
end

function mt:on_remove()
    local target = self.target 
    target:add('攻击丢失',-self.value)    
    if self.eff then self.eff:remove() self.eff = nil end
    if self.trg then self.trg:remove() self.trg = nil end
end
function mt:on_cover(new)
	return new.value > self.value
end
