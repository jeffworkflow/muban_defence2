
local mt = ac.skill['闪电']
mt{
--等久
level = 1,
--图标
art = [[shadidubo.blp]],
--说明
tip = [[ 
    点击后，在其它玩家的脚下，播放倒计时0.5秒的预警圈，倒计时结束，50%的概率会劈下一道闪电(闪电模型：Lightnings Long.mdx)，如果命中立刻死亡
]],
--物品类型
item_type = '消耗品',
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r',
rate = 50
}

function mt:on_cast_start()
   --使用 
    local hero = self.owner 
    local p =hero.owner 
    ac.player.self:sendMsg(p:get_name()..'使用了闪电卡',5)

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
                ac.wait(0/5*1000,function()
                    if math.random(100000)/1000 <= self.rate then 
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
art = [[shadidubo.blp]],
--说明
tip = [[ 
    点击后，在其它玩家的脚下，播放倒计时0.5秒的预警圈，倒计时结束，50%的概率会劈下一道闪电(闪电模型：Lightnings Long.mdx)，如果命中立刻死亡
]],
--物品类型
item_type = '消耗品',
target_type = ac.skill.TARGET_TYPE_UNIT,
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
				size = 2
			}:remove() 
			ac.wait(500,function()
				ac.effect_ex{
					point = target:get_point(),
					model = skill.effect3,
					size = 2
				}:remove() 

				for i, u in ac.selector()
				: in_range(target,skill.area)
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
		point = target:get_point(),
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
    ac.player.self:sendMsg(p:get_name()..'使用了导弹',5)
    self:atk_pas_shot(self.target)
end


local mt = ac.skill['追踪导弹']
mt{
--等久
level = 1,
--图标
art = [[shadidubo.blp]],
--说明
tip = [[ 
    施法距离10000，点击选择一名玩家，在该玩家的脚下，创建一个会跟随英雄的瞄准特效，0.7秒后，在玩家的头上，从天降下一个导弹，100%命中死亡
]],
--物品类型
item_type = '消耗品',
target_type = ac.skill.TARGET_TYPE_UNIT,
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
    ac.player.self:sendMsg(p:get_name()..'使用了导弹',5)
    self:atk_pas_shot(self.target)
end


local mt = ac.skill['磁铁']
mt{
--等久
level = 1,
--图标
art = [[shadidubo.blp]],
--说明
tip = [[ 
    点击后，在其它玩家的脚下，播放倒计时0.5秒的预警圈，倒计时结束，50%的概率会劈下一道闪电(闪电模型：Lightnings Long.mdx)，如果命中立刻死亡
]],
--物品类型
item_type = '消耗品',
target_type = ac.skill.TARGET_TYPE_UNIT,
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
        p:sendMsg('不可对非英雄单位使用',5)
        return true
    end
    ac.player.self:sendMsg(p:get_name()..'使用了导弹',5)

    --自己加属性
    hero:add('力量',hero:get('力量')*0.05)  
    hero:add('敏捷',hero:get('敏捷')*0.05)  
    hero:add('智力',hero:get('智力')*0.05)  
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
art = [[shadidubo.blp]],
--说明
tip = [[ 
    施法距离10000，点击在目标位置放一个香蕉，模型bananaa.mdx，持续时间30秒，当有玩家走过时，晕眩4秒
]],
--物品类型
item_type = '消耗品',
target_type = ac.skill.TARGET_TYPE_POINT,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r',
range = 10000,
area = 200,
--特效
effect =[[az_juli01.mdx]],
time = 30,
stu_time = 4,
}
function mt:on_cast_start()
    local target = self.target

    local x,y = target:get_point():get()
    local rect = ac.rect.create(x-100,y-100,x+100,y+100)
    local region = ac.region.create(rect)

    local eff = ac.effect_ex{
        point = target:get_point(),
        model = self.model,
        time = self.time
    }

    region:event '区域-进入' (function(trg, hero)
        if reg < hero:get_point()  then --不加区域判断，会有莫名其妙的问题，在练功房传送到其他地方，可能会出现在其他区域。
            if not hero:is_hero() then 
                return 
            end
            hero:add_buff '晕眩'{
                time = self.stu_time
            }
        end
    end)

    ac.wait(self.time*1000,function()
        region:remove()
    end)

end



local mt = ac.skill['大魔王']
mt{
--等久
level = 1,
--图标
art = [[shadidubo.blp]],
--说明
tip = [[ 
    点击在目标位置召唤出可以控制的一只地狱火（等待创建），持续时间60秒
]],
--物品类型
item_type = '消耗品',
target_type = ac.skill.TARGET_TYPE_POINT,
range = 10000,
area = 200,
--物品详细介绍的title
content_tip = '|cffffe799使用说明：|r',
time = 60,
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
art = [[shadidubo.blp]],
--说明
tip = [[ 
点击选择一名玩家，在他头上倒计时30秒，30秒后，播放爆炸特效：AZ_AurelVlaicu_C4.MDX，范围500码的所有人都死亡
]],
--物品类型
item_type = '消耗品',
target_type = ac.skill.TARGET_TYPE_UNIT,
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
    local p = self.owner.owner
    if not self.target:is_hero() then 
        p:sendMsg('不可对非英雄单位使用',5)
        return true
    end
    -- local eff = target:add_effect('overhead',self.effect)
    ac.on_texttag_time(self.time,target)
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



--奖品
local award_list = { 
    ['魔灵争霸'] =  {
        { rand = 64, name = '闪电*1'},
        
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