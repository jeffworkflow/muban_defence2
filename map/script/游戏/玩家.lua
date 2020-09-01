
local player = require 'ac.player'
local hero = require 'types.hero'

--2个电脑
player.com = {}

	player.com[1] = player[11]
	player.com[2] = player[12]

	player.com['联盟勇士'] = player[11]
	player.com['恶魔公社'] = player[12]

--2组玩家
player.force = {}

	player.force[1] = {
		[0] = player.com[1],
		player[1],
		player[2],
		player[3],
		player[4],
		player[5],
		player[6],
	}

	player.force[2] = {
		[0] = player.com[2],
		player[7],
		player[8],
		player[9],
		player[10],
	}

--玩家敌对
for x = 0, 6 do
	for y = 0, 4 do
		player.force[1][x]:setAllianceSimple(player.force[2][y], false)
		player.force[2][y]:setAllianceSimple(player.force[1][x], false)
	end
	--允许控制中立被动的单位
	player.force[1][x]:setTeam(1)
	player.force[1][x]:enableControl(player[16])
end 

--队伍一 相互结盟
for x = 0, 6 do
	for y = 0,4 do
		player.force[1][x]:setAllianceSimple(player.force[1][y], true)
	end
end

--队伍二 相互结盟
for x = 0, 6 do
	for y = 0,4 do
		player.force[2][y]:setAllianceSimple(player.force[2][x], true)
	end
end
--允许控制中立被动的单位
for y = 0,4 do
	player.force[2][y]:setTeam(2)
	player.force[2][y]:enableControl(player[16])
end	


--玩家结盟
ac.init_alliance = function()
	--玩家敌对
	for x = 0, 6 do
		for y = 0,4 do
			player.force[1][x]:setAllianceSimple(player.force[2][y], false)
			player.force[2][y]:setAllianceSimple(player.force[1][x], false)
		end
		--允许控制中立被动的单位
		player.force[1][x]:setTeam(1)
		player.force[1][x]:enableControl(player[16])
	end 
	
	--队伍一 相互结盟
	for x = 0, 6 do
		for y = 0,4 do
			player.force[1][x]:setAllianceSimple(player.force[1][y], true)
		end
	end
	
	--队伍二 相互结盟
	for x = 0, 6 do
		for y = 0,4 do
			player.force[2][y]:setAllianceSimple(player.force[2][x], true)
		end
	end
	--允许控制中立被动的单位
	for y = 0,4 do
		player.force[2][y]:setTeam(2)
		player.force[2][y]:enableControl(player[16])
	end	
end
--玩家敌对
ac.init_enemy = function() 
	for x = 1, 6 do
		for y = 1, 6 do
			if x == y then 
				player.force[1][x]:setAllianceSimple(player.force[1][y], true)
			else
				player.force[1][x]:setAllianceSimple(player.force[1][y], false)
			end	
			
			if x == y then 
				player.force[1][y]:setAllianceSimple(player.force[1][x], true)
			else
				player.force[1][y]:setAllianceSimple(player.force[1][x], false)
			end	
			--设置队伍
			player.force[1][x]:setTeam(x)
		end
	end	
end	



--电脑与野怪互相友好
player.force[1][0]:setAllianceSimple(player[13], true)
player.force[2][0]:setAllianceSimple(player[13], true)
player[13]:setAllianceSimple(player.force[1][0], true)
player[13]:setAllianceSimple(player.force[2][0], true)

player.self:clearMsg()

--设置名字
player.com[1]:setName '联盟勇士'
player.com[2]:setName '恶魔公社'

--玩家离开通报
ac.game:event '玩家-离开' (function(trg, p)
	local hero = p.hero
	local hero_name
	if hero then
		hero_name = hero:get_name()
	else
		hero_name = '没有英雄'
	end
	player.self:sendMsg(('%s%s(%s)|r |cffff1111哭着逃跑了!|r'):format(p:getColorWord(), p:get_name(), hero_name),3)
end)

--玩家离开删除英雄并分钱
ac.game:event '玩家-离开' (function(trg, tp)
	local h = tp.hero
	if h then
		h:remove()
		hero.getAllHeros()[h] = nil
	end
	local peon = tp.peon
	if peon then
		peon:remove()
	end
	local mojian = tp.unit_mojian
	if mojian then
		mojian:remove()
	end
	local unit_shenjian = tp.unit_shenjian
	if unit_shenjian then
		unit_shenjian:remove()
	end
	local unit_fs = tp.unit_fs
	if unit_fs then
		unit_fs:remove()
	end
	local unit_ys = tp.unit_ys
	if unit_ys then
		unit_ys:remove()
	end
	--移除炮台
	if tp.paotai then 
		tp.paotai:remove()
		tp.paotai = nil
	end
end)