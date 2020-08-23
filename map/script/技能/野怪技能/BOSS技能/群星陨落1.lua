local mt = ac.skill['群星陨落1']
mt{--目标类型 = 单位
target_type = ac.skill.TARGET_TYPE_POINT,
--施法信息
cast_start_time = 0,
cast_channel_time = 0,
cast_shot_time = 0,
cast_finish_time = 0.0,
--初始等级
level = 1,
--技能图标
art = [[icon\card\2\card2_3.blp]],
--技能说明
tip = [[
    攻击10%触发，在周围1000码的范围里，随机创建10个直径100码的小区域，在每个小区域中播放倒计时0.5秒的预警圈，
    预警圈消失后，在每个小区域播放一个星落特效（模型Abilities\Spells\NightElf\Starfall\StarfallTarget.mdl），并造成攻击力*10的物理伤害，内置CD12秒
]],
damage = function(self)
    return self.owner:get('攻击')*10
end,  
--范围
range = 1000,
area = 50,
--冷却
cool = 12}
mt.effect = [[Abilities\Spells\NightElf\Starfall\StarfallTarget.mdl]]
-- mt.effect1 = [[Abilities\Spells\Other\ANrm\ANrmTarget.mdl]]

function mt:boss_skill_shot()
    local skill = self
    local hero = self.owner

	local source = hero:get_point()
	local target = self.target
    local temp = {} 
    local x,y = source:get()
    for i=1,10 do 
        local point = ac.point(math.random(x-self.range,x+self.range),math.random(y-self.range,y+self.range))
        table.insert(temp,point)
        --预警圈
        ac.warning_effect_ring
        {
            point = point,
            area = self.area,
            time = 0.5,
        }
    end
    --造成伤害
    ac.wait(0.5*1000,function()
        for i,point in ipairs(temp) do 
            --特效
            ac.effect_ex{
                point = point,
                model = self.effect,
            }:remove()
            for i, u in ac.selector()
            : in_range(point,skill.area)
            : is_enemy(hero)
            : is_not(ac.main_unit)
            : ipairs()
            do 
                u:damage
                {
                    source = hero,
                    skill = self,
                    damage = self.damage
                }
            end	
        end
    end)
    
end

function mt:on_cast_start()
    -- if self:is_cooling() then 
    --     return 
    -- end    
end

function mt:on_cast_shot()
    self:boss_skill_shot()
    self:active_cd()
end

function mt:on_cast_stop()
    if self.eft then
        self.eft:remove()
    end
end

function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end