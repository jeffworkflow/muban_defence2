--物品名称
local mt = ac.skill['赤炎甲']
mt{
    level = 1 ,
    max_level = 26,
    --颜色
    color = '紫',
    tip = [[

%show_tip%
%ugrade_tip%]],

    --技能图标
    art = [[chiyanjia.blp]],
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
    ['全属性'] = {20000,40000,60000,80000,100000,200000,300000,400000,500000,600000,800000,1000000,1200000,1400000,1600000,1800000,2000000,2200000,2400000,2600000,2800000,3000000,3200000,3400000,3600000,4000000,},
    --每秒加全属性
    -- ['每秒加全属性'] = {0,1,3,10,30,100,300,900,1800,3600,7200,},
    --攻击
    -- ['攻击'] = {0,0,2500,5000,25000,50000,250000,500000,1250000,2500000,5000000,},
    --护甲
    ['护甲'] = {10,20,30,40,50,100,150,200,250,300,400,500,600,700,800,900,1000,1100,1200,1300,1400,1500,1600,1700,1800,2000,},
    --每秒加金币
    ['伤害减少'] = {0,0,0,0,0,40000,60000,80000,100000,120000,160000,200000,240000,280000,320000,360000,400000,440000,480000,520000,560000,600000,640000,680000,720000,800000,},
    --每秒加木头
    ['生命恢复']  = {0,0,0,0,0,40000,60000,80000,100000,120000,160000,200000,240000,280000,320000,360000,400000,440000,480000,520000,560000,600000,640000,680000,720000,800000,},
    --会心几率
    -- ['每秒回血']  = {0,0,0,0,0,0,0,0,0,0,1,2,3,4,5,6,7,8,9,10,10,10,10,10,10,10,},
    --会心伤害
    ['减伤'] = {0,0,0,0,0,0,0,0,0,0,0.5,1,1.5,2,2.5,3,3.5,4,4.5,5,5,5,5,5,5,5,},
    ['免伤几率'] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0.5,1,1.5,2,2.5,3,3.5,4,4.5,5,5,},
    ['闪避'] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2,3,4,5,5,},
    --吸血
    ['每秒回血'] = 5,
    --消耗木头
    wood_cnt = {1,2,3,4,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100,105,0,},
    -- wood_cnt = {10,100},
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
        if self['护甲'] >0 then 
            str = str ..'+|cffffff00'..bignum2string(self['护甲'])..'|r 护甲'..'\n'
        end    
        if self['伤害减少'] >0 then 
            str = str ..'+|cffffff00'..bignum2string(self['伤害减少'])..'|r 伤害减少'..'\n'
        end    
        if self['生命恢复'] >0 then 
            str = str ..'+|cffffff00'..bignum2string(self['生命恢复'])..'|r 生命恢复'..'\n'
        end    
        if self['减伤'] >0 then 
            str = str ..'+|cffffff00'..bignum2string(self['减伤'])..'%|r 减伤'..'\n'
        end   
        if self['免伤几率'] >0 then 
            str = str ..'+|cffffff00'..bignum2string(self['免伤几率'])..'%|r 免伤几率'..'\n'
        end    
        if self['闪避'] >0 then 
            str = str ..'+|cffffff00'..bignum2string(self['闪避'])..'%|r 闪避'..'\n'
        end    
        if self['每秒回血'] >0 then 
            str = str ..'+|cffffff00'..bignum2string(self['每秒回血'])..'%|r 每秒回血'..''
        end     
        -- if self['吸血'] >0 then 
        --     str = str ..'+|cffffff00'..bignum2string(self['吸血'])..'%|r 吸血'..''
        -- end     
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
    if not item then return end
    if item.level == item.max_level then
        return 
    end  
    if has_wood >= wood and not p.flag_cyj  then 
        hero:add_wood(-wood)
        if self.level%5 ~= 0 then 
            self:upgrade(1) --升级
        else     
            --传送
            p.flag_cyj = true
            local blink_rect = ac.rect.j_rect('chiyanjia')
            hero:blink(blink_rect,true,false,true)
            --创建升级怪 
            local rect = ac.rect.j_rect('chiyanjia1')
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
                u = ac.player(12):create_unit('焰皇BOSS'..math.ceil(self.level/5),point)
                u:event '单位-死亡'(function(_,unit,killer)
                    p.flag_cyj = false 
                    --物品升级
                    item:upgrade(1)
                    --传送回练功房
                    local point = ac.map.rects['练功房刷怪'..p.id]:get_point()
                    hero:blink(point,true,false,true)
                end)
            end)
            --创建区域离开事件
            local reg = ac.map.regions['chiyanjia2']
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
                p.flag_cyj = false 
                --删除自己的
                trg:remove()  
            end)

        end    
    else 
        p:sendMsg('|cffffe799【系统消息】|cff00ff00木材不足，或已有玩家正在挑战',5)
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