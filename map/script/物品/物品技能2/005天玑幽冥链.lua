local mt = ac.skill['天玑幽冥链']
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
	color = "黑",
	--图标
	art = [[tjyml.blp]],
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
 ['力量%'] = 10,
 ['杀怪加力量'] = 10000,
 ['攻击加力量'] = 10000,
 ['每秒加力量'] = 10000,
 ['全伤加深'] = 50,

v1 = {-5,-20},
	--介绍
	tip = [[

|cffcccccc天玑链,困神魔，幽冥锁中有着四个黑銫古字:天下太平

|cffffff00+%力量%%|r |cffffff00%|r 力量
|cffffff00+%杀怪加力量%|r 杀怪加力量
|cffffff00+%攻击加力量%|r 攻击加力量
|cffffff00+%每秒加力量%|r 每秒加力量
|cffffff00+%全伤加深%|r |cffffff00%|r 全伤加深

|cff00ffff【唯一被动-天下太平】|r减少周围敌人%v1% %的攻击
]],
	--备注
	effect4 = [[降低敌人的攻击]],
	--业务技能代码
	area = 3000
}
mt.aura = {'天下太平'}
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