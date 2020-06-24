local mt = ac.skill['龙之血珠']
mt{
--等久
level = 1,
--冷却
cool = 0,
content_tip = '|cffffe799使用说明：|r',
--描述
tip = [[


|cff00ffff点击可食用 可以让|cffff0000部分顶级功法|cff00ffff获得强化！无法强化相同功法！|r

已强化 %cnt%|cffffff00 / %max_cnt%|r 个： %content%]],

cnt = function(self) 
    local cnt = 0
    if self and self.owner and self.owner:is_hero() then 
        local hero = self.owner
        local player = hero:get_owner()
        cnt = player.qh_skill_cnt or 0 
    end    
    return cnt
end,
max_cnt = function(self) 
    local cnt = 0
    if self and self.owner and self.owner:is_hero() then 
        local hero = self.owner
        local player = hero:get_owner()
        cnt = player:get('龙之血珠使用上限') + 8
    end    
    return cnt
end,
content = function(self) 
    local content = '' 
    --恶魔果实在宠物也可以展示
    if self and self.owner  then 
        local hero = self.owner
        local player = hero:get_owner()
        if player.qh then 
            for i,item in ipairs(player.qh) do
                content = content ..'\n'.. item.name
            end
        end    
    end    
    return content
end,
--品质
-- color = '紫',
art = [[longxiezhu.blp]],
--物品类型
item_type = '消耗品',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
strong_skill_name = name,
--冷却
cool = 1,
--购买价格
gold = 10000,
--物品模型
-- specail_model = [[acorn.mdx]],

-- model_size = 2,
--物品数量
_count = 1,

}

--处理强化
function mt:on_strong(skill)
    local hero = skill.owner
    local player = hero:get_owner()
    hero = player.hero
    local slot_id = skill.slot_id
    --强化技能
    hero:replace_skill(skill.name,'真·'..skill.name)
    player:sendMsg('|cffffe799【系统消息】|r|cffffff00功法强化成功|r 强化后的功法可以在 英雄技能栏 查看')
    
end
function mt:on_cast_start()
    local unit = self.owner
    local hero = self.owner
    local player = hero:get_owner()
    local count = 0
    local name = self:get_name()
    hero = player.hero
    local list = {}
    --只能吞噬 10 个 物品类的，没法更新数据
    local cnt = player:get('龙之血珠使用上限') + 8
    if (player.qh_skill_cnt or 0) >= cnt then 
        self:add_item_count(1)
        player:sendMsg('无法食用更多的恶魔果实')
        return 
    end    
    for i=1,8 do 
        local skill = hero:find_skill(i,'英雄')
        if skill then 
            local flag
            if player.qh then 
                for i,item in ipairs(player.qh) do
                    if item.name == skill.name then 
                        flag =true 
                        break
                    end    
                end
            end  
            if skill.level>=skill.max_level and _in(skill.color,'天阶','天赋','神阶') and not flag then 
                count = count + 1
                local info = {
                    name = "|cff"..ac.color_code['淡黄']..'强化 '..'|cff'..ac.color_code[skill.color].. clean_color(skill:get_title()),
                    skill = skill
                }
                table.insert(list,info)
            end    
        end
    end 

    if count < 1 then 
        player:sendMsg('没有可强化的技能')
        if self._count > 1 then 
            -- print('数量')
            self:set_item_count(self._count+1)
        else
            --重新添加给英雄
            unit:add_item(name,true)
        end     
        return 
    end 
    local info = {
        name = '取消 (Esc)',
        key = 512
    }
    table.insert(list,info)

    if not self.dialog  then 
        self.dialog = create_dialog(player,'请选择要强化的技能',list,function (index)
            local skill = list[index].skill
            if skill then 
                --进行强化处理
                self:on_strong(skill)
                --吞噬个数 +1
                if not player.qh_skill_cnt then 
                    player.qh_skill_cnt =0
                end    
                player.qh_skill_cnt = player.qh_skill_cnt + 1

                --吞噬名
                if not player.qh then 
                    player.qh = {}
                end    
                table.insert(player.qh,skill)
                
                --触发超级彩蛋
                -- if player.qh_skill_cnt  == 8 then 
                --     ac.game:event_notify('技能-插入魔法书',hero,'超级彩蛋','霸王色的霸气')
                --     ac.player.self:sendMsg('|cffffe799【系统消息】|r|cff00ffff'..player:get_name()..'|r|cff00ffff 不断食用恶魔果实|r 惊喜获得技能|cffff0000 "霸王色的霸气" |r |cff00ff00每5秒触发一次，对周围敌人造成全属性*30的伤害，并晕眩0.8秒|r',6)
                -- end   
                

            else
                -- print('取消更换技能')
                if self._count > 1 then 
                    -- print('数量')
                    self:set_item_count(self._count+1)
                else
                    --重新添加给英雄
                    unit:add_item(name,true)
                end        
            end
            
            self.dialog = nil
        end)
    else
        self:add_item_count(1)    
    end    


end

function mt:on_remove()
end

