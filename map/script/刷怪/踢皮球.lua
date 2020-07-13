local mt = ac.skill['小皮球']
mt{
--必填
is_skill = true,
--等级
level = 1,
--目标类型
target_type = ac.skill.TARGET_TYPE_POINT,
content_tip = '|cffffe799物品说明：|r',
tip = [[


|cff00ff00点击进行|cffffff00射门
]],
--cd
cool = 0,
art = [[xiaopiqiu.blp]],
--模型
specail_model = [[bignoanimball.MDX]],
--物品
item_type = '消耗品',
unit_type = '英雄',
unit_type_tip = [[|cffebb608【系统】|cffff0000宠物捡不起来|r]],
max_use_count = 500, --最大使用次数
range = 1000,
hit_area =150,
model_size = 1.4
}

--奖品
local award_list = { 
    ['踢皮球'] =  {
        { rand = 5, name = '扣除所有木头'},
        { rand = 5, name = '定身5秒，禁止使用物品5秒'},
        { rand = 5, name = '定身15秒，禁止使用物品15秒'},
        { rand = 5, name = '随机卡片'},
        { rand = 5, name = '神球小将'},
        
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
        p:sendMsg('|cffebb608【系统】|r |cff00ff00好球！干得漂亮！',3) 
    elseif  finds(rand_name,'扣除所有木头') then
        hero:add_wood(-p.wood)
        p:sendMsg('|cffebb608【系统】|r|cff00ff00不是让你踢假球吗，怎么进了？？？|cffff0000扣除所有木头！',4) 
    elseif  finds(rand_name,'定身5秒') then
        hero:add_buff '定身'{
            time = 5
        }
        p:sendMsg('|cffebb608【系统】|r|cff00ff00进球的时候脚崴了一下，|cffffff00休息5秒',4) 
    elseif  finds(rand_name,'定身15秒') then
        hero:add_buff '定身'{
            time = 15
        }
        p:sendMsg('|cffebb608【系统】|r|cff00ff00进球的时候闪到了腰，|cffffff00休息15秒',4) 
    elseif finds(rand_name,'随机卡片')  then    
        local list = ac.all_card
        local name = list[math.random(#list)]
        local it = hero:add_item(name)
        p:sendMsg('|cffebb608【系统】|r|cff00ff00违规进球，裁判掏出了|cffff0000【卡片'..name..'】|r，被你一把抢了过来',4)
    elseif  rand_name == '神球小将' then 
        local skl = hero:find_skill(rand_name,nil,true)
        if not skl  then 
            local new_skl = ac.game:event_dispatch('技能-插入魔法书',hero,'彩蛋',rand_name)
            player.is_show_nickname = rand_name
            ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff'..player:get_name()..'|r在场上披荆斩棘，不断进球！ 获得成就|cffff0000 "神球小将" |r，奖励 |cffff0000+1500万全属性，攻击速度+100%，攻击减甲+188，攻击间隔-0.05，对BOSS额外伤害+50%|r',6)
            ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff'..player:get_name()..'|r在场上披荆斩棘，不断进球！ 获得成就|cffff0000 "神球小将" |r，奖励 |cffff0000+1500万全属性，攻击速度+100%，攻击减甲+188，攻击间隔-0.05，对BOSS额外伤害+50%|r',6)
            ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff'..player:get_name()..'|r在场上披荆斩棘，不断进球！ 获得成就|cffff0000 "神球小将" |r，奖励 |cffff0000+1500万全属性，攻击速度+100%，攻击减甲+188，攻击间隔-0.05，对BOSS额外伤害+50%|r',6)
        else
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
        hit_type = '友方',
        allow_god = true,
        on_hit = function(self,u)
            if u:get_name() ~='球门' then 
                return 
            end
            -- print(u)
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
ac.game:event '单位-丢弃物品后' (function (_,unit,item)
    if item.name ~='小皮球' then 
        return 
    end
    item.flag_removed = true
end)

ac.game:event '单位-获得物品后' (function (_,unit,item,old_item)
    local it = old_item or item
    if it.name ~='小皮球' then 
        return 
    end
    if it.flag_removed then 
        return 
    end
    on_create()
end)
--注册创建事件
local time = 8 * 60
-- time = 10
ac.wait(time*1000,function()
    --创建球
    on_create()
    --创建球门
    local rt = ac.rect.j_rect('zuqiu1')
    local x,y = rt:get_point():get()
    local buttom_point = ac.point(x,y-400)
    local top_point = ac.point(x,y+400)
    local u = ac.player(11):create_unit('球门',rt)
    u:add_restriction '无敌'
    u:add_restriction '缴械'
    cf(u,buttom_point,top_point)

    local rt = ac.rect.j_rect('zuqiu2')
    local x,y = rt:get_point():get()
    local buttom_point = ac.point(x,y-400)
    local top_point = ac.point(x,y+400)
    local u = ac.player(11):create_unit('球门',rt,180)
    cf(u,buttom_point,top_point)
    u:add_restriction '无敌'
    u:add_restriction '缴械'

end)
