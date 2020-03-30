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

--游戏时长 
ac.g_game_time = 0 

local ti = ac.loop(1000,function(t)
    --modify by jeff 
    ac.g_game_time = ac.g_game_time + 1
    local str = os.date("!%H:%M:%S",  ac.g_game_time)
    -- ranking.ui.date:set_text('游戏时长:'..str)
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
	local rec_ex = tonumber(string.format( "%.2f",rec_ex))
	self.rec_ex = (self.rec_ex or 0) + rec_ex
	-- self.rec_ex = jass.I2R(self.rec_ex)
	if self.rec_ex < 0 then 
		self.rec_ex = 0
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
local function findunit_byname(name)
	local unit
	for key,val in pairs(ac.unit.all_units) do 
		if val:get_name() == name then 
			unit = val
			break
		end
	end	
	return unit
end	
ac.game.findunit_byname = findunit_byname
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

--禁止A队友
ac.game:event '单位-攻击开始' (function(self, data)
	if data.target:is_ally(data.source) then
		if data.target:get_name() ~= '游戏说明' then 
			data.source:issue_order 'stop'
			return true		--终结事件流程
		end	
	end
end)
--游戏说明 被玩家12攻击则无敌5秒
ac.game:event '游戏-开始' (function()
	local unit = ac.game.findunit_byname('游戏说明')
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



