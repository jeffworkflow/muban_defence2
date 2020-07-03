
local jass = require 'jass.common'
local dbg = require 'jass.debug'
local collectgarbage = collectgarbage
local unit = require 'types.unit'
local mover = require 'types.mover'
local effect = require 'types.effect'
local item = require 'types.item'
local math = math
local table = table

local DebugInfoMap = {}

local function print_skill()
	local hero = ac.player.self.hero
	if hero then 
		local str = ''
		for skl in hero:each_skill '英雄' do 
			str = str .. skl.name .. ' '
		end	
		print(hero,'已学技能:',str)
	end	
end

local type_list = {
    { '+dlb', "button" },
    { '+dlg', "dialog" },
    { '+w3d', "destructable" },
    { '+EIP', "effect" },
    { '+EIm', "effect" },
    { '+rev', "event" },
    { 'alvt', "event" },
    { 'bevt', "event" },
    { 'devt', "event" },
    { 'gevt', "event" },
    { 'gfvt', "event" },
    { 'pcvt', "event" },
    { 'pevt', "event" },
    { 'psvt', "event" },
    { 'tmet', "event" },
    { 'tmvt', "event" },
    { 'uevt', "event" },
    { '+flt', "filter" },
    { '+fgm', "fogmodifier" },
    { '+frc', "force" },
    { '+grp', "group" },
    { 'ghth', "hashtable" },
    { 'item', "item" },
    { '+loc', "location" },
    { '+mdb', "multiboard" },
    { '+ply', "player" },
    { '+rct', "rect" },
    { '+agr', "region" },
    { '+snd', "sound" },
    { '+tmr', "timer" },
    { '+tid', "timerdialog" },
    { '+trg', "trigger" },
    { '+tac', "triggeraction" },
    { 'tcnd', "triggercondition" },
    { '+w3u', "unit" },
}

local type_map = {}
for i,v in ipairs(type_list) do 
    type_map[v[1]] = v[2]
end 

function display_jass_object()
    local count = dbg.handlemax()
    --统计句柄数量
    local types = {}

	local all_count = 0

	local unit_pos_map = {}
	local effect_pos_map = {}

    for i = 1,count do 
        local handle = 0x100000 + i
        local info = dbg.handledef(handle)
        if info and info.type then 
            local str = type_map[info.type] or ''
            local num = types[str] or 0 
			num = num + 1 
			all_count = all_count + 1
			types[str] = num
			

			--统计单位 跟特效的 出生信息
			local handle_info = DebugInfoMap[handle]
			if handle_info then 
				if str == 'unit' then 
					local count = unit_pos_map[handle_info] or 0 

					unit_pos_map[handle_info] = count + 1

				elseif str == 'effect' then 
					local count = effect_pos_map[handle_info] or 0 

					effect_pos_map[handle_info] = count + 1
				end 
			end 
        end
	end
	


    print('--------------start------------')
    for k,v in pairs(types) do 
        print('类型',k,'数量',v)
	end
	print('统计数量',all_count,'底层获取数量',dbg.handlecount())
	if ac.player.self._debug then 
		for info,count in pairs(unit_pos_map) do 
			
			print('单位数量以及出生信息',count .. '个',info)
			print('=======')
		end 

		for info,count in pairs(effect_pos_map) do 
			print('特效数量以及出生信息',count .. '个',info)
			print('=======')
		end 
	end 

    print('--------------end------------')
    print('')
end  


ac.game:event '游戏-开始' (function()
	log.debug(('游戏开始: %.f'):format(ac.clock() / 1000))
end)


local Real = {}
for name,func in pairs(jass) do 
	Real[name] = func
end 

local function hookFunc(name,callback)
	rawset(jass,name,callback)
end 

local function unhookFunc(name)
	rawset(jass,name,Real[name])
end 

local function hookCreate(name)
	hookFunc(name,function (...)
		local retval = Real[name](...)
		if retval and retval > 0 then 
			DebugInfoMap[retval] = debug.traceback(1)
		end 
		return retval
	end)
end 

local function hookDestroy(name)
	hookFunc(name,function (handle)
		if handle and handle > 0 then 
			DebugInfoMap[handle] = nil 
		end 
		return Real[name](handle)
	end)
end 

local function enableDebug(bool)

	if bool then 
		hookCreate('CreateUnit')
		hookCreate('AddSpecialEffect')
		hookCreate('AddSpecialEffectTarget')

		hookDestroy('RemoveUnit')
		hookDestroy('DestroyEffect')
	else 
		unhookFunc('CreateUnit')
		unhookFunc('AddSpecialEffect')
		unhookFunc('AddSpecialEffectTarget')

		unhookFunc('RemoveUnit')
		unhookFunc('DestroyEffect')
	end 
end 


ac.game:event '玩家-聊天' ( function(trg, player, str)

	if str == '-debug_timer' then 
		ac.enable_debug_timer = true
		print('开启计时器debug')
	end 
	if str ~= '-debug' then
		return 
	end 
	player._debug = player._debug ~= true 

	enableDebug(player._debug)

end)


local function rawpairs(t)
	return next, t, nil
end


ac.loop(30 * 1000, function()
	print_skill()
	collectgarbage("collect")
	local lua_memory = collectgarbage 'count'
	print('------------Lua定期报告-----------')
	print(('时间: %.f'):format(ac.clock() / 1000))
	print(('内存[%.3fk]'):format(lua_memory))
	print(('jass句柄数[%d],历史最大句柄[%d]'):format(dbg.handlecount(), dbg.handlemax()))
	if ac.debug_print_timer then 
		ac.debug_print_timer()
	end
	print(('计时器 正常[%d]'):format(ac.timer_size()))
	-- print(('game计时器 正常[%d]'):format(game.timer_size()))

	local unit_normal_count = 0
	local creature_normal_count = 0
	local moni_normal_count = 0
	local unit_dead_count = 0
	local creature_dead_count = 0
	local moni_dead_count = 0
	local unit_removed_count = 0
	local creature_removed_count = 0
	local moni_removed_count = 0
	for _, u in pairs(unit.all_units) do
		if u:is_alive() then
			if u:get_class()=='模拟死亡' then
				moni_normal_count = moni_normal_count + 1
			elseif u:get_class() then
				unit_normal_count = unit_normal_count + 1
			else
				creature_normal_count = creature_normal_count + 1
			end
		else
			if u:get_class()=='模拟死亡' then
				moni_dead_count = moni_dead_count + 1
			elseif u:get_class() then
				unit_dead_count = unit_dead_count + 1
			else
				creature_dead_count = creature_dead_count + 1
			end
		end
	end
	for u in pairs(unit.removed_units) do
		if u:get_class()=='模拟死亡' then
			moni_removed_count = moni_removed_count + 1
		elseif u:get_class() then
			unit_removed_count = unit_removed_count + 1
		else
			creature_removed_count = creature_removed_count + 1
		end
	end

	

	print(('单位 正常[%d],死亡[%d],等待释放[%d]'):format(creature_normal_count, creature_dead_count, creature_removed_count))
	print(('马甲 正常[%d],死亡[%d],等待释放[%d]'):format(unit_normal_count, unit_dead_count, unit_removed_count))
	print(('模拟死亡 正常[%d],死亡[%d],等待释放[%d]'):format(moni_normal_count, moni_dead_count, moni_removed_count))
	
	local count1 = 0
	for _ in pairs(mover.mover_group) do
		count1 = count1 + 1
	end
	local count2 = 0
	for _ in pairs(mover.removed_mover) do
		count2 = count2 + 1
	end
	print(('运动器 正常[%d],等待释放[%d]'):format(count1, count2))

	local item_normal_count = 0
	for _, it in pairs(item.item_map) do
		item_normal_count = item_normal_count + 1
	end
	local item_removed_count = 0
	for u in pairs(item.removed_items) do
		item_removed_count = item_removed_count + 1
	end
	print((('物品 正常[%d],等待释放[%d]'):format(item_normal_count, item_removed_count)))

	local effect_normal_count = 0
	for _, it in pairs(ac.effects.effect_map) do
		effect_normal_count = effect_normal_count + 1
	end
	local effect_removed_count = 0
	for eff in pairs(ac.effects.removed_effects) do
		if not eff.item_show then 
			effect_removed_count = effect_removed_count + 1
		end
	end
	print((('特效 正常[%d],等待释放[%d]'):format(effect_normal_count, effect_removed_count)))
	-- count1 = 0
	-- for _ in pairs(ac.tree.all_trees) do 
	-- 	count1 = count1 + 1
	-- end 

	-- count2 = 0
	-- for _ in pairs(ac.tree.all_removed) do 
	-- 	count2 = count2 +1
	-- end 
	-- print(('可破坏物 正常[%d],等待释放[%d]'):format(count1, count2))
	-- log.debug('-----------------------------------------------------------')

	display_jass_object()
end)

function unit:__gc()
	if self.removed then
		return
	end
	log.warn(('[单位]失去引用但是没有被移除:[%s]'):format(self:get_name()))
end

function mover:__gc()
	if self.removed then
		return
	end
	log.warn(('[运动]失去引用但是没有被移除:[%s][%s]'):format(
		self.source:get_name(),
		self.skill and skill.skill.name
	))
end

function effect:__gc()
	if self.removed then
		return
	end
	log.warn(('[特效]失去引用但是没有被移除:[%s][%s]'):format(
		self.unit and self.unit:get_name(),
		self.model
	))
end

function item:__gc()
	if self.has_removed then
		return
	end
	log.warn(('[物品]失去引用但是没有被移除:[%s]%s'):format(self.name,self:get_point()))
end
--function trigger:__gc()
--	if self.removed then
--		return
--	end
--	log.error('[触发器]失去引用但是没有被移除')
--	for event in pairs(self.events) do
--		log.error(event.name)
--	end
--end

ac.game:event '游戏-结束' (function()
	collectgarbage()
	--log.debug '=========================='
	--log.debug '统计已经被移除但是依然被引用的触发器'
	--for self in pairs(trigger.removed_triggers) do
	--	log.debug(('++++触发器[%s]'):format(self))
	--	local u = self.unit_event_unit
	--	if u then
	--		log.debug(('单位[%s]'):format(u:get_name()))
	--	else
	--		log.debug('全局')
	--	end
	--	log.debug('曾使用的事件:' .. table.concat(self.event_names, ' '))
	--end
	if not base.release then
		-- log.debug '=========================='
		-- log.debug '统计死亡单位'
		-- for _, u in pairs(unit.all_units) do
		-- 	local self = u
		-- 	if not u:is_alive() then
		-- 		log.debug(('++++单位[%s][%s][%s][%s]'):format(self:get_name(), self.id, (self:get_class() or ''),self:get_point()))
		-- 		log.debug('所有者:' .. self:get_owner():get_name())
		-- 		log.debug(self,self.removed,self._is_alive,self:is_alive())
				
		-- 	end
		-- end
		log.debug '=========================='
		log.debug '统计已经被移除但是依然被引用的单位'
		for self in pairs(unit.removed_units) do
			log.debug(('++++单位[%s][%s]'):format(self:get_name(), self.id))
			log.debug('所有者:' .. self:get_owner():get_name())
			if self.model then
				log.debug('模型:' .. self.model)
			end
		end
		
		log.debug '=========================='
		log.debug '统计已经被移除但是依然被引用的特效'
		for eff in pairs(ac.effects.removed_effects) do
			log.debug(('++++特效[%s]'):format(eff.model))
		end
		
		log.debug '=========================='
		log.debug '统计已经被移除但是依然被引用的运动器'
		local callback_list = {'on_move', 'on_hit', 'on_remove', 'on_block', 'on_finish'}
		for self in pairs(mover.removed_mover) do
			log.debug(('++++运动器 name[%s] id[%s] model[%s]'):format(self.mover:get_name(), self.id, self.model))
			for i = 1, #callback_list do
				local name = callback_list[i]
				local f = self[name]
				if f then
					local info = debug.getinfo(f, 'S')
					log.debug(('[%s] - %s : %d'):format(name, info.source, info.linedefined))
				end
			end
		end
		
		log.debug( '==========================')
		log.debug( '统计已经被移除但是依然被引用的物品')
		for self in pairs(item.removed_items) do
			local x,y =self:get_point():get()
			log.debug((('++++物品[%s][%s][x:%s y:%s]'):format(self.name, self.type_id,x,y)))
			log.debug(('所有者:' .. (self.owner and self.owner:get_name() or '无')))
		end
	end

	unit.__gc = nil
	mover.__gc = nil
	effect.__gc = nil
	item.__gc = nil
	--trigger.__gc = nil
end)
