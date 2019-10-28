-- require '通用.建造.建筑'
-- require '通用.建造.1-准备建造'
-- require '通用.建造.2-建造完成'
-- require '通用.建造.3-建造物品'
-- require '通用.建造.4-回收英雄'
-- require '通用.建造.5-提升星级'



ac.game:event '技能-施法开始' (function (_,hero,item)
    print('进入技能施法开始1')
    local name = item.build
    if name == nil or hero.is_build then
        return
    end
    local player = hero:get_owner()

    local count = 0 
    for build in player:each_build() do 
        count = count + 1
    end 

    if count >= 10 then 
        player:sendMsg('最多只能同时召唤10个英雄，请回收其他英雄后再召唤吧。')
        return 
    end 

    hero.build_item = item

    hero:event_notify('单位-准备建造',hero,name)
end)