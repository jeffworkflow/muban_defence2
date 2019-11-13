local mt = ac.skill['雷神']
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
	color = "天阶",
	--技能类型
	skill_type = "被动,智力",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 1,
	--忽略技能冷却
	ignore_cool_save = true,
	--伤害
	damage = function(self)
  return (self.owner:get('智力')*40+10000)* self.level
end,
	--施法范围
	area = 500,
	--属性加成
['每秒加智力'] = {1600,32000},
	--介绍
	tip = [[|cffffff00【每秒加智力】+1600*Lv

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（智力*40+10000）*Lv]],
	--技能图标
	art = [[leibao.blp]],
	--特效
	effect = [[AZ_Goods_TP_Target_effect.MDX]],
	--特效1
	effect1 = [[[Sepll]007.MDX]],
	--特效4
	effect4 = [[参考希尔瓦娜斯的雷暴，额外雷暴数量=6]],
    --随机雷暴数量
    count = 6,
	hit_area=100,
    --随机落雷的伤害 %
    ren_damage = 30,
}

--分散龙卷风
local function tornado(skill,target,max_damage)
    local hero = skill.owner
    --爆炸伤害范围
    local areaa = skill.hit_area 
    --伤害
    local damage = max_damage * 0.15
    for i=1,skill.count do
        local x,y = target:get_point():get()
        --取出最小值
        local ox = math.modf(x - skill.area/2)
        local max_x = math.modf(x + skill.area/2)
        --取出最大值
        local oy = math.modf(y - skill.area/2)
        local max_y = math.modf(y + skill.area/2)

        x = math.random(ox,max_x)
        y = math.random(oy,max_y)

        local poi = ac.point(x,y)
        ac.wait(i*100,function()
            --创建一个雷电特效
            ac.effect(poi,skill.effect,0,1,'origin'):remove()
            --创建一个爆炸特效
            ac.wait(130,function()
                ac.effect(poi,skill.effect1,0,2,'origin'):remove()
            end)
        end)
        --造成伤害
        for _, u in ac.selector():in_range(poi,areaa):is_enemy(hero):ipairs() do
            u:damage
            {
                source = hero,
                skill = skill,
                damage_type = '法术',
                damage = damage,
            }
        end
    end
end


function mt:on_add()
    local hero = self.owner
	local skill = self
    local function range_attack_start(hero,damage)
        if damage.skill and damage.skill.name == self.name then
            return
        end

        local max_damage = self.damage

        local target = damage.target
        local area = self.hit_area

        --创建一个雷电特效
        ac.effect(target:get_point(),self.effect,0,1,'origin'):remove()
        --创建一个爆炸特效
        ac.wait(130,function()
            ac.effect(target:get_point(),skill.effect1,0,2,'origin'):remove()
        end)
        --创建伤害
        for _, u in ac.selector():in_range(target,area):is_enemy(hero):ipairs() do
            u:damage
            {
                source = hero,
                skill = self,
                damage_type = '法术',
                damage = max_damage,
            }
        end
        tornado(self,target,max_damage)

    end

	self.trg = hero:event '造成伤害效果' (function(_,damage)
		if not damage:is_common_attack()  then 
			return 
		end 
		--技能是否正在CD
        if skill:is_cooling() then
			return 
		end
        --触发时修改攻击方式
        if math.random(100) <= self.chance then
            range_attack_start(hero,damage)
            hero:event_notify('技能-触发被动', self)
            --激活cd
            skill:active_cd()
        end 

    end)

end


function mt:on_remove()
	local hero = self.owner
	if self.trg then 
		self.trg:remove()
		self.trg=nil
	end
end


