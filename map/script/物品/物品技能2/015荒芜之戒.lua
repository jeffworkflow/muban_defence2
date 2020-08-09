local mt = ac.skill['荒芜之戒']
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
	color = "神",
	--图标
	art = [[hwzj.blp]],
	--售价
	gold = 1000,
	--被动
	passive = true,
	--耗蓝
	cost = 1,
	--冷却时间
	cool = 1,
	--忽略技能冷却
	ignore_cool_save = true,
	--属性加成
['智力%'] = 35,
['技能冷却'] = 10,
['触发概率加成'] = 50,
['技暴伤害'] = 600,
['技能伤害加深'] = 300,

v1 = {-6,-12},
	--介绍
	tip = [[

|cffcccccc万年圣物，荒芜之戒。

|cffffff00+%智力%%|r |cffffff00%|r 智力
|cffffff00+%技能冷却%|r |cffffff00%|r 技能冷却
|cffffff00+%触发概率加成%|r |cffffff00%|r 触发概率加成
|cffffff00+%技暴伤害%|r |cffffff00%|r 技暴伤害
|cffffff00+%技能伤害加深%|r |cffffff00%|r 技能伤害加深

|cff00ffff【唯一被动-荒芜】|r减少周围敌人%v1% %的护甲
]],
	--业务技能代码
	area = 3000
}
mt.aura = {'荒芜'}
function mt:on_upgrade()
    local skill = self
    local hero = self.owner
    local player = hero:get_owner()
    if not self.timer then 
        self.timer = ac.loop(1000,function ()
            for _,unit in ac.selector()
                : in_range(hero,self.area)
                : is_enemy(hero)
                : ipairs()
            do  
                for i,name in ipairs(self.aura) do
                    unit:add_buff(name)
                    {
                        value = self['v'..i],
                        time = 1,
                        source = hero,
                        skill = self,
						cover = math.abs(self['v'..i])
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