--物品名称
local mt = ac.skill['烧火棍']
mt{
    level = 1 ,
    max_level = 26,
    --颜色
    color = '紫',
    tip = [[

%show_tip%
%ugrade_tip%]],

    --技能图标
    art = [[qiu305.blp]],
    ugrade_tip = function(self)
        local str =''
        if self.level >= self.max_level then 
            str = '|cffcccccc【更多玩法在高难度开放】|r'
        else 
            local t_str = self.level%5 == 0 and ',并成功挑战BOSS ' or ''
            str = '|cffFFE799【进阶】|r消耗 %wood_cnt% 木头'..t_str..' 升级'
        end        
      
        return str
    end,    
    --全属性
    ['全属性'] = {100,500,2500,5000,25000,50000,250000,500000,1250000,2500000,5000000,},
    --每秒加全属性
    ['每秒加全属性'] = {0,1,3,10,30,100,300,900,1800,3600,7200,},
    --攻击
    ['攻击'] = {0,0,2500,5000,25000,50000,250000,500000,1250000,2500000,5000000,},
    --护甲
    ['护甲'] = {1,5,10,15,25,50,100,200,500,1500,5000,},
    --每秒加金币
    ['每秒加金币'] = {0,50,100,500,1000,5000,5000,5000,5000,5000,5000,},
    --每秒加木头
    ['每秒加木头']  = {0,0,0,0,0,0,1,2,5,25,50,},
    --会心几率
    ['会心几率']  = {0,0,0,1,2,3,4,5,6,8,10,},
    --会心伤害
    ['会心伤害'] = {0,0,0,10,20,30,40,50,60,80,100,},
    --吸血
    ['吸血'] = 10,
    --消耗木头
    wood_cnt = {10,100},
    --唯一
    unique = true,
    --显示等级
    show_level = true,
    show_tip = function(self)
        local str = ''
        local attribute = ac.unit.attribute
        if self['全属性'] >0 then 
            str = str ..'+|cffffff00'..bignum2string(self['全属性'])..'|r 全属性'..'\n'
        end    
        if self['每秒加全属性'] >0 then 
            str = str ..'+|cffffff00'..bignum2string(self['每秒加全属性'])..'|r 每秒加全属性'..'\n'
        end    
        if self['攻击'] >0 then 
            str = str ..'+|cffffff00'..bignum2string(self['攻击'])..'|r 攻击'..'\n'
        end    
        if self['护甲'] >0 then 
            str = str ..'+|cffffff00'..bignum2string(self['护甲'])..'|r 护甲'..'\n'
        end    
        if self['每秒加金币'] >0 then 
            str = str ..'+|cffffff00'..bignum2string(self['每秒加金币'])..'|r 每秒加金币'..'\n'
        end   
        if self['每秒加木头'] >0 then 
            str = str ..'+|cffffff00'..bignum2string(self['每秒加木头'])..'|r 每秒加木头'..'\n'
        end    
        if self['会心几率'] >0 then 
            str = str ..'+|cffffff00'..bignum2string(self['会心几率'])..'%|r 会心几率'..'\n'
        end    
        if self['会心伤害'] >0 then 
            str = str ..'+|cffffff00'..bignum2string(self['会心伤害'])..'%|r 会心伤害'..'\n'
        end     
        if self['吸血'] >0 then 
            str = str ..'+|cffffff00'..bignum2string(self['吸血'])..'%|r 吸血'..'\n'
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
            ac.wait(100,function()
                ac.effect_ex{
                    model = self.effect2,
                    point = point
                }:remove()
            end)
            ac.wait(1*1000,function()
                local u = ac.player(12):create_unit('三眼灵猴BOSS'..math.ceil(self.level/5),point)
                u:event '单位-死亡'(function(_,unit,killer)
                    p.flag_shg = false 
                    --物品升级
                    item:upgrade(1)
                    --传送回练功房
                    local point = ac.map.rects['练功房刷怪'..p.id]:get_point()
                    hero:blink(point,true,false,true)
                end)
                --创建区域离开事件
                local reg = ac.region.create(ac.rect.j_rect('shaohuogun2'))
                reg:event '区域-离开'(function(trg,unit)
                    if hero ~= unit then 
                        return 
                    end  
                    if not u:is_alive() then 
                        return 
                    end    
                    p.flag_shg = false 
                    u:remove()
                    --删除自己的
                    trg:remove()  
                end)
            end)

        end    
    else 
        p:sendMsg('木材不够，或是已经在挑战boss',5)
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