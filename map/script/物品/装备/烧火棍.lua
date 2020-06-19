--物品名称
local mt = ac.skill['烧火棍']
mt{
    level = 1 ,
    max_level = 26,
    --颜色
    color = '紫',
    tip = [[

%show_tip%
%ugrade_tip%
|cff00ff00(升至顶级后，可用|cffffff00 圣龙精魄 |cff00ff00进行熔炼入体)]],

    --技能图标
    art = [[shihun.blp]],
    ugrade_tip = function(self)
        local str =''
        if self.level >= self.max_level then 
            str = ''
        else 
            local t_str = self.level%5 == 0 and '前往|cffff0000杀死BOSS|r' or ''
            str = '\n|cffFFE799【升级】|r点击消耗 %wood_cnt% 木头'..t_str..' '

        end        
      
        return str
    end,    
    --全属性
    ['攻击'] = {60000,120000,180000,240000,300000,600000,900000,1200000,1500000,1800000,2400000,3000000,3600000,4200000,4800000,5400000,6000000,6600000,7200000,7800000,8400000,9000000,9600000,10200000,10800000,12000000},
    --每秒加全属性
    ['攻击速度'] = {5,10,15,20,25,30,35,40,45,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,50,},
    --攻击
    -- ['攻击减甲'] = {0,0,0,0,0,0,5,10,15,20,25,30,35,35,35,35,35,35,35,35,35,35,35,35,35,35,},
    --护甲
    ['物理伤害加深'] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,20,30,40,50,50,50,50,50,50,},
    --每秒加金币
    ['暴击几率'] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2,3,4,5,5,5,5,5,5,},

    ['暴击伤害']  = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,20,30,40,50,60,70,80,90,100,},
    --会心几率
    ['技暴几率']  = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2,3,4,5,},
    --会心伤害
    ['技暴伤害'] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,10,20,30,40,50,},
    --吸血
    ['吸血'] = 5,
    --消耗木头
    wood_cnt = {1,2,3,4,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100,105,0,},
    --唯一
    unique = true,
    --显示等级
    show_level = true,
    show_tip = function(self)
        local str = ''
        local attribute = ac.unit.attribute
        if self['攻击'] >0 then 
            str = str ..'+|cffffff00'..bignum2string(self['攻击'])..'|r 攻击'..'\n'
        end    
        if self['攻击速度'] >0 then 
            str = str ..'+|cffffff00'..bignum2string(self['攻击速度'])..'%|r 攻击速度'..'\n'
        end 
        -- if self['攻击减甲'] >0 then 
        --     str = str ..'+|cffffff00'..bignum2string(self['攻击减甲'])..'|r 攻击减甲'..'\n'
        -- end 
        if self['物理伤害加深'] >0 then 
            str = str ..'+|cffffff00'..bignum2string(self['物理伤害加深'])..'%|r 物理伤害加深'..'\n'
        end 
        if self['暴击几率'] >0 then 
            str = str ..'+|cffffff00'..bignum2string(self['暴击几率'])..'%|r 暴击几率'..'\n'
        end 
        if self['暴击伤害'] >0 then 
            str = str ..'+|cffffff00'..bignum2string(self['暴击伤害'])..'%|r 暴击伤害'..'\n'
        end 
        if self['技暴几率'] >0 then 
            str = str ..'+|cffffff00'..bignum2string(self['技暴几率'])..'%|r 技暴几率'..'\n'
        end 
        if self['技暴伤害'] >0 then 
            str = str ..'+|cffffff00'..bignum2string(self['技暴伤害'])..'%|r 技暴伤害'..'\n'
        end 

        -- if self['每秒加全属性'] >0 then 
        --     str = str ..'+|cffffff00'..bignum2string(self['每秒加全属性'])..'|r 每秒加全属性'..'\n'
        -- end    
        -- if self['攻击'] >0 then 
        --     str = str ..'+|cffffff00'..bignum2string(self['攻击'])..'|r 攻击'..'\n'
        -- end    
        -- if self['护甲'] >0 then 
        --     str = str ..'+|cffffff00'..bignum2string(self['护甲'])..'|r 护甲'..'\n'
        -- end    
        -- if self['每秒加金币'] >0 then 
        --     str = str ..'+|cffffff00'..bignum2string(self['每秒加金币'])..'|r 每秒加金币'..'\n'
        -- end   
        -- if self['会心几率'] >0 then 
        --     str = str ..'+|cffffff00'..bignum2string(self['会心几率'])..'%|r 会心几率'..'\n'
        -- end    
        -- if self['会心伤害'] >0 then 
        --     str = str ..'+|cffffff00'..bignum2string(self['会心伤害'])..'%|r 会心伤害'..'\n'
        -- end     
        if self['吸血'] >0 then 
            str = str ..'+|cffffff00'..bignum2string(self['吸血'])..'%|r 吸血'..''
        end     
        return str
    end,   
    --升级特效
    effect ='Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdx',
    effect2 = [[Void Teleport Target.mdx]],
    --物品详细介绍的title
    content_tip = '|cffFFE799基本属性：|r',
}


function mt:on_upgrade()
    local hero = self.owner
    if hero:get_owner().id >10 then 
        return 
    end    
    -- print(self.life_rate_now)   
    hero:add_effect('chest',self.effect):remove()
    
    if self.set_name then 
    self:set_name(self.name)
    end
end

function mt:on_cast_start()
    local hero = self.owner
    local p = hero:get_owner()
    hero = p.hero

    local wood = self.wood_cnt
    local has_wood = p.wood
    local item = hero:has_item(self.name)
    if item.level == item.max_level then
        return 
    end    
    if has_wood >= wood and not p.flag_shg  then 
        hero:add_wood(-wood)
        if self.level%5 ~= 0 then 
            self:upgrade(1) --升级
        else     
            --传送
            p.flag_shg = true
            local blink_rect = ac.rect.j_rect('shaohuogun')
            hero:blink(blink_rect,true,false,true)
            --创建升级怪 
            local rect = ac.rect.j_rect('shaohuogun1')
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
            local trg_t = ac.wait(1*1000,function(t)
                u = ac.player(12):create_unit('三眼灵猴BOSS'..math.ceil(self.level/5),point)
                u:event '单位-死亡'(function(_,unit,killer)
                    p.flag_shg = false 
                    --物品升级
                    item:upgrade(1)
                    --传送回练功房
                    local point = ac.map.rects['练功房刷怪'..p.id]:get_point()
                    hero:blink(point,true,false,true)
                end)
            end)

            --创建区域离开事件
            local reg = ac.map.regions['shaohuogun2']
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
                p.flag_shg = false 
                --删除自己的
                trg:remove()  
            end)

        end    
    else 
        p:sendMsg('|cffffe799【系统消息】|cffff0000木头不足，或已有玩家正在挑战',5)
    end    

end    
--实际是丢掉
function mt:on_remove()
    local hero = self.owner
    if self.trg then 
        self.trg:remove()
        self.trg = nil
    end    

end