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

function player.__index:create_pets(name)
    local name =name or '宠物'
    -- local x,y = ac.map.rects['出生点']:get_point():get()
    -- local u = self:create_unit(name,ac.point(x-500,y))

    local u = self:create_unit(name,ac.rect.j_rect('chongwu'),270)
    u.unit_type = '宠物'
    u:set('移动速度',522)


    self.peon = u
    if u.data and u.data.skill_name then 
        u:add_skill(u.data.skill_name ,'英雄',9)
    end    
    -- u:set_animation_speed(1000)
    --添加切换背包
    u:add_skill('切换背包','英雄',5)
    u:add_restriction '无敌'
    u:add_restriction '缴械'
    u:add_skill('拾取','拾取',1)

    u:add_skill('全图闪烁','英雄')
    u:add_skill('传递物品','英雄')
    u:add_skill('一键拾取','英雄')
    u:add_skill('物品合成','英雄')
    -- u:add_skill('荣耀称号','英雄',8)
    u:add_skill('宠物纪念册','英雄',12)
    u:add_skill('宠物技能','英雄',8)
    -- u:add_skill('一键合成','英雄',9)
    -- u:add_skill('商城管理','英雄')
    if self:Map_GetMapLevel() >= 3 then 
        -- u:add_skill('一键出售','英雄',7)
        u:add_skill('一键合成','英雄',6)
        u:add_skill('一键丢弃','英雄',7)
    end
    -- 测试魔法书
    -- u:add_skill('魔法书demo','英雄')
end

-- local n = 0
-- local point = ac.rect.j_rect('chongwu')
-- ac.game:event '玩家-聊天' (function(self, player, str)
--     for i =1,5 do
--         n=n+1
--         local name = ac.peon_list[n]
--         local u = player:create_unit(name,point)
--         u.unit_type = '宠物'
--     end
-- end)
