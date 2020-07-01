local mt = ac.skill['藏宝图']
mt{
    --等久
    level = 1,
    --图标
    art = [[cangbaotu.blp]],
    --说明
    tip = [[


根据提示，到指定地点，挖开即可获得|cffdf19d0 各种宝藏 |r|cffffff00（仅英雄单位可以使用）

|cffffe799每点挖宝熟练度|r 奖励 |cff00ff00每秒加敏捷+0.1
|cffcccccc（属性|cffff0000永久存档|cffcccccc，上限受地图等级影响）]],
    --物品类型
    item_type = '消耗品',
    specail_model = [[ScrollOfProtection.mdx]],
    --目标类型
    target_type = ac.skill.TARGET_TYPE_NONE,
    --物品技能
    is_skill = true,
    --挖图范围
    area = 500,
    --售价
    kill_count = 200,
    --cd
    cool = 0.5,
    --物品详细介绍的title
    content_tip = '|cffffe799使用说明：|r',
    --自动挖宝
    wabao_auto_use = false,
    --全部玩家发送信息概率
    rate = 0.3,
    --多少秒后地上物品消失
    time_removed = 200,
    --可能会掉线
    effect = function(self)
        local str = ''
        if self.owner:get_owner():is_self() then 
            str='biaoji_gantanhao.mdx'
        end
        return str    
    end   
}
    
local npc = {'基地','第一幕·圣龙气运','第二幕·一个人的踢馆','第三幕·突破','第四幕·狩猎','第五幕·战就战','第六幕·魔神之路'}

local function get_random_point()
	local flag
	local point
	while not flag do 
		point = ac.map.rects['藏宝区']:get_random_point(true)
		for i,name in ipairs(npc) do 
			local where = ac.table.UnitData[name].where
			local npc_point = ac.rect.j_rect(where[1]) and ac.rect.j_rect(where[1]):get_point() 
			-- print(name,npc_point,point)
			if point:is_in_range(npc_point,150) then 
				-- print('点在npc周围',name,point,npc_point,point*npc_point)
				-- get_random_point()
				break
			else
				if i ==#npc then 
					flag = true
				end
			end
		end
	end
	return point
end
--测试：
local ret1 = ac.rect.j_rect('cbt2')
local ret2 = ac.rect.j_rect('cbt3')
local region = ac.region.create(ret1,ret2)

function mt:on_add()
    --全图随机刷 正式用
    self.random_point =  region:get_point()
    -- self.random_point =  get_random_point()

    -- print(ac.map.rects['藏宝区']:get_random_point(true))
    --测试用
    -- self.random_point = self.owner:get_point()
end

function mt:on_cast_start()
    local hero = self.owner
    local player = hero:get_owner()
    local p = hero:get_owner()
    local item = self 
    local list = {}
    --需要先增加一个，否则消耗品点击则无条件先消耗
    self:add_item_count(1) 

    if hero.wabao_auto then 
        self.wabao_auto_use = true
    else
        self.wabao_auto_use = false
    end    
    if player.peon_wabao then 
        if player.hero.wabao_auto then 
            self.wabao_auto_use = true
        else
            self.wabao_auto_use = false
        end 
    end    

    if p.eff then 
        p.eff:remove()
    end    
    p.eff = ac.effect_ex{
        model = self.effect,
        point = self.random_point,
        item_show = true
    }

    local tx,ty = self.random_point:get()
    --自动寻宝
    if self.wabao_auto_use then 
        --区域修改
        local rect  = ac.rect.create( tx - 64, ty-64, tx + 64, ty + 64)
        local region = ac.region.create(rect)
        if not self.trg then 
            self.trg = region:event '区域-进入' (function(trg, unit)
                if  unit == hero then
                    if not player.peon_wabao and  (hero.unit_type == '宠物' or hero.unit_type == '召唤物') then 
                        player:sendMsg('|cffebb608【系统】|cffff0000宠物无法使用藏宝图|r',3)
                        player:sendMsg('|cffebb608【系统】|cffff0000宠物无法使用藏宝图|r',3)
                        return true
                    end 
                    -- print('单位进入')
                    self:on_add() 
                    for i =1,player.cnt_award_wabao or 1 do 
                       self:add_content()  
                    end
                    self:add_item_count(-1) 
                    if self.trg then 
                        self.trg:remove()
                        self.trg = nil
                    end    
                    region:remove()

                    if self:get_item_count()>= 1 then 
                        --模拟消耗品使用
                        self:on_cast_start()
                        self:add_item_count(-1) 
                    end  
                end
            end)
        end    
        ac.wait(500,function()
            hero:issue_order('move',self.random_point)
        end)
        player:pingMinimap(self.random_point, 3)
    else      
        local rect = ac.rect.create( tx - self.area/2, ty-self.area/2, tx + self.area/2, ty + self.area/2)
        local region = ac.region.create(rect)
        local point = hero:get_point()
        --点在区域内
        if region < point  then
            if not player.peon_wabao and  ( hero.unit_type == '宠物' or hero.unit_type == '召唤物') then 
                player:sendMsg('|cffebb608【系统】|cffff0000宠物无法使用藏宝图|r',3)
                player:sendMsg('|cffebb608【系统】|cffff0000宠物无法使用藏宝图|r',3)
                return true
            end    

            region:remove()

            self:add_item_count(-1) 
            self:on_add() 
            --添加东西给英雄
            --测试用
            for i =1,player.cnt_award_wabao or 1 do 
                self:add_content()  
             end 
        else
            player:pingMinimap(self.random_point, 3)
        end 
    end       
end    

function mt:add_content()
    local hero = self.owner
    local player = self.owner:get_owner()
    local p = self.owner:get_owner()
    hero = player.hero 
    if p.eff then 
        p.eff:remove()
    end 
    --初始化
    player.achievement = player.achievement or {}
    -- print('使用了命运花')
    local rand_list = ac.unit_reward['藏宝图']
    local rand_name,rand_rate = ac.get_reward_name(rand_list)
    -- print(rand_list,rand_name) 
    if not rand_name then 
        return true
    end  
    local tran_player = rand_rate < self.rate and ac.player.self or player
    local flag
    local temp_rand_name = rand_name
    --先处理属性相关
    for k,v in string.gsub(temp_rand_name,'-','+-'):gmatch '(%S+)%+([-%d.]+%s-)' do
        --增加人物属性
        -- print(k,v)
        flag = true
        hero:add(k,v)
    end    
    --发送消息
    if flag then 
        tran_player:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 挖到了 |cffff0000'..rand_name..'|r',2)
    end 
    
    p.flag_cbt = p.flag_cbt or {} 
    --处理掉落物品相关
    for k,v in rand_name:gmatch '(%S+)%*(%d+%s-)' do
        --进行多个处理
        local it 
        if finds(k,'熔炼石')  then
            if not p.flag_cbt[k] then  
                for i=1,tonumber(v) do 
                    it = self.owner:add_item(k,true)
                end 
                p.flag_cbt[k] = true
                tran_player:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 挖到了 |cffff0000'..(it.color_name or it.name)..'|r',2)
            else
                print('重新再随机一次',self.name,k)
                self:add_content()
                return
            end
        else
            for i=1,tonumber(v) do 
                it = self.owner:add_item(k,true)
            end 
            tran_player:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 挖到了 |cffff0000'..(it.color_name or it.name)..'|r',2)
        end
    end 

    --加挖宝熟练度
    player:Map_AddServerValue('sldwb',1) --网易服务器
    -- player:AddServerValue('wbjf',1) 自定义服务器
    ac.game:event_notify('挖图成功',hero) --发布事件回调

    if rand_name == '无' then
        player:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 什么事情都没有发生 |cffffff00(挖宝熟练度+1，当前挖宝熟练度 '..player.server['挖宝熟练度']..' )|r',2)
    elseif  rand_name == '随机物品' then
        --给英雄随机添加物品
        local name = ac.all_item[math.random( 1,#ac.all_item)]
        --满时，掉在地上
        self.owner:add_item(name,true)
        local lni_color ='白'
        if  ac.table.ItemData[name] and ac.table.ItemData[name].color then 
            lni_color = ac.table.ItemData[name].color
        end    
        tran_player:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 挖到了 |cff'..ac.color_code[lni_color]..name..'|r',2)
    elseif finds(rand_name,'天阶','地阶','玄阶','黄阶') then
        local list = ac.quality_skill[rand_name]
        --添加给购买者
        local name = list[math.random(#list)]
        local it = ac.item.add_skill_item(name,self.owner)
        local color = it and it.color 
        tran_player:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 挖到了 |cff'..ac.color_code[color or '白']..'【技能书】'..name..'|r',2)
    elseif  rand_name == '魔丸' then
        self.owner:add_rec_ex(10000)
        tran_player:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 挖到了 |cffff0000'..rand_name..'+10000|r',2) 
    elseif  rand_name == '木头' then
        self.owner:add_wood(3500)

        tran_player:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 挖到了 |cffff0000'..rand_name..'+3500|r',2) 
    elseif rand_name == '碎片幼儿园' then
        if not ac.flag_spyey  then 
            ac.flag_spyey = true 
            ac.func_give_suipian(self.owner:get_point())
            ac.player.self:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 在挖宝时挖塌了|cffff0000'..rand_name..'，一大堆碎片散落|cffff0000老家周围|r，大家快去枪啊|r',2) 
        else 
            self:add_content() --已挖到再随机一次
        end    

    elseif finds(rand_name,'勤劳的矿工') then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            local new_skl = ac.game:event_dispatch('技能-插入魔法书',hero,'藏宝阁',rand_name)
            player.is_show_nickname = rand_name
            --给全部玩家发送消息
            ac.player.self:sendMsg1('|cffebb608【系统】|r|cffff0000运气暴涨!!!|r|cff00ffff'..player:get_name()..'|r使用|cff00ff00'..self.name..'|r，惊喜获得 |cffff0000'..rand_name..' |r，奖励 |cffff0000全属性+150万，攻击减甲+50，护甲+1500',6)
            ac.player.self:sendMsg1('|cffebb608【系统】|r|cffff0000运气暴涨!!!|r|cff00ffff'..player:get_name()..'|r使用|cff00ff00'..self.name..'|r，惊喜获得 |cffff0000'..rand_name..' |r，奖励 |cffff0000全属性+150万，攻击减甲+50，护甲+1500',6)
            ac.player.self:sendMsg1('|cffebb608【系统】|r|cffff0000运气暴涨!!!|r|cff00ffff'..player:get_name()..'|r使用|cff00ff00'..self.name..'|r，惊喜获得 |cffff0000'..rand_name..' |r，奖励 |cffff0000全属性+150万，攻击减甲+50，护甲+1500',6)
        else
            self:add_content() --已挖到再随机一次
            -- player:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 什么事情都没有发生 |cffffff00(挖宝熟练度+1，当前挖宝熟练度 '..player.server['挖宝熟练度']..' )|r',2)
        end  
        
    elseif finds(rand_name,'挖宝小能手') then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            local new_skl = ac.game:event_dispatch('技能-插入魔法书',hero,'藏宝阁',rand_name)
            player.is_show_nickname = rand_name
            local tip = tran_space(new_skl:get_tip()) --去除换行为空格
            --给全部玩家发送消息
            ac.player.self:sendMsg1('|cffebb608【系统】|r|cffff0000运气暴涨!!!|r|cff00ffff'..player:get_name()..'|r使用|cff00ff00'..self.name..'|r，惊喜获得 |cffff0000'..rand_name..' |r，奖励 |cffff0000全属性+300万，移速+75，技能冷却+5%，每秒加护甲+10',6)
            ac.player.self:sendMsg1('|cffebb608【系统】|r|cffff0000运气暴涨!!!|r|cff00ffff'..player:get_name()..'|r使用|cff00ff00'..self.name..'|r，惊喜获得 |cffff0000'..rand_name..' |r，奖励 |cffff0000全属性+300万，移速+75，技能冷却+5%，每秒加护甲+10',6)
            ac.player.self:sendMsg1('|cffebb608【系统】|r|cffff0000运气暴涨!!!|r|cff00ffff'..player:get_name()..'|r使用|cff00ff00'..self.name..'|r，惊喜获得 |cffff0000'..rand_name..' |r，奖励 |cffff0000全属性+300万，移速+75，技能冷却+5%，每秒加护甲+10',6)
        else
            self:add_content() --已挖到再随机一次
            -- player:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 什么事情都没有发生 |cffffff00(挖宝熟练度+1，当前挖宝熟练度 '..player.server['挖宝熟练度']..' )|r',2)
        end  
    elseif finds(rand_name,'黑格的陨石') then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            local new_skl = ac.game:event_dispatch('技能-插入魔法书',hero,'藏宝阁',rand_name)
            player.is_show_nickname = rand_name
            local tip = tran_space(new_skl:get_tip()) --去除换行为空格
            --给全部玩家发送消息
            ac.player.self:sendMsg1('|cffebb608【系统】|r|cffff0000运气暴涨!!!|r|cff00ffff'..player:get_name()..'|r使用|cff00ff00'..self.name..'|r，惊喜获得 |cffff0000'..rand_name..' |r，奖励 |cffff0000全属性+600万，技暴几率+5%，技暴伤害+100%，技能伤害加深+50%',6)
            ac.player.self:sendMsg1('|cffebb608【系统】|r|cffff0000运气暴涨!!!|r|cff00ffff'..player:get_name()..'|r使用|cff00ff00'..self.name..'|r，惊喜获得 |cffff0000'..rand_name..' |r，奖励 |cffff0000全属性+600万，技暴几率+5%，技暴伤害+100%，技能伤害加深+50%',6)
            ac.player.self:sendMsg1('|cffebb608【系统】|r|cffff0000运气暴涨!!!|r|cff00ffff'..player:get_name()..'|r使用|cff00ff00'..self.name..'|r，惊喜获得 |cffff0000'..rand_name..' |r，奖励 |cffff0000全属性+600万，技暴几率+5%，技暴伤害+100%，技能伤害加深+50%',6)
        else
            self:add_content() --已挖到再随机一次
            -- player:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 什么事情都没有发生 |cffffff00(挖宝熟练度+1，当前挖宝熟练度 '..player.server['挖宝熟练度']..' )|r',2)
        end  
    elseif finds(rand_name,'法老的遗产') then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            local new_skl = ac.game:event_dispatch('技能-插入魔法书',hero,'藏宝阁',rand_name)
            player.is_show_nickname = rand_name
            local tip = tran_space(new_skl:get_tip()) --去除换行为空格
            --给全部玩家发送消息
            ac.player.self:sendMsg1('|cffebb608【系统】|r|cffff0000运气暴涨!!!|r|cff00ffff'..player:get_name()..'|r使用|cff00ff00'..self.name..'|r，惊喜获得 |cffff0000'..rand_name..' |r，奖励 |cffff0000全属性+1200万，减少周围护甲+1500，每秒加木头+50，木头加成+50%',6)
            ac.player.self:sendMsg1('|cffebb608【系统】|r|cffff0000运气暴涨!!!|r|cff00ffff'..player:get_name()..'|r使用|cff00ff00'..self.name..'|r，惊喜获得 |cffff0000'..rand_name..' |r，奖励 |cffff0000全属性+1200万，减少周围护甲+1500，每秒加木头+50，木头加成+50%',6)
            ac.player.self:sendMsg1('|cffebb608【系统】|r|cffff0000运气暴涨!!!|r|cff00ffff'..player:get_name()..'|r使用|cff00ff00'..self.name..'|r，惊喜获得 |cffff0000'..rand_name..' |r，奖励 |cffff0000全属性+1200万，减少周围护甲+1500，每秒加木头+50，木头加成+50%',6)
        else
            self:add_content() --已挖到再随机一次
            -- player:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 什么事情都没有发生 |cffffff00(挖宝熟练度+1，当前挖宝熟练度 '..player.server['挖宝熟练度']..' )|r',2)
        end  
    elseif finds(rand_name,'ONE_PIECE') then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            local new_skl = ac.game:event_dispatch('技能-插入魔法书',hero,'藏宝阁',rand_name)
            player.is_show_nickname = rand_name
            local tip = tran_space(new_skl:get_tip()) --去除换行为空格
            --给全部玩家发送消息
            ac.player.self:sendMsg1('|cffebb608【系统】|r|cffff0000运气暴涨!!!|r|cff00ffff'..player:get_name()..'|r使用|cff00ff00'..self.name..'|r，惊喜获得 |cffff0000'..rand_name..' |r，奖励 |cffff0000全属性+2400万，会心几率+5%，会心伤害+50%，全伤加深+50%',6)
            ac.player.self:sendMsg1('|cffebb608【系统】|r|cffff0000运气暴涨!!!|r|cff00ffff'..player:get_name()..'|r使用|cff00ff00'..self.name..'|r，惊喜获得 |cffff0000'..rand_name..' |r，奖励 |cffff0000全属性+2400万，会心几率+5%，会心伤害+50%，全伤加深+50%',6)
            ac.player.self:sendMsg1('|cffebb608【系统】|r|cffff0000运气暴涨!!!|r|cff00ffff'..player:get_name()..'|r使用|cff00ff00'..self.name..'|r，惊喜获得 |cffff0000'..rand_name..' |r，奖励 |cffff0000全属性+2400万，会心几率+5%，会心伤害+50%，全伤加深+50%',6)
        else
            self:add_content() --已挖到再随机一次
            -- player:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 什么事情都没有发生 |cffffff00(挖宝熟练度+1，当前挖宝熟练度 '..player.server['挖宝熟练度']..' )|r',2)
        end  
    elseif finds(rand_name,'挖宝达人') then
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            local new_skl = ac.game:event_dispatch('技能-插入魔法书',hero,'藏宝阁',rand_name)
            player.is_show_nickname = rand_name
            local tip = tran_space(new_skl:get_tip()) --去除换行为空格
            --给全部玩家发送消息
            ac.player.self:sendMsg1('|cffebb608【系统】|r|cffff0000运气暴涨!!!|r|cff00ffff'..player:get_name()..'|r使用|cff00ff00'..self.name..'|r，惊喜获得 |cffff0000'..rand_name..' |r，奖励 |cffff0000全属性+1800万，物品获取率+75%，闪避+5%，多重暴击几率+5%|r',6)
            ac.player.self:sendMsg1('|cffebb608【系统】|r|cffff0000运气暴涨!!!|r|cff00ffff'..player:get_name()..'|r使用|cff00ff00'..self.name..'|r，惊喜获得 |cffff0000'..rand_name..' |r，奖励 |cffff0000全属性+1800万，物品获取率+75%，闪避+5%，多重暴击几率+5%|r',6)
            ac.player.self:sendMsg1('|cffebb608【系统】|r|cffff0000运气暴涨!!!|r|cff00ffff'..player:get_name()..'|r使用|cff00ff00'..self.name..'|r，惊喜获得 |cffff0000'..rand_name..' |r，奖励 |cffff0000全属性+1800万，物品获取率+75%，闪避+5%，多重暴击几率+5%|r',6)
        else
            self:add_content() --已挖到再随机一次
            -- player:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 什么事情都没有发生 |cffffff00(挖宝熟练度+1，当前挖宝熟练度 '..player.server['挖宝熟练度']..' )|r',2)
        end 



    elseif rand_name == '家里有矿' then
        if finds(hero:get_name(),'剑仙','至尊宝','鬼厉') then 
            local skl = hero:find_skill(rand_name,nil,true)
            if not skl  then 
                ac.game:event_notify('技能-插入魔法书',hero,'彩蛋',rand_name)
                player.is_show_nickname = rand_name  
                --给全部玩家发送消息
                ac.player.self:sendMsg1('|cffebb608【系统】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 惊喜获得 |cffff0000'..rand_name..' |r 奖励 |cff00ff00所有队友的全属性+5%',6)
            else
                player:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 什么事情都没有发生 |cffffff00(挖宝熟练度+1，当前挖宝熟练度 '..player.server['挖宝熟练度']..' )|r',2)
            end
        else 
            self:add_content() --已挖到再随机一次
        end   


    -- elseif rand_name == '挖宝达人' then
    --     local skl = hero:find_skill(rand_name,nil,true)
    --     if not skl  then 
    --         ac.game:event_notify('技能-插入魔法书',hero,'彩蛋',rand_name)
    --         player.is_show_nickname = rand_name
    --         --给全部玩家发送消息
    --         ac.player.self:sendMsg1('|cffebb608【系统】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 惊喜获得 |cffff0000'..rand_name..' |r 奖励 |cffff0000全属性+1500万，物品获取率+75%，闪避+10%，多重暴击几率+10%|r',6)
    --     else
    --         player:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 什么事情都没有发生 |cffffff00(挖宝熟练度+1，当前挖宝熟练度 '..player.server['挖宝熟练度']..' )|r',2)
    --     end   
        
    elseif rand_name == '黄金矿工' then
        if not p.flag_yccj then 
            p.flag_yccj = {} 
        end    
        if p.flag_yccj[rand_name] then 
            player:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 什么事情都没有发生 |cffffff00(挖宝熟练度+1，当前挖宝熟练度 '..player.server['挖宝熟练度']..' )|r',2)
            return 
        end   
        p.flag_yccj[rand_name] = true --一局只能获得一次
        --存档
        local key = ac.server.name2key(rand_name)
        if ac.g_game_degree_attr > p:Map_GetServerValue(key) then 
            p:Map_AddServerValue(key,1)
            local skl = hero:find_skill(rand_name,nil,true) 
            if not skl  then 
                ac.game:event_notify('技能-插入魔法书',hero,'隐藏成就',rand_name)
                ac.player.self:sendMsg1('|cffebb608【系统】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 惊喜获得 |cffff0000【可存档成就】'..rand_name..' |r 属性可在最强魔灵-隐藏成就中查看',6)
                ac.player.self:sendMsg1('|cffebb608【系统】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 惊喜获得 |cffff0000【可存档成就】'..rand_name..' |r 属性可在最强魔灵-隐藏成就中查看',6)
                ac.player.self:sendMsg1('|cffebb608【系统】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 惊喜获得 |cffff0000【可存档成就】'..rand_name..' |r 属性可在最强魔灵-隐藏成就中查看',6)
            else 
                skl:upgrade(1)  
                ac.player.self:sendMsg1('|cffebb608【系统】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r |cffff0000【可存档成就】'..rand_name..' 得到升级|r 升级后的属性可在最强魔灵-隐藏成就中查看',6)
                ac.player.self:sendMsg1('|cffebb608【系统】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r |cffff0000【可存档成就】'..rand_name..' 得到升级|r 升级后的属性可在最强魔灵-隐藏成就中查看',6)
                ac.player.self:sendMsg1('|cffebb608【系统】|r|cffff0000运气暴涨!!!|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r |cffff0000【可存档成就】'..rand_name..' 得到升级|r 升级后的属性可在最强魔灵-隐藏成就中查看',6)
            end   
        else 
            self:add_content() --已挖到再随机一次
            -- player:sendMsg('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 什么事情都没有发生 |cffffff00(挖宝熟练度+1，当前挖宝熟练度 '..player.server['挖宝熟练度']..' )|r',2)
        end           
    end   

    
end



function mt:on_remove()
    local hero = self.owner
    if self.trg then 
        self.trg:remove()
        self.trg = nil
    end    
    
end

--散落碎片 @起始点 @随机掉落物品表
ac.func_give_suipian = function(start,tab)
    local cnt = math.random(5,10)
    local tab = tab or ac.shenlong_suipin
    for i=1,cnt do 
        local item_name = tab[math.random(1,#tab)]
        local point = ac.map.rects['藏宝区']:get_random_point(true)
        --运动
        local mvr = ac.mover.target
        {
            source = start,
            target = point,
            model = [[RedCrystalShard.mdx]],
            height = 800,
            speed = 1000,
            skill = '碎片运动'
        }
        if not mvr then
            return
        end
        function mvr:on_finish()
            ac.item.create_item(item_name,point)
        end    
    end    
end


--解决藏宝图在npc脚下，英雄挖不到宝，幽灵会导致 物品地上卡人的位置。
ac.game:event '玩家-注册英雄' (function(_, _, hero)
    -- hero:add_restriction('幽灵') 
end)    
