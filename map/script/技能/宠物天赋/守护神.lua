local mt = ac.skill['守护神']
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
 ['力量%'] = 10,
	--介绍
	tip = [[ 
|cffffe799【力量】+10%

|cff00ffff所有队友|cffffff00【每秒加护甲+5】
|cff00ffff基地|cffffff00【每秒加护甲+5】

]],
	--技能图标
    art = [[wugui.blp]],
    --光环影响范围
    area = 99999,
    --值
    team_value = function()
        return (ac.g_game_degree_attr or 1 ) * 5
    end,
    main_value = function()
        return (ac.g_game_degree_attr or 1 ) * 5
    end,
}
function mt:on_upgrade()
    local skill = self
    local hero = self.owner
    local player = hero:get_owner()
    local name = self:get_name()
    --升级时，需要先删除下之前的计时器、特效，再添加buff.
    -- self:on_remove()
    -- print('升级啦')
    if not self.timer then 
    -- self.eff = hero:add_effect('origin',self.effect)
        self.timer = ac.loop(1000,function ()
            for _,unit in ac.selector()
                : in_range(hero,self.area)
                : is_ally(hero)
                : ipairs()
            do  
                local value =self.team_value
                if unit == ac.main_unit then 
                    value = self.main_value 
                end 
                unit:add_buff(name)
                {
                    value = value,
                    time = 1,
                    source = hero,
                    skill = self,
                    effect = self.effect,
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

local mt = ac.buff['守护神']
mt.cover_type = 0

function mt:on_add()
    local target = self.target
    local eff
    if self.effect then 
        eff = target:add_effect('origin',self.effect)
    end
    self.eff = eff
    target:add('每秒加护甲',self.value)

end

function mt:on_remove()
    local target = self.target
    if self.eff then 
        self.eff:remove() 
        self.eff = nil 
    end
    target:add('每秒加护甲',-self.value)
end
function mt:on_cover(new)
    -- print('即将要覆盖啦',new.value > self.value)
	return new.value > self.value
end

