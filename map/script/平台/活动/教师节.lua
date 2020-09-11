local mt = ac.skill['桃李满天下，何须堂前花']
mt{
--等久
level = 1,
--图标
art = [[huahua.blp]],
--说明
tip = [[ 
|cffffe799【活动时间】|r|cff00ff009月12日-9月22日
|cffffe799【活动说明】|r
|cff00ff001.教师节到了，为回报师父平日的教导，亲手种一些鲜花送给师父吧！|cffffff00百花宫|cff00ff00中有着不少种子！

|cff00ff002.活动期间内，带萌新通关获得的|cffff0000爱心积分翻倍！
 ]],
--物品类型
item_type = '神符',
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
--冷却
cool = 1,
--物品技能
is_skill = true,
store_affix = '',
-- store_name = '|cffdf19d0挑战 |r',
--物品详细介绍的title
content_tip = ''
}

--奖品
local award_list = { 
    ['攻击奖励'] =  {
        {    rand = 20.5, name = '随机力量',},
        {    rand = 20.5, name = '随机敏捷',},
        {    rand = 20.5, name = '随机智力',},
		{    rand = 22.5, name = '随机全属性',},
		
		{    rand = 1, name = '攻击速度+10%',},
		{    rand = 1, name = '分裂伤害+10%',},
		{    rand = 1, name = '攻击距离+10',},
        {    rand = 1, name = '暴击伤害+10%',},
        {    rand = 1, name = '技暴伤害+10%',},
        {    rand = 1, name = '会心伤害+10%',},
        {    rand = 1, name = '物理伤害加深+10%',},
        {    rand = 1, name = '技能伤害加深+10%',},
        {    rand = 1, name = '全伤加深+10%',},
        {    rand = 1, name = '对BOSS额外伤害+10%',},
        {    rand = 1, name = '暴击伤害系数+2%',},
        {    rand = 1, name = '技暴伤害系数+2%',},
        {    rand = 1, name = '会心伤害系数+2%',},
        {    rand = 1, name = '物理伤害加深系数+2%',},
        {    rand = 1, name = '技能伤害加深系数+2%',},
        {    rand = 1, name = '全伤加深系数+2%',},
    },
}

local function add_content(p)
	local rand_list = award_list['攻击奖励']
	local rand_name,rand_rate = ac.get_reward_name(rand_list)
	if not rand_name then 
		return true
	end
	--处理属性相关
	for k,v in string.gsub(rand_name,'-','+-'):gmatch '(%S+)%+([-%d.]+%s-)' do
		--增加人物属性
		-- print(k,v)
		p.hero:add(k,v)
		ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ff00将鲜花献给了恩师，恭喜额外获得|cffffff00'..rand_name..' ',3) 
	end  
	if finds(rand_name,'随机') then
		local attr = rand_name:sub(7,-1)
		local val = math.random(99999)
		p.hero:add(attr,val)
		p:sendMsg('|cffebb608【系统】|r|cff00ff00将鲜花献给了恩师，恭喜额外获得|cffffff00'..attr..'|cffffff00+'..val..'|r ',3) 
	end
end
--爱心积分翻倍
ac.wait(0,function()
    for i=1,6 do 
        local p = ac.player(i)
        if p:is_player() then 
            p:add('爱心积分加成',100)
        end
    end
end)


--注册挖图回调
ac.game:event '触发一颗神奇的种子事件'(function(trg,skill,hero)
    local p = hero:get_owner() 
    p.seed_cnt = (p.seed_cnt or 0) + 1
    add_content(p)
    --成就相关
    if p.seed_cnt == 100 and (p.cus_server['懂事的孩子标识'] or 0) <=0 then 
        local real_name = '懂事的孩子'
        local hero = p.hero
        local key = ac.server.name2key(real_name)
        if p:Map_GetServerValue(key) < ac.skill[real_name].max_level  then 
            --激活成就（存档） 
            p:Map_AddServerValue(key,1) --网易服务器
            --激活今日标识
            p:SetServerValue(ac.server.name2key('懂事的孩子标识'),1) --自己服务器
            --动态插入魔法书
            local skl = hero:find_skill(real_name,nil,true) 
            if not skl  then 
                ac.game:event_notify('技能-插入魔法书',hero,'精彩活动',real_name)
                ac.player.self:sendMsg('|cffebb608【系统】|r |cff00ffff'..p:get_name()..'|r 不断种植鲜花献给恩师，惊喜获得|cffff0000【可存档成就】'..real_name..'|r，成就属性可在“最强魔灵-活动成就”中查看',6) 
                ac.player.self:sendMsg('|cffebb608【系统】|r |cff00ffff'..p:get_name()..'|r 不断种植鲜花献给恩师，惊喜获得|cffff0000【可存档成就】'..real_name..'|r，成就属性可在“最强魔灵-活动成就”中查看',6) 
                ac.player.self:sendMsg('|cffebb608【系统】|r |cff00ffff'..p:get_name()..'|r 不断种植鲜花献给恩师，惊喜获得|cffff0000【可存档成就】'..real_name..'|r，成就属性可在“最强魔灵-活动成就”中查看',6) 
            else
                skl:upgrade(1)
                ac.player.self:sendMsg('|cffebb608【系统】|r |cff00ffff'..p:get_name()..'|r 不断种植鲜花献给恩师，使|cffff0000【可存档成就】'..real_name..'|r得到了升级，升级后的属性可在“最强魔灵-活动成就”中查看',6) 
                ac.player.self:sendMsg('|cffebb608【系统】|r |cff00ffff'..p:get_name()..'|r 不断种植鲜花献给恩师，使|cffff0000【可存档成就】'..real_name..'|r得到了升级，升级后的属性可在“最强魔灵-活动成就”中查看',6) 
                ac.player.self:sendMsg('|cffebb608【系统】|r |cff00ffff'..p:get_name()..'|r 不断种植鲜花献给恩师，使|cffff0000【可存档成就】'..real_name..'|r得到了升级，升级后的属性可在“最强魔灵-活动成就”中查看',6) 
            end 
        end    
    end
end)
-- player:event_notify('挖图成功',hero)
