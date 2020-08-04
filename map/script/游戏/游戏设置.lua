--游戏全局设置
--ac.rect.map 全图 rect.create(-4000,-4000,4000,4000) or
local rect = require("types.rect")
local region = require("types.region")
local slk = require 'jass.slk'
local effect = require 'types.effect'
local jass = require 'jass.common'
local player = require 'ac.player'
local Unit = require 'types.unit'
local fogmodifier = require 'types.fogmodifier'
local Skill = require 'ac.skill'

--游戏时长 
ac.g_game_time = 0 
local DaysNormalMonth = {[1] = 31, [2] = nil, [3] = 31, [4] = 30, [5] = 31, [6] = 30, [7] = 31, [8] = 31, [9] = 30, [10] = 31, [11] = 30, [12] = 31}
function getDaysWithMonth(month,year)
	if month == 2 then
		if (year%4 == 0 and year % 100 ~= 0) or (year % 100 == 0 and year % 400 == 0) then
			return 29
		else
			return 28
		end
	else
		return DaysNormalMonth[month]
	end
end

local ti = ac.loop(1000,function(t)
    --modify by jeff 
    ac.g_game_time = ac.g_game_time + 1
	local str = os.date("!%H:%M:%S",  ac.g_game_time)
	-- print(os.date("!%Y-%m-%d %H:%M:%S",1585755413))
	-- print(os.date("%Y-%m-%d %H:%M:%S",1585755413)) --北京时间

    ac.game.multiboard:set_time(str) --多面板显示
	-- ac.game.multiboard:set_title()
	local end_time = 60*60*7.5
	-- local end_time = 30-- 测试
    if ac.g_game_time == end_time  then
        ac.game:event_notify('游戏-结束')
        t:remove()
    end

end)


ac.game:event '玩家-金币变化' (function(_,data) 
	local gold = data.gold
	local player = data.player
	--大于100W 转为 100 木头
	local target_gold = 1000000
	if player.gold >=target_gold then
		player:addGold(-target_gold) 
		player:add_wood(100)
	end	
end)

--魔丸相关
player.__index.rec_ex = 0
function player.__index:get_rec_ex()
	return (self.rec_ex or 0) 
end	
--获得魔丸
--	魔丸数量
--	[漂浮文字显示位置]
--	[不抛出加木头事件]
function player.__index:add_rec_ex(rec_ex, where, flag)
	if not rec_ex or tonumber(rec_ex) == 0  then 
		return 
	end	
	local data = {player = self, rec_ex = rec_ex}
	if rec_ex > 0 and not flag then
		self:event_notify('玩家-即将获得魔丸', data)
		rec_ex = data.rec_ex
	end
	local rec_ex = tonumber(math.tointeger(rec_ex) or ('%.2f'):format(rec_ex))
	self.rec_ex = (self.rec_ex or 0) + rec_ex
	self.rec_ex = tonumber(math.tointeger(self.rec_ex) or ('%.2f'):format(self.rec_ex))
	-- self.rec_ex = jass.I2R(self.rec_ex)
	if self.rec_ex < 0 then 
		self.rec_ex = 0
	elseif self.rec_ex >= 5000000 then 
		self.rec_ex = 5000000
	end	
	self:event_notify('玩家-魔丸变化', data)

	if not where  then
		return
	end
	if not where:is_visible(self) then
		where = self.hero
		if not where then
			return
		end
	end
	local x, y,z = where:get_point():get()
	-- local z = where:get_point():getZ()
	local position = ac.point(x - 30, y, z + 30)
	--modify by jeff 金币小于0 也显示文字出来
	local str = nil
	if rec_ex < 0 then 
		 str =  bignum2string(rec_ex)
	else
		 str = '+' .. bignum2string(rec_ex)
	end	
	ac.texttag
	{
		string = str,
		size = 10,
		position = position,
		speed = 86,
		red = 223,
		green = 25,
		blue = 208,
		player = self,
		fade =1,
		life =1.5,
		show = ac.texttag.SHOW_SELF
	}
end
--单位获得魔丸
function Unit.__index:add_rec_ex(num)
	self:get_owner():add_rec_ex(num, where or self, flag)
end


--获取购买价格
function Skill.__index:buy_price()
	local gold = (self.player_gold and self.player_gold[ac.player.self]) and self.player_gold[ac.player.self] or (self.gold or 0)
	return self.gold or 0,gold,self.player_gold and self.player_gold[ac.player.self] 
end

--获取购买木头
function Skill.__index:buy_wood()
	local gold = (self.player_wood and self.player_wood[ac.player.self]) and self.player_wood[ac.player.self] or (self.wood or 0)
	return self.wood or 0,gold,self.player_wood and self.player_wood[ac.player.self] 
end

--获取购买杀敌数
function Skill.__index:buy_kill_count()
	local gold = (self.player_kill and self.player_kill[ac.player.self]) and self.player_kill[ac.player.self] or (self.kill_count or 0)
	-- print(gold,self.kill_count)
	self.kill_count = self.kill_count or 0 
	for i=1,10 do
		if ac.player(i) == ac.player.self then
			if ac.player.self.kill_count then 
				gold = gold ..'   |cff00ffff(拥有'..(ac.player.self.kill_count or '0')..')|r'
			end
		end	
	end
	self.show_kill_count = gold
	return self.kill_count,self.show_kill_count,self.player_kill and self.player_kill[ac.player.self] 
end


--获取购买积分
function Skill.__index:buy_jifen()
	local gold = (self.player_jifen and self.player_jifen[ac.player.self] ) and self.player_jifen[ac.player.self] or (self.jifen or 0)
	self.jifen = self.jifen or 0 
	-- self.jifen = gold
	for i=1,10 do
		if ac.player(i) == ac.player.self then
			gold = gold..'   |cff00ffff(拥有'..(ac.player.self.jifen or '0')..')|r'
		end	
	end
	self.show_jifen = gold
	return self.jifen,self.show_jifen,self.player_jifen and self.player_jifen[ac.player.self] 
end


--获取购买魔丸
function Skill.__index:buy_rec_ex()
	local gold = (self.player_rec_ex and self.player_rec_ex[ac.player.self]) and self.player_rec_ex[ac.player.self] or (self.rec_ex or 0)
	-- self.rec_ex = gold
	self.rec_ex = self.rec_ex or 0 
	for i=1,10 do
		if ac.player(i) == ac.player.self then
			gold = gold ..'   |cff00ffff(拥有'..(ac.player.self.rec_ex or '0')..')|r'
		end	
	end
	self.show_rec_ex = gold
	return self.rec_ex,self.show_rec_ex,self.player_rec_ex and self.player_rec_ex[ac.player.self] 
end


local function find_unit(name)
	local unit
	for key,val in pairs(ac.unit.all_units) do 
		if finds(val:get_name(),name) then 
			unit = val
			break
		end
	end	
	return unit
end	
ac.find_unit = find_unit
--@table 
--@true不重复  
function player.__index:random(tab,flag)
	if type(tab) ~= 'table' then 
		print('传入的不是table')
		return 
	end
	if #tab <=0 then 
		print('传入的table不是序列号型')
		return 
	end
	local tab = ac.table_copy(tab) --使 不改变全局
	
	local index = math.random(#tab)
	local name = tab[index]
	if not name then print('没有 name') return end 
	table.remove(tab,index)
	
	self.flag = self.flag or {}
	if flag then 
		if not self.flag[name] then 
			self.flag[name] = true
			return name 
		else 
			return self:random(tab,flag)
		end
	else 
		return name
	end

end
--奖品
local award_list = { 
    ['攻击奖励'] =  {
        {    rand = 22.5, name = '随机力量',},
        {    rand = 22.5, name = '随机敏捷',},
        {    rand = 22.5, name = '随机智力',},
		{    rand = 22.5, name = '随机全属性',},
		
		{    rand = 1, name = '攻击速度+1%',},
		{    rand = 1, name = '分裂伤害+1%',},
		{    rand = 1, name = '攻击距离+1',},
        {    rand = 1, name = '暴击伤害+1%',},
        {    rand = 1, name = '技暴伤害+1%',},
        {    rand = 1, name = '会心伤害+1%',},
        {    rand = 1, name = '物理伤害加深+1%',},
        {    rand = 1, name = '技能伤害加深+1%',},
        {    rand = 1, name = '全伤加深+1%',},
        {    rand = 1, name = '对BOSS额外伤害+1%',},
    },
}

local function add_content(p)
	local rand_list = award_list['攻击奖励']
	local rand_name,rand_rate = ac.get_reward_name(rand_list)
	if not rand_name then 
		return true
	end
	--处理属性相关
	for k,v in string.gsub(rand_name,'-','+-'):gmatch '(%S+)%+([-%d.]+%s-)' do
		--增加人物属性
		-- print(k,v)
		p.hero:add(k,v)
		ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ff00'..rand_name..' ',3) 
	end  
	if finds(rand_name,'随机') then
		local attr = rand_name:sub(7,-1)
		local val = math.random(99)
		p.hero:add(attr,val)
		p:sendMsg('|cffebb608【系统】|r|cff00ff00'..attr..'+'..val..'|r ',3) 
	end
end
--禁止A队友
ac.game:event '单位-攻击开始' (function(self, data)
	if data.target:is_ally(data.source) then
		if data.target:get_name() ~= '游戏说明' then 
			data.source:issue_order 'stop'
			return true		--终结事件流程
		end	
		--攻击 游戏说明 加属性
		local p = data.source.owner
		add_content(p)
		
		--概率触发隐藏成就
		local rate = 0.08
		rate = 40
		if math.random(100000)/1000 < rate then 
			ac.active_yccj(p,'人间大炮')
		end

		local rate = 0.3
		rate = 40
		if math.random(100000)/1000 < rate then 
			ac.active_yccj(p,'天选之子')
		end
		
	end
end)
--游戏说明 被玩家12攻击则无敌5秒
ac.game:event '游戏-开始' (function()
	local unit = ac.find_unit('游戏说明')
    if not unit then return end
	unit:event '受到伤害效果'(function(_,damage)
		if damage.source:get_owner().id >=11 then 
			damage.target:add_buff '无敌'{
				time = 5
			}
		end	
	end)
end)

ac.map = {}
ac.map_area =  ac.rect.map --全图
ac.map.rects={
    ['刷怪1'] = rect.j_rect('cg1') ,
    ['刷怪2'] = rect.j_rect('cg2') ,
    ['刷怪3'] = rect.j_rect('cg3') ,
	['进攻点'] = rect.j_rect('jg1') ,
	['主城'] = rect.j_rect('jg2_jd') ,
	['游戏结束'] = rect.j_rect('jg2_jd') ,
	
	['选人区域'] =rect.j_rect('xuanrenjingtou') ,

    ['选人出生点'] =rect.j_rect('xrcs') ,
	['出生点'] =rect.j_rect('F2cs') ,

	--练功房 
	['练功房11'] =rect.j_rect('lgf11') ,
	['练功房12'] =rect.j_rect('lgf12') ,
	['练功房13'] =rect.j_rect('lgf13') ,
	['练功房14'] =rect.j_rect('lgf14') ,
	-- ['练功房刷怪1'] =rect.j_rect('lgfsg1') ,
	['练功房刷怪1'] =rect.j_rect('lgfbh1') ,

	['练功房21'] =rect.j_rect('lgf21') ,
	['练功房22'] =rect.j_rect('lgf22') ,
	['练功房23'] =rect.j_rect('lgf23') ,
	['练功房24'] =rect.j_rect('lgf24') ,
	['练功房刷怪2'] =rect.j_rect('lgfbh2') ,

	['练功房31'] =rect.j_rect('lgf31') ,
	['练功房32'] =rect.j_rect('lgf32') ,
	['练功房33'] =rect.j_rect('lgf33') ,
	['练功房34'] =rect.j_rect('lgf34') ,
	['练功房刷怪3'] =rect.j_rect('lgfbh3') ,

	['练功房41'] =rect.j_rect('lgf41') ,
	['练功房42'] =rect.j_rect('lgf42') ,
	['练功房43'] =rect.j_rect('lgf43') ,
	['练功房44'] =rect.j_rect('lgf44') ,
	['练功房刷怪4'] =rect.j_rect('lgfbh4') ,

	['练功房51'] =rect.j_rect('lgf51') ,
	['练功房52'] =rect.j_rect('lgf52') ,
	['练功房53'] =rect.j_rect('lgf53') ,
	['练功房54'] =rect.j_rect('lgf54') ,
	['练功房刷怪5'] =rect.j_rect('lgfbh5') ,

	['练功房61'] =rect.j_rect('lgf61') ,
	['练功房62'] =rect.j_rect('lgf62') ,
	['练功房63'] =rect.j_rect('lgf63') ,
	['练功房64'] =rect.j_rect('lgf64') ,
	['练功房刷怪6'] =rect.j_rect('lgfbh6') ,
	
	

	--藏宝图
	['藏宝图 '] =rect.j_rect('cbt1') ,
	['藏宝区'] =rect.j_rect('cbt2'),

	

}

ac.map.regions={
	['moshen4'] = ac.region.create(ac.rect.j_rect('moshen4')),
	['dujie2'] = ac.region.create(ac.rect.j_rect('dujie2')),
	['tupo2'] = ac.region.create(ac.rect.j_rect('tupo2')),
	['zhanjiuzhan2'] = ac.region.create(ac.rect.j_rect('zhanjiuzhan2')),
	['chiyanjia2'] = ac.region.create(ac.rect.j_rect('chiyanjia2')),
	['shaohuogun2'] = ac.region.create(ac.rect.j_rect('shaohuogun2')),
	['shixiezhu2'] = ac.region.create(ac.rect.j_rect('shixiezhu2')),
}
-- local minx, miny, maxx, maxy = ac.map.rects['刷怪']:get()
-- local point = rect.j_rect('sg002'):get_point()
-- print(minx, miny, maxx, maxy)
local minx, miny, maxx, maxy = ac.map_area:get()
-- print(minx, miny, maxx, maxy)

--关闭附近可通行的点
local function pathRegionInit(minx, miny, maxx, maxy)
	jass.EnumDestructablesInRect(jass.Rect(minx, miny, maxx, maxy), nil, function()
		local dstrct = jass.GetEnumDestructable()
		local id = jass.GetDestructableTypeId(dstrct)
		if tonumber(slk.destructable[id].walkable) == 1 then
			return
		end
		local x0, y0 = jass.GetDestructableX(dstrct), jass.GetDestructableY(dstrct)
		
		--将附近的区域加入不可通行区域
		--local rng = 64
		--point.path_region = point.path_region + rect.create(x - rng, y - rng, x + rng, y + rng)
		local fly = false
		if id == base.string2id 'YTfb' or id == base.string2id 'YTfc'  then
			fly = true
		end
		--关闭附近的通行
		for x = x0 - 64, x0 + 64, 32 do
			for y = y0 - 64, y0 + 64, 32 do
				jass.SetTerrainPathable(x, y, 1, false)
				if fly then
					jass.SetTerrainPathable(x, y, 2, false)
				end
				jass.RemoveDestructable(dstrct)
			end
		end
	end)
end
pathRegionInit(minx, miny, maxx, maxy)

--设置镜头平滑参数
-- jass.CameraSetSmoothingFactor(30.00)

--出地图者死 
local rect = ac.rect.create(minx-200, miny-500, maxx+200, maxy+800)
local out_reg = ac.region.create(rect)

out_reg:event '区域-离开' (function(trg, hero)
	if  not hero.out_map_dying then
		--标记已经在死了
		hero.out_map_dying = true
		print(hero:get_name(),'出地图死')
		hero:kill()
		-- --附近找个地方
		-- local p = hero:get_point() - {hero:get_facing() + math.random(-60, 60), math.random(800, 1000)}
		-- --找可通行点 
		-- p:findMoveablePoint(1000)
		-- --创建一个黑洞
		-- local eff = ac.effect(p, [[cosmic field_65.mdl]])
		-- eff.unit:set_size(1)
		-- eff.unit:shareVisible(hero:get_owner())
		-- eff.unit:addSight(400)

		-- local mvr = ac.mover.target
		-- {
		-- 	source = eff.unit,
		-- 	mover = hero,
		-- 	start = hero,
		-- 	target = eff.unit,
		-- 	speed = 0,
		-- 	accel = 100,
		-- 	skill = false,
		-- 	super = true,
		-- }

		-- local function kill()
		-- 	hero:add_buff '晕眩'
		-- 	{
		-- 		source = hero,
		-- 		time = 1,
		-- 	}
		-- 	hero:set_animation('death')
		-- 	local count = 45
		-- 	ac.loop(20, function(t)
		-- 		if count <= 0 then
		-- 			hero:kill()
		-- 			eff:remove()
		-- 			hero.out_map_dying = false
		-- 			hero:set_size(1)
		-- 			hero:set_high(0)
		-- 			if not hero:is_alive() then
		-- 				hero:add_restriction '阿卡林'
		-- 				hero:event '单位-复活' (function(trg)
		-- 					trg:remove()
		-- 					hero:remove_restriction '阿卡林'
		-- 				end)
		-- 			end
		-- 			t:remove()
		-- 			return
		-- 		end
		-- 		count = count - 1
		-- 		hero:set_size(0.022*count)
		-- 		hero:set_high(135-3*count)
		-- 		hero:blink(p,true,true)
		-- 		if count == 15 then
		-- 			ac.effect(p, [[shadowexplosion.mdl]]):remove()
		-- 		end
		-- 		if count > 15 then
		-- 			eff.unit:set_size(1.9-0.02*count)
		-- 		else
		-- 			eff.unit:set_size(0.1*count)
		-- 		end
		-- 	end)
		-- end
		
		-- if not mvr then
		-- 	kill()
		-- 	return
		-- end

		-- function mvr:on_remove()
		-- 	kill()
		-- end
	end
end)



