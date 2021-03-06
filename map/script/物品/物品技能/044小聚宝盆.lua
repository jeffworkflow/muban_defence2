local mt = ac.skill['小聚宝盆']
mt{
    --初始等级
    level = 1,
    --最大等级
   max_level = 15,
    --触发几率
   chance = function(self) return self.level+5 end,
    --伤害范围
   damage_area = 500,
	--类型
	item_type = "装备",
	--品质
	color = "蓝",
	--图标
	art = [[jubaopen.blp]],
	--售价
	gold = 1000,
	--被动
	passive = true,
	--耗蓝
	cost = 1,
	--冷却时间
	cool = {405,315},
	--忽略技能冷却
	ignore_cool_save = true,
	--属性加成
 ['每秒加杀敌数'] = 1,
 ['每秒加木头'] = 10,
 ['每秒加魔丸'] = 25,

	v1 = {405,315},


	--介绍
	tip = [[|cffffff00+%每秒加杀敌数%|r  每秒加杀敌数
|cffffff00+%每秒加木头%|r 每秒加木头
|cffffff00+%每秒加魔丸%|r 每秒加魔丸

|cffffe799【被动-造宝】|r每隔%v1%秒，造出一个随机装备
]],
	--业务技能代码
}
-- function mt:on_upgrade()
--     local skill = self
--     local hero = self.owner
--     local player = hero:get_owner()
-- 	if  self.timer then 
-- 		self.timer:remove()
-- 		self.timer = nil
-- 	end
-- 	self.timer = ac.loop(math.floor(self.v1)*1000,function ()
-- 		--随机装备
-- 		local name = ac.all_item[math.random(#ac.all_item)]
-- 		hero:add_item(name)
-- 	end)   
-- end
-- local function give_award(self,flag)
-- 	local skill = self
-- 	local hero = self.owner
-- 	if skill:is_cooling() then 
-- 		return 
-- 	end
-- 	if skill.owner then 
-- 		--随机装备
-- 		local name = ac.all_item[math.random(#ac.all_item)]
-- 		print('给了随机装备',name)
-- 		hero:add_item(name)
-- 		--激活cd
-- 		if flag then 
-- 			ac.wait(0,function()
-- 				skill:active_cd()
-- 			end)
-- 		else
-- 			skill:active_cd()
-- 		end

-- 	end
-- end
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
	local name = ac.all_item[math.random(#ac.all_item)]
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

--观察者模式进行 
-- ac.loop(1000,function()
-- 	for i,name in ipairs({'小聚宝盆','中聚宝盆','大聚宝盆','沈万三的聚宝盆'}) do 

-- 	end
-- end)