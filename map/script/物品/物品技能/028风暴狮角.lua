local mt = ac.skill['风暴狮角']
mt{
    --初始等级
    level = 1,
    --最大等级
   max_level = 15,
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 500,
	--类型
	item_type = "装备",
	--品质
	color = "白",
	--图标
	art = [[ReplaceableTextures\CommandButtons\BTNLionHorn.blp]],
	--售价
	gold = 1000,
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--忽略技能冷却
	ignore_cool_save = true,
	--属性加成
v1 = {5,35},
	--介绍
	tip = [[

|cffffe799【唯一被动-专注】|r能给周围友军提供额外 %v1% |cffffe799%|r的生命上限
]],


	--业务技能代码
	area = 1000,
}
mt.aura = {'专注'}

function mt:on_upgrade()
    local skill = self
    local hero = self.owner
    local player = hero:get_owner()
    if not self.timer then 
        self.timer = ac.loop(1000,function ()
            for _,unit in ac.selector()
                : in_range(hero,self.area)
                : is_ally(hero)
                : ipairs()
            do  
                for i,name in ipairs(self.aura) do
                    unit:add_buff(name)
                    {
                        value = self['v'..i],
                        time = 1,
                        source = hero,
                        skill = self,
                    }
                end
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