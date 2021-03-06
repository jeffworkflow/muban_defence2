local mt = ac.skill['学习技能']
--技能模型
-- mt._model = ac.zb_color_model['书']
-- mt.model_size = 1.5
-- mt.color ='紫'
mt.is_skill = true
mt.cus_type = '技能' --类型
mt.item_type = '技能' --类型
mt.skill_cnt =8 --一共技能数量
mt.item_type_tip= ''
mt.model_size= 1.3
-- mt.time_removed = 180
function mt:on_cast_shot()
    local hero = self.owner 
    local owner = self.owner 
    local player = hero:get_owner()
    --宠物也帮忙学技能
    hero = player.hero
    local name = self.skill_name
    if name == nil then 
        return 
    end 

    local skill = hero:find_skill(name,'英雄',true)

    if skill then 
        local upgrade_count = skill.upgrade_count or 1

        if upgrade_count >= skill.max_level then 
            player:sendMsg('技能已经满级')

            if self._count > 1 then 
                -- print('数量')
                self:set_item_count(self._count+1)
            else
                --重新添加给所有者
                ac.item.add_skill_item(name,owner)
            end     

            return 
        end 
        upgrade_count = upgrade_count + 1

        skill.upgrade_count = upgrade_count 

        skill:set_level(skill:get_level() + 1)
        -- self:remove()
        --升级技能后
        local unit = self.owner
        if not unit:is_hero() then 
            for skill in unit:each_skill '英雄' do 
                skill:fresh()
            end 
        end
        return 
    end 

    local count = 0

    local list = {}

    for i=1,self.skill_cnt do 
        local skill = hero:find_skill(i,'英雄')
        if skill then 
            local key = skill:get_hotkey() 
            -- local info = {
            --     name = '|cff00ff00更换 |cff'..ac.color_code[skill.color or '白'].. clean_color(skill:get_title()) .. ' ( ' .. key.. ' )',
            --     key = key:byte(),
            --     skill = skill,
            -- }
            local info = {
                skill.name,key:byte(),'|cff00ff00更换 |cff'..ac.color_code[skill.color or '白'].. clean_color(skill:get_title()) .. ' ( ' .. key.. ' )'
            }
            table.insert(list,info)
        end
    end 
    if #list < self.skill_cnt then 
        hero:add_skill(name,'英雄')
        if #list == self.skill_cnt - 1 then 
            --增加彩蛋 八个技能的男人
            local skl = hero:find_skill('八个技能的男人',nil,true)
            if not skl  then 
                ac.game:event_notify('技能-插入魔法书',hero,'彩蛋','八个技能的男人')
                player.is_show_nickname = '八个技能的男人'
                --给全部玩家发送消息
                ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff'..player:get_name()..'|r获得成就|cffff0000 "八个技能的男人" |r 奖励 |cffff0000全属性+100w，攻击减甲+15，魔丸+1W|r',8)
                ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ff00当功法学满后，点击新的功法书|cffffff00可替换|cff00ff00身上的功法，且|cffffff00功法等级可被继承|cffff0000（大胆地去武学功法NPC处升级功法吧！）|r',8)
            end
            

        end    
    else 
        local info = {
            '取消 (Esc)','Esc'
        }
        table.insert(list,info)
        table.insert(list,1,'更换技能')
        local skill = self
        local dialog = player:dialog(list)
        function dialog:onClick(rname)
            local skl = hero:find_skill(rname,'英雄')
            if skl then 
                local id = skl.slotid
                local level = skl.level
                skl:remove()
                local new_skl = hero:add_skill(name,'英雄',id)
                new_skl:set_level(level)
            else
                -- print('取消更换技能')
                if skill._count > 1 then 
                    skill:set_item_count(skill._count+1)
                else
                    ac.item.add_skill_item(name,owner)
                end        
            end
        end
        -- if not self.dialog  then 
        --     self.dialog = create_dialog(player,'更换技能',list,function (index)
        --         local skl = list[index].skill
        --         if skl then 
        --             local id = skl.slotid
        --             local level = skl.level
        --             skl:remove()
        --             local new_skl = hero:add_skill(name,'英雄',id)
        --             new_skl:set_level(level)
        --         else
        --             -- print('取消更换技能')
        --             if self._count > 1 then 
        --                 self:set_item_count(self._count+1)
        --             else
        --                 if hero:is_alive() then 
        --                     ac.item.add_skill_item(name,owner)
        --                 else    
        --                     if hero.xuexijineng_trg then hero.suijijineng_trg:remove() end
        --                     hero.xuexijineng_trg = hero:event '单位-复活' (function ()
        --                         ac.item.add_skill_item(name,hero)
        --                         hero.xuexijineng_trg:remove()
        --                     end)    
        --                 end    
        --             end        
        --         end
                
        --         self.dialog = nil
        --     end)
        -- else
        --     self:add_item_count(1)    
        -- end    
    end

    --学习技能后，刷新技能
    local unit = self.owner
    if not unit:is_hero() then 
        for skill in unit:each_skill '英雄' do 
            skill:fresh()
        end 
    end
end 