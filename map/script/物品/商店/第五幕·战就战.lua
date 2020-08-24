local mt = ac.skill['火炎之力']
mt{
    --等级
    level = 0,
    --魔法书相关
    is_order = 1 ,
    art = [[BTN131.blp]], 
    tip = [[
    
|cffFFE799【属性】：|r
|cff00ff00+500W 全属性
+3000  减少周围护甲|r

]],
    ['全属性'] = 5000000,
    ['减少周围护甲'] = 3000,
}

local mt = ac.skill['水寒之力']
mt{
    --等级
    level = 0,
    --魔法书相关
    is_order = 1 ,
    art = [[BTN137.blp]], 
    tip = [[
    
|cffFFE799【属性】：|r
|cff00ff00+600W 全属性
攻击有10%几率造成|cffffff00（全属性*100）|cff00ff00的范围技能伤害|r

]],
    ['全属性'] = 6000000,
	--技能类型
	skill_type = "被动,全属性",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 1,
	--忽略技能冷却
	ignore_cool_save = true,
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 500,
	--伤害
	damage = function(self)
  return ((self.owner:get('力量')+self.owner:get('智力')+self.owner:get('敏捷'))*100)
end,
	--被动事件
	event_name = "造成伤害效果",
	--特效
    effect = [[Abilities\Spells\Undead\FrostNova\FrostNovaTarget.mdl]],
    
}

function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
	local target = damage.target
	if not damage:is_common_attack()  then 
		return 
	end 
    ac.effect_ex{
        model = skill.effect,
        size = 4,
    	point = target:get_point(),
    }:remove()
	for i, u in ac.selector()
		: in_range(hero,self.damage_area)
		: is_enemy(hero)
		: ipairs()
	do
        u:damage
        {
            source = hero,
            skill = skill,
            damage = skill.damage,
            damage_type = '法术'
        }
	end	
end

local mt = ac.skill['暴风之力']
mt{
    --等级
    level = 0,
    --魔法书相关
    is_order = 1 ,
    art = [[BTN167.blp]], 
    tip = [[
    
|cffFFE799【属性】：|r
|cff00ff00+700W 全属性
+25%  攻击距离|r

]],
    ['全属性'] = 7000000,
    ['攻击距离%'] = 25,
    
}

local mt = ac.skill['天雷之力']
mt{
    --等级
    level = 0,
    --魔法书相关
    is_order = 1 ,
    art = [[BTN142.blp]], 
    tip = [[
    
|cffFFE799【属性】：|r
|cff00ff00+800W 全属性
+100%  暴击伤害
+50%  技暴伤害
+25%   会心伤害|r

]],
    ['全属性'] = 8000000,
    ['暴击伤害'] = 100,
    ['技暴伤害'] = 50,
    ['会心伤害'] = 25,
    
}

local mt = ac.skill['生命之力']
mt{
    --等级
    level = 0,
    --魔法书相关
    is_order = 1 ,
    art = [[BTN134.blp]], 
    tip = [[
    
|cffFFE799【属性】：|r
|cff00ff00+900W 全属性
+10%  生命上限
+10%  每秒回血|r

]],
    ['全属性'] = 9000000,
    ['生命上限%'] = 10,
    ['每秒回血'] = 10,
    
}

local mt = ac.skill['死亡之力']
mt{
    --等级
    level = 0,
    --魔法书相关
    is_order = 1 ,
    art = [[BTN138.blp]], 
    tip = [[
    
|cffFFE799【属性】：|r
|cff00ff00+1000W 全属性
+10%  攻击
攻击有10%几率秒杀敌人（对BOSS无效）|r

]],
    ['全属性'] = 10000000,
    ['攻击%'] = 10,
	--技能类型
	skill_type = "被动,秒杀",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 1,
	--忽略技能冷却
	ignore_cool_save = true,
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
	--被动事件
	event_name = "造成伤害效果",
	--特效
	effect = [[AZ_Leviathan_V2.mdx]],
}

function mt:damage_start(damage)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
	local target = damage.target

	if not damage:is_common_attack()  then 
		return 
	end 
    ac.effect_ex{
    	model = skill.effect,
    	point = target:get_point(),
    }:remove()
    if not target:is_type('boss') then 
        target:kill(hero)
    end
end

local mt = ac.skill['光明之力']
mt{
    --等级
    level = 0,
    --魔法书相关
    is_order = 1 ,
    art = [[BTN127.blp]], 
    tip = [[
    
|cffFFE799【属性】：|r
|cff00ff00+1100W 全属性
+300%   暴击伤害
+100%   物理伤害加深|r

]],
    ['全属性'] = 11000000,
    ['暴击伤害'] = 300,
    ['物理伤害加深'] = 100,
}

local mt = ac.skill['黑暗之力']
mt{
    --等级
    level = 0,
    --魔法书相关
    is_order = 1 ,
    art = [[BTN128.blp]], 
    tip = [[
    
|cffFFE799【属性】：|r
|cff00ff00+1200W 全属性
+100%   技暴伤害
+50%    技能伤害加深|r

]],
    ['全属性'] = 12000000,
    ['技暴伤害'] = 100,
    ['技能伤害加深'] = 50,
    
    
}

local mt = ac.skill['时间之力']
mt{
    --等级
    level = 0,
    --魔法书相关
    is_order = 1 ,
    art = [[BTN136.blp]], 
    tip = [[
    
|cffFFE799【属性】：|r
|cff00ff00+1300W 全属性
+1000 杀怪加全属性
+2W   每秒加全属性|r

]],
    ['全属性'] = 13000000,
    ['杀怪加全属性'] = 1000,
    ['每秒加全属性'] = 20000,
    
    
}

local mt = ac.skill['空间之力']
mt{
    --等级
    level = 0,
    --魔法书相关
    is_order = 1 ,
    art = [[BTN161.blp]], 
    tip = [[
    
|cffFFE799【属性】：|r
|cff00ff00+1500W 全属性
+100%   会心伤害
+50%    全伤加深

]],
    ['全属性'] = 15000000,
    ['会心伤害'] = 100,
    ['全伤加深'] = 50,
    
    
}

for i,name in ipairs({'火炎之力 ','水寒之力 ','暴风之力 ','天雷之力 ','生命之力 ','死亡之力 ','光明之力 ','黑暗之力 ','时间之力 ','空间之力 '}) do 
    local mt = ac.skill[name]
    mt.effect2 = [[Void Teleport Target.mdx]]
    function mt:on_cast_start()
        local p=self.owner.owner
        local hero =p.hero 
        -- p.flag_all = p.flag_all or {}
        local real_name = string.sub(name,1,-2)
        
        --创建升级怪 
        local rect = ac.rect.j_rect('zhanjiuzhan1')
        local point = rect:get_point()

        ac.wait(150,function()
            ac.effect_ex{
                model = self.effect2,
                size = 3,
                point = point
            }:remove()
        
        end)
        ac.wait(500,function()
            ac.effect_ex{
                model = self.effect2,
                size = 3,
                point = point
            }:remove()
        
        end)
        local u 
        local trg_t = ac.wait(1*1500,function()
            u = ac.player(12):create_unit(real_name,point)
            u:event '单位-死亡'(function(_,unit,killer)
                --激活属性
                local skl = hero:find_skill(real_name,nil,true)
                if skl and skl.level<1 then 
                    skl:set_level(1)
                    p:sendMsg('|cffebb608【系统】|r|cffffff00激活成功|r |cff00ff00属性可在圣龙气运-战就战系统中查看',2)
                end    
                --传送回练功房
                local point = ac.map.rects['练功房刷怪'..p.id]:get_point()
                if finds(ac.g_game_degree_name,'深渊冒险') then 
                    point = ac.rect.j_rect('zxzw1'):get_point()
                end
                hero:blink(point,true,false,true)
            end)
        end)
        --创建区域离开事件
        local reg = ac.map.regions['zhanjiuzhan2']
        reg:event '区域-离开'(function(trg,unit)
            if hero ~= unit then 
                return 
            end  
            if u and u:is_alive() then 
                u:remove()
            end
            if trg_t then 
                trg_t:remove()
                trg_t = nil 
            end   
            --删除自己的
            trg:remove()  
        end)

    end
end
