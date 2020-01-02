-- 顺序： 加载脚本 → 选择难度 → 注册英雄 → 游戏-开始 → 开始刷兵
-- 规则：
-- 3分钟一波，25波=75分钟，10分钟可以减3分钟，一局最多75+21=96分钟
-- 每5波一只挑战boss，额外出。
-- ac.special_boss = {
-- '挑战怪10','挑战怪20','挑战怪30','挑战怪40','挑战怪50','挑战怪60','挑战怪70','挑战怪80','挑战怪90','挑战怪100'
-- }
ac.attack_unit = {}
ac.attack_boss = {}
local temp_boss = {}
for name,data in pairs(ac.table.UnitData) do 
    if data.unit_type =='小怪' and data.index then 
        ac.attack_unit[data.index] = name
    end     
    if data.unit_type =='boss' and data.index then 
        table.insert(temp_boss,{index = data.index,name = name})
    end     
end 
--排序 
table.sort(temp_boss,function(a,b)
    return a.index < b.index
end)
for i,tab in ipairs(temp_boss) do 
    table.insert(ac.attack_boss,tab.name)
end    
ac.attack_unit_str = table.concat(ac.attack_unit,' ')
ac.attack_boss_str = table.concat(ac.attack_boss,' ')

-- ac.attack_unit = {
--     '民兵','甲虫','镰刀手','剪刀手','狗头人','步兵','长牙兽','骷髅战士','巨魔','食人鬼战士','骑士',
--     '牛头人','混沌骑士','屠夫','德鲁伊','娜迦暴徒','龙卵领主','潮汐','血恶魔','火凤凰','九头怪','黑龙',
--     '蜥蜴领主','地狱火','末日'
-- }
-- ac.attack_boss = {
--     '一棒男','戴瑟提克','格里弗','克尔苏加德','虚空诺亚'
-- }  
local force_cool = 3*60
if global_test then 
    force_cool = 180
end    
for i =1,3 do 
    local mt = ac.creep['刷怪'..i]{    
        region = 'cg'..i,
        creeps_datas = '',
        force_cool = force_cool,
        max_index = 25,
        creep_player = ac.player.com[2],
        create_unit_cool = 0.5,
        -- tip ="|cffff0000怪物开始进攻！！！|r"

    }
    --进攻怪刷新时的初始化
    function mt:on_start()
        local rect = require 'types.rect'
        if i == 1 then 
            self.timer_ex_title ='距离 第'..(self.index+2)..'波 怪物进攻'
         end   
    end

    function mt:on_next()
        if i == 1 then 
           self.timer_ex_title ='距离 第'..(self.index+2)..'波 怪物进攻'
        end   
        --进攻提示
        if self.name =='刷怪1' then
            local panel = class.screen_animation.get_instance()
            if panel then panel:up_jingong_title(' 第 '..self.index..' 波 ') end
        end    
        --小地图ping
        ac.player.self:pingMinimap(self.region,3,255,0,0)
        ac.player.self:pingMinimap(self.region,3,255,0,0)
        -- if ac.ui then ac.ui.kzt.up_jingong_title(' 第 '..self.index..' 波 ') end

        ac.player.self:sendMsg("|cffff0000 第"..self.index.."波 怪物开始进攻！！！|r",5)
        local index = self.index
        self.creeps_datas = ac.attack_unit[index]..'*20'
        self:set_creeps_datas()

        --20波以后，加快进攻速度
        if index == 20 then 
            self.force_cool = 30
            self.creeps_datas = ac.attack_unit[index]..'*40'
            self:set_creeps_datas()
            ac.player.self:sendMsg("|cffff0000 进攻怪 加速进攻，请全体成员牢牢守住基地。|r",5)
            ac.player.self:sendMsg("|cffff0000 进攻怪 加速进攻，请全体成员牢牢守住基地。|r",5)
        end    

    end

    --改变怪物
    function mt:on_change_creep(unit,lni_data)
        --设置搜敌范围
        unit:set_search_range(1000)
        local point = ac.map.rects['主城']:get_point()
        unit:issue_order('attack',point)

    end
    --每3秒刷新一次攻击目标 原地不动才发起攻击
    function mt:attack_hero() 
        self.attack_hero_timer = ac.loop(3 * 1000 ,function ()
            -- print('野怪区的怪数量',#mt.group)
            local point = ac.map.rects['主城']:get_point()
            for _, unit in ipairs(self.group) do
                if unit:is_alive() then 
                    if unit.last_point then 
                        local distance =  unit.last_point * unit:get_point()
                        local hero = ac.find_hero(unit)
                        local hero_distance = 0
                        if hero then 
                            hero_distance = hero:get_point() * unit:get_point()
                        end    
                        if hero_distance <= 10 then
                            --1500码内，优先攻击英雄，英雄死亡则攻向基地点
                            unit:issue_order('attack',point)
                        elseif hero_distance <= 1500  then
                            unit:issue_order('attack',hero)
                        else    
                            unit:issue_order('attack',point)
                        end      
                    end  
                    unit.last_point = unit:get_point()
                end   
            end 
        end) 
        self.attack_hero_timer:on_timer()
    end    

    --刷怪结束
    function mt:on_finish()  
        if self.key_unit_trg then 
            self.key_unit_trg:remove()
        end    
        if self.mode_timer then 
            self.mode_timer:remove()
        end    
        if self.attack_hero_timer then 
            self.attack_hero_timer:remove()
        end  
        -- ac.game:event_dispatch('游戏-最终boss',self.index,self)
    end   
end    
--注册boss进攻事件
ac.game:event '游戏-回合开始'(function(trg,index, creep) 
    if creep.name ~= '刷怪1' then
        return
    end    
    --取余数,为0 得给物品
    local value = ac.creep['刷怪1'].index % 5
    local ix = math.ceil(ac.creep['刷怪1'].index / 5)
    if value == 0 then 
        local point = ac.map.rects['进攻点']:get_point()
        --最后一波时，发布最终波数
        if ix == #ac.attack_boss then
            ac.game:event_dispatch('游戏-最终boss')
        else
            local boss = ac.player.com[2]:create_unit(ac.attack_boss[ix],point)
            -- table.insert(ac.creep['刷怪1'].group,boss)
            boss:add_buff '攻击英雄' {}
            boss:add_skill('无敌','英雄')
            boss:add_skill('撕裂大地','英雄')

            boss:add('减伤',1.5 * ac.get_difficult(ac.g_game_degree_attr))
            boss:add('物理伤害加深',1.45 * ac.get_difficult(ac.g_game_degree_attr))
            
        end    

    end    
end)    



-- 注册难度事件

-- 注册英雄杀怪得奖励事件
ac.game:event '单位-死亡' (function(_,unit,killer) 
    if killer.category =='进攻怪' or killer.category =='boss' or unit == killer then
		return
    end

    local player = killer:get_owner()
    local gold 
    local exp =0 
    local wood  =0
    local rec_ex =0
    
    -- 英雄的召唤物 打死的怪，也给英雄加钱加经验
    -- 英雄召唤物享有 英雄的金币、经验加成
    if player  then 
        killer = player.hero
    end   
    -- 进攻怪杀死单位，不用加钱和经验
    if not killer or not killer:is_hero()  then  
        return
    end    
    -- print(unit,)
    --加钱
    if unit.gold  then 
        gold = unit.gold * ( 1 + killer:get('金币加成')/100)
    end   
    --加经验,
    if unit.exp  then
        exp = unit.exp * ( 1 + killer:get('经验加成')/100)
    end  
    --加木头 加魔丸
    if unit.wood then 
        wood = unit.wood * ( 1 + killer:get('木头加成')/100)
    end    
    if unit.rec_ex then 
        rec_ex = unit.rec_ex * ( 1 + killer:get('魔丸加成')/100)
    end   
    --杀敌数加成
    local kill_cnt = 1 + killer:get('杀敌数加成')/100 + killer:get('额外杀敌数')

    local source = killer
    local target = unit
    --自己加经验
    if source:is_alive() and source:is_hero() then 
        source:addXp(exp)
    end	
    --加资源
    player:addGold(gold,unit)
    player:add_wood(wood,unit)
    player:add_rec_ex(rec_ex,unit)
    player:add_kill_count(kill_cnt)
    

end);


--boss以及进攻单位 杀死英雄马上进攻其他英雄
ac.game:event '单位-杀死单位' (function(trg, killer, target)
    
    local unit_str = table.concat(ac.attack_unit) .. table.concat(ac.attack_boss)
    if not target:is_hero() or not finds(unit_str,killer:get_name()) then 
        return 
    end    
    ac.attack_hero(killer)
    --其他进攻单位
    for i=1 ,3 do
        local creep = ac.creep['刷怪'..i]
        for _, unit in ipairs(creep.group) do
            -- print('刷怪单位',unit:get_name())
            ac.attack_hero(unit)
        end    
    end    

end)    