
local mt = ac.skill['维特的另一条腿']
mt{
--等久
level = 1,
art = [[wtzj.blp]],
specail_model = [[File00000376 - RC.mdx]],
--类型
item_type = "消耗品",
no_use = true,
color ='黑',
tip = [[

|cffcccccc神奇的力量，神奇的秘密。
 ]],
is_skill = true,
content_tip = '|cffffe799物品说明：|r'
}  
local function create_dbl()
	local point = ac.rect.j_rect('jiao5'):get_point()
	local u = ac.player(12):create_unit('超级大菠萝',point)
	u:add_buff '攻击英雄' {}
	u:add_buff '无敌' {
		time = 2
	}
	u:add_skill('火焰呼吸','英雄')
	u:add_skill('死亡火球','英雄')
	u:event '单位-死亡'(function(_,unit,killer)
		--给神级物品
		local name = ac.quality_item['神'][math.random(#ac.quality_item['神'])]
		ac.item.create_item(name,unit:get_point())
		--给六号熔炼石
		local p = killer.owner 
		if not p.flag_6hrls then 
			ac.item.create_item('六号熔炼石',unit:get_point())
			p.flag_6hrls = true 
		end
		p:sendMsg('|cffebb608【系统】|r |cff00ff00恭喜击败超级大菠萝',5)
	end)

end
local kill_cnt =0
ac.wait(0,function()
	for i=1,3 do 
		local mt = ac.creep['奶牛'..i]{    
			creeps_datas = '奶牛*15',
			region = 'jiao'..(i+1),
			cool = 1,
			create_unit_cool = 0,
		}
		function mt:on_change_creep(unit,lni_data)
			--设置搜敌范围
			unit:set_search_range(1000)
			unit:event '单位-死亡'(function(_,unit,killer)
				local player = killer.owner
				local hero = player.hero
				kill_cnt = kill_cnt + 1
				--2000 个数量创建大菠萝
				if kill_cnt == 2000 then 
					kill_cnt = 0 
					create_dbl()
				end 
			end)
		end  
	end    
end)


local function create_nainiu(hero)
    --传送
    local p = hero:get_owner()
    hero = p.hero
    -- print(ac.map.rects['奶牛区'],ac.map.rects['奶牛区']:get_point())
    hero:blink(ac.rect.j_rect('jiao1'):get_point(),true,false,true)
    --开启奶牛刷怪
    for i=1,3 do 
        local crep = ac.creep['奶牛'..i]
        crep:start()
    end 
    --倒计时
    if not ac.flag_jixian then
        ac.flag_jixian={}
    end    
    if ac.flag_jixian['奶牛'] then 
        ac.flag_jixian['奶牛']:remove()
    end    
    ac.flag_jixian['奶牛'] = ac.timer_ex 
    {
        time = 2.5*60, 
        -- time = 30,  --测试
        title = '奶牛'.."消失倒计时：",
        func = function ()--关闭刷怪
            for i=1 ,3 do 
                local crep = ac.creep['奶牛'..i] 
                crep:finish(true)
            end  
            ac.flag_jixian['奶牛'] = nil
        end,
    }
end
ac.game:event '受到伤害效果'(function(_,damage)
	if damage.target:get_name() ~='神奇的奶牛' then 
		return 
	end 
	if not damage:is_common_attack()  then 
		return 
	end 
	local hero = damage.source
	local p = hero.owner
	hero = p.hero
	local rate =10
	if math.random(100000)/1000 <=rate then 
		--发送提示【系统】需要维特的腿
		p:sendMsg('|cffebb608【系统】|r|cff00ff00不痒不痛的，没有|cffffff00维特的腿（黑色物品）|cff00ff00你也想搞我？ ',5)
		
	end
	local item = damage.source:has_item('维特的另一条腿')
	if not item then 
		return 
	end
	
	local rate =10
	if math.random(100000)/1000 <=rate then 
		p:sendMsg('|cffebb608【系统】|r|cff00ff00你来到了一个全新的地方 ',5)
		create_nainiu(hero)
		item:add_item_count(-1)
	end

end)
ac.game:event '单位-死亡'(function(_,unit,killer)
	if unit:get_name() ~= '神奇的奶牛' then 
		return 
	end 

	--给神级物品
	local name = ac.quality_item['神'][math.random(#ac.quality_item['神'])]
	ac.item.create_item(name,unit:get_point())
	--删除自身回调
	_:remove()

end)
-- ac.nainiu_unit