local mt = ac.skill['腐蚀光环']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    --最大等级
   max_level = 5,
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 500,
	--流派
	skill_type = "护甲+光环类",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--忽略技能冷却
	ignore_cool_save = true,
	--作用在人身上
	strong_hero = true,
	--属性加成
 ['暴击几率'] = 5,
	--介绍
	tip = [[ 
|cffffe799【暴击几率】+5%

|cff00ffff所有小怪|cffffff00【每秒加护甲-10】
|cff00ffff所有boss|cffffff00【每秒加护甲-20】

]],
	--技能图标
    art = [[kulotou.blp]],
    value = 10,
    value1 = 20,
    area = 3000,
}
function mt:on_upgrade()
    local skill = self
    local hero = self.owner
    local player = hero:get_owner()
    local name = self:get_name()
    --升级时，需要先删除下之前的计时器、特效，再添加buff.
    -- self:on_remove()
    if not self.timer then 
        self.eff = hero:add_effect('origin',self.effect)
        self.timer = ac.loop(1000,function ()
            for _,unit in ac.selector()
                : in_range(hero,self.area)
                : is_enemy(hero)
                : ipairs()
            do 
                unit:add_buff(name)
                {
                    value = unit.data.type =='boss' and self.value1  or self.value,
                    time = 1,
                    source = hero,
                    skill = self,
                }
            end 
        end)
    end    
 
end
function mt:on_remove()
    local hero = self.owner
    if self.timer then 
        self.timer:remove()
        self.timer = nil
    end 
    if self.eff then 
        self.eff:remove()
        self.eff = nil
    end 
end

local mt = ac.buff['腐蚀光环']
-- 魔兽中两个不同的专注光环会相互覆盖，但光环模版默认是不同来源的光环不会相互覆盖，所以要将这个buff改为全局buff。
mt.pulse = 1
mt.cover_type = 1
mt.cover_max = 1
mt.effect = [[]]
-- mt.keep = true

function mt:on_add()
    local target = self.target
    self.eff = target:add_effect('origin',self.effect)
    target:add('护甲',-self.value)

end

function mt:on_remove()
    local target = self.target
    if self.eff then self.eff:remove() end
end
function mt:on_cover(new)
	return new.value > self.value
end
