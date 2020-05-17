local mt = ac.skill['屠戮_神魂一击']
mt{
    level = 1,

    --冷却时间
    cool = 15,

    --伤害值
    damage = function(self,hero)
        return hero:get '攻击' * 30
    end,

    --回血比例
    hp = 5,

    tip = [[在所有玩家英雄脚下创建一个预警圈，1秒后对圈内的英雄造成伤害，并且治疗BOSS，治疗量：BOSS的生命上限 * 5%]],

    --镰刀模型
    model = [[AZ_Rotund'jere_R2.MDX]],

    --预警圈模型
    model1 = [[ring_600_2.mdx]],

}
function mt:is_conditions()
    local list = ac.selector():in_range(self.owner,1000):is_enemy(self.owner):is_not(ac.main_unit):get()
    if #list == 0 then
        return
    end
    return list[1]
end

function mt:on_add()
    local hero = self.owner
    local skill = self

    self.trg = hero:event '造成伤害结束'(function(_,data)
        if data.shenhunyiji then
            local hp = hero:get '生命上限' * (skill.hp / 100) / 5
            ac.timer(200,5,function()
                hero:heal{
                    source = hero,
                    heal = hp,
                    skill = skill,
                    red = 82,
                    green = 7,
                    blue = 74,
                    all_player = true,
                }
            end)
        end
    end)
end

function mt:on_cast_start()
    local hero = self.owner
    local skill = self
    local pointList = {}
    hero:setAllSkillCd(3,6)

    for _,u in ac.selector():in_range(hero,2000):is_enemy(hero):is_not(ac.main_unit):ipairs() do
        ac.effect_ex{model = skill.model1,point = u:get_point(),size = 0.4,time = 1}
        table.insert(pointList,u:get_point())
    end

    --ac.effect_ex({model = [[xuesetx.mdx]],point = skill.target:get_point()})

    --如果1秒后还在这里点
    ac.wait(1000,function()
        for _,point in ipairs(pointList) do
            for _,u in ac.selector()
                :in_range(point,200)
                :is_enemy(hero)
                :is_not(ac.main_unit)
                :add_filter(function(dest)
                    return dest.shenhunyiji ~= true
                 end)
                :ipairs() do

                u:follow{
                    source = hero,
                    model = [[AZ_Rotund'jere_R2.MDX]],
                    time = 1.734,
                    skill = skill,
                }

                u.shenhunyiji = true
                --等个1.5秒特效落下来后造成伤害
                u:wait(1500,function()
                    u.shenhunyiji = nil
                    u:damage{
                        source = hero,
                        skill = skill,
                        damage = skill.damage,
                        shenhunyiji = true,
                    }
                end)
            end
        end
    end)
end

function mt:on_remove()
    local hero = self.owner
    local skill = self
    if self.trg then
        self.trg:remove()
    end
end