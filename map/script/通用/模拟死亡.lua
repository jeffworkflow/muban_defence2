
local dbg = require 'jass.debug'
--[[
模拟死亡：
1.单位类型为 模拟死亡的，第一次创建时，会赋值class 为模拟死亡，当它真正死亡时，不移除单位而是隐藏。
2.再次创建时，从all_unit 取class为模拟死亡且id 为预设id 且 已死亡过的单位。重新赋值并复活。
3.会动态拓展单位，若地图同时在场100只，则100只无法释放单位。 --用在练功房合适
]]
local unit = require("types.unit")
unit.simulation_units = {}
-- setmetatable(unit.simulation_units, {__mode = "kv"});
--根据类型取可用的handle  function player.__index:get_unit_handle(class) simulation
function unit.get_unit_handle(id,class)
    if not class then return end 
    local handle
    local u 
    -- for hd,j_u in pairs(unit.all_units) do 
	-- 	if j_u.id == id and j_u:get_class() == class and j_u.removed then 
    --         handle = hd
    --         u = j_u
	-- 		break
	-- 	end
    -- end	 
    for i,j_u in ipairs(unit.simulation_units) do 
        if j_u.id == id and j_u:get_class() == class and j_u.removed then 
            handle = j_u.handle
            u = j_u
            break
        end
    end	 
    return handle,u
end
function unit.__index:add_simu_remove(key)
    self._need_remove = self._need_remove or {}
    self._need_remove[key] = true
    
end
ac.game:event '单位-创建'(function(_,u)
    local name = u:get_name()
    local data = ac.table.UnitData[name]
    if data and data.class then
        u:set_class(data.class)
    end       
end)    
ac.game:event '单位-创建前'(function(_,id,self,j_id, x, y,face)
    -- if not data then return end
    local handle,u = unit.get_unit_handle(id,'模拟死亡')
    -- print(handle,u)
    if handle then 
        u.born_point = ac.point(x,y)
        u:set_position(ac.point(x,y),true,true) --需要提前设置位置
        -- print('1',u:get_point())
        -- local u = unit.init_unit(handle, self) --重新初始化
        -- print('2',u:get_point())
        -- jass.SetUnitOwner(handle,self.handle, false) --需要重新设置所有者
        u:set_owner(self,true)
        unit.remove_handle_map[handle] = nil 
        u.removed = nil
        u._is_alive = true
        if u:has_restriction '隐藏' then 
            u:remove_restriction '隐藏'
        end
        if u:has_restriction '定身' then 
            u:remove_restriction '定身'
        end
        if u:has_restriction '无敌' then 
            u:remove_restriction '无敌'
        end
        if u:has_restriction '缴械' then 
            u:remove_restriction '缴械'
        end
        -- u:remove_restriction '禁锢'
        --重新初始化相关属性
        for key in sortpairs(ac.unit.attribute) do 
            if key ~= '生命上限' and key~='魔法上限' and key~='生命' and key~='魔法' then
                u:set(key,0)
            end
        end
        u:set('生命', u:get '生命上限')
        -- print('单位创建前',u.handle)
        
        if ac.unit.init_attribute then 
            ac.unit.init_attribute(u)
        end

        return u
    end    
end)

ac.game:event '单位-移除'(function(_,self)
    if self:get_class() ~= '模拟死亡' then 
        return 
    end    
    --移除模拟死亡中对应的key 保存值，以免影响其他单位
    if self._need_remove then 
    for k in pairs(self._need_remove) do 
        if self[k] then 
            self[k] =nil 
        end
    end
end

    --处理移除时，单位操作
    self:add_restriction '隐藏'
    self:add_restriction '定身'
    self:add_restriction '无敌'
    -- self:add_restriction '禁锢'
    self:add_restriction '缴械'

    --移除单位的所有Buff
    if self.buffs then
        local buffs = {}
        for bff in pairs(self.buffs) do
            buffs[#buffs + 1] = bff
        end
        for i = 1, #buffs do
            buffs[i]:remove()
        end
    end
    --移除单位身上的计时器
    if self._timers then
        for i, t in ipairs(self._timers) do
            t:remove()
        end
    end
    --移除单位的所有技能
    for skill in self:each_skill() do
        skill:remove()
    end
    --只有英雄才删除物品
    if self:is_hero() then 
        for i = 1, 6 do
            local it = self:get_slot_item(i)
            if it then
                it:item_remove()
            end
        end
    end	
    --移除事件events
    self.events = nil
    
    unit.remove_handle_map[self.handle] = true
    --插入模拟死亡table
    local flag = true
    for i,u in ipairs(unit.simulation_units) do 
        if u.handle == self.handle then 
            flag = false
            break
        end  
    end    
    if flag then 
        table.insert(unit.simulation_units,self)
    end    

    --商店移除时使用
    if self.on_remove then 
        self:on_remove()
    end	
    return true
end)
--真正移除，移除模拟死亡
function unit.__index:real_remove()
    self._last_point = ac.point(jass.GetUnitX(self.handle), jass.GetUnitY(self.handle))
    
    if self:has_restriction '隐藏' then 
        self:remove_restriction '隐藏'
    end	
    self:removeAllEffects()
    --移除单位的所有Buff
    if self.buffs then
        local buffs = {}
        for bff in pairs(self.buffs) do
            buffs[#buffs + 1] = bff
        end
        for i = 1, #buffs do
            buffs[i]:remove()
        end
    end
    --移除单位的所有技能
    for skill in self:each_skill() do
        skill:remove()
    end
    --只有英雄才删除物品
    if self:is_hero() then 
        for i = 1, 6 do
            local it = self:get_slot_item(i)
            if it then
                it:item_remove()
            end
        end
    end	
    --移除单位身上的计时器
    if self._timers then
        for i, t in ipairs(self._timers) do
            t:remove()
        end
    end

    ignore_flag = true
    jass.RemoveUnit(self.handle)
    unit.remove_handle_map[self.handle] = true
    ignore_flag = false
    --从表中删除单位
    unit.all_units[self.handle] = nil
    unit.removed_units[self] = self
    dbg.handle_unref(self.handle)

    --商店移除时使用
    if self.on_remove then 
        self:on_remove()
    end	
end
--手动回收已创建过的单位。 先不写吧。基本上要一个正常流程的回收。然后一个标志去说我要回收。
function unit.all_real_remove()
    -- print('执行手动清除')
    -- for hd,j_u in pairs(unit.all_units) do 
    --     if  j_u:get_class() == '模拟死亡' and j_u.removed then 
    --         -- print('进入循环')
    --         j_u:real_remove()
	-- 	end
    -- end	 
    for i,j_u in ipairs(unit.simulation_units) do 
        if  j_u:get_class() == '模拟死亡' and j_u.removed then 
            j_u:real_remove()
        end    
    end   
    unit.simulation_units = {}
    -- print(#unit.simulation_units)
end
--5分钟清除一次 地图上的模拟死亡单位
local time = 5*60
ac.loop(time*1000,function()
    ac.unit.all_real_remove()
end)