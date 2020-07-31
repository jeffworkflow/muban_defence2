local mt = ac.skill['多重攻击']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    --最大等级
   max_level = 1,
	--流派
	skill_type = "技能触发类",
	--耗蓝
	cost = 0,
	--忽略技能冷却
	ignore_cool_save = true,
	--作用在人身上
	strong_hero = true,
	--属性加成
 ['多重射'] = 1,
	--介绍

tip = [[ 
|cffffe799移动速度+50

|cff00ff00使用羊皮纸、无字天书时候，10%概率再解密一次

]],
	--技能图标
    art = [[shadiao.blp]],
    passive = true,

}
function mt:on_add()
    local skill = self
	local hero = self.owner
	local p = hero.owner
	hero = p.hero 

	self.trg = hero:add_buff '多重攻击'{
		pulse = 5
	}



end
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
local mt = ac.buff['多重攻击']
mt.cover_type = 0
mt.effect =[[Abilities\Weapons\ChimaeraAcidMissile\ChimaeraAcidMissile.mdl]]
function mt:on_add()
end

function mt:on_pulse()
	local bff = self
	for i, unit in ac.selector()
		: in_range(self.target:get_point(),800)
		: is_enemy(self.target)
		: ipairs()
	do 
		if i<=9 then 
			--投射物
			local mvr = ac.mover.target
			{
				source = self.target,
				target = unit,
				model = self.effect,
				speed = 1000,
				height = 110,
				skill = '多重攻击',
				on_finish = function(self)
					unit:damage
					{
						source = bff.target,
						damage = bff.target:get('攻击') * 10,
						skill = '多重攻击',
						damage_type = '法术'
					}
				end
			}
		end
	end
end
function mt:on_remove()
end



