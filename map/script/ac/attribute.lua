--属性设置
local jass = require 'jass.common'

local Care = {
    '金币', 
    '木头',
    '食物', 
    '食物上限',

    '局内地图等级', 
    '宠物等级', 
    '翻倍', 

    '练功房怪',
    '强化成功概率',
    '藏宝图掉落概率', 
    '羊皮纸掉落概率',
    '无字天书掉落概率',
    '强化石掉落概率',
    '天谕掉落概率',
    '一颗神奇的种子掉落概率',
    '扭蛋券(十连抽)掉落概率',
    '超级扭蛋券(十连抽)掉落概率',
    '黑暗骰子掉落概率',
    '锻造次数',
    '扭蛋次数',

    '木头翻倍概率',
    '魔丸翻倍概率',
    '杀敌数翻倍概率',
    '全属性翻倍概率',

    '返还资源',

    '龙之血珠使用上限',
    '无谓因果使用上限',
    '吞噬丹使用上限',
    
    '万分之一空气概率',
    
}
ac.player_attr = Care

--基础值
local base_attr =[[
    金币 木头 食物 食物上限 局内地图等级 宠物等级 练功房怪
]]

local Show = {
    ['金币'] = function (player, v)
        jass.SetPlayerState(player._handle, 1, math.floor(v))
    end,
    ['木材'] = function (player, v)
        jass.SetPlayerState(player._handle, 2, math.floor(v))
    end,
    ['食物'] = function (player, v)
        jass.SetPlayerState(player._handle, 5, math.floor(v))
    end,
    ['食物上限'] = function (player, v)
        jass.SetPlayerState(player._handle, 4, math.floor(v))
    end,
}

local Set = {
}

local Get = {
}

local mt = ac.player.__index
-- mt.type = 'player attribute'

mt._base = {}
mt._rate = {}
mt._show = {}

-- 设置固定值，会清除百分比部分
function mt:set(k, v)
    local ext = k:sub(-1)
    if ext == '%' then
        error('设置属性不能带属性')
    end
    local wait = self:onSet(k)
    self._base[k] = v
    self._rate[k] = 0.0
    if wait then
        if wait() == false then
            return
        end
    end
    self:onShow(k)
end

function mt:get(k)
    --没有传key 表示获取玩家id
    if not k then 
        return self.id
    end    
    local base = self._base[k] or 0.0
    local rate = self._rate[k] or 0.0
    local v = base * (1.0 + rate / 100.0)
    if Get[k] then
        v = Get[k](self, v) or v
    end
    return math.tointeger(v) or v
end

function mt:add_tran(name, value)
	local base_name = name
	if name:sub(-1, -1) == '%' then
		base_name =  name:sub(1, -2)
		-- print(base_name)
		--如果是基础值，则调用英萌自带的加%函数，会先*基础值再+
		if finds(base_attr,base_name) then 
			self:add(name, value)
		else
		--%值 调用英萌自带的加，直接+
			self:add(base_name, value)
		end	
	else	
		--调用英萌自带的加，直接+
		self:add(base_name, value)
	end	
end

function mt:add(k, v)
    local ext = k:sub(-1)
    if ext == '%' then
        k = k:sub(1, -2)
        local wait = self:onSet(k)
        self._rate[k] = (self._rate[k] or 0.0) + v
        if wait then
            if wait() == false then
                return
            end
        end
        self:onShow(k)
    else
        local wait = self:onSet(k)
        self._base[k] = (self._base[k] or 0.0) + v
        if wait then
            if wait() == false then
                return
            end
        end
        self:onShow(k)
    end
    local used
    return function ()
        if used then
            return
        end
        used = true
        self:add(k, -v)
    end
end


function mt:onShow(k)
    if not Show[k] then
        return
    end
    local v = self:get(k)
    local s = self._show[k] or 0.0
    if v == s then
        return
    end
    local player = self
    local delta = v - s
    self._show[k] = v
    Show[k](player, v)
    player:eventNotify('玩家-属性变化', player, k, delta)
end

function mt:onSet(k)
    if not Set[k] then
        return nil
    end
    return Set[k](self)
end
-- local function init()
--     for i=1,10 do 

        
--     end
-- end 
-- init()    
-- return function (player)
--     local obj = setmetatable({
--         _player = player,
--         _base = {},
--         _rate = {},
--         _show = {},
--     }, mt)
--     for _, k in ipairs(Care) do
--         obj:set(k, 0.0)
--     end
--     return obj
-- end
