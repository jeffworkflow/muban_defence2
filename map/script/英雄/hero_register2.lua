
local player_hero_tm_list = {}
local function add_units_buff(p,time)
	local temp = {}
	table.insert(temp,p.unit_mojian)
	table.insert(temp,p.unit_shenjian)
	table.insert(temp,p.unit_fs)
	table.insert(temp,p.unit_ys)
	for i,u in ipairs(temp) do 
		-- print('单位死亡打印：',i,u)
		u:add_buff '隐藏'{
			time = time
		}
		u:add_buff '缴械'{
			time = time
		}
	end


end

ac.game:event '玩家-注册英雄' (function(_, player, hero)
	if not player_hero_tm_list[player] then
		player_hero_tm_list[player] = tm
	end
	--取消控制 玩家16 （中立单位）
    local id = player.id - 1
	player:disableControl(ac.player[16])

	hero:event '单位-死亡' (function()
		local p = hero.owner
		--复活时间 减少复活时间 
		hero.revive_time = math.max(1, 10 - hero:get('减少复活时间'))
		--武林大会开启期间 复活时间属性无效
		if ac.flag_wldh then 
			hero.revive_time = 10
		end
		local time = hero.revive_time
		--给玩家随从 添加对应的buff
		add_units_buff(p,time)
		ac.timer_ex
		{
			time = time,
			title = '英雄复活: ',
			player = hero:get_owner(),
			func = function ()
				--倒计时后，复活
				local random_point 
				if ac.flag_tlmt then 
					random_point = ac.rect.j_rect('moku5'):get_random_point()
					hero:revive(random_point)
					hero:add_buff '无敌' {
						time = 1
					}
				elseif ac.flag_wldh then 
					random_point = ac.rect.j_rect('moku5'):get_random_point()
					hero:revive(random_point)
					hero:add_buff '无敌' {
						time = 3
					}	
				else
					random_point = p.revive_point or ac.map.rects['出生点']:get_point()
					hero:revive(random_point)
				end	
            end,
		}
		p.cnt_death = (p.cnt_death or 0) + 1
		--文字提醒
		ac.player.self:sendMsg('|cffebb608【系统】|r |cffff0000'..hero:get_owner():get_name()..' |cff00ff00已阵亡 等待复活中',5)
	end)

	
	hero:event '单位-英雄升级' (function(_,hero)
		
		local data = ac.table.UnitData[hero:get_name()]
		if data == nil then 
			return 
		end 
		if data.upgrade == nil then 
			return 
		end 

		--添加属性
		for k, v in sortpairs(data.upgrade) do

			if finds(k,'力量','敏捷','智力')then

				local base_formula
				local lv_formula
				local regular_formula
				local index =1 
				for name in v:gmatch '%S+' do
					if index == 2 then  
						base_formula = name 
					end	
					if index == 3 then  
						lv_formula = name 
					end	
					if index == 4 then  
						regular_formula = name 
					end	
					index =index +1
				end	
				
				--(上一级力量基础值+0)*1.08+0
				--base 0 1.08 0
				-- 每级增加的三围属性和上一级有关
				
				local function get_attr_by_lv (attr,lv)
					if lv > 1 then 
						return ( get_attr_by_lv(attr,lv-1) + base_formula ) * lv_formula + regular_formula
					else 
						return data.attribute[attr]	 
					end	 
				end	
				
				local lv = hero.level 
				local value = get_attr_by_lv(k,lv) - get_attr_by_lv(k,lv-1)
				-- print('打印人物升级增加的属性',lv,k,value)
				hero:add(k,value)
			end	
		end

		--护甲公式相关
		local function get_defence_by_lv (lv)
			if lv > 1 then 
				return ( get_defence_by_lv(lv-1)) * 1 + 0
			else 
				return 1
			end	 
		end	
		
		local lv = hero.level 
		local value = get_defence_by_lv(lv) - get_defence_by_lv(lv-1)
		-- print('打印人物升级增加的属性',lv,k,value)
		hero:add('护甲',value)

		--hero:add('技能冷却', 1.5)

		

	end)
end)



-- ac.game:event '玩家-注册英雄后' (function(_, player, hero)
-- 	--移动英雄天赋位置	
-- 	local skl = hero:find_skill(hero.name..'天赋','英雄',true)
-- 	-- print(skl,hero.name..'天赋')
-- 	if skl then 
-- 		skl:remove()
-- 		hero:add_skill(hero.name..'天赋','英雄',5)
-- 	end	
-- end)
