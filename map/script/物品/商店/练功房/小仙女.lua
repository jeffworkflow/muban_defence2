
local rect = require 'types.rect'

-- 小仙女
local fairy ={}
--从 lni 数据读取 到变量
for name,data in sortpairs(ac.table.ItemData) do 
    if data.class == '小仙女' then 
        table.insert(fairy,name)
    end
end        



local mt = ac.skill['抽取【召唤】铭文']
mt{
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
   time =15,
--    model = [[units\creeps\GrizzlyBear\GrizzlyBear.mdl]],
   event_name = '造成伤害效果',
   unit_name ='狗熊',
--    cool=12,
   mul = 1
}
function mt:on_add()
    local hero = self.owner
    local p = hero.owner
    if not p.hero then 
        return 
    end
    local skl = p.hero:find_skill(self.name,nil,true)
    if skl then 
        skl:set('cool',12) --魔法书里的技能升级时，激活cd。
    end

end    
function mt:damage_start(damage)
    local hero =self.owner
    local p = hero.owner
    local skill =self
    local target = damage.target

	if not damage:is_common_attack()  then 
		return 
    end 
    
    local u = p:create_unit(self.unit_name,hero:get_point() - {math.random(360),100})
    u:remove_ability 'AInv'
    u:add_ability 'Aloc'
    u:add_restriction '无敌'

    local attribute ={
        ['攻击'] = hero:get('攻击')*self.mul,
        ['护甲'] = hero:get('护甲')*self.mul,
        ['攻击间隔'] = hero:get('攻击间隔'),
        ['攻击速度'] = hero:get('攻击速度'),
        ['生命上限'] = hero:get('生命上限')*self.mul,
        ['魔法上限'] = hero:get('魔法上限'),
        ['生命恢复'] = hero:get('生命恢复')*self.mul,
        ['魔法恢复'] = hero:get('魔法恢复')*self.mul,
        ['移动速度'] = hero:get('移动速度'),

        -- ['分裂伤害'] = hero:get('分裂伤害'),
        -- ['攻击减甲'] = hero:get('攻击减甲'),
        ['暴击几率'] = hero:get('暴击几率'),
        ['暴击伤害'] = hero:get('暴击伤害'),
        ['会心几率'] = hero:get('会心几率'),
        ['会心伤害'] = hero:get('会心伤害'),

        ['物品获取率'] = hero:get('物品获取率'),
        ['木头加成'] = hero:get('木头加成'),
        ['金币加成'] = hero:get('金币加成'),
        ['杀敌数加成'] = hero:get('杀敌数加成'),
        ['魔丸加成'] = hero:get('魔丸加成'),--新资源

    }
    
    u:add_buff "召唤物"{
        -- model = self.model,
        time = self.time,
        attribute = attribute,
        remove_target = true,
        skill = self,
        follow = true,
        search_area = 500, --搜敌路径
    }

    --存档加成 
    if p.hero:find_skill('熊灵分裂',nil) then 
        u:add_skill('熊灵分裂1','英雄')
    end
    if p.hero:find_skill('熊灵攻击减甲',nil) then 
        u:add_skill('熊灵攻击减甲1','英雄')
    end
    if p.hero:find_skill('熊灵粉碎击',nil) then 
        u:add_skill('熊灵粉碎击1','英雄')
    end
    
end    


local mt = ac.skill['抽取【长生】铭文']
mt{
    --触发几率
   chance = 15,
   effect = [[Abilities\Spells\Human\Resurrect\ResurrectCaster.mdl]],
   event_name = '单位-即将死亡',
}
function mt:damage_start(unit,killer)
    local hero =self.owner
    local p = hero.owner
    local skill =self
    --目标特效
    -- ac.effect(damage.target:get_point(),self.effect,0,4,'origin'):remove()
    hero:add_effect('chest',self.effect):remove()
    --目标减最大 
    hero:heal
    {
        source = hero,
        skill = skill,
        string = '长生',
        size = 10,
        heal = hero:get('生命上限'),
    }	
    hero:add_buff '无敌'{
        time =0.5
    }
    -- hero:add('护甲',1000000000)
    return true
end    

local mt = ac.skill['铭文就是力量']
mt{
    --等久
    level = 1,
    --魔法书相关
    is_order = 1 ,
    art = [[mingwenjiushililiang.blp]], 
    tip = [[
    
|cffFFE799【成就属性】：|r
|cff00ff00+100W 力量
+35%   攻击速度|r

]],
    ['力量'] = 1000000,
    ['攻击速度'] = 35,
    
}


local mt = ac.skill['古老的铭文']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[mingwen8.blp]],
    title = '古老的铭文',
    tip = '\n点击查看 |cff00ff00古老的铭文|r，通过 |cffffff00练功房右上角NPC|r 抽奖获得\n|r',
}
mt.skills = fairy
for _,name in ipairs(fairy) do 
    --物品名称
    local mt = ac.skill[name]
    mt.level = 0
    --施法动作
    -- mt.cast_animation = ''
    --初始概率
    mt.rate = 10
    --概率增加
    mt.up_rate = 5
    mt.is_ui_text=true
    
    function mt:on_cast_shot()
        local hero = self.owner
        local p = hero:get_owner()
        local seller = self.owner
        hero = p.hero
        local name = self.name 

        --如果所有者就是英雄，则返回
        if hero == self.owner then 
            --停止继续执行   
            self:stop()
            return 
        end
        --如果有足够的钱
        if p.kill_count >self.kill_count  then 
            hero:add_kill_count(-self.kill_count)
            if math.random(100) <= self.rate then
                --概率激活铭文
                local skl = hero:find_skill(self.name,nil,true)
                if skl then 
                    if finds(self.name, '召唤') then 
                        --概率激活变异狗熊
                        local rate = 0.1
                        if math.random(10000)/100 <= rate then 
                            skl.unit_name = '变异狗熊'
                            skl.mul = 3
                            ac.player.self:sendMsg('|cffebb608【系统】|cff00ff00恭喜 '..p:get_name()..' 触发事件-|cffff0000变异|r',5)   
                        end    
                    end
                    skl:set_level(1) 
                    skl.passive = true
                    --删除技能
                    self:remove()
                end 
                p:sendMsg('|cffebb608【系统】|cffffff00恭喜抽中|cff00ff00，铭文属性可在圣龙气运-古老的铭文中查看',5)   
                --创建真小仙女
                p.fw_cnt =  (p.fw_cnt or 0) + 1
                -- print('玩家小仙女激活个数：',p,p.fw_cnt,#fairy )
                if p.fw_cnt == 8 then 
                    local x,y = seller:get_point():get()
                    --移出原来的小仙女
                    seller:remove()
                    --新增新的小仙女
                    local sp = ac.shop.create('真·小仙女',x,y,270)
                    sp:add_sell_item('十连换',12)
                    
                    -- 铭文就是力量
                    local skl = hero:find_skill('铭文就是力量',nil,true) 
                    if not skl  then 
                        ac.game:event_notify('技能-插入魔法书',hero,'古老的铭文','铭文就是力量')
                        p:sendMsg('|cffebb608【系统】|cff00ff00终于全部抽到了！获得成就|cffffff00 铭文就是力量 |cff00ff00奖励 |cffff0000力量+100万，攻击速度+35%',5)  
                    end   
                end
            else
                --抽取失败 提升概率
                self:set('rate',self.rate + self.up_rate)
                p:sendMsg('|cffebb608【系统】|cff00ff00差一点就抽中了，祝你下次好运|cffffff00（下次抽取的命中率提升了5%）',5)  
                -- 下次抽中概率:'..self.rate + self.up_rate,5)  
               
                --概率激活彩蛋
                local rate = 2
                local real_name = '错臂之交'
                if math.random(10000)/100 <= rate then 
                    local skl = hero:find_skill(real_name,nil,true) 
                    if not skl  then 
                        ac.game:event_notify('技能-插入魔法书',hero,'彩蛋',real_name)
                    end    
                end    
            end 
        else 
            p:sendMsg('|cffebb608【系统】|cffff0000杀敌数不足',5)    
        end
    end  
end     

ac.game:event '单位-创建商店'(function(trg,shop)
    local name = shop:get_name()
    if name ~='小仙女' then 
        return 
    end    
    --添加技能
    local flag =true
    for num,name in ipairs(fairy) do    
        flag = flag and 300*num  
        ac.wait(flag or 0,function()
            if num <= 4 then 
                shop:add_skill(name,'英雄',num + 8 ):upgrade(1)
            elseif num <= 8 then 
                shop:add_skill(name,'英雄',num):upgrade(1)
            else
                shop:add_skill(name,'英雄',num - 8):upgrade(1)
            end   
        end)
    end   
end)



