
--注册事件
ac.game:event '单位-发布指令' (function(self, hero, order, target, player_order)
    if order ~= 'smart' then
        return
	end
	-- print('发布移动闪烁指令',hero, order, target, player_order)
	if hero:is_type('宠物') and target then 
		
		hero:find_skill('全图闪烁',nil,true):cast(target) --有淡化特效
		-- hero:blink(target:get_point()) --无特效，瞬发
    end
end)