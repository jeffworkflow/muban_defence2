local mt = ac.skill['屠戮_屠戮盛宴']
mt{
    level = 1,

    --冷却时间
    cool = 25,

    --持续时间
    time = 10,

    --攻速加成
    speed = 100,

    --伤害值
    damage = function(self,hero)
        return hero:get '攻击' * 2
    end,

    tip = [[获得杀戮者BUFF，持续10秒，增加50%攻速，每次普攻会对周围单位造成 攻击 * 2伤害,抹除普攻伤害，所以不会造成两次伤害]],
}
function mt:is_conditions()
    local list = ac.selector():in_range(self.owner,1000):is_not(ac.main_unit):is_enemy(self.owner):get()
    if #list == 0 then
        return
    end
    return list[1]
end

function mt:on_cast_start()
    local hero = self.owner
    local skill = self
    hero:add_buff '屠戮_屠戮盛宴'
    {
        source = hero,
        skill = skill,
        speed = skill.speed,
        time = skill.time,
    }
end

function mt:on_remove()
    local hero = self.owner
    local skill = self
    
end

local mt = ac.buff['屠戮_屠戮盛宴']
mt.cover_type = 1
mt.cover_max = 1

function mt:on_add()
    local hero = self.target
    local skill = self.skill
    self.eff = hero:add_effect('origin',[[jhmhtdd.mdx]])
    hero:add('攻击速度',self.speed)

    self.trg = hero:event '单位-攻击出手'(function(_,data)
        data.damage = 0
        for _,u in ac.selector():in_range(hero,300):is_enemy(hero):is_not(ac.main_unit):ipairs() do
            u:damage
            {
                source = hero,
                skill = skill,
                damage = skill.damage,
            }
            ac.effect_ex({model = [[Effect_AZEffect3.mdx]],point = u:get_point()}):remove()
        end
    end)
end

function mt:on_remove()
    local hero = self.target
    hero:add('攻击速度',-self.speed)
    if self.eff then
        self.eff:remove()
    end

    if self.trg then
        self.trg:remove()
    end
end