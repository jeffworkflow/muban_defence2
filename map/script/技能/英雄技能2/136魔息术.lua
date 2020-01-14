local mt = ac.skill['魔息术']
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
	skill_type = "主动,技暴",
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 20,
	--施法范围
	area = 500,
	--属性加成
['每秒加智力'] = {200,4000},
	--介绍
	tip = [[|cffffff00【每秒加智力】+200*Lv|r

|cff00bdec【主动施放】增加 |cffffff00技暴几率+(8+0.4*Lv)%  技暴伤害+(80+4*Lv)%  |r |cff00bdec持续5秒|r]],
	--技能图标
	art = [[dyyb.blp]],
	--特效4
	effect4 = [[参考赤灵的渡业妖爆]],
    --技暴几率
    skill_rate = function(self)
        return 8 + self.level*0.4
    end,
    --技暴伤害
    skill_damage = function(self)
        return 80 + self.level*4
    end,
    damage_type = '法术',
    time = 5
}
function mt:on_cast_start()
    local skill = self
    local hero = self.owner
    self.trg = hero:add_buff('渡业妖爆')
    {
        value = self.skill_rate,
        skill_rate = self.skill_rate,
        skill_damage = self.skill_damage,
        source = hero,
        time = self.time,
        skill = self,
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

local mt = ac.buff['渡业妖爆']
mt.cover_type = 1
mt.cover_max = 1
-- mt.keep = true

function mt:on_add()
    local target = self.target
    local hero = self.target
    target:add('技暴几率',self.skill_rate)   
    target:add('技暴伤害',self.skill_damage)   
end

function mt:on_remove()
    local target = self.target 
    target:add('技暴几率',-self.skill_rate)   
    target:add('技暴伤害',-self.skill_damage)   
    if self.eff then self.eff:remove() self.eff = nil   end
    if self.trg then self.trg:remove() self.trg = nil end
end
function mt:on_cover(new)
	return new.value > self.value
end