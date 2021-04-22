local mt = ac.skill['你怎么不去死']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
	is_order= 1,
    --最大等级
   max_level = 5,
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--忽略技能冷却
	ignore_cool_save = true,
	--作用在人身上
	strong_hero = true,
	--属性加成
 ['减少复活时间'] = 1,
	--介绍
	tip = [[ 
|cffffe799减少复活时间-1S

|cff00ff00当有英雄死亡时，给所有玩家发放|cffff0000150木头*游戏难度

]],
	--技能图标
	art = [[emogaoyang.blp]],
	wood  = function()
        return (ac.g_game_degree_attr or 1)*150
    end
}
function mt:on_add()
	local hero = self.owner 
	local p = hero.owner
	self.trg = ac.game:event '单位-死亡'(function(_,unit,killer)
		if not unit:is_hero() then 
			return 
		end
		for i=1,6 do 
			local p = ac.player(i)
			if p:is_player() and p.hero then 
				p.hero:add_wood(self.wood)
			end
		end
		--发送文字
		ac.player.self:sendMsg('|cffebb608【系统】|r |cff00ffff'..self.owner.owner:get_name()..' |cff00ff00的宠物【死亡羔羊】，对尸体进行分解，所有玩家获得|cffff0000150木头',5)
	
	end)
end

function mt:on_remove()
	if self.trg then 
		self.trg:remove()
		self.trg = nil
	end
end
