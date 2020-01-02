
local tools ={
    add_frame = function (self,off_x,off_y,size,off_size,is_show)
        if self.model_frame then 
            self.model_frame:show()
            return
        end
        local new_ui = class.panel:builder
        {
            parent = self,
            x = 800,--假的
            y = 800,--假的
            w = 80,
            h = 80,
            level = 5,
            is_show = false,
            normal_image = 'Transparent.tga',
            
            model = {
                type = 'model',
                size = 1,
                model = [[tx6.mdx]],
            },
        }
        --默认为传进来控件的坐标
        new_ui:set_real_position(self:get_real_position())
        -- print('边框位置：',self:get_real_position())
        -- print('text位置：',new_ui.txt:get_real_position())
        -- print('model1位置：',new_ui.model:get_real_position())
        -- print('model2位置：',new_ui.model:get_model_offset())

        if off_x and off_y then 
            new_ui.model:set_model_offset(off_x,off_y)
        end    
        if size then 
            new_ui.model:set_size(size)
        end   
        if off_size then 
            local x,y,z = table.unpack(off_size)
            new_ui.model:set_scale(x,y,z)
        end    
        new_ui:show()
        if self.on_button_mouse_enter  then 
            self.old_on_button_mouse_enter = self.on_button_mouse_enter
        end    
        --如果外部有传参，会有问题。
        function self:on_button_mouse_enter()  
            if self.old_on_button_mouse_enter then 
                self:old_on_button_mouse_enter()
            end    
            if not is_show then 
                new_ui:hide()
            end     
        end   
        self.model_frame = new_ui
        return new_ui
    end,  
    
}
--赋予基础方法
for name, func in pairs(tools) do 
    class.ui_base[name] = func
end 



--业务 ： 至凶之物 1分钟内加动态边框
local time = 60 
ac.game:event '玩家-选择单位' (function(self, player, hero)
    if hero:get_name() ~= '第一幕·圣龙气运' then 
        return 
    end    
    if ac.g_game_time >= time then 
        self:remove()
        return
    end    
    if player:is_self()then
        ac.ui.client.panel.skillPanel.buttonList[1]:add_frame(42,-45,1.4 ,{1,1.1,1},true)
    end 
end)
ac.game:event '玩家-取消选择单位' (function(self, player, hero)
    if hero:get_name() ~= '第一幕·圣龙气运' then 
        return 
    end    
    if ac.g_game_time >= time then 
        self:remove()
        return
    end   
    if player:is_self()then
        ac.ui.client.panel.skillPanel.buttonList[1].model_frame:hide()
    end 
end)

