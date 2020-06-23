local effect_class = require 'types.effect'
local rect = require 'types.rect'
local dbg = require 'jass.debug'
local mt = {}
setmetatable(mt,mt)
mt.__index = effect_class

effect_ex = mt
ac.effects = {}
ac.effects.effect_map = {}
ac.effects.removed_effects = setmetatable({}, { __mode = 'kv' })

function mt:get_name()
    return '特效' .. tostring(self.handle)
end

function mt:set_point(loc)

    if self.start_point * loc > 1500 then
        japi.EXSetEffectZ(self.handle, -500)
        dbg.handle_unref(self.handle)
        jass.DestroyEffect(self.handle)
        self.handle = jass.AddSpecialEffect(self.model, loc:get())
        dbg.handle_ref(self.handle)
        self.start_point = loc
        self:model_init()
    end

    self.point = loc
    japi.EXSetEffectXY(self.handle, loc[1],loc[2])
    --if loc[3] then
    --    self:set_height(loc[3])
    --end
end

function mt:get_point()
    local x = japi.EXGetEffectX(self.handle)
    local y = japi.EXGetEffectY(self.handle)
    -- local z = japi.EXGetEffectZ(self.handle)
    local z = self.high
    return ac.point(x,y,z)
end

function mt:set_high(h)
    self:set_height(h)
end

function mt:get_high()
    return self:get_height()
end

function mt:add_high(h)
    self:set_high(self:get_high() + h)
end


function mt:set_height(h)
    self.high = h or 0
    japi.EXSetEffectZ(self.handle, self.point:getZ() + self.high)
end

function mt:get_height()
    return self.high --japi.EXGetEffectZ(self.handle)
end


function mt:set_rotate(x,y,z)
    japi.EXEffectMatRotateX(self.handle, x - self.rotate[1])
    japi.EXEffectMatRotateY(self.handle, y - self.rotate[2])
    japi.EXEffectMatRotateZ(self.handle, z - self.rotate[3])
    self.rotate[1] = x
    self.rotate[2] = y
    self.rotate[3] = z
end
function mt:add_rotate(x,y,z)
    self.rotate[1] = self.rotate[1] + x
    self.rotate[2] = self.rotate[2] + y
    self.rotate[3] = self.rotate[3] + z
    japi.EXEffectMatRotateX(self.handle, x)
    japi.EXEffectMatRotateY(self.handle, y)
    japi.EXEffectMatRotateZ(self.handle, z)
end
function mt:set_rotate_ex(x,y,z)
    japi.EXEffectMatRotateX(self.handle, x)
    japi.EXEffectMatRotateY(self.handle, y)
    japi.EXEffectMatRotateZ(self.handle, z)
end

function mt:set_size(size)
    self.size = size
    japi.EXSetEffectSize(self.handle, size)
end

function mt:set_facing(facing)
    japi.EXEffectMatRotateZ(self.handle, facing - self.rotate[3])
    self.rotate[3] = facing
end
function mt:get_facing()
    return self.rotate[3]
end


function mt:set_speed(spd)
    japi.EXSetEffectSpeed(self.handle, spd)
end
function mt:add_scale(scale)
    self.scale = scale
    japi.EXEffectMatScale(self.handle, self.scale[1], self.scale[2], self.scale[3])
end

function mt:set_time(time)
    ac.wait(time * 1000,function ()
        self:remove()
    end)
end

function mt:kill(time)
    self:remove()
end

--移除
function mt:remove()
	if self.removed then
		return
	end

	ac.effects.effect_map[self.handle] = nil
    ac.effects.removed_effects[self] = self

	--判断绑在单位身上的特效
	if self.UnitEffectData then
		if self.UnitEffectData[self.socket..self.model].num > 1 then
			self.UnitEffectData[self.socket..self.model].num = self.UnitEffectData[self.socket..self.model].num - 1
		else
			self.UnitEffectData[self.socket..self.model] = nil
			jass.DestroyEffect(self.handle)
			dbg.handle_unref(self.handle)
			self.handle = nil
		end
	else
		jass.DestroyEffect(self.handle)
		dbg.handle_unref(self.handle)
		self.handle = nil
	end

    
	self.removed = true

	--从单位身上删除记录
	if self.unit then
		for i, v in ipairs(self.unit._effect_list) do
			if v == self then
				table.remove(self.unit._effect_list, i)
				break
			end
		end
	end
	if self.follow_timer then
		self.follow_timer:remove()
		self.follow_timer = nil
	end
end
-----------替代单位的方法------------------

--移动单位到指定位置(检查碰撞)
--	移动目标
--	[无视地形阻挡]
--	[无视地图边界]
function mt:set_position(where, path, super)
	if where:get_point():is_block(path, super) then
		return false
	end
	local x, y = where:get_point():get()
	local x1, y1, x2, y2 = rect.map:get()
	if x < x1 then
		x = x1
	elseif x > x2 then
		x = x2
	end
	if y < y1 then
		y = y1
	elseif y > y2 then
		y = y2
	end
	self:set_point(ac.point(x, y))
	return true
end
function mt:set_animation()

end

function mt:removeAllEffects()

end

function mt:is_alive()
    if self.removed then
        return false
    end
    return true
end

function mt:is_pause_mover()
    return false
end
-----------------------------------------

function mt:model_init()
	if self.scale then
		self:add_scale(self.scale)
	end
	--size
	if self.size and self.size ~= 1 then
		self:set_size(self.size)
	else
		self.size = 1
	end
    --high
    if self.high ~= 0 then
        self:set_height(self.high)
    end
	if self.rotate then
		self:set_rotate_ex(self.rotate[1],self.rotate[2],self.rotate[3])
	else
		self.rotate = {0,0,0}
    end
    if self.angle then
        self:set_facing(self.angle)
    end
	--speed
	if self.speed and self.speed~=0 then
		self:set_speed(self.speed)
	else
		self.speed = 1
	end
end


local function point_effect_simple(self, point)
    self.point = point
    self.model = (self.model == '' or not self.model) and  [[arrow.mdl]] or self.model
    if ac.low == true then
        if self.item_show then 
            self.handle = jass.AddSpecialEffect(self.model, point:get())
        else     
            self.handle = jass.AddSpecialEffect(ac.low_effect_model,point:get())
        end
    else
        self.handle = jass.AddSpecialEffect(self.model, point:get())
    end
	dbg.handle_ref(self.handle)

    setmetatable(self, {__index = effect_ex})
    self.start_point = self.point
    --记录到总表
    ac.effects.effect_map[self.handle] = self
    self:model_init()
	return self
end



ac.effect_ex = function(data)
    --point
    --rotate
    --model
    --size
    --speed
    --time
    if data.point == nil then

        print('点为空',debug.traceback())
    end
    local effect = point_effect_simple(data, data.point)
    if data.time then
        ac.timer(data.time*1000,1,function()
            if data.on_finish then 
                data:on_finish(effect) 
            end
            if effect then
                effect:remove()
            end
        end)
    else
        -- print('[warining]创建了一个永久存在的特效',data.model,data.time)
        -- 需要想想，加入到 memtest
        -- ac.wait(5*1000,function()
        --     if effect:is_alive() and not effect.item_show then 
        --         print('[warining]创建了一个永久存在的特效',data.model,effect:is_alive())
        --     end
        -- end)
    end
    if data.follow then
        effect.follow_timer = ac.loop(33, function()
            effect:set_point(data.follow:get_point())
        end)
    end
    return effect
end



