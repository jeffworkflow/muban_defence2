
local rect = require 'types.rect'

local function create_unit(p,lv,point)
    if lv > 5 then 
        return 
    end 
    local u = ac.player(12):create_unit('爱我你就爆了我'..lv,point)
    u:add_restriction '定身'
    u:add_restriction '缴械'

    u:event '单位-死亡'(function()
        p:add('练功房怪',1)
        p:add_wood(100)
        -- self.owner:add_wood(68)
        
        ac.wait(1*1000,function()
            create_unit(p,lv + 1,point)
        end)
        p:sendMsg('|cffffe799【系统消息】|r|cff00ff00阁下内功精进，连练功柱子都能打爆，奖励 |cffffff00练功房怪物数量+1 木头+100',10)
        -- p:sendMsg('|cffffe799【系统消息】|r|cff00ff00阁下内功精进，连练功柱子都能打爆，奖励 |cffffff00练功房怪物数量+1',5)
        -- p:sendMsg('|cffffe799【系统消息】|r|cff00ff00阁下内功精进，连练功柱子都能打爆，奖励 |cffffff00练功房怪物数量+1',5)
    end)
end
for i=1,6 do 
    local point = ac.rect.j_rect('lgfsg'..i):get_point()
    local p = ac.player(i)
    create_unit(p,1,point)
end