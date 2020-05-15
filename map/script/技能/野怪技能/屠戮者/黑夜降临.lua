local mt = ac.skill['屠戮_黑夜降临']
mt{
    level = 1,

    --冷却时间
    cool = 10,

    --伤害值
    damage = function(self,hero)
        return hero:get '攻击' * 50
    end,

    --刀刃模型
    model1 = [[tgrtrr.mdx]],
}

function mt:on_add()
    local hero = self.owner
    local skill = self
    for i = 1,12 do
        ac.player[i]:set_day('')
    end
    jass.SetWaterBaseColor(0,0,0,0)
end

function mt:is_conditions()
    local list = ac.selector():in_range(self.owner,1000):is_enemy(self.owner):get()
    if #list == 0 then
        return
    end
    return list[1]
end

--斩击效果
local function heiyejianglin(hero,skill,point)
    ac.effect_ex({model = [[tgrtrr.mdx]],point = point,angle = 45,size = 0.5}):remove()

    ac.wait(150,function()
        ac.effect_ex({model = [[tgrtrr.mdx]],point = point,angle = -45,size = 0.5}):remove()
    end)

    ac.wait(500,function()
        ac.effect_ex({model = [[tgrtrr.mdx]],point = point,size = 1.5,angle = 90}):remove()
    end)

    for _,u in ac.selector():in_range(point,350):is_enemy(hero):ipairs() do
        u:damage{
            source = hero,
            skill = skill,
            damage = skill.damage,
        }
    end
end

function mt:on_cast_start()
    local hero = self.owner
    local skill = self
    local target = self.target
    local point = target:get_point()

    hero:setAllSkillCd(2,4)
    -- ac.effect_ex{model = [[warningring.mdx]],point = point,time = 1,size = 1.3}
    ac.warning_effect_ring
    {
        point = point,
        area = 200,
        time = self.time,
    }
    hero:wait(500,function()
        if not hero:is_alive() then
            return
        end

        hero:setPoint(point)
        heiyejianglin(hero,skill,point)
        --斩击后等待0.5秒创建3个分身冲击其他玩家
        local list = {}
        --先创建预警圈
        for _,u in ac.selector()
            :in_range(hero,1500)
            :is_enemy(hero)
            :is_not(target)
            :add_filter(function(dest)
                return dest:get_point() * hero:get_point() > 300
            end)
            :ipairs() do
            table.insert(list,u:get_point())
            -- ac.effect_ex{model = [[warningring.mdx]],point = u:get_point(),time = 1,size = 1.3}
            ac.warning_effect_ring
            {
                point =  u:get_point(),
                area = 200,
                time = 1,
            }
        end

        --在等待0.6秒后进行冲击
        ac.wait(600,function()
            for _,point in ipairs(list) do
                ac.mover.line{
                    source = hero,
                    skill = skill,
                    speed = 1900,
                    distance = point * hero:get_point(),
                    angle = hero:get_point() / point,
                    model = [[SpiritofVengeance.mdx]],
                    size = 1.5,
                    on_remove = function(mvr)
                        mvr.mover:set_size(0)
                        heiyejianglin(hero,skill,point)
                    end,
                }
            end
        end)
    end)
end

function mt:on_remove()
    local hero = self.owner
    local skill = self
    for i = 1,12 do
        ac.player[i]:set_day(nil)
    end

    jass.SetWaterBaseColor(255,255,255,255)
end