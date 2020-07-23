
local mt = ac.skill['闪电']
mt{
--等久
level = 1,
--图标
art = [[shandian.blp]],
--说明
tip = [[ 

|cff00ff00使用后会风云变色，电闪雷鸣，令其它玩家遭受雷劈！
]],
--物品类型
item_type = '消耗品',
specail_model = [[item_gem_diamond.mdx]],

--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r',
effect =[[Lightnings Long.mdx]],
rate = 50
}

function mt:on_cast_start()
   --使用 
    local hero = self.owner 
    local p =hero.owner 
    ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff'..p:get_name()..'|cffff0000使用【闪电】，顿时风云变色，电闪雷鸣！',5)

    for i=1,6 do 
        local pp = ac.player(i)
        if pp:is_player() then 
            if pp ~= p and pp.hero then 
                local point = pp.hero:get_point():copy()
                --创建预警圈
                ac.warning_effect_circle
                {
                    point = point,
                    area = 300,
                    time = 0.5,
                }
                --概率造成伤害
                ac.wait(0.5*1000,function()
                    if math.random(100000)/1000 <= self.rate then 
                        ac.effect_ex{
                            point = point,
                            model = self.effect,
                            time = 0.5
                        }
                        if pp.hero:is_in_range(point,150) then 
                            pp.hero:kill(hero)
                        end
                    end
                end)
            end
        end
    end
end


local mt = ac.skill['导弹']
mt{
--等久
level = 1,
--图标
art = [[daodan.blp]],
--说明
tip = [[ 

|cff00ff00请选择你想轰炸的玩家！
]],
--物品类型
item_type = '消耗品',
specail_model = [[item_gem_diamond.mdx]],
target_type = ac.skill.TARGET_TYPE_UNIT,
--目标允许	
target_data = '联盟 玩家单位 敌人',
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r',
range = 10000,
--特效
effect = [[calldown_4.mdx]],
--特效1
effect1 = [[calldown_flydown.mdx]],
--特效2
effect2 = [[calldown_flyup.mdx]],
effect3 = [[AZ_AurelVlaicu_C4.MDX]],
area1 = 500,
}

function mt:atk_pas_shot(target)
    local skill = self
	local hero = self.owner
    local source_point = target:get_point():copy()

	local function start_damage()
		--导弹上升特效
		ac.effect_ex{
			point = hero:get_point(),
			model = skill.effect2,
			size = 2
		}:remove()  
		--导弹下降特效
		ac.wait(800,function()
			ac.effect_ex{
				point = source_point:get_point(),
				model = skill.effect1,
				size = 2
			}:remove() 
			ac.wait(500,function()
				ac.effect_ex{
					point = source_point:get_point(),
					model = skill.effect3,
					size = 2
				}:remove() 

				for i, u in ac.selector()
				: in_range(source_point,skill.area1)
                : is_type('英雄')
                : is_not(hero)
				: ipairs()
                do 
                    u:kill(hero)
				end	
			end)
		end)
	end	

	local source = hero:get_point()
	--瞄准特效
	ac.effect_ex{
		point = source_point:get_point(),
		model = skill.effect,
		time = 3
	}

	start_damage()
	-- ac.wait(1000,function()
	-- 	start_damage()
	-- end)
end

function mt:on_cast_start()
   --使用 
    local hero = self.owner 
    local p =hero.owner 
    local target_p =self.target.owner
    ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ff00Good luck！|cff00ffff'..p:get_name()..'|cff00ff00对|cff00ffff'..target_p:get_name()..'|cff00ff00发射了一枚|cffffff00【导弹】！',5)
    self:atk_pas_shot(self.target)
end


local mt = ac.skill['追踪导弹']
mt{
--等久
level = 1,
--图标
art = [[zhuizongdaodan.blp]],
--说明
tip = [[ 

|cff00ff00请选择你想轰炸的玩家！
]],
--物品类型
item_type = '消耗品',
specail_model = [[item_gem_diamond.mdx]],
target_type = ac.skill.TARGET_TYPE_UNIT,
--目标允许	
target_data = '联盟 玩家单位 敌人',
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r',
range = 10000,
--特效
effect = [[calldown_4.mdx]],
--特效1
effect1 = [[calldown_flydown.mdx]],
--特效2
effect2 = [[calldown_flyup.mdx]],
effect3 = [[AZ_AurelVlaicu_C4.MDX]],
}

function mt:atk_pas_shot(target)
    local skill = self
	local hero = self.owner

	local function start_damage()
		--导弹上升特效
		ac.effect_ex{
			point = hero:get_point(),
			model = skill.effect2,
			size = 2
		}:remove()  
		--导弹下降特效
		ac.wait(800,function()
			ac.effect_ex{
				point = target:get_point(),
				model = skill.effect1,
                size = 2,
                follow = target
            }:remove() 
			ac.wait(500,function()
				ac.effect_ex{
					point = target:get_point(),
					model = skill.effect3,
					size = 2,
                    follow = target
				}:remove() 
                target:kill(hero)
			end)
		end)
	end	

	local source = hero:get_point()
	--瞄准特效
	ac.effect_ex{
		point = target:get_point(),
		model = skill.effect,
		time = 3,
        follow = target
    }
    -- local eff = target:add_effect('origin',skill.effect)
    -- ac.wait(3*1000,function()
    --     eff:remove()
    -- end)
	start_damage()
	-- ac.wait(1000,function()
	-- 	start_damage()
	-- end)
end

function mt:on_cast_start()
   --使用 
    local hero = self.owner 
    local p =hero.owner 
    local target_p =self.target.owner
    ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ff00Good luck！|cff00ffff'..p:get_name()..'|cff00ff00对|cff00ffff'..target_p:get_name()..'|cff00ff00发射了一枚|cffffff00【追踪导弹】！',5)
    self:atk_pas_shot(self.target)
end


local mt = ac.skill['磁铁']
mt{
--等久
level = 1,
--图标
art = [[citie.blp]],
--说明
tip = [[ 

|cff00ff00对一名玩家使用，吸收他身上所有的铁元素，让他全属性-5%，并增加到自己身上！
]],
--物品类型
item_type = '消耗品',
specail_model = [[item_gem_diamond.mdx]],

target_type = ac.skill.TARGET_TYPE_UNIT,
--目标允许	
target_data = '联盟 玩家单位 敌人',
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r',
range = 10000,
--特效
effect =[[az_juli01.mdx]]
}
function mt:on_cast_start()
   --使用 
    local hero = self.owner 
    local p =hero.owner 
    hero = p.hero
    
    if not self.target:is_hero() then 
        p:sendMsg('|cffebb608【系统】|r|cffff0000不可对非英雄单位使用',5)
        return true
    end
    local target_p =self.target.owner
    ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ff00Good luck！|cff00ffff'..p:get_name()..'|cff00ff00对|cff00ffff'..target_p:get_name()..'|cff00ff00使用了|cffffff00【磁铁】！',5)

    --自己加属性
    hero:add('力量',self.target:get('力量')*0.05)  
    hero:add('敏捷',self.target:get('敏捷')*0.05)  
    hero:add('智力',self.target:get('智力')*0.05)  
    hero:add_effect('chest',self.effect):remove()
    ac.wait(0.1*1000,function()
        hero:add_effect('chest',self.effect):remove()
    end)
    ac.wait(0.2*1000,function()
        hero:add_effect('chest',self.effect):remove()
    end)
    
    --对方扣属性
    self.target:add('力量',-self.target:get('力量')*0.05)  
    self.target:add('敏捷',-self.target:get('敏捷')*0.05)  
    self.target:add('智力',-self.target:get('智力')*0.05)  
    self.target:add_effect('chest',self.effect):remove()
    ac.wait(0.1*1000,function()
        self.target:add_effect('chest',self.effect):remove()
    end)
    ac.wait(0.2*1000,function()
        self.target:add_effect('chest',self.effect):remove()
    end)
end


local mt = ac.skill['香蕉']
mt{
--等久
level = 1,
--图标
art = [[xiangjiao.blp]],
--说明

tip = [[ 

|cff00ff00在目标地点放置一个持续30秒的香蕉，不看路的玩家可能会摔倒！
]],
--物品类型
item_type = '消耗品',
specail_model = [[item_gem_diamond.mdx]],
target_type = ac.skill.TARGET_TYPE_POINT,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r',
range = 10000,
area = 200,
--特效
effect =[[bananaa.mdx]],
time = 30,
stu_time = 4,
}
function mt:on_cast_start()
    local target = self.target

    local x,y = target:get_point():get()
    local rect = ac.rect.create(x-50,y-50,x+50,y+50)
    local region = ac.region.create(rect)

    local eff = ac.effect_ex{
        point = target:get_point(),
        model = self.effect,
        time = self.time,
        size = 10
    }

    region:event '区域-进入' (function(trg, hero)
        if region < hero:get_point()  then --不加区域判断，会有莫名其妙的问题，在练功房传送到其他地方，可能会出现在其他区域。
            if not hero:is_hero() then 
                return 
            end
            hero:add_buff '晕眩'{
                time = self.stu_time
            }
            ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ff00Good luck！不看路的|cff00ffff'..hero.owner:get_name()..'|cff00ff00踩到了一个香蕉，摔倒在地！',5)
           
            region:remove()
            region = nil
            eff:remove()
        end
    end)

    ac.wait(self.time*1000,function()
        if region then 
            region:remove()
            region = nil
        end
    end)

end



local mt = ac.skill['大魔王']
mt{
--等久
level = 1,
--图标
art = [[damowang1.blp]],
--说明
tip = [[ 

|cff00ff00召唤出一只凶恶的大魔王，持续时间20秒！
]],
--物品类型
item_type = '消耗品',
specail_model = [[item_gem_diamond.mdx]],
target_type = ac.skill.TARGET_TYPE_POINT,
range = 10000,
area = 200,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r',
time = 20,
}
function mt:on_cast_start()
    local target = self.target
    local p = self.owner.owner
    local u = p:create_unit('地狱火',target:get_point())
    u:add_buff '召唤物'{
        time = self.time,
        remove_target = true,
        skill = self,
        search_area = 500, --搜敌路径
    }
    u:add_skill('攻击','英雄')
end

local mt = ac.skill['定时炸弹']
mt{
--等久
level = 1,
--图标
art = [[dingshizhadan.blp]],
--说明
tip = [[ 

|cff00ff00请选择你想轰炸的玩家！炸弹30秒之后爆炸！
]],
--物品类型
item_type = '消耗品',
specail_model = [[item_gem_diamond.mdx]],
target_type = ac.skill.TARGET_TYPE_UNIT,
--目标允许	
target_data = '联盟 玩家单位 敌人',
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r',
range = 10000,
effect = [[AZ_AurelVlaicu_C4.MDX]],
area1 = 500,
time = 30
}
function mt:on_cast_start()
    local target = self.target
    local hero = self.owner 
    local skill = self 
    local p = self.owner.owner
    if not self.target:is_hero() then 
        p:sendMsg('|cffebb608【系统】|r|cffff0000不可对非英雄单位使用',5)
        return true
    end
    local target_p =self.target.owner
    ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ff00Good luck！|cff00ffff'..p:get_name()..'|cff00ff00对|cff00ffff'..target_p:get_name()..'|cff00ff00使用了|cffffff00【定时炸弹】！',5)
    -- local eff = target:add_effect('overhead',self.effect)
    local time = self.time
    ac.on_texttag_time(time,target)
    ac.timer(1*1000, math.ceil(time),function()
        time = time - 1
        ac.on_texttag_time(time,target)
    end)
    ac.wait(self.time*1000,function()
        -- eff:remove()

        --爆炸
        ac.effect_ex{
            model = skill.effect,
            point = target:get_point()
        }:remove()

        for i, u in ac.selector()
        : in_range(target:get_point(),skill.area1)
        : is_type('英雄')
        : ipairs()
        do 
            u:kill(hero)
        end	
    end)
end

local mt = ac.skill['均富']
mt{
--等久
level = 1,
--图标
art = [[junfu.blp]],
--说明
tip = [[ 

|cff00ff00你有我有全都有！将所有玩家的木头、魔丸平分
]],
--物品类型
item_type = '消耗品',
specail_model = [[item_gem_diamond.mdx]],
-- target_type = ac.skill.TARGET_TYPE_UNIT,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r',
}
function mt:on_cast_start()
    local wood = 0
    local rec_ex = 0
    for i=1,6 do 
        local p = ac.player(i)
        if p:is_player() then 
            wood = wood + p.wood
            rec_ex = rec_ex + p.rec_ex
        end
    end

    for i=1,6 do 
        local p = ac.player(i)
        if p:is_player() then 
            p:add_wood(-p.wood)
            p:add_wood(wood/get_player_count())

            p:add_rec_ex(-p.rec_ex)
            p:add_rec_ex(rec_ex/get_player_count())
        end
    end
    
    local p = self.owner.owner
    ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ff00你有我有全都有！|cff00ffff'..p:get_name()..'|cff00ff00使用了|cffffff00【均富】！|cffff0000所有玩家的木头、魔丸平分',5)
end


local mt = ac.skill['均贫']
mt{
--等久
level = 1,
--图标
art = [[junpin.blp]],
--说明
tip = [[ 

|cff00ff00你有我有！与指定玩家平分所有木头、魔丸
]],
--物品类型
item_type = '消耗品',
specail_model = [[item_gem_diamond.mdx]],
range = 10000,
target_type = ac.skill.TARGET_TYPE_UNIT,
--目标允许	
target_data = '联盟 玩家单位 敌人',
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r',
}
function mt:on_cast_start()
    local wood = 0
    local rec_ex = 0
    local target = self.target
    local hero = self.owner 
    local p = self.owner.owner
    local target_p = target.owner
    if not self.target:is_hero() then 
        p:sendMsg('|cffebb608【系统】|r|cffff0000不可对非英雄单位使用',5)
        return true
    end
    ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ff00Good luck！|cff00ffff'..p:get_name()..'|cff00ff00对|cff00ffff'..target_p:get_name()..'|cff00ff00使用了|cffffff00【均贫】！',5)
    wood = wood + p.wood + target_p.wood
    rec_ex = rec_ex + p.rec_ex + target_p.rec_ex

    p:add_wood(-p.wood)
    p:add_wood(wood/get_player_count())
    p:add_rec_ex(-p.rec_ex)
    p:add_rec_ex(rec_ex/get_player_count())

    target_p:add_wood(-target_p.wood)
    target_p:add_wood(wood/get_player_count())
    target_p:add_rec_ex(-target_p.rec_ex)
    target_p:add_rec_ex(rec_ex/get_player_count())
   
end


local mt = ac.skill['抢夺']
mt{
--等久
level = 1,
--图标
art = [[qiangduo1.blp]],
--说明
tip = [[ 

|cff00ff00可抢夺其它玩家的装备
]],
--物品类型
item_type = '消耗品',
specail_model = [[item_gem_diamond.mdx]],
range = 10000,
target_type = ac.skill.TARGET_TYPE_UNIT,
--目标允许	
target_data = '联盟 玩家单位 敌人',
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r',
rate = 50
}
function mt:on_cast_start()
    local target = self.target
    local hero = self.owner 
    local p = self.owner.owner
    local target_p = target.owner
    if not self.target:is_hero() then 
        p:sendMsg('|cffebb608【系统】|r|cffff0000不可对非英雄单位使用',5)
        return true
    end
    local temp = {}
    for i=1,6 do 
        local it = target:get_slot_item(i)
        if it and finds(it.color,'白','蓝','金','红','黑') then 
            table.insert(temp,it)
        end
    end
    if #temp <=0 then 
        p:sendMsg('|cffebb608【系统】|r|cffff0000抢夺失败',5)
        return 
    end
    --实施抢夺
    if math.random(100000)/1000 <= self.rate then
        local it = temp[math.random(#temp)]
        target:remove_item(it)
        hero:add_item(it)
        ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff'..p:get_name()..'|cff00ff00夺走了|cff00ffff'..target_p:get_name()..'|cff00ff00的'..it.color_name,5)
    else
        p:sendMsg('|cffebb608【系统】|r|cffff0000抢夺失败',5)
    end
    
end


local mt = ac.skill['抢钱']
mt{
--等久
level = 1,
--图标
art = [[qiangduo.blp]],
--说明
tip = [[ 

|cff00ff00可抢夺其它玩家的木头、魔灵
]],
--物品类型
item_type = '消耗品',
specail_model = [[item_gem_diamond.mdx]],
range = 10000,
target_type = ac.skill.TARGET_TYPE_UNIT,
--目标允许	
target_data = '联盟 玩家单位 敌人',
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r',
}
function mt:on_cast_start()
    local target = self.target
    local hero = self.owner 
    local p = self.owner.owner
    local target_p = target.owner
    if not self.target:is_hero() then 
        p:sendMsg('|cffebb608【系统】|r|cffff0000不可对非英雄单位使用',5)
        return true
    end
    local rate = math.random(100)
    local wood = target_p.wood * rate /100
    local rec_ex = target_p.rec_ex * rate /100
    p:add_wood(wood)
    p:add_rec_ex(rec_ex)
    target_p:add_wood(-wood)
    target_p:add_rec_ex(-rec_ex)
    ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff'..p:get_name()..'|cff00ff00夺走了|cff00ffff'..target_p:get_name()..'|cffff0000'..rate..'|cffff0000%的木头和魔灵',5)
end

local mt = ac.skill['冬眠']
mt{
--等久
level = 1,
--图标
art = [[dongmian.blp]],
--说明
tip = [[ 

|cff00ff00使所有玩家进入冬眠！
]],
--物品类型
item_type = '消耗品',
specail_model = [[item_gem_diamond.mdx]],
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r',
effect =[[Abilities\Spells\Undead\Sleep\SleepTarget.mdl]],
time =10
}

function mt:on_cast_start()  
    --使用 
    local hero = self.owner 
    local p =hero.owner 
    ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff'..p:get_name()..'|cffff0000使用【冬眠】，所有玩家进入了沉睡！',5)

    for i=1,6 do 
        local pp = ac.player(i)
        if pp:is_player() then 
            if pp ~= p and pp.hero then 
                pp.hero:add_buff '晕眩'{
                    time = self.time,
                    model = self.effect
                }
            end
        end
    end
end


local mt = ac.skill['梦游']
mt{
--等久
level = 1,
--图标
art = [[ReplaceableTextures\CommandButtons\BTNSleep.blp]],
--说明
tip = [[ 

|cff00ff00让指定玩家进入梦游！
]],
--物品类型
item_type = '消耗品',
specail_model = [[item_gem_diamond.mdx]],
range = 10000,
target_type = ac.skill.TARGET_TYPE_UNIT,
--目标允许	
target_data = '联盟 玩家单位 敌人',
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r',
time = 15,
effect = [[Abilities\Spells\Undead\Sleep\SleepTarget.mdl]],
}
function mt:on_cast_start()
    local target = self.target
    local hero = self.owner 
    local p = self.owner.owner
    local target_p = target.owner
    if not self.target:is_hero() then 
        p:sendMsg('|cffebb608【系统】|r|cffff0000不可对非英雄单位使用',5)
        return true
    end
    target:add_buff '晕眩'{
        time = self.time,
        model = self.effect
    }
    ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff'..p:get_name()..'|cff00ff00让|cff00ffff'..target_p:get_name()..'|cffff0000进入了【梦游】！',5)
end


local mt = ac.skill['乌龟']
mt{
--等久
level = 1,
--图标
art = [[wugui1.blp]],
--说明
tip = [[ 

|cff00ff00让指定玩家变成乌龟，持续时间10秒！
]],
--物品类型
item_type = '消耗品',
specail_model = [[item_gem_diamond.mdx]],
range = 10000,
target_type = ac.skill.TARGET_TYPE_UNIT,
--目标允许	
target_data = '联盟 玩家单位 敌人',
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r',
time = 15,
effect = [[Turtle.mdx]],
}
function mt:on_cast_start()
    local target = self.target
    local hero = self.owner 
    local p = self.owner.owner
    local target_p = target.owner
    if not self.target:is_hero() then 
        p:sendMsg('|cffebb608【系统】|r|cffff0000不可对非英雄单位使用',5)
        return true
    end
    target:add_buff '召唤物' {
        skill = self,
        time = self.time,
        model = self.effect,
        remove_target = false
    }
    target:add('移动速度%',-90) 
    target:add('攻击速度',-250) 
    target:add('攻击间隔',0.5) 

    target:wait(self.time * 1000,function()
        target:add('移动速度%',90) 
        target:add('攻击速度',250) 
        target:add('攻击间隔',-0.5) 
    end)
    ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff'..p:get_name()..'|cff00ff00把|cff00ffff'..target_p:get_name()..'|cffff0000变成了一只乌龟！',5)
end

local mt = ac.skill['充公']
mt{
--等久
level = 1,
--图标
art = [[chonggong.blp]],
--说明
tip = [[ 
    
|cff00ff00让指定玩家的木头、魔丸全部充公！
]],
--物品类型
item_type = '消耗品',
specail_model = [[item_gem_diamond.mdx]],
range = 10000,
target_type = ac.skill.TARGET_TYPE_UNIT,
--目标允许	
target_data = '联盟 玩家单位 敌人',
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r',
}
function mt:on_cast_start()
    local target = self.target
    local hero = self.owner 
    local p = self.owner.owner
    local target_p = target.owner
    if not self.target:is_hero() then 
        p:sendMsg('|cffebb608【系统】|r|cffff0000不可对非英雄单位使用',5)
        return true
    end
    target_p:add_wood(-target_p.wood)
    target_p:add_rec_ex(-target_p.rec_ex)
    ac.player.self:sendMsg('|cffebb608【系统】|r|cff00ffff'..p:get_name()..'|cff00ff00让|cff00ffff'..target_p:get_name()..'|cffff0000的木头、魔丸全部充公！',5)
end

--奖品
local award_list = { 
    ['魔灵争霸'] =  {
        { rand = 0.02, name = '闪电*1'},
        { rand = 0.02, name = '导弹*1'},
        { rand = 0.02, name = '追踪导弹*1'},
        { rand = 0.02, name = '磁铁*1'},
        { rand = 0.02, name = '香蕉*1'},
        { rand = 0.02, name = '大魔王*1'},
        { rand = 0.02, name = '定时炸弹*1'},
        { rand = 0.02, name = '均富*1'},
        { rand = 0.02, name = '均贫*1'},
        { rand = 0.02, name = '抢钱*1'},
        { rand = 0.02, name = '冬眠*1'},
        { rand = 0.02, name = '梦游*1'},
        { rand = 0.02, name = '乌龟*1'},
        { rand = 0.02, name = '充公*1'},
        
    },
}


ac.game:event '单位-死亡' (function (_,unit,killer)
    if not finds(ac.g_game_degree_name,'魔灵争霸') then 
        return
    end    
    local p = killer:get_owner()
    local rand_name = ac.get_reward_name(award_list['魔灵争霸'])  
    if not rand_name then 
        return 
    end   
    --处理掉落物品相关
    local point = unit:get_point()
    for k,v in rand_name:gmatch '(%S+)%*(%d+%s-)' do
        for i=1,tonumber(v) do 
            ac.item.create_item(k,point)  
        end 
    end

end)