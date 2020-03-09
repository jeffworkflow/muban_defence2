
class.screen_animation = extends(class.panel){
    
    create = function ()
        local hero = ac.player.self.hero
        local panel = class.panel.create('image\\控制台\\jingong.tga',(1920-700)/2,300,700,250)
        local title = panel:add_text('',(panel.w-260)/2,(panel.h-40)/2-30,260,40,15,4)
        panel.__index = class.screen_animation 
        panel.title = title
        panel:hide()
        return panel
    end,


    --进攻提示
    up_jingong_title = function(self,title)
        self.title:set_text(title)
        -- if not self.old_x then 
        --     self.old_x,self.old_y = self:get_position()
        -- end
        -- -- local start_size = 2
        -- -- local start_x = (1920-1400)/2
        -- -- local start_y = 150
        
        -- self:set_position(self.old_x,self.old_y)
        -- -- self:set_position(start_x,start_y)
        -- -- self:set_relative_size(start_size)

        -- -- self:move_animation(self.old_x+500,self.old_y+540,4)
        -- self:show()
        
        -- ac.wait(3*1000,function()
        --     self:set_position(self.x,50)
        -- end)
        self:show()
        self:blink(4,1)
    end,
    
}

--业务：蜗牛出品 
local new_ui = class.panel:builder
{
    x = 0,--假的
    y = 0,--假的
    w = 1920,
    h = 1080,
    level = 5,
    is_show = false,
    normal_image = 'woniu1.blp',
    --蜗牛出品
    danhua = function(self)
        self:show()
        --停留时长
        local stu_time = 0.25
        ac.wait(stu_time*1000,function()
            --淡化时长
            local time = 1
            local cnt = time/0.1
            ac.timer(100,cnt,function(t)
                local per_rate = 100/cnt
                self:set_alpha(per_rate * t.count/100)
            end)
        end)
    end
}
new_ui:danhua()


--业务：战斗力
local new_ui = class.panel:builder
{
    x = 360,--假的
    y = 815,--假的
    -- x = 728,--假的
    -- y = 770,--假的
    w = 512,
    h = 100,
    -- w = 512,
    -- h = 96, 
    level = 5,
    is_show = false,
    normal_image = [[ui\battle_power\ui-a10.tga]],
    md = {
        type = 'model',
        size = 1,
        model = [[zhanlixlz.mdx]],
    },
    target_val = 0,
    current_val = 0,
    get_target_val = function(self)
        return self.target_val 
    end,    
    set_target_val = function(self,v)
        self.target_val = v
    end,   
    set_val = function(self,val)
        if self.s_timer then 
            self:set_target_val(val)
            return 
        end    

        --淡化时长
        local time = 4
        local cnt = math.floor( time/0.03 )
        self.s_timer = ac.timer(30,cnt,function(t)
            if t.count == 0 then 
                t:remove()
                self.s_timer = nil
                return
            end    
            local target_val = self:get_target_val()
            -- print(t.count,'目标值和当前值',target_val,self.current_val)
            local distance = target_val - self.current_val
            local per_val = math.floor( distance / t.count)
            if per_val ~= 0 then 
                self.current_val = self.current_val + per_val
                self:show_val(self.current_val)
            end    
        end)
    end,
    show_val = function(self,val)
        --清除图片
        self:clean_pics()
        --大数字转小数字+w
        local val = tonumber(val)
        if type(val) == 'string' then 
            return 
        end	
        if val < 100000 then
            val =  math.tointeger(val) or ('%.2f'):format(val)
        elseif val < 1000000000 then
            val =  ('%.0f'):format(val/10000)..'w'
        else
            val =  ('%.0f'):format(val/100000000)..'y' 
        end

        local str = string.reverse(''..val) --倒序
        local i = 1
        for num in string.gmatch(str, "%w") do
            local path = [[ui\battle_power\zdl]]..num..'.tga'
            if self.pics[i] then 
                self.pics[i]:set_normal_image(path)
            end    
            i = i + 1
        end
    end,
    --预设10个数字图片位置
    create_pics = function(self)
        self.pics = {}
        local font_space = 0 --字间距
        for i =1,10 do 
            local pic = self:add_texture([[Transparent.tga]], 295 -(i-1)*(font_space+26), 50, 32, 32)
            table.insert(self.pics,pic)
        end    
    end,
    clean_pics =  function(self)
        for i,pic in ipairs(self.pics)do 
            pic:set_normal_image([[Transparent.tga]])
        end    
    end       
}
new_ui:create_pics()

local str = [[
（（力量+智力+敏捷）/1000+护甲）*（
    1+（减伤+免伤几率+闪避）/3
    +（暴击几率+技暴几率+会心几率）/3
    +（暴击伤害+技暴伤害+会心伤害）/100000
    +（物理伤害加深+技能伤害加深）/20000
    +（全伤加深）/10000
    +（攻击减甲/（-攻击间隔）*攻击速度）/50000
    ）
    +天赋技能+1000*（Lv-1）+黄阶技能+1000*Lv+玄阶技能+2000*Lv+地阶技能+4000*Lv+天阶技能+8000*Lv+真天阶技能+16000*Lv
]]
local skl_point ={
    ['天赋'] = 1000,
    ['黄阶'] = 1000,
    ['玄阶'] = 2000,
    ['地阶'] = 4000,
    ['天阶'] = 8000,
    ['真天阶'] = 16000,
}
ac.game:event '玩家-注册英雄' (function(self, player, hero)
    hero:event '单位-属性变化'(function(self, hero, name,value)
        if not hero:is_hero() then 
            return 
        end 
        if not finds(str,name) then 
            return 
        end       
        local zdl = ((hero:get('力量')+hero:get('智力')+hero:get('敏捷'))/1200 + hero:get('护甲')/1.1+ hero:get('攻击')/2400
        +(hero:get('攻击减甲')/hero:get('攻击间隔')*(1+hero:get('攻击速度')/100)*2)) *(
            1 + (hero:get('减伤')+hero:get('免伤几率')+hero:get('闪避'))/300
            + (hero:get('暴击几率')+hero:get('技暴几率')+hero:get('会心几率'))/300
            + (hero:get('暴击伤害')+hero:get('技暴伤害')+hero:get('会心伤害'))/30000
            + (hero:get('物理伤害加深')+hero:get('技能伤害加深'))/12500
            + (hero:get('全伤加深'))/5000)
        zdl = math.floor(zdl)
        local skl_zdl = 0
        for skl in hero:each_skill('英雄',true) do 
            if skl.color == '天赋' then 
                skl_zdl = skl_zdl + skl_point[skl.color or '黄阶'] *(skl.level -1)
            else
                skl_zdl = skl_zdl + skl_point[skl.color or '黄阶'] *(skl.level)
            end
        end
        zdl = zdl + skl_zdl
        -- print('战斗力',zdl,name,value)
        if hero.owner:is_self()then 
            new_ui:set_val(zdl)
        end    
    end)
end)    

ac.game:event '玩家-选择单位' (function(self, player, hero)
    if hero ~= player.hero then 
        return 
    end    
     
    if player:is_self()then
        new_ui:show()
    end 
end)
ac.game:event '玩家-取消选择单位' (function(self, player, hero)
    if hero ~= player.hero then 
        return 
    end    
     
    if player:is_self()then
        new_ui:hide()
    end 
end)



--业务 ： 至凶之物 1分钟内加动态边框
local time = 60 
ac.game:event '玩家-选择单位' (function(self, player, hero)
    if hero:get_name() ~= '第一幕·圣龙气运 ' then 
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
    if hero:get_name() ~= '第一幕·圣龙气运 ' then 
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


--业务：刷怪进攻提醒
ac.game:event '游戏-回合开始'(function(trg,index, creep) 
    if not finds(creep.name,'刷怪1') then
        return
    end    
    
    print('开始进攻提醒啦')
    local panel = class.screen_animation.get_instance()
    if finds(creep.name,'无尽') then 
        if panel then panel:up_jingong_title(' 第 '..creep.index..' 波 （无尽）') end
    else
        if panel then panel:up_jingong_title(' 第 '..creep.index..' 波 ') end
    end

end)

