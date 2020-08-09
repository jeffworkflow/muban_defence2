local mt = ac.skill['贪婪手']
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
	art = [[dianjinshou.blp]],
	--售价
	gold = 1000,
	--被动
	passive = true,
	--耗蓝
	cost = 1,
	--冷却时间
	cool = {270,180},
	--忽略技能冷却
	ignore_cool_save = true,
	--属性加成

 ['杀敌数加成'] = 60,
 ['物品获取率'] = 60,
 ['木头加成'] = 60,
 ['魔丸加成'] = 60,
 ['每秒加杀敌数'] = 20,
 ['每秒加木头'] = 500,
 ['每秒加魔丸'] = 1000,

v1 = {270,180},
	--介绍
	tip = [[

|cffcccccc贪婪是个丑恶的字眼,但它不放过任何一个人。

|cffffff00+%杀敌数加成%|r |cffffff00%|r 杀敌数加成
|cffffff00+%物品获取率%|r |cffffff00%|r 物品获取率
|cffffff00+%木头加成%|r |cffffff00%|r 木头加成
|cffffff00+%魔丸加成%|r |cffffff00%|r 魔丸加成
|cffffff00+%每秒加杀敌数%|r 每秒加杀敌数
|cffffff00+%每秒加木头%|r 每秒加木头
|cffffff00+%每秒加魔丸%|r 每秒加魔丸

|cff00ffff【唯一被动-贪婪】|r每隔%v1%秒，造出一个随机红色装备
 ]],
	--备注
	effect4 = [[印钞手的进化版本]],
	--业务技能代码
}
function mt:on_upgrade()
	local skill = self
	local hero = self.owner
	-- give_award(self,true)
	--计时器检测
	if not self.timer then 
		self.timer = ac.loop(1000,function()
			if skill:is_cooling() then 
				return 
			end
			--物品施法
			ac.item_cast(hero,self)
			if not self.owner then 
				self.timer:remove()
				self.timer = nil
			end
		end)
	end
end
function mt:on_cast_start()
	-- print('使用物品：',self.name)
	local skill = self
	local hero = self.owner
	local name = ac.quality_item['红'][math.random(#ac.quality_item['红'])]
	print('给了随机装备',name)
	hero:add_item(name)
end

function mt:on_remove()
	local hero = self.owner
	-- print('进入on_remove',self.name,self.timer)
    if self.timer then 
        self.timer:remove()
        self.timer = nil
    end 
    if self.eff then 
        self.eff:remove()
        self.eff = nil
    end 
end
