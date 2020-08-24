--物品名称
local mt = ac.skill['噬魂珠']
mt{
    level = 1 ,
    max_level = 5,
    sec_degree_attr = 5,
    --颜色
    color = '紫',
    tip = [[

%show_tip%
%ugrade_tip%]],

    --技能图标
    art = [[shihunzhu.blp]],
    ugrade_tip = function(self)
        local str =''
        if self.level >= self.max_level then 
            str = '\n|cffcccccc【天下至凶，生者勿近】'
        else 
            str = '\n|cffFFE799【进阶】|r杀满 %kill_cnt% 只怪后，点击前往杀死心魔BOSS'
        end        
      
        return str
    end,    
    --全属性
    ['全属性'] = {30000000,40000000,60000000,80000000,100000000,},
    --每秒加全属性
    ['每秒加全属性'] = {75000,100000,125000,150000,200000,},
    -- --攻击
    -- ['攻击'] = {0,0,2500,5000,25000,50000,250000,500000,1250000,2500000,5000000,},
    -- --护甲
    -- ['护甲'] = {1,5,10,15,25,50,100,200,500,1500,5000,},
    --每秒加金币
    -- ['每秒加金币'] = {0,50,100,500,1000,5000,5000,5000,5000,5000,5000,},
    --每秒加木头
    ['每秒加木头']  = {400,550,700,850,1000,},
    --会心几率
    ['减少周围护甲']  = {6000,8000,10000,12000,15000,},
    --会心伤害
    ['多重暴击几率'] = {6,7,8,9,10,},
    ['多重暴击'] = {1,1,1,1,2,},
    --吸血
    ['吸血'] = 12,
    --杀敌个数
    kill_cnt = {15000,16500,18000,20000,},
    -- kill_cnt = {10,100},
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
        -- if self['攻击'] >0 then 
        --     str = str ..'+|cffffff00'..bignum2string(self['攻击'])..'|r 攻击'..'\n'
        -- end    
        -- if self['护甲'] >0 then 
        --     str = str ..'+|cffffff00'..bignum2string(self['护甲'])..'|r 护甲'..'\n'
        -- end    
        -- if self['每秒加金币'] >0 then 
        --     str = str ..'+|cffffff00'..bignum2string(self['每秒加金币'])..'|r 每秒加金币'..'\n'
        -- end   
        if self['每秒加木头'] >0 then 
            str = str ..'+|cffffff00'..bignum2string(self['每秒加木头'])..'|r 每秒加木头'..'\n'
        end    
        if self['减少周围护甲'] >0 then 
            str = str ..'+|cffffff00'..bignum2string(self['减少周围护甲'])..'|r 减少周围护甲'..'\n'
        end   
        if self['多重暴击几率'] >0 then 
            str = str ..'+|cffffff00'..bignum2string(self['多重暴击几率'])..'|r 多重暴击几率'..'\n'
        end  
        -- if self['会心几率'] >0 then 
        --     str = str ..'+|cffffff00'..bignum2string(self['会心几率'])..'%|r 会心几率'..'\n'
        -- end    
        -- if self['会心伤害'] >0 then 
        --     str = str ..'+|cffffff00'..bignum2string(self['会心伤害'])..'%|r 会心伤害'..'\n'
        -- end     
        if self['吸血'] >0 then 
            str = str ..'+|cffffff00'..bignum2string(self['吸血'])..'%|r 吸血'..'\n'
        end   
        if self['多重暴击'] >0 then 
            str = str ..'+|cffffff00'..bignum2string(self['多重暴击'])..'|r 多重暴击'..'\n'
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
    -- print(self.trg,self.level,self.max_level)
    if not self.trg and self.level < self.max_level then 
        self.trg = ac.game:event '单位-杀死单位' (function(trg, killer, target)
            --召唤物杀死也继承
            local hero = killer:get_owner().hero
            if hero ~= self.owner then 
                return 
            end    
            if hero and hero:has_item(self.name) and (hero == self.owner) then 
                local item = hero:has_item(self.name)
                if item.level > item.max_level then 
                    return 
                end
                if item._count < item.kill_cnt then 
                    item:add_item_count(1)
                end    
            end    
        end)
    end   
end

function mt:on_cast_start()
    local hero = self.owner
    local p = hero:get_owner()
    hero = p.hero
    --处理进入魔窟截止
    if ac.flag_tlmt then 
        p:sendMsg('|cffebb608【系统】|cffff0000已入魔窟，无法传送',5)
        return 
    end



    --需要先增加一个，否则消耗品点击则无条件先消耗
    -- self:add_item_count(1) 
    local item = hero:has_item(self.name)
    if item._count >= item.kill_cnt and not p.flag_sxz  then 
        if item.level == item.max_level and ac.g_game_degree_attr < self.sec_degree_attr then 
            return 
        end    
        p.flag_sxz = true
        --传送
        local blink_rect = ac.rect.j_rect('shixiezhu')
        hero:blink(blink_rect,true,false,true)
        --创建升级怪 
        local rect = ac.rect.j_rect('shixiezhu1')
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
            u = ac.player(12):create_unit('心魔BOSS'..(self.level+ac.skill['噬血珠'].max_level),point)
            u:event '单位-死亡'(function(_,unit,killer)
                p.flag_sxz = false 
                --物品升级
                if item.level >= self.max_level then 
                  
                else 
                    item:add_item_count(-item.kill_cnt+1)
                    item:upgrade(1)
                end    
                --传送回练功房
                local point = ac.map.rects['练功房刷怪'..p.id]:get_point()
                if finds(ac.g_game_degree_name,'深渊冒险') then 
                    point = ac.rect.j_rect('zxzw1'):get_point()
                end
                hero:blink(point,true,false,true)
            end)
        end)
        --创建区域离开事件
        local reg = ac.map.regions['shixiezhu2']
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
            p.flag_sxz = false 
            --删除自己的
            trg:remove()  
        end)
        
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