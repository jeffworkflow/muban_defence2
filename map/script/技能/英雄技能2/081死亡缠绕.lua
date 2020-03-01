local mt = ac.skill['死亡缠绕']
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
	skill_type = "主动,全属性",
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 20,
	--伤害
	damage = function(self)
  return ((self.owner:get('力量')+self.owner:get('智力')+self.owner:get('敏捷'))*2+10000)* self.level*5
end,
	--施法范围
	area = 500,
	--属性加成
['杀怪加全属性'] = {5,100},
['攻击加全属性'] = {5,100},
['每秒加全属性'] = {5,100},
	--介绍
	tip = [[

|cffffff00【杀怪加全属性】+5*Lv
【攻击加全属性】+5*Lv
【每秒加全属性】+5*Lv

|cff00bdec【主动施放】对周围敌人造成范围技能伤害
【伤害公式】（全属性*2+10000）*Lv*5|r

]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNDeathCoil.blp]],
	--特效
    effect = [[Abilities\Spells\Undead\DeathCoil\DeathCoilMissile.mdl]],
    casting_cnt = 1,
	--特效4
	effect4 = [[参考赤灵的死亡脉冲]],
}
function mt:on_add()
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
end
function mt:on_cast_shot()
    local skill = self
	local hero = self.owner
	local target = self.target
	local function start_damage()
        for i, u in ac.selector()
            : in_range(hero,self.area)
            : of_not_building()
            : is_enemy(hero)
            : ipairs()
        do
            local mvr = ac.mover.target
            {
                source = hero,
                target = u,
                model = skill.effect,
                speed = 600,
                height = 110,
                skill = skill,
            }
            if not mvr then
                return
            end
            function mvr:on_finish()
                u:damage
                {
                    source = hero,
                    damage = skill.damage ,
                    skill = skill,
                    damage_type = '法术'
                }	
            end
        end
	end

	--先释放一次，再释放4次
	start_damage()
	if self.casting_cnt >1 then 
		hero:timer(0.3*1000,self.casting_cnt-1,function(t)
			start_damage()
		end)
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
