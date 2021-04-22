ac.peon_list = {}
for name,data in pairs(ac.table.UnitData) do 
    local color = data.unit_type 
    if data.unit_type == '宠物' and data.name ~='宠物' then 
        ac.peon_list[tonumber(data.cid)] = name
        -- table.insert(ac.peon_list,name)
    end 
end 

-- table.sort(ac.peon_list,function (strA,strB)
--     return strA<strB
-- end)

local player = require 'ac.player'
local points = {}
local base_point = ac.rect.j_rect('chongwu'):get_point()
for x =1,3 do 
    for y=1,2 do 
        local off_x =100
        local base_x,base_y = base_point:get()
        local new_point =ac.point(base_x -off_x +(y-1)*150,base_y -(x-1)*150) 
        -- print(new_point:get())
        table.insert(points,new_point)
    end
end
function player.__index:create_pets(name,re)
    local name =name or '宠物'
    -- local x,y = ac.map.rects['出生点']:get_point():get()
    -- local u = self:create_unit(name,ac.point(x-500,y))
    local u = self:create_unit(name,points[self.id],180)
    u.unit_type = '宠物'
    u:set('移动速度',522)


    self.peon = u
    if u.data and u.data.skill_name then 
        local skl = u:add_skill(u.data.skill_name ,'英雄',9)
        if skl and not skl.passive then 
            skl:active_cd()
        end
        ac.wait(0,function()
            if not re then 
                self:sendMsg('|cffebb608【系统】|r|cff00ff00恭喜获得宠物 |cff00ffff'..name..'|cffffff00(拥有天赋:'..u.data.skill_name..')|cff00ff00，2分钟内输入 “|cffff0000re|cff00ff00” 可重置一次',6)
            else
                self:sendMsg('|cffebb608【系统】|r|cff00ff00恭喜获得宠物 |cff00ffff'..name..'|cffffff00(拥有天赋:'..u.data.skill_name..')',6)
            end
        end)
    end    
    u:add('魔法恢复',1)
    -- u:set_animation_speed(1000)
    --添加切换背包
    -- u:add_skill('切换背包','英雄',5)
    u:add_restriction '无敌'
    u:add_restriction '缴械'
    u:add_skill('拾取','拾取',1)

    u:add_skill('全图闪烁','隐藏')
    u:add_skill('传递物品','英雄')
    u:add_skill('一键拾取','英雄')
    u:add_skill('一键丢弃','英雄')
    u:add_skill('物品合成','英雄')
    -- u:add_skill('荣耀称号','英雄',8)
    u:add_skill('宠物纪念册','英雄',12)
    u:add_skill('宠物技能','英雄',8)
    -- u:add_skill('一键合成','英雄',9)
    -- u:add_skill('商城管理','英雄')
    if self:Map_GetMapLevel() >= 3 then 
        u:add_skill('一键出售','英雄',11)
        -- u:add_skill('一键合成','英雄',6)
        u:add_skill('一键分类','英雄',7)
    end
    -- 测试魔法书
    -- u:add_skill('魔法书demo','英雄')
end

--注册 输入 re 随机得一只宠物 
local point = ac.rect.j_rect('chongwu')
ac.game:event '玩家-聊天' (function(self, player, str)
    if string.lower(str) ~= 're' then
        return 
    end
    --测试
    --有随机过一次的
    if player.flag_re  then 
        return 
    end 

    --2分钟后
    if ac.g_game_time >120 then 
        return 
    end
    --没有选英雄就输的
    if not player.peon then
        return 
    end
    player.flag_re = true

    --丢弃物品在地上再移除 
    if player.peon then 
        for i=1,6 do
            local it = player.peon:get_slot_item(i)
            if it then 
                if it.name ~= '勇士徽章' then 
                    player.peon:remove_item(it)
                end	
            end
        end
        player.peon:remove()
        player.peon = nil
    end
    --重新随机一只
	player:create_pets(ac.peon_list[math.random(#ac.peon_list)],true)
    
end)
