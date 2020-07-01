local mt = ac.skill['小皮球']
mt{
--必填
is_skill = true,
--等级
level = 1,
--目标类型
target_type = ac.skill.TARGET_TYPE_POINT,
tip = [[
    小皮球
]],
--cd
cool = 0,
art = [[xiaopiqiu.blp]],
--模型
specail_model = [[bignoanimball.MDX]],
--物品
item_type = '消耗品',
unit_type = '英雄',
unit_type_tip = [[【系统】 宠物不可拾取]],
max_use_count = 20, --最大使用次数
range = 1000,
hit_area =150,
model_size = 2
}

--奖品
local award_list = { 
    ['踢皮球'] =  {
        { rand = 5, name = '扣除所有木头'},
        { rand = 5, name = '定身5秒，禁止使用物品5秒'},
        { rand = 5, name = '定身15秒，禁止使用物品15秒'},
        { rand = 5, name = '随机卡片'},
        { rand = 5, name = '足球小将'},
        
        { rand = 75, name = '无'},
    },
}

local function give_award(hero) 
    local p = hero:get_owner()
    local player = hero:get_owner()
    local peon = p.peon
    local rand_list = award_list['踢皮球']
    local rand_name,rand_rate = ac.get_reward_name(rand_list)
    -- print(rand_list,rand_name)  
    if not rand_name then 
        return true
    end
    if rand_name == '无' then
        p:sendMsg('|cffebb608【系统】|r |cff00ffff美味的粽子|cff00ff00果真名不虚传阿',3) 
    elseif  finds(rand_name,'扣除所有木头') then
        hero:add_wood(-p.wood)
        p:sendMsg('|cffebb608【系统】|r|cff00ff00这个粽子里面怎么有东西硬硬的，获得|cffff0000'..(rand_name)..'|r',4) 
    elseif  finds(rand_name,'定身5秒') then
        hero:add_buff '定身'{
            time = 5
        }
        p:sendMsg('|cffebb608【系统】|r|cff00ff00这个粽子里面怎么有东西硬硬的，获得|cffff0000'..(rand_name)..'|r',4) 
    elseif  finds(rand_name,'定身15秒') then
        hero:add_buff '定身'{
            time = 15
        }
        p:sendMsg('|cffebb608【系统】|r|cff00ff00这个粽子里面怎么有东西硬硬的，获得|cffff0000'..(rand_name)..'|r',4) 
    elseif finds(rand_name,'随机卡片')  then    
        local list = {
            '杀敌数保本卡','木头保本卡','魔丸保本卡','全属性保本卡',
            '杀敌数翻倍卡','木头翻倍卡','魔丸翻倍卡','全属性翻倍卡',
            '炸弹卡','大炸弹卡','猜拳卡','gg卡'
        }
        local name = list[math.random(#list)]
        local it = hero:add_item(name)
        p:sendMsg('|cffebb608【系统】|r|cff00ff00这个粽子里面怎么有东西硬硬的，获得|cffff0000'..name..'|r',4)
    elseif  rand_name == '足球小将' then 
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            local new_skl = ac.game:event_dispatch('技能-插入魔法书',hero,'彩蛋',rand_name)
            player.is_show_nickname = rand_name
            --重新来一次
            give_award(hero)
        end    
    end    
end

function mt:on_cast_start()
    local skill = self
    local target = self.target
    local hero = self.owner
    local mvr = ac.mover.line
	{
		source = hero,
		skill = skill,
		model =  skill.specail_model,
		speed = 800,
		angle = hero:get_point()/target:get_point() ,
		hit_area = skill.hit_area,
		distance = skill.range,
        high = 120,
        hit_type = '联盟',
        on_hit = function(self,u)
            if u:get_name() ~='球门' then 
                return 
            end
            print(u)
            give_award(hero)
            return true
		end	
	}

end
--来回冲锋
local function cf(source,start,target)
    local mvr = ac.mover.target
	{
		source = source,
        mover = source,
        skill = '循环',
        speed = 300,
        target = target,
        -- high = 120,
        on_finish = function(self,dest)
            cf(source,target,start)
		end	
	}
end

--创建
local function on_create()
    local rect = ac.rect.j_rect('zuqiu')
    local point = rect:get_random_point()
    local it = ac.item.create_item('小皮球',point)
    -- ac.effect_ex{
    --     point = point,
    --     model =[[biaoji_gantanhao.mdx]],
    --     size = 1.5
    -- }
    -- print(it.name,point)
end

ac.game:event '单位-获得物品后' (function (_,unit,item)
    if item.name ~='小皮球' then 
        return 
    end
    on_create()
end)
--注册创建事件
local time = 1 * 60
time = 10
ac.wait(time*1000,function()
    --创建球
    on_create()
    --创建球门
    local rt = ac.rect.j_rect('zuqiu1')
    local x,y = rt:get_point():get()
    local buttom_point = ac.point(x,y-400)
    local top_point = ac.point(x,y+400)
    local u = ac.player(11):create_unit('球门',rt)
    cf(u,buttom_point,top_point)

    local rt = ac.rect.j_rect('zuqiu2')
    local x,y = rt:get_point():get()
    local buttom_point = ac.point(x,y-400)
    local top_point = ac.point(x,y+400)
    local u = ac.player(11):create_unit('球门',rt,180)
    cf(u,buttom_point,top_point)

end)
