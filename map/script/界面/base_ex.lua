
--淡化
function class.ui_base:fade(time)
    --进行淡化
    ac.timer(time/100 * 1000,100,function(t)
        -- print((100-t.cnt)/100) 
        self:set_alpha((100-t.cnt)/100)
    end)
end   

--闪烁
function class.ui_base:blink(time,speed,keep)
    local time = time or 1
    local speed = speed or 0.2 --一闪烁来回时间
    local per_speed = 100 /(speed / 2 /0.001) 
    local flag=1
    local current_alpha = 1
    ac.timer(0.001*1000,math.floor(time/0.001),function(t)

        current_alpha = (current_alpha*100 - per_speed * flag)/100
        -- print('闪烁:',current_alpha)
        self:set_alpha(current_alpha)
        --变淡
        if current_alpha <= 0 then 
            flag = -1
        elseif current_alpha >= 1 then 
            flag = 1
        end

        if t.count <=0  then 
            local v = keep and 1 or 0 
            self:set_alpha(v)
        end
        
    end)
end   

local process = {}
setmetatable(process, process)
--结构
local mt = {}
process.__index = mt
mt.source = 0
mt.target = 0
function mt:get_target()
    return self.target
end
function mt:get_source()
    return self.source
end
function mt:set_target(v)
    self.target = v
    return self.target
end
function mt:set_source(v)
    self.source = v
    return self.source
end

function mt:start(data)
    if self.t_timer then 
        --刷新数据
        self:set_target(data.target)
        return 
    end
    
    if self.source == data.target then 
        -- print('相同的源',self.source,self.target,data.target)
        return 
    end

    local time = self.time or 2
    local cnt = math.floor( time/0.001 )
    self.t_timer = ac.timer(1,cnt,function(t)
        if t.count == 0 then 
            t:remove()
            self.t_timer = nil
            return
        end    
        local target = self:get_target()
        local source = self:get_source()
        -- print(t.count,'目标值和当前值',target,source)

        local distance = target - source
        local per_val = math.floor( distance / t.count)
        if per_val ~= 0 then 
            source = source + per_val
            self:set_source(source)
            self:show(source)
        end    
    end)

end
--设置动画 handle,target,time,show = function
function class.ui_base:set_process(data)
    local handle = data.handle
    if not handle then return end 

    local pr
    self.all_process = self.all_process  or {}
    --初始化
    if not self.all_process[handle] then 
        setmetatable(data, process)
        self.all_process[handle] = data
        pr = data
    else
        pr = self.all_process[handle]
    end
    
    pr:start(data)
    
end   