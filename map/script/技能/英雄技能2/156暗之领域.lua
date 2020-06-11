local mt = ac.skill['暗之领域']
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
	skill_type = "主动,降敌护甲",
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 20,
	--施法范围
	area = 500,
	--属性加成
['减少周围护甲'] = {1050,2000},
	--介绍
	tip = [[

|cffffff00【减少周围护甲】+（1000+50*Lv）

|cff00bdec【唯一效果】使用后降低周围敌人（10+0.5*lv）%护甲，持续5秒|r

]],
	--技能图标
	art = [[azly.blp]],
	--特效4
	effect4 = [[参考赤灵的暗之领域]],
    value = {10.5,20}, --等差，最小，最大,
    time = 8,

}
function mt:on_cast_start()
    local skill = self
    local hero = self.owner

    for _,u in ac.selector()
        : in_range(hero,skill.area)
        : is_enemy(hero)
        : ipairs()
    do  
        u:add_buff('暗之领域')
        {
            value = self.value,
            source = hero,
            time = self.time,
            skill = self,
            effect = self.effect,
        }
        u:add_effect('chest',[[Abilities\Weapons\FireBallMissile\FireBallMissile.mdl]]):remove()
    end

end    
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end

local mt = ac.buff['暗之领域']
mt.cover_type = 1
mt.cover_max = 1
-- mt.keep = true

function mt:on_add()
    local target = self.target
    local hero = self.target
    target:add('护甲%',-self.value)   
end

function mt:on_remove()
    local target = self.target 
    target:add('护甲%',self.value)  
    if self.eff then self.eff:remove() self.eff = nil   end
    if self.trg then self.trg:remove() self.trg = nil end
end
function mt:on_cover(new)
	return new.value > self.value
end


