
local mt = ac.item['建造']

--当建造完成
function mt:on_build_finish()
    local hero = self.owner
    local player = hero:get_owner()
    local name = self.build
    local target = self.target
    if name == nil then
        return
    end

    local count = 0 
    for build in player:each_build() do 
        count = count + 1
    end 

    if count >= 10 then 
        player:sendMsg('最多只能同时召唤10个英雄，请回收其他英雄后再召唤吧。')
        return 
    end 

    ac.build.convert_build(self,target)

    local count = self:get_count()
    if count > 1 then 
        self:set_count(count - 1)
    else 
        self:remove()
    end 


end
