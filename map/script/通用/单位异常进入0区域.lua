local rct = ac.rect.create(-200,-200,200,200)
-- local point = rct:get_point()
local region = ac.region.create(rct)
--异常进入用区域进入检测不到
region:event '区域-进入' (function(trg, hero, self)
    if region < hero:get_point()  then --不加区域判断，会有莫名其妙的问题，在练功房传送到其他地方，可能会出现在其他区域。
        print('单位进入0点',hero,hero:get_point(),hero.born_point)
        if hero.born_point then
            hero:blink(hero.born_point)
        end
    end     
end)    

local time = 1
ac.loop(time*1000,function()
    for _, u in pairs(ac.unit.all_units) do
        if u:get_name()~='马甲单位' and u:is_in_range(ac.point(0,0),150) then 
            print(u:get_name(),'异常，是否活着：',u:is_alive(),u:get_point(),u.born_point,u:has_restriction('禁锢'))
            print('lua 生命:',u:get('生命'),'魔兽生命：',jass.GetWidgetLife(u.handle))
            if u.born_point then 
                -- u:blink(u.born_point)--传送不了
                u:setPoint(u.born_point)
            else 
                u:kill()
            end
        end	
    end
end)

