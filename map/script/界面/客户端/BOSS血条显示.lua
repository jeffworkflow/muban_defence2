


--血条亮红色
local new_ui = class.panel:builder{
    x = 600,--屏幕界面X坐标
    y = 100,--屏幕界面Y坐标
    w = 80,
    h = 80,
    is_show = true,
    level = 1,
    normal_image = 'Transparent.tga',
    --血条
    model_bg = {
        level = 8,
        type = 'model',
        size = 1.5,
        model = [[Bar_Red2.mdx]],
        model_black = {
            type = 'model',
            level = 5,
            size = 1.5,
            model = [[Bar_XT_Black.mdx]],
        },
    },
    init_data = function(self)
        -- print(self, self.model_bg,self.model_bg.type)
        self.model_bg.model_black:set_animation(0,false)
        self.model_bg.model_black:set_progress(0.99)
        
        -- self.model_bg.model_red:set_progress(0.2)
    end,
    fresh = function(self,rate)
        -- print('概率',rate)
        -- self.model_bg.model_red:set_progress(0.2)
        --设置动画
        local tab = self.model_bg
        -- tab:set_process({
        --     handle = '血条',
        --     target = rate,
        --     show = function(self,source)
        --         tab.model_black:set_progress(source/100)
        --     end
        -- })
        tab.model_black:set_progress(rate/100)
    end,
    add_unit = function(self,unit)
        self:show()
        if self.trg then 
            self.trg:remove()
            self.trg =nil
        end
        if self.trg1 then 
            self.trg1:remove()
            self.trg1 =nil
        end
        self.trg = unit:event '伤害计算完毕' (function(_,damage)
            local rate = unit:get('生命') /unit:get('生命上限')*100
            -- print(rate)
            self:fresh(rate)
        end)
        self.trg1 = unit:event '单位-死亡' (function(_,damage)
            self:hide()
        end)


    end
}

new_ui:init_data()

ac.ui.blood_bar = new_ui
print('加载了 boss血条')

-- ac.game:event '游戏-回合开始'(function(trg,index, creep) 
--     if creep.name ~= '深渊冒险' then
--         return
--     end   
-- end)


--如下 为 orpg 每个玩家 选择或 造成伤害不同，显示不同的血条。
-- ac.game:event '玩家-选择单位' (function(self, player, hero)
--     if hero == player.selected then 
--         return 
--     end    
--     --选择的时同盟单位 也是return
--     if hero.owner:is_ally(player) then 
--         return 
--     end    
--     if new_ui.trg then 
--         new_ui.trg:remove()
--         new_ui.trg = nil
--     end
--     if new_ui.trg1 then 
--         new_ui.trg1:remove()
--         new_ui.trg1 = nil
--     end
--     --如果选中了其他 boss
--     if hero.unit_type =='boss' then 
--         if player:is_self()then
--             new_ui:show()
--             new_ui.unit = hero
--             new_ui.trg = hero:event '伤害计算完毕' (function(_,damage)
--                 local rate = hero:get('生命') /hero:get('生命上限')*100
--                 -- print(rate)
--                 new_ui:fresh(rate)
--             end)
--             new_ui.trg1 = hero:event '单位-死亡' (function(_,damage)
--                 new_ui:hide()
--             end)
--         end 
--     --选中了 小兵，取消ui显示
--     else
--         if player:is_self()then
--             new_ui:hide()
--         end
--     end    
    
-- end)

-- ac.game:event '造成伤害效果' (function(_,damage)
--     if not damage.source:is_hero() then 
--         return 
--     end
--     if not damage:is_common_attack() then 
--         return 
--     end
--     local p = damage.source.owner
--     local target = damage.target
--     if p:is_self() then 
--         if new_ui.unit == damage.target then 
--         else
--             if new_ui.trg then 
--                 new_ui.trg:remove()
--                 new_ui.trg = nil
--             end
--             if new_ui.trg1 then 
--                 new_ui.trg1:remove()
--                 new_ui.trg1 = nil
--             end

--             new_ui:show()
--             new_ui.unit = target
--             new_ui.trg = target:event '伤害计算完毕' (function(_,damage)
--                 local rate = target:get('生命') /target:get('生命上限')*100
--                 -- print(rate)
--                 new_ui:fresh(rate)
--             end)
--             new_ui.trg1 = target:event '单位-死亡' (function(_,damage)
--                 new_ui:hide()
--             end)
--         end
--     end


-- end)
