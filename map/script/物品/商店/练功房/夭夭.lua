
local rect = require 'types.rect'


-- 传送 快速达到 兑换 交易
local devil_deal ={
}
--从 lni 数据读取 到变量
for name,data in sortpairs(ac.table.ItemData) do 
    if data.class == '夭夭' then 
        -- print(name,data.num)
        if not devil_deal[data.num] then 
            devil_deal[data.num] = {}
        end      
        table.insert(devil_deal[data.num],{name,data.coin,data.coin_val,data.art})
    end
end        



ac.devil_deal = devil_deal
--根据重数 给商店添加10技能，并让第一技能为可点击状态
--单位，重数
local function add_skill_by_lv(shop,lv,flag)
    --最后一重时，增加魔鬼的交易
    if lv > #devil_deal then 
        shop:add_sell_item('真魔鬼的交易',1)
        shop:add_sell_item('魔鬼的合成',4)
        
    end    
    if not devil_deal[lv] then 
        return 
    end    
    for num,value in ipairs(devil_deal[lv]) do    
        flag = flag and 300*num  
        ac.wait(flag or 0,function()
            if num <= 4 then 
                -- print(value[1])
                shop:add_skill(value[1],'英雄',num + 8 )
            elseif num <= 8 then 
                shop:add_skill(value[1],'英雄',num)
            else
                shop:add_skill(value[1],'英雄',num - 8)
            end   
            -- shop:add_skill(value[1],'英雄')
            if num ==1 then 
                local skl = shop:find_skill(value[1],'英雄',true)
                skl:set_level(1)
            end 
        end)
    end   
end   

local mt = ac.skill['神魂修炼']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[xiulian10.blp]],
    title = name,
    tip = '\n点击查看 |cff00ff00神魂修炼\n|r',
}
for _,tab in ipairs(devil_deal) do 
    if not mt.skills then 
        mt.skills ={}
    end    
    local name = string.sub(tab[_][1],1,6)
    --每重魔法书
    table.insert(mt.skills,name)

    -- print('夭夭',name)
    local mt2 = ac.skill[name]
    mt2{
        is_spellbook = 1,
        is_order = 2,
        art = tab[_][4],
        title = name,
        tip = '\n查看 |cff00ff00'.. name ..'\n|r',
    }
    if not mt2.skills then 
        mt2.skills ={}
    end    
    for num,value in ipairs(tab) do 
        --插入到魔法书
        table.insert(mt2.skills,value[1])
        --物品名称
        local mt = ac.skill[value[1]]
        mt{
            level = 0,
            --施法动作
            -- cast_animation = '',
            content_tip = '',
            show_tip = function(self) --不可删，否则消耗good 会有问题。
                local str = ''
                if self.gold then 
                    str = '' .. self.gold .. '金币'
                end   
                if self.kill_count then 
                    str = '杀敌数' .. self.kill_count 
                end   
                if self.wood then 
                    str = '' .. self.wood .. '木头'
                end    
                if self.cost_allattr then 
                    str = '' .. self.cost_allattr .. '全属性'
                end    
                if self.fire_seed then 
                    str = '' .. self.fire_seed .. '火灵'
                end    
                return str
            end,
        }
        if value[2]=='全属性' then
            mt.cost_allattr = tonumber(value[3])
        end   
        local function add_next_skill(skill,seller,hero)
            local self = skill
            seller:remove_skill(self.name)
            local skl_name = ''
            if num == #tab then 
                add_skill_by_lv(seller,_+1)
            else
                skl_name = tab[num +1][1] --下一个技能名
            end   
            -- 激活下商店下一个属性 
            local skl = seller:find_skill(skl_name,'英雄',true)
            if skl then 
                skl:set_level(1)
            end    
            --激活人身上的技能及属性
            local skl = hero:find_skill(self.name,nil,true)
            if skl then 
                skl:set_level(1)
                skl:set('extr_tip','\n|cffFFE799【状态】：|r|cff00ff00已激活|r')
                -- skl:fresh_tip()
            end   
        end  
        --模拟商店点击
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
            
            -- print(owner_value,self.cost_allattr)
            if self.cost_allattr then 
                local owner_value = math.min(hero:get('力量'),hero:get('敏捷'),hero:get('智力'))
                -- print(owner_value,self.cost_allattr)
                --有足够的全属性
                if owner_value > self.cost_allattr  then 
                    self.seller = seller
                    --扣除全属性
                    hero:add('全属性',-self.cost_allattr)
                    --给与奖励
                    self:on_cast_finish()
                else
                    p:sendMsg('全属性不足',10) 
                end  
                --停止继续执行   
                self:stop()
                return  
            end

            local item = setmetatable(self,ac.item)
            -- print(name,self.name,self.gold,self.wood,item.gold)
            item.name = name
            if hero:is_alive() then 
                hero:event_notify('单位-点击商店物品',seller,hero,item)
            else
                local flag = hero:event_dispatch('单位-点击商店物品',seller,hero,item)
                if flag then 
                    add_next_skill(self,seller,hero) --增加属性，删除技能
                    
                end    
            end    
            self.owner = seller
            --停止继续执行
            self:stop()
        end  
        --商品实际被点击时的执行效果
        function mt:on_cast_finish()
            local hero = self.owner
            local p = hero:get_owner()
            local seller = self.seller
            hero = p.hero
            -- print('施法结束啦')
            --增加属性
            -- print(self.attr_name,self.attr_val)
            -- hero:add(self.attr_name,self.attr_val)
            --处理下一个
            --local next = self.position + 1 
            -- self:remove()
            -- print(seller,hero,self.name) 
            add_next_skill(self,seller,hero)
            

        end
    end    

end     

ac.game:event '单位-创建商店'(function(trg,shop)
    local name = shop:get_name()
    if name ~='夭夭' then 
        return 
    end    
    add_skill_by_lv(shop,1,true)
end)



