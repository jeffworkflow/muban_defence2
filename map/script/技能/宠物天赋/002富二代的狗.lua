local mt = ac.skill['富二代的狗']
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
 ['每秒加木头'] = -500,
	--介绍

tip = [[ 
|cffffe799移动速度+50

|cff00ff00使用羊皮纸、无字天书时候，10%概率再解密一次

]],
	--技能图标
    art = [[shadiao.blp]],
	passive = true,
	time = 10,
	
	awood = 1000000

}
function mt:on_add()
    local skill = self
	local hero = self.owner
	local p = hero.owner
	hero = p.hero 

	local wait = ac.wait(self.time*1000,function()
		for i=1,6 do 
			local p = ac.player(i)
			if p:is_player() and p.hero then 
				print('加木头啦',p)
				p.hero:add_wood(self.awood)
			end
		end
	end)
	self:set('h_wait',wait)

end
function mt:on_remove()
    local hero = self.owner
    if self.h_wait then
        self.h_wait:remove()
        self.h_wait = nil
    end
end



