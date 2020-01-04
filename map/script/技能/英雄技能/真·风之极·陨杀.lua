local mt = ac.skill['真·风之极·陨杀']
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
  return (self.owner:get('智力')*80+100000000)* self.level
end,
	--施法范围
	area = 500,
	--属性加成
['攻击加智力'] = {960,19200},
	--介绍
	tip = [[|cffffff00【攻击加智力】+960*Lv

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（智力*80+100000000）*Lv
 ]],
	--技能图标
	art = [[fengbaozhili.blp]],
	--特效
	effect = [[AZ_Kaer_X1.mdx]],
	--特效1
	effect1 = [[AZ_Kaer_X1.mdx]],
	--特效4
	effect4 = [[参考赤灵传说的风暴之力，0.1秒后再触发一次风暴之力]],
    --自由碰撞时的碰撞半径
    hit_area = 100,
    --移动距离
    dis = 550,
    damage_type = '法术'
}
--分散龙卷风
local function tornado(skill,target,max_damage)
    local hero = skill.owner
    --角度
    local angle = 45
    --移动距离
    local dis = 350
    --碰撞范围
    local areaa = skill.hit_area
    --伤害
    local damage = max_damage * 0.1
    for i=0,3 do
        angle = angle + i * 90
        mvr = ac.mover.line
        {
            source = hero,
            model = skill.effect,
            angle = angle,
            distance = dis,
            speed = 500,
			skill = skill,
			damage = damage,
            hit_area = areaa,
            start = target,
            size = 0.7,
        }
        if mvr then
            function mvr:on_hit(dest)
                dest:damage
                {
                    source = hero,
                    skill = skill,
                    damage = damage,
                    damage_type = skill.damage_type,
                }
            end
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
        local distance1 =  target:get_point() * hero:get_point() 
        if distance1 >=200 then 
            distance1 = 200
        end    

        mvr = ac.mover.line
        {
            source = hero,
            model = self.effect,
            angle = hero:get_point()/target:get_point(),
            distance = self.dis,
            speed = 700,
			skill = self,
			damage = max_damage,
            hit_area = area,
            start = target:get_point() -{target:get_point()/hero:get_point(),distance1} 
        }

        if not mvr then
            return
        end

        function mvr:on_hit(dest)
            local mover = mvr.mover
            dest:damage
            {
                source = hero,
                skill = self.skill,
                damage = max_damage,
                damage_type = skill.damage_type,
            }
        end

        function mvr:on_remove()
            tornado(self.skill,mvr.mover:get_point(),max_damage)
        end


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
			ac.wait(100,function()
				range_attack_start(hero,damage)
			end)
            hero:event_notify('单位-触发被动', hero,self)
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