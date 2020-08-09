local mt = ac.skill['诛天始祖剑']
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
	art = [[ztszj.blp]],
	--售价
	gold = 1000,
	--被动
	passive = true,
	--耗蓝
	cost = 1,
	--冷却时间
	cool = 0.75,
	--忽略技能冷却
	ignore_cool_save = true,
	--属性加成
['力量%'] = 15,
['敏捷%'] = 15,
['智力%'] = 15,
 ['杀怪加全属性'] = 10000,
 ['攻击加全属性'] = 10000,
 ['每秒加全属性'] = 10000,
['会心伤害'] = 300,

v1 = {200,500},
v2 = {2,7},
	--介绍
	tip = [[

|cffcccccc世间万器之始祖，有着强大到忤逆秩序的力量。

|cffffff00+%智力%%|r |cffffff00%|r 全属性
|cffffff00+%杀怪加全属性%|r 杀怪加全属性
|cffffff00+%攻击加全属性%|r 攻击加全属性
|cffffff00+%每秒加全属性%|r 每秒加全属性
|cffffff00+%会心伤害%|r |cffffff00%|r 会心伤害

|cff00ffff【唯一被动-忤逆】|r攻击10% 几率增加自己，对BOSS额外伤害+%v1% % ，持续%v2%S，可叠加
]],
	--备注
	effect4 = [[爆头：对BOSS额外伤害，可叠加的那种，唯一]],
	--业务技能代码
	--业务技能代码
	unique_name ='永恒',
	cover = function(self)
		return self.v1
	end
}
mt.event_name = '造成伤害效果'
mt.chance = 10

function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
    local target = damage.target
    self.value = self.v1
	if not damage:is_common_attack()  then 
		return 
	end 
	hero:add_buff '永恒2'{
		time = self.v2,
		value = self.v1
	}
	
end

function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.skl1 then
        self.skl1:remove()
        self.skl1 = nil
    end
end


local mt = ac.buff['永恒2']
mt.cover_type = 1
-- mt.cover_max = 1
-- 攻击速度-250%，移动速度-50%
function mt:on_add()
	self.target:add('对BOSS额外伤害',self.value)
end

function mt:on_remove()
	self.target:add('对BOSS额外伤害',-self.value)
end

