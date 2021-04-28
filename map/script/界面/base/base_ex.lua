--先改变 game.timer 
function game.timer(timeout, count, on_timer)
	if count == 0 then
		return game.loop(timeout, on_timer)
	end
	local t = game.loop(timeout, function(t)
        if not t.cnt then 
            t.cnt = 0
        end
        
        t.cnt = t.cnt + 1	
        count = count - 1
        t.count = count
        on_timer(t)
        if count <= 0 then
            if t.on_timeout then 
                t:on_timeout()
            end	
            t:remove()
        end
	end)
	return t
end
--文字，字体大小，返回宽度
ac.ui.get_auto_width = function(text,font_size)
    local tool = class.panel:builder
    {
        h = 30,
        w = 80,
        is_show = false,
        title = {
            font_size =font_size,
            type = 'text',
            text = text,
            align = 'auto_width',
        }
    }
    local w = tool.w
    tool:destroy()
    return w
end

function class.ui_base:get_point()
    local x,y = self:get_position()
    return ac.point(x,y)
end
--平移 
--@正数：淡化 负数：渐入
function class.ui_base:move(target,speed)
    if self.move_timer then 
        self.move_timer:remove()
    end 
    local speed = speed or 1 
    self.move_timer=game.loop(0.03*1000,function(t)
        --进行移动
        local source = self:get_point()
        local angle = source / target
        local new_point = source - {angle,speed}
        -- print('平移：',source,new_point,speed,speed*0.03)
        --检查碰撞
        local is_finish
        if new_point * target <= speed then 
            new_point = target
            is_finish = true
        end
        local x,y = new_point:get()
        self:set_position(x,y)
        if is_finish then 
            t:remove()
            self.move_timer = nil
        end
    end)
    self.move_timer:on_timer()
end   

--淡化 
--@正数：淡化 负数：渐入
function class.ui_base:fade(time,source)
    --进行淡化
    local time = time or 0.3
    local source = source or (time>0 and 100 or 0)
    local time = math.abs(time)
    if self.fade_timer then 
        self.fade_timer:remove()
    end 
    local timer_cnt = math.floor(time/0.001)
    self.fade_timer=game.timer(0.001 * 1000,timer_cnt,function(t)
        -- print((100-t.cnt)/100) 
        local speed = source / timer_cnt
        local val = math.abs(source - speed*t.cnt)
        --math.abs(source - t.cnt)/100
        self:set_alpha(val)
    end)
    self.fade_timer:on_timer()
end   
function class.ui_base:fade(time)
        --进行淡化
    local time = time or 0.3
    local source = time>0 and 100 or 0
    local time = math.abs(time)

    game.timer(time/100 * 1000,100,function(t)
        -- print((100-t.cnt)/100) 
        local val = math.abs(source - t.cnt)/100
        self:set_alpha(val)
    end)
end   
--闪烁
function class.ui_base:blink(time,speed,keep)
    local time = time or 1
    local speed = speed or 0.2 --一闪烁来回时间
    local per_speed = 100 /(speed / 2 /0.001) 
    local flag=1
    local current_alpha = 1
    if self.blink_timer then 
        self.blink_timer:remove()
        self.blink_timer = nil
    end
    self.blink_timer = game.timer(0.001*1000,math.floor(time/0.001),function(t)

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
mt.source = 0 --起始
mt.target = 0 --目标
mt.now = 0 --当前
mt.last_max=0 --上次结束时的值 作为下次起点
mt.min_per_val = 1 --最小步长(%)
mt.tween_speed = 1 --动画速度
mt.tween_flag = false
mt.t=0 --插值因子 动态
function mt:get(str)
    return self[str]
end
function mt:set(k,v)
    self[k] = v
    return v
end

--获取增量时间 Time.deltaTime 理解
function mt:get_deltatime()
    local fps = japi.GetFps()
    return 1/fps
end

function mt:update()
    if self.tween_flag then 
        local target = self:get('target')
        local source = self:get('source')
        
        -- if self.handle =='血条' then
        -- print('起始位置1：',self,source)
        -- end
        self.t = self.t + self.tween_speed * self:get_deltatime()
        -- print('插值因子：',self.t,self.tween_speed,self:get_deltatime(),japi.GetFps())
        if self.t > 1 then
            self.t = 1
            self:set('last_max',target)
            self:set('tween_flag',false)
        end
        local old_now = self:get('now')
        local now = math.lerp(source, target, self.t);
        -- print('现在的位置宽度：',now,now/420*100,now - old_now,(now - old_now)/420*100)
        self:set('now',now)
        self:show(now)
    else
        self:set('now',self:get('target'))
        self:show(self:get('target'))
    end
end
function mt:remove()
    if self.t_timer then 
        self.t_timer:remove()
        self.t_timer = nil
    end
    
end

function mt:start(data)
    if self.t_timer then 
        --刷新数据
        -- self:set_target(data.target)
        for k,v in pairs(data) do 
            self[k] = v 
        end
        -- if self.handle =='血条' then
        --     print('起始位置2：',self,self.source)
        -- end
        --缓慢流动时，改变 source
        if self.tween_flag then 
            self:set('source',self:get('now'))
        else
            self:set('source',self:get('last_max'))
        end
        self:set('target',data.target)
        self:set('t',0)
        self:set('tween_flag',true)
        
        -- local distance = self.source  - self.target
        -- local cur_distance = self.source - self.now 
        -- if math.abs(cur_distance/distance) <= 0.01 then 
        --     self:set('tween_flag',false)
        --     self:set('now',self.target)
        --     self:show(self.target)
        -- else
        -- end

        return 
    end
    
    self:update()
    self.t_timer = game.loop(10,function(t)
        self:update()
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
        pr = setmetatable({}, process)
        for k,v in pairs(data) do 
            pr[k] = v 
        end
        self.all_process[handle] = pr
    else
        pr = self.all_process[handle]
    end
    -- if data.handle =='血条' then
    -- print('起始位置：',pr,data.source,pr.source)
    -- end
    pr:start(data)
end   

function class.ui_base:remove_process(handle)
    if self.all_process[handle] then 
        self.all_process[handle]:remove()
        self.all_process[handle] = nil 
    end
end


--鼠标划过时，添加图片
function class.ui_base:hover(img)
    if self.hover_img_ui then 
        print('已经有hover_img_ui了 ')
        return 
        -- self.hover_img_ui:destroy()
    end
    local new_ui = class.panel:builder
    {
        parent = self,
        x = 0,
        y = 0,
        w = self.w,
        h = self.h,
        is_show = true,
        type = 'panel',
        normal_image = [[]],
        btn = {
            type = 'button',
            normal_image = [[]],
            on_button_mouse_enter = function(self)
                -- print('鼠标进入啦')
                self:set_normal_image(img)
            end,
            on_button_mouse_leave = function(self)
                -- print('鼠标离开啦')
                self:set_normal_image([[]])
            end,
        },
    }
    self.hover_img_ui = new_ui
end   

--重写缩放
function class.ui_base:set_relative_size(size, not_scale_font,align)
    local w,h = self.w, self.h
    local x,y = self.x,self.y
    -- print('进入重写的的缩放')
    local scale = self._scale or 1
    local default = self.default_size or 1
    local old_size = (self.relative_size or 1) * default

    local real_size = 1 / old_size * size * scale
    self.relative_size = size 
    self.default_size = scale

    if self.set_size and not_scale_font ~= true then 
        self:set_size(self.size or 1)
    end 
    if self._control == nil then 
        self:set_control_size(self.w * real_size,self.h * real_size)
    end
    for index,child in ipairs(self.children) do
        if child._control == nil then
            child._scale = scale 
            child:set_relative_size(size, not_scale_font)
            child:set_position(child.x * real_size,child.y * real_size)
        end
    end
    local pad_x
    local pad_y
    --缩放排列
    if align then 
        if align == 'center' then 
            pad_x = x - ((w * real_size) - w) / 2
            pad_y = y - ((h * real_size) - h) / 2
        elseif align =='topright' then 
            pad_x = x - ((w * real_size) - w) 
            pad_y = y 
        elseif align =='bottomright' then 
            pad_x = x - ((w * real_size) - w)
            pad_y = y - ((h * real_size) - h)
        elseif align =='bottomleft' then 
            pad_x = x
            pad_y = y - ((h * real_size) - h)
        end
        -- print('进入重写的缩放',align,pad_x,pad_y,x,y)
        self:set_position(pad_x,pad_y)
    end
end