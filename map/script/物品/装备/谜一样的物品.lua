--物品名称
local mt = ac.skill['谜一样的箱子']
mt{
    level = 1 ,
    --颜色
    color = '紫',
    tip = [[ 
        
|cff00ff00一个可以收集怪物灵魂的箱子，性能不详
    ]],
    --|cff00ffff功法怪灵魂（可在练功房-武学功法NPC处召唤）|cff00ff00
    --技能图标
    art = [[tkdbz.blp]],
    kill_cnt = 1000,
    --唯一
    unique = true,
    owner_ship = true,
    --升级特效
    effect2 = [[Void Teleport Target.mdx]],
    --物品详细介绍的title
    content_tip = '|cffFFE799说明：|r',
}

function mt:on_add()
    local hero = self.owner
    local p = hero.owner
    if hero:get_owner().id >10 then 
        return 
    end    
    self:set_name(self.name)
    -- print(self.trg,self.level,self.max_level)
    if not self.trg and not p.flag_myydxz  then 
        self.trg = ac.game:event '单位-杀死单位' (function(trg, killer, target)
            --召唤物杀死也继承
            local hero = killer:get_owner().hero
            if hero ~= self.owner then 
                return 
            end    
            if hero and hero:has_item(self.name) and (hero == self.owner) then 
                local item = hero:has_item(self.name)
                if item._count < item.kill_cnt then 
                    item:add_item_count(1)
                else 
                    p.flag_myydxz = true
                    --给红装 删物品
                    item:item_remove()
                    local name = ac.all_item[math.random(#ac.all_item)]
                    local it = hero:add_item(name)
                    p:sendMsg('|cffebb608【系统】|r百思终得其解，|cffffff00谜一样的物品|r 原来是 '..it.color_name,5)
                    -- ac.item.create_item(name,point)

                    
                end    
            end    
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


--物品名称
local mt = ac.skill['谜一样的天书']
mt{
    level = 1 ,
    --颜色
    color = '紫',
    tip = [[ 

|cff00ff00一本可以收集|cff00ffff 功法怪灵魂 |cff00ff00的功法，性能不详

|cffcccccc（可在练功房的武学功法NPC处，召唤功法怪）]],
    --技能图标
    art = [[gongfa.blp]],
    kill_cnt = 1000,
    --唯一
    unique = true,
    owner_ship = true,
    --升级特效
    effect2 = [[Void Teleport Target.mdx]],
    --物品详细介绍的title
    content_tip = '|cffFFE799说明：|r',
}

function mt:on_add()
    local hero = self.owner
    local p = hero.owner
    if hero:get_owner().id >10 then 
        return 
    end    
    self:set_name(self.name)
    -- print(self.trg,self.level,self.max_level)
    if not self.trg and not p.flag_myydts then 
        self.trg = ac.game:event '单位-杀死单位' (function(trg, killer, target)
            if not finds(target:get_name(),'功法怪') then 
                return 
            end
            --召唤物杀死也继承
            local hero = killer:get_owner().hero
            if hero ~= self.owner then 
                return 
            end    
            if hero and hero:has_item(self.name) and (hero == self.owner) then 
                local item = hero:has_item(self.name)
                if item._count < item.kill_cnt then 
                    item:add_item_count(1)
                else 
                    p.flag_myydts = true
                    --给红装 删物品
                    item:item_remove()
                    local name = ac.all_skill[math.random(#ac.all_skill)]
                    local it = ac.item.add_skill_item(name,hero)
                    p:sendMsg('|cffebb608【系统】|r百思终得其解，|cffffff00谜一样的天书|r 原来是 '..it.color_name..' |cffcccccc（学满8个功法有惊喜！）',5)
                    -- ac.item.create_item(name,point)
                end    
            end    
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

ac.game:event '单位-死亡'(function(trg,unit,killer)
    if not _in(unit:get_name(),'灵魂','熊猫人')  then 
        return
    end		
    local p = killer.owner
    p.flag = p.flag or {}
    --掉落谜一样的箱子
    if unit:get_name() == '灵魂' then 
        local name = '谜一样的箱子'
        if not p.flag[name] then 
            local it = ac.item.create_item(name,unit:get_point())
            it.owner_ship = p
            p.flag[name] = true
        end
    end

    --掉落谜一样的天书
    if unit:get_name() == '熊猫人' then 
        local name = '谜一样的天书'
        if not p.flag[name] then 
            local it = ac.item.create_item(name,unit:get_point())
            it.owner_ship = p
            p.flag[name] = true
        end
    end

end)



