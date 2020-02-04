local mt = ac.skill['魔胎']
mt{
    --等级
    level = 0,
    --魔法书相关
    is_order = 1 ,
    art = [[tupo.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+50W 全属性
+25%  攻击速度|r

]],
    ['全属性'] = 500000,
    ['攻击速度'] = 25,
}
local mt = ac.skill['半魔']
mt{
    --等级
    level = 0,
    --魔法书相关
    is_order = 1 ,
    art = [[tupo.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+100W 全属性
+25%  分裂伤害|r

]],
    ['全属性'] = 1000000,
    ['分裂伤害'] = 25,
}

local mt = ac.skill['原魔']
mt{
    --等级
    level = 0,
    --魔法书相关
    is_order = 1 ,
    art = [[tupo.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+150W 全属性
+25  攻击减甲|r

]],
    ['全属性'] = 1500000,
    ['攻击减甲'] = 25,
}
local mt = ac.skill['真魔'] 

mt{
    --等级
    level = 0,
    --魔法书相关
    is_order = 1 ,
    art = [[tupo.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+200W 全属性
+2.5%  减伤

]],
    ['全属性'] = 2000000,
    ['减伤'] = 2.5,
}
local mt = ac.skill['天魔']
mt{
    --等级
    level = 0,
    --魔法书相关
    is_order = 1 ,
    art = [[tupo.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+250W 全属性
+2.5%  闪避

]],
    ['全属性'] = 2500000,
    ['闪避'] = 2.5,
}
local mt = ac.skill['魔主']
mt{
    --等级
    level = 0,
    --魔法书相关
    is_order = 1 ,
    art = [[tupo.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+300W 全属性
+2.5%  免伤几率

]],
    ['全属性'] = 3000000,
    ['免伤几率'] = 2.5,
}
local mt = ac.skill['魔君']
mt{
    --等级
    level = 0,
    --魔法书相关
    is_order = 1 ,
    art = [[tupo.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+350W 全属性
+2.5%  暴击几率
+25%  暴击伤害|r

]],
    ['全属性'] = 3500000,
    ['暴击几率'] = 2.5,
    ['暴击伤害'] = 25,
}
local mt = ac.skill['魔尊']
mt{
    --等级
    level = 0,
    --魔法书相关
    is_order = 1 ,
    art = [[tupo.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+400W 全属性
+2.5%  技暴几率
+25%  技暴伤害|r

]],
    ['全属性'] = 4000000,
    ['技暴几率'] = 2.5,
    ['技暴伤害'] = 25,
}
local mt = ac.skill['魔王']
mt{
    --等级
    level = 0,
    --魔法书相关
    is_order = 1 ,
    art = [[tupo.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+450W 全属性
+2.5%  会心几率
+25%  会心伤害|r

]],
    ['全属性'] = 4500000,
    ['会心几率'] = 2.5,
    ['会心伤害'] = 25,
}
local mt = ac.skill['魔帝']
mt{
    --等级
    level = 0,
    --魔法书相关
    is_order = 1 ,
    art = [[tupo.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+450W 全属性
-0.05  攻击间隔

]],
    ['全属性'] = 5000000,
    ['攻击间隔'] = -0.05,
}







for i,name in ipairs({'魔胎 ','半魔 ','原魔 ','真魔 ','天魔 ','魔主 ','魔君 ','魔尊 ','魔王 ','魔帝 '}) do 
    local mt = ac.skill[name]
    mt.effect2 = [[Void Teleport Target.mdx]]
    function mt:on_cast_start()
        local p=self.owner.owner
        local hero =p.hero 
        -- p.flag_all = p.flag_all or {}
        local real_name = string.sub(name,1,-2)
        -- print(real_name)
        --创建升级怪 
        local rect = ac.rect.j_rect('tupo1')
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

        local u  
        local trg_t = ac.wait(1*1500,function(t)
            u = ac.player(12):create_unit(real_name,point)
            u:event '单位-死亡'(function(_,unit,killer)
                --激活属性
                local skl = hero:find_skill(real_name,nil,true)
                if skl and skl.level<1 then 
                    skl:set_level(1)
                    p:sendMsg('|cffffe799【系统消息】|cff00ff00突破成功')
                end    
                --传送回练功房
                local point = ac.map.rects['练功房刷怪'..p.id]:get_point()
                hero:blink(point,true,false,true)
            end)
        end)
        --创建区域离开事件
        local reg = ac.region.create(ac.rect.j_rect('tupo2'))
        reg:event '区域-离开'(function(trg,unit)
            if hero ~= unit then 
                return 
            end  
            if u and u:is_alive() then 
                u:remove()
            end
            if trg_t then 
                trg_t:remove()
                trg_t = nil 
            end 
            --删除自己的
            trg:remove()  
        end)

    end
end
