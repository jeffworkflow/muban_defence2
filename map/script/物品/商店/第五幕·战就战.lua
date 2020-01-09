local mt = ac.skill['火炎之力']
mt{
    --等级
    level = 0,
    --魔法书相关
    is_order = 1 ,
    art = [[fldyc.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+500W 全属性
+2.5%  会心几率
+25%  会心伤害|r

]],
    ['全属性'] = 5000000,
    ['会心几率'] = 2.5,
    ['会心伤害'] = 25,
}



for i,name in ipairs({'火炎之力 ','水寒之力 ','暴风之力 ','天雷之力 ','生命之力 ','死亡之力 ','光明之力 ','黑暗之力 ','时间之力 ','空间之力 '}) do 
    local mt = ac.skill[name]
    mt.effect2 = [[Void Teleport Target.mdx]]
    function mt:on_cast_start()
        local p=self.owner.owner
        local hero =p.hero 
        -- p.flag_all = p.flag_all or {}
        local real_name = string.sub(name,1,-2)
        
        --创建升级怪 
        local rect = ac.rect.j_rect('zhanjiuzhan1')
        local point = rect:get_point()

        ac.wait(150,function()
            ac.effect_ex{
                model = self.effect2,
                size = 3,
                point = point
            }:remove()
        
        end)
        ac.wait(500,function()
            ac.effect_ex{
                model = self.effect2,
                size = 3,
                point = point
            }:remove()
        
        end)

        ac.wait(1*1500,function()
            local u = ac.player(12):create_unit(real_name,point)
            u:event '单位-死亡'(function(_,unit,killer)
                --激活属性
                local skl = hero:find_skill(real_name,nil,true)
                if skl and skl.level<1 then 
                    skl:set_level(1)
                    p:sendMsg('激活成功')
                end    
                --传送回练功房
                local point = ac.map.rects['练功房刷怪'..p.id]:get_point()
                hero:blink(point,true,false,true)
            end)
            --创建区域离开事件
            local reg = ac.region.create(ac.rect.j_rect('zhanjiuzhan2'))
            reg:event '区域-离开'(function(trg,unit)
                if hero ~= unit then 
                    return 
                end  
                if not u:is_alive() then 
                    return 
                end    
                u:remove()
                --删除自己的
                trg:remove()  
            end)
        end)

    end
end
