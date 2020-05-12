local api = {}
--存放所有需要释放技能的单位
api.list = ac.list()

--检查是否满足施法条件
function api:is(skl)
    
    if not skl.is_conditions then
        return false
    end

	if skl.owner:has_restriction '晕眩' then
		return false
	end

	if skl.owner:has_restriction '时停' then
		return false
    end

	if skl.owner:has_restriction '禁魔' then
		return false
    end
    
    --是否在施法中
    if skl.owner.is_cast_start then
        return false
    end

    if skl.removed then
		return false
    end
    
	if skl:is_cooling() then
		return false
    end

	if not skl:is_enable() then
		return false
    end
    
    --检查该技能的施法条件是否满足
    local target = skl:is_conditions()
    if not target then
        return false
    end

    return target
end

--释放技能
function api:cast_force(u)
    for skl in u:each_skill('隐藏') do
        local target = api:is(skl)
        if target then
            skl:cast_force(target)
        end
    end
end

--添加单位
function ac.unit.__index:add_aut_skill()
    api.list:insert(self)
    self:event '单位-死亡'(function(trg)
        api.list:remove(self)
        trg:remove()
    end)
end

api.time = ac.loop(5000,function()
    for u in api.list:pairs() do
        api:cast_force(u)
    end
end)

ac.game:event '技能-获得'(function(_,hero,self)
    if not self.is_conditions then
        return
    end

    if api.list:has(hero) then
        return
    end

    hero:add_aut_skill()
end)

function ac.unit.__index:setAllSkillCd(i,n)
    self.is_cast_start = true
    local v = math.random(i,n)
    ac.wait(v * 1000,function()
        self.is_cast_start = false
    end)
end