local multiboard = require 'types.multiboard'

local base_icon = [[ReplaceableTextures\CommandButtons\BTNSelectHeroOn.blp]]
local mtb
local color = {
	['神魂修炼'] = {
		['炼皮'] = '|cff00ff00',
		['锻膜'] = '|cff00ff00',
		['造骨'] = '|cff00ffff',
		['凝血'] = '|cff00ffff',
		['练气'] = '|cffffff00',
		['神勇'] = '|cffffff00',
		['壮腑'] = '|cffff0000',
		['通灵'] = '|cffff0000',
		['魂变'] = '|cffdf19d0',
		['涅盘'] = '|cffdf19d0',
	},
	
	['踢馆'] = '|cff00ff00',
	['突破'] = '|cff00ffff',
	['狩猎'] = '|cffffff00',
	['战就战'] = '|cffff0000',

	['魔神之路'] = '|cffdf19d0',

	['其它'] = {
		['大屠杀'] = '|cff00ff00',
		['错臂之交'] = '|cff00ff00',
		['八个技能的男人'] = '|cff00ff00',

		-- ['挖宝达人'] = '|cff00ffff',
		-- ['鉴宝大师'] = '|cff00ffff',
		-- ['鬼斧神工'] = '|cff00ffff',
		-- ['扭转乾坤'] = '|cff00ffff',
		-- ['园艺大师'] = '|cff00ffff',
		-- ['骰子王'] = '|cff00ffff',

		['五道杠少年'] = '|cffffff00',

		['倒霉蛋'] = '|cffff0000',

		['游戏王'] = '|cffdf19d0',


-- 大屠杀
-- 错臂之交
-- 八个技能的男人
-- 挖宝达人
-- 鉴宝大师
-- 鬼斧神工
-- 扭转乾坤
-- 园艺大师
-- 骰子王
-- 五道杠少年
-- 倒霉蛋
-- 游戏王

	},
}
local function get_skill_all_sub_skl_name(book_skill,list)
	local skl = ac.skill[book_skill]
	if skl.is_spellbook then 
		list = (list or'') ..'['..skl.name..'],'
		for i=#skl.skills,1,-1 do
			local name = skl.skills[i]
			local skl = ac.skill[name]
			if skl.is_spellbook then 
				list = get_skill_all_sub_skl_name(name,list)
			else
				list = (list or'') ..name..','
			end
		end
	end
	return list
end

-- local r_str  --要求在某几个魔法书里面进行搜索
-- ac.wait(0,function()
-- 	for k,v in pairs(color['圣龙气运']) do 
-- 		local skl = ac.skill['圣龙气运']
-- 		for i=#skl.skills,1,-1 do
-- 			local name = skl.skills[i]
-- 			if k == name then 
-- 				r_str = (r_str or'') .. (get_skill_all_sub_skl_name(name) or '')
-- 			end
-- 		end
-- 	end
-- 	print('测试：：：：：：：：：：：：：：：',r_str)
-- end)
--深度优先算法
local function get_text(hero,book_skill,filter)
	local str = ''
	local skl = hero:find_skill(book_skill,nil,true)
	if not skl or  not skl.skill_book  then return str end 
	for i=#skl.skill_book,1,-1 do
		local skill = skl.skill_book[i]
		if skill.level>=1 then 
			if skill.is_spellbook then
				--深度优先，没有判断 则每次递归都有值返回，而我们是要找到符合条件的才返回，所以加判断。
				-- if filter then print('测试测试2：：：：：',filter,r_str,skill.name) end
				-- if not filter or (filter and finds(r_str,skill.name)) then
					if get_text(hero,skill.name,filter) then 
						return get_text(hero,skill.name,filter) 
					end	
				-- end
			else
				-- print(skill.name)
				str = skill.title or skill.name
				return str
			end	
		end	
	end
end	
local function add_color(str,book_skill)
	local str = str or ''
	--处理颜色代码
	if color[book_skill] then
		if type(color[book_skill]) == 'table' then  
			for key,val in sortpairs(color[book_skill]) do
				-- print(str,key,val)
				if finds(str,key) then
					str = val..str..'|r'
					break
				end
			end	
		else
			str = color[book_skill]..str..'|r'
		end
	end	
	
	return str
end


local title =  {'玩家','|cff00ff00战斗力|r','|cff00ffff杀敌数|r','|cffffff00魔丸|r','|cffff0000神魂修炼|r','|cffffff00主线|r','|cff00ffff其它|r'}

local function init()

	local online_player_cnt = get_player_count()
	local all_lines = online_player_cnt +3
	mtb = multiboard.create(#title,all_lines)
	ac.game.multiboard = mtb
	mtb:setTitle('【'..(ac.server_config and ac.server_config['map_name'] or '魔灵降世')..'】难度：'..(ac.g_game_degree_name or ''))
	
	function mtb:set_time(time)
		local str = '【'..(ac.server_config and ac.server_config['map_name'] or '魔灵降世')..'】难度：'..(ac.g_game_degree_name or '')
		mtb:setTitle(' '..str..'     【游戏时长】'..time)
	end	
	-- mtb:setTitle("信息面板")
	--设置表头
    for i = 1,#title do 
        mtb:setText(i,1,title[i])
	end 
	--统一设置宽度
	mtb:setAllWidth(0.05)
    -- mtb:setWidth(2,1,0.03)
	--调整局部宽度 第x列
    mtb:setXwidth(2,0.03)
    mtb:setXwidth(3,0.03)
    mtb:setXwidth(4,0.03)
    -- mtb:setXwidth(5,0.03)
	mtb:setXwidth(7,0.03)
	local ix = 2
	--初始化所有数据
    for i = 1,10 do 
		local player = ac.player(i)
		if player:is_player() then 
			mtb:setText(1,ix,player:getColorWord()..player:get_name()..'|r')
			mtb:setText(2,ix,'0')
			mtb:setText(3,ix,'0')
			mtb:setText(4,ix,'0')
			mtb:setText(5,ix,' ')
			mtb:setText(6,ix,' ')
			mtb:setText(7,ix,' ')
			player.ix = ix
			ix = ix + 1 --位置第几行
		end	
	end 
	
	mtb:setWidth(1,ix+1,0.1)
	-- function mtb:set_auto_tip()
	-- 	mtb:setText(1,ix+1,'|cffff0000F6查看无尽排行榜|r')
	-- end	
	-- mtb:setText(1,ix+1,'|cffff0000F6|r查看无尽排行榜')
	
	--初始化格式
	mtb:setAllStyle(true,false)
	mtb:show()
	
end

--具体函数
local function player_init(player,hero)
	mtb:setText( 1, player.id + 1, player:get_name())
	mtb:setIcon( 1, player.id + 1, hero:get_slk('Art',base_icon))
end

local function fresh(player,hero)
	-- print(1111111111)
	--刷新杀敌数
	mtb:setText( 2, player.ix, bignum2string(player.zdl or 0))
	mtb:setText( 3, player.ix, bignum2string(player.kill_count))
	mtb:setText( 4, player.ix, bignum2string(player.rec_ex))
	--刷新字段
	-- print(get_text(hero,'魔鬼的交易'))
	for i,book_skill in ipairs(title) do 
		--去颜色
		local book_skill = clean_color(book_skill)
		local new_str 
		if book_skill == '其它' then 
			new_str = player.is_show_nickname
		elseif book_skill == '主线' then
			book_skill = '圣龙气运'
			for i,name in ipairs({'战就战','狩猎','突破','踢馆'}) do 
				new_str = get_text(hero,name)
				if new_str then 
					book_skill = name
					break
				end
			end
			if not new_str then 
				if player.flag_slqy then 
					new_str = '圣龙气运'
				end
			end
			if player.flag_mszl then 
				new_str = '魔神之路'
				book_skill = '魔神之路'
			end
			-- print(book_skill,new_str)
		else	
			new_str = get_text(hero,book_skill)
		end	 
		
		new_str = clean_color(new_str or '')
		new_str = add_color(new_str,book_skill)
		-- print(book_skill,new_str)
		if new_str and new_str ~='' then 
			mtb:setText( i, player.ix, new_str)
		end	
	end	
end	

ac.loop(1000,function()
	for i=1,10 do 
		local player = ac.player(i)
		local hero = player.hero
		if player:is_player() and hero then 
			fresh(player,hero)
		end	
	end	
end)

ac.game:event '游戏-开始' (function()
	--游戏开始时，重新更改标题
	mtb:setTitle('【'..(ac.server_config and ac.server_config['map_name'] or '')..'】难度：'..(ac.g_game_degree_name or ''))
end)

ac.wait(0,function()
	init()
end)