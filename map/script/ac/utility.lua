function ac.split(str, p)
	local rt = {}
	str:gsub('[^'..p..']+', function (w)
		table.insert(rt, w)
	end)
	return rt
end

--计算2个角度之间的夹角
--	@夹角[0, 180]
--	@旋转方向(1 = 逆时针旋转, -1 = 顺时针旋转)
function ac.math_angle(r1, r2)
	local r = (r1 - r2) % 360
	if r >= 180 then
		return 360 - r, 1
	else
		return r, -1
	end
end


--========================================================
--         能按添加顺序遍历的数据结构 KEY要非int类型
--========================================================
local mt = {}
mt.__index = mt
function mt:insert(key,value)
    if not key then
        return false
    end
    self.count = self.count + 1
    local list = self.list
    if list[key] then
        return false
    end
    local n = #list+1
    list[n] = {key = key,value = value}
    list[key] = n
    return true
end

function mt:remove(key)
    local list = self.list
    local n = list[key]
    if not n then
        return false
    end
    self.count = self.count - 1
    list[n] = false
    list[key] = nil
    self:clean()
    return true
end

function mt:get_obj(k)
    local slot = self.list[k]
    return self.list[slot].value
end

function mt:has(key)
    local list = self.list
    return list[key] ~= nil
end

function mt:get(slot)
    local list = self.list
    return list[slot]
end

function mt:pairs()
    local i = 0
    local list = self.list

    local function nextObject()
        i = i + 1
        local obj = list[i]

        if obj then
            return obj.key,obj.value
        elseif obj == nil then
            return nil
        else
            return nextObject()
        end
    end

    return nextObject
end

function mt:ipairs()
    local i = 0
    local list = self.list

    local function nextObject()
        i = i + 1
        local obj = list[i]

        if obj then
            return obj.key,obj.value
        elseif obj == nil then
            return nil
        else
            return nextObject()
        end
    end

    return nextObject
end

function mt:get_count()
    local count = 0
    local list = self.list
    for i,v in ipairs(list) do
        if list[i] then
            count = count + 1
        end
    end

    return count
end

function mt:clean()
    if self.cleaning then
        return
    end

    local list = self.list
    self.cleaning = true
    ac.wait(0,function()
        self.cleaning = false
        local alive = 0
        for i = 1, #list do
            local obj = list[i]
            if obj then
                alive = alive + 1
                if i ~= alive then
                    list[alive] = obj
                    list[obj.key] = alive
                    list[i] = nil
                end
            else
                list[i] = nil
            end
        end
    end)
end

function mt:getList()
    local list = {}
    for i=1,#self.list do
        local obj = self.list[i]
        if obj then
            table.insert(list,obj)
        end
    end
    return list
end

function ac.list()
    return setmetatable({
        max = 10,
        list = {},
        cleaning = false,
        count = 0,
        _type = 'list'
    }, mt)
end