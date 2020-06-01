local math_random = math.random
local table_insert = table.insert
local dbg = require 'jass.debug'

local event_name = {
    ['单位-攻击出手'] = true,
    ['单位-被攻击出手'] = true,
    ['造成伤害开始'] = true,
    ['受到伤害开始'] = true,
    ['造成伤害效果'] = true,
    ['受到伤害效果'] = true,
    ['单位-杀死单位'] = true,
    ['单位-死亡'] = true,
    ['单位-即将死亡'] = true,
}

local api = {}
setmetatable(api,api)
local mt = {}
ac.damage = api

api.__index = mt

mt.type = '被动技能处理'

--所属者
mt.owner = nil

--事件名
mt.event_name = '单位-攻击出手'

--事件对象
mt.trg = nil

--触发概率
mt.random = nil

--技能对象
mt.skill = nil

--冷却时间
mt.cool = nil

--自定义条件回调
mt.can_damage = nil

--被动开始时回调
mt.damage_start = nil

--触发失败回调
mt.damage_failure = nil

--被动完成时回调
mt.damage_finish = nil



--自定义条件
mt.filters = nil
function mt:add_filter(f)
	table_insert(self.filters, f)
	return self
end

--技能是否可用
function mt:is_enable()
    return self.enable
end

function mt:do_filter()
    for i = 1, #self.filters do
        local filter = self.filters[i]
        if not filter(self) then
            return false
        end
    end
    return true
end

--条件检查
function mt:can_passive(source,target,damage)
    --同一个技能 
    --由于是后注册先执行，因此是一个深度优先。
    --当2个被动技能，触发概率为100时，只会触发一个（因为第一个技能触发时产生伤害，会进行第一个技能的伤害判断，
    --而又因第二个技能不是普通直接return时，导致进入cd,会被return掉）
    if damage and damage.skill and (self.skill == damage.skill or self.skill.name == damage.skill.name) then
        return
    end
    --不是普攻 返回
    if damage and not damage:is_common_attack() then
        return
    end
    local random = self.random or self.skill.chance or 100
    if math_random(100) > random or not self:do_filter() then
        return
    end

    --如果有传技能CD 则先判断是否在冷却中
    if self.cool and self.skill:is_cooling() then
        return
    end

    --如果有传耗蓝
    if self.cost and self.owner:get '魔法' < self.cost then
        return
    end

    return true
end

--触发成功做的处理
function mt:finish()
    self.owner:event_notify('单位-触发被动',self.owner,self.skill,self.target,self.damage)

    --进入CD
    if self.cool then
        self.skill:active_cd()
    end

    --扣蓝
    if self.cost then
        self.owner:add('魔法',-self.owner:get_cost(self.cost) or 0)
    end
end

function mt:init()
    --插入自定义条件
    if self.can_damage then
        self:add_filter(self.can_damage)
    end

    if self.event_name == '单位-杀死单位' or self.event_name == '单位-死亡' or self.event_name == '单位-即将死亡' then
        self.trg = self.owner:event(self.event_name)(function(_,source,target,damage)
            self.source =source
            self.target = target 
            self.damage =damage
            local is_success 
            --被动开始
            if self:can_passive(source,target,damage) then
                is_success = self.damage_start(self.skill,source,target,damage)
                self:finish()
            elseif self.damage_failure then
                --被动失败
                self.damage_failure(self.skill,source,target,damage)
            end
    
            --被动完成
            if self.damage_finish then
                self.damage_finish(self.skill,source,target,damage)
            end
            return is_success
        end)
    else
        self.trg = self.owner:event(self.event_name)(function(_,damage)
            self.damage =damage
            local is_success 
            --被动开始
            if self:can_passive(_,_,damage)  then
                -- print('111',self,self.skill.name,damage,damage.skill,damage.skill and damage.skill.name)
                is_success = self.damage_start(self.skill,damage)
                -- print('222',self,self.skill.name,damage,damage.skill,damage.skill and damage.skill.name)
                self:finish()
            elseif self.damage_failure then
                --被动失败
                self.damage_failure(self.skill,damage)
            end
    
            --被动完成
            if self.damage_finish then
                self.damage_finish(self.skill,damage)
            end
            return is_success
        end)
    end

    self.owner:event '技能-失去'(function(trg,hero,skill)
        if self.removes then
            trg:remove()
            -- print('已经移除',self)
            return
        end
        -- print('技能失去：',self,self.skill,skill)
        -- print('技能失去2：',self,self.skill.name,skill.name)
        if self.skill == skill then  
            self:remove()
            trg:remove()
        end    
    end)

    return self
end

function mt:remove()
    if self.removes then
        return
    end
    self.removes = true
    if self.trg then
        self.trg:remove()
    end

    self.skill = nil
    self.owner = nil
end

function ac.damage(name)
    return function(data)
        if not event_name[name] then
            log.error('不存在该事件', name)
            return
        end
        setmetatable(data, api)

        if not data.skill then
            log.error('damage没有传入skill参数')
            return
        end

        if data.skill.type == 'buff' then
            data.skill = data.skill.skill
        end
        -- print('被动技能的几率：',data.skill.chance)
        data.owner = data.skill.owner
        data.filters = {}
        data.event_name = name
        return data:init()
    end
end


ac.game:event '技能-升级' (function (_,hero,self)
    local hero = self.owner
    local skill = self 
    if skill.event_name and skill.damage_start then 
        if skill.unique_name then 
            --生成buff
            local buff = ac.buff[skill.unique_name]
            if not buff.on_add then 
                buff.cover_type = 0
                buff.keep = true
                function buff:on_add()
                    local target = self.target
                    local hero = self.target

                    self.dmg_trg = ac.damage(skill.event_name){
                        skill = self.skill,
                        cool = true,
                        damage_start = self.damage_start,
                    } 
                    -- print('添加到buff:',self.dmg_trg,self.dmg_trg.skill,self.dmg_trg.skill.owner)
                end

                function buff:on_remove()
                    local target = self.target   
                    -- print('移除buff:',self.dmg_trg,self.dmg_trg.skill)
                    if self.dmg_trg then 
                        self.dmg_trg:remove()
                        self.dmg_trg = nil 
                    end
                end
                function buff:on_cover(new)
                    if new.value then 
                        return new.value > self.value   
                    else
                        return false
                    end
                end
            end
            --添加buff
            skill.unique_buff = hero:add_buff(skill.unique_name){
                value = skill.cover,
                skill = skill,
                damage_start = skill.damage_start,
            }

        else
            if skill.flag_passive then 
                skill.flag_passive:remove()
                skill.flag_passive = nil
            end
            skill.flag_passive = ac.damage(self.event_name){
                skill = skill,
                cool = true,
                damage_start = skill.damage_start,
            } 
        end
    end    
end)

ac.game:event '技能-失去' (function (_,hero,self)
    
    -- print('技能移除:',self.unique_buff)
    if self.flag_passive then 
        self.flag_passive:remove()
        self.flag_passive = nil 
    end
    if self.unique_buff then 
        self.unique_buff:remove()
        self.unique_buff = nil 
    end
end)

local mt = ac.skill['bd']
mt{
	--是否被动
	passive = true,
	--初始等级
	level = 1,
    max_level = 5,
    chance = 50,
    cool =1,
	tip = [[
		|cff00ccff被动|r:
		暴击几率+%暴击几率% % ，暴击伤害+%physical_damage% % 
		会心几率+%physical_rate% % ，会心伤害+%physical_damage% %
		技暴几率+%physical_rate% % ，技暴伤害+%physical_damage% %]],
	--技能图标
	art = [[ReplaceableTextures\PassiveButtons\PASBTNCriticalStrike.blp]],
	--特效
	effect = [[Abilities\Spells\Undead\FreezingBreath\FreezingBreathMissile.mdl]],
	--特效1
	effect1 = [[Abilities\Spells\Other\CrushingWave\CrushingWaveDamage.mdl]],
	--特效4
	effect4 = [[参考赤灵传说的巨浪，移动距离缩短到1000]],
	--范围
	distance = 1000,
	hit_area = 125,
	--概率%
	cool = 1,
	--弹道数量
	num = 1,
	damage_type = '法术',
    event_name = '造成伤害效果'
}
function mt:on_add()
    local skill = self
    local hero = self.owner
    -- ac.damage '造成伤害效果'{
    --     skill = skill,
    --     damage_start = function (_,data )
    --         print(_.name)
    --     end,
    -- }


end    

function mt:damage_start(damage)
    local hero = self.owner
    local skill =self
    local target = damage.target
    local timer
    -- print('伤害开始',skill.num)
    -- print_r(skill)
    local num = skill.num

    for i = 1, num do
        local mvr = ac.mover.line
        {
            source = hero,
            skill = skill,
            model =  skill.effect,
            speed = 600,
            angle = hero:get_point()/target:get_point() + 360/num * i,
            hit_area = skill.hit_area,
            distance = skill.distance,
            high = 120,
            size = 3,
        }
        if mvr then
            function mvr:on_hit(u)
                u:damage
                {
                    source = hero,
                    skill = skill,
                    target = u,
                    damage = skill.damage,
                    damage_type = skill.damage_type,
                }
            end

            function mvr:on_remove()
                if timer then
                    timer:remove()
                end
            end
        end
    end
end