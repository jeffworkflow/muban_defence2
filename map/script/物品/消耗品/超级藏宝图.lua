local mt = ac.skill['超级藏宝图']
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
    area = 200,
    --售价
    kill_count = 200,
    --cd
    cool = 10,
    --物品详细介绍的title
    content_tip = '|cffffe799使用说明：|r',
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
end

function mt:on_cast_start()
    local hero = self.owner
    local player = hero:get_owner()
    local p = hero:get_owner()
    local item = self 
    local list = {}
    --需要先增加一个，否则消耗品点击则无条件先消耗
    self:add_item_count(1) 

    local tx,ty = self.random_point:get()    
    local point = hero:get_point()
    local sx,sy = point:get()
    local str ='【系统】罗盘指向了北（上）方]]'
    local strs = {}
    --目标在右边
    if tx - sx > 100 then 
        str ='【系统】罗盘指向了东（右）方]]'
        table.insert(strs,str)
    end
    --目标在左边边
    if tx - sx < -100 then 
        str ='【系统】罗盘指向了西（左）方]]'
        table.insert(strs,str)
    end
    --目标在左边边
    if ty - sy > 100 then 
        str ='【系统】罗盘指向了北（上）方]]'
        table.insert(strs,str)
    end
    --目标在左边边
    if ty - sy < -100 then 
        str ='【系统】罗盘指向了南（下）方]]'
        table.insert(strs,str)
    end

    --点在区域内
    if hero:is_in_range(self.random_point,self.area/2)  then
        if not player.peon_wabao and  ( hero.unit_type == '宠物' or hero.unit_type == '召唤物') then 
            player:sendMsg('|cffebb608【系统】|cffff0000宠物无法使用藏宝图|r',3)
            player:sendMsg('|cffebb608【系统】|cffff0000宠物无法使用藏宝图|r',3)
            return true
        end    
        self:add_item_count(-1) 
        self:on_add() 
        --添加东西给英雄
        --测试用
        for i =1,player.cnt_award_wabao or 1 do 
            self:add_content()  
        end 
        
    else
        --随机提示
        local str = strs[math.random(#strs)]
        player:sendMsg(str,5)
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
    local rand_list = ac.unit_reward['超级藏宝图']
    local rand_name,rand_rate = ac.get_reward_name(rand_list)
    -- print(rand_list,rand_name) 
    if not rand_name then 
        return true
    end  
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
        ac.player.self:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 挖到了 |cffff0000'..rand_name..'|r',2)
    end 
    
    p.flag_cbt = p.flag_cbt or {} 
    --处理掉落物品相关
    for k,v in rand_name:gmatch '(%S+)%*(%d+%s-)' do
        --进行多个处理
        local it 
        if finds(k,'熔炼石')  then
            if not p.flag_cbt[k] then  
                for i=1,tonumber(v) do 
                    it = self.owner:add_item(k)
                end 
                p.flag_cbt[k] = true
                ac.player.self:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 挖到了 |cffff0000'..(it.color_name or it.name)..'|r',2)
            else
                print('重新再随机一次',self.name,k)
                self:add_content()
                return
            end
        else
            for i=1,tonumber(v) do 
                it = self.owner:add_item(k)
            end 
            ac.player.self:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 挖到了 |cffff0000'..(it.color_name or it.name)..'|r',2)
        end
    end 

    if rand_name == '无' then
        player:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 什么事情都没有发生 |cffffff00(挖宝熟练度+1，当前挖宝熟练度 '..player.server['挖宝熟练度']..' )|r',2)
    elseif finds(rand_name,'红','黑','神') then
        --给英雄随机添加物品
        local list = ac.quality_item[rand_name]
        --添加给购买者
        local name = list[math.random(#list)]
        local it = self.owner:add_item(name)
        ac.player.self:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 挖到了 '..it.color_name,2)
    elseif finds(rand_name,'天阶','地阶','玄阶','黄阶') then
        local list = ac.quality_skill[rand_name]
        --添加给购买者
        local name = list[math.random(#list)]
        local it = ac.item.add_skill_item(name,self.owner)
        local color = it and it.color 
        ac.player.self:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 挖到了 |cff'..ac.color_code[color or '白']..'【技能书】'..name..'|r',2)
    elseif  rand_name == '魔丸' then
        self.owner:add_rec_ex(10000)
        ac.player.self:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 挖到了 |cffff0000'..rand_name..'+10000|r',2) 
    elseif  rand_name == '木头' then
        self.owner:add_wood(3500)

        ac.player.self:sendMsg1('|cffebb608【系统】|r |cff00ffff'..player:get_name()..'|r 使用|cff00ff00'..self.name..'|r 挖到了 |cffff0000'..rand_name..'+3500|r',2) 
    elseif finds(rand_name,'科尔格的执着') then
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
    end   

    
end


function mt:on_remove()
    local hero = self.owner
    if self.trg then 
        self.trg:remove()
        self.trg = nil
    end    
    
end


