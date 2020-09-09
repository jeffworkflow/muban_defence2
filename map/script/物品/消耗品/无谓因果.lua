local mt = ac.skill['无谓因果']
mt{
--等久
level = 1,
--冷却
cool = 0,
content_tip = '|cffffe799使用说明：|r',
--描述
tip = [[
|cffcccccc无谓因果，不惧轮回。

|cff00ffff点击可食用 可以让|cffff0000强化后的顶级功法|cff00ffff融合入体！无法融合相同功法！|r

已融合 %cnt%|cffffff00 / %max_cnt%|r 个： %content%]],

cnt = function(self) 
    local cnt = 0
    if self and self.owner and self.owner:is_hero() then 
        local hero = self.owner
        local player = hero:get_owner()
        cnt = player.ruti_cnt or 0 
    end    
    return cnt
end,
max_cnt = function(self) 
    local cnt = 0
    if self and self.owner and self.owner:is_hero() then 
        local hero = self.owner
        local player = hero:get_owner()
        cnt = player:get('无谓因果使用上限') + 8
    end    
    return cnt
end,
content = function(self) 
    local content = '' 
    --恶魔果实在宠物也可以展示
    if self and self.owner  then 
        local hero = self.owner
        local player = hero:get_owner()
        if player.ruti then 
            for i,skl in ipairs(player.ruti) do
                content = content ..'\n'.. '|cff'..ac.color_code[skl.color or '白']..skl.name..'|r'
            end
        end    
    end    
    return content
end,
--品质
-- color = '紫',
art = [[rongheyinguo.blp]],
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
    --入体技能
    --先删除
    skill:remove() 
    ac.game:event_notify('技能-插入魔法书',hero,'神技入体',skill.name)
    player:sendMsg('|cffebb608【系统】|r|cffffff00功法吞噬成功|r 吞噬后的功法可以在 圣龙气运-吞噬系统中 查看')
    --设置入体技能为5级
    ac.wait(300,function() 
        local skl = hero:find_skill(skill.name,nil,true)
        if skl then skl:set_level(skl.max_level) end
    end)
    
end
function mt:on_cast_start()
    local unit = self.owner
    local hero = self.owner
    local owner = self.owner
    local player = hero:get_owner()
    local count = 0
    local name = self:get_name()
    hero = player.hero
    local list = {}
    --只能吞噬 10 个 物品类的，没法更新数据
    local cnt = player:get('无谓因果使用上限') + 8 
    if (player.ruti_cnt or 0) >= cnt then 
        self:add_item_count(1)
        player:sendMsg('无法食用更多的无谓因果')
        return 
    end    
    for i=1,8 do 
        local skill = hero:find_skill(i,'英雄')
        if skill then 
            local flag
            if player.ruti then 
                for i,item in ipairs(player.ruti) do
                    if item.name == skill.name then 
                        flag =true 
                        break
                    end    
                end
            end  
            -- if skill.level>=skill.max_level and skill.color == '真天阶' and not flag then 
            if skill.level>=skill.max_level and _in(skill.color,'真天阶','真天赋','真神阶') and not flag then 
                count = count + 1
                local info = {
                    
                    skill.name,'',"|cff"..ac.color_code['淡黄']..'吞噬 '..'|cff'..ac.color_code[skill.color].. clean_color(skill:get_title())
                    -- name = "|cff"..ac.color_code['淡黄']..'吞噬 '..'|cff'..ac.color_code[skill.color].. clean_color(skill:get_title()),
                    -- skill = skill
                }
                table.insert(list,info)
            end    
        end
    end 

    if count < 1 then 
        player:sendMsg('没有可吞噬的技能')
        if self._count > 1 then 
            -- print('数量')
            self:set_item_count(self._count+1)
        else
            --重新添加给英雄
            unit:add_item(name)
        end     
        return 
    end 
    local info = {
        '取消 (Esc)','Esc'
    }
    table.insert(list,info)
    table.insert(list,1,'请选择要吞噬的技能')
    local skill = self
    local dialog = player:dialog(list)
    function dialog:onClick(rname)
        local skl = hero:find_skill(rname,'英雄')
        if skl then 
            --进行强化处理
            skill:on_strong(skl)
            --吞噬个数 +1
            if not player.ruti_cnt then 
                player.ruti_cnt =0
            end    
            player.ruti_cnt = player.ruti_cnt + 1

            --吞噬名
            if not player.ruti then 
                player.ruti = {}
            end    
            table.insert(player.ruti,skl)
            
            --触发超级彩蛋
            if player.ruti_cnt  == 8 then 
                ac.game:event_notify('技能-插入魔法书',hero,'彩蛋','不惧轮回')
                ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff'..player:get_name()..'|r|cff00ffff 不断食用'..skill:get_title()..'|r 惊喜获得技能|cffff0000 "不惧轮回" |r |cff00ff00每5秒触发一次，对周围敌人造成全属性*175的伤害，并晕眩1秒|r',6)
                ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff'..player:get_name()..'|r|cff00ffff 不断食用'..skill:get_title()..'|r 惊喜获得技能|cffff0000 "不惧轮回" |r |cff00ff00每5秒触发一次，对周围敌人造成全属性*175的伤害，并晕眩1秒|r',6)
                ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff'..player:get_name()..'|r|cff00ffff 不断食用'..skill:get_title()..'|r 惊喜获得技能|cffff0000 "不惧轮回" |r |cff00ff00每5秒触发一次，对周围敌人造成全属性*175的伤害，并晕眩1秒|r',6)
            end   

            --触发 扫地神僧
            if not ac.sdss then 
                ac.sdss = true 
                local x,y = ac.rect.j_rect('sds'):get_point():get()
                local shop = ac.shop.create('扫地神僧',x,y,270)
                shop:add_sell_item('神僧的秘密',1)
                shop:add_sell_item('真·神魂修炼',9)
                shop:add_sell_item('神魂合成',12)
                ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ff00在|cff00ffff藏经阁|cff00ff00的虚弥空间隐藏着一位远古大能、能力通天，传言只要此人出山便可解决这次无数时空、位面的旷世大劫',10)
                ac.player.self:sendMsg('|cff00ff00可惜，此人不知何原因心意已死，独守虚弥空间，即使万千世界毁灭亦不踏出一步，谁入便是敌人',10)
                ac.player.self:sendMsg('|cffffff00传说此人身兼数万灭世大能，即这世间极少数站在顶峰之人传言中的凌驾所有功法之上的|cffff0000神阶功法',10)
            end
        else               
            -- print('取消更换技能')
            if skill._count > 1 then 
                skill:set_item_count(skill._count+1)
            else
                owner:add_item(skill.name)
            end        
        end
    end
    -- if not self.dialog  then 
    --     self.dialog = create_dialog(player,'请选择要吞噬的技能',list,function (index)
    --         local skill = list[index].skill
    --         if skill then 
    --             --进行强化处理
    --             self:on_strong(skill)
    --             --吞噬个数 +1
    --             if not player.ruti_cnt then 
    --                 player.ruti_cnt =0
    --             end    
    --             player.ruti_cnt = player.ruti_cnt + 1

    --             --吞噬名
    --             if not player.ruti then 
    --                 player.ruti = {}
    --             end    
    --             table.insert(player.ruti,skill)
                
    --             --触发超级彩蛋
    --             if player.ruti_cnt  == 8 then 
    --                 ac.game:event_notify('技能-插入魔法书',hero,'彩蛋','不惧轮回')
    --                 ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff'..player:get_name()..'|r|cff00ffff 不断食用'..self:get_title()..'|r 惊喜获得技能|cffff0000 "不惧轮回" |r |cff00ff00每5秒触发一次，对周围敌人造成全属性*175的伤害，并晕眩1秒|r',6)
    --                 ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff'..player:get_name()..'|r|cff00ffff 不断食用'..self:get_title()..'|r 惊喜获得技能|cffff0000 "不惧轮回" |r |cff00ff00每5秒触发一次，对周围敌人造成全属性*175的伤害，并晕眩1秒|r',6)
    --                 ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff'..player:get_name()..'|r|cff00ffff 不断食用'..self:get_title()..'|r 惊喜获得技能|cffff0000 "不惧轮回" |r |cff00ff00每5秒触发一次，对周围敌人造成全属性*175的伤害，并晕眩1秒|r',6)
    --             end   
                

    --         else
    --             -- print('取消更换技能')
    --             if self._count > 1 then 
    --                 -- print('数量')
    --                 self:set_item_count(self._count+1)
    --             else
    --                 --重新添加给英雄
    --                 unit:add_item(name)
    --             end        
    --         end
            
    --         self.dialog = nil
    --     end)
    -- else
    --     self:add_item_count(1)    
    -- end    


end

function mt:on_remove()
end

