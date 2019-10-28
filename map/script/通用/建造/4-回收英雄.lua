
local mt = ac.skill['回收英雄']

function mt:on_add()

end 

function mt:on_cast_finish()
    local hero = self.owner 
    local target = self.target 
    local player = hero:get_owner()

    if hero == target or target == nil or not target.is_build then 
        return 
    end 

    if player ~= target:get_owner() then 
        return 
    end 


    target:convert_item(hero)

end

