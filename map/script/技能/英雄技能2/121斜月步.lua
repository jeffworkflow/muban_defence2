local mt = ac.skill['斜月步']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    --最大等级
   max_level = 20,
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 500,
	--技能品阶
	color = "黄阶",
	--技能类型
	skill_type = "主动,无敌",
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 25,
	--施法范围
	area = 500,
	--属性加成
['免伤几率'] = {5.1,7},
	--介绍
	tip = [[

|cffffff00【免伤几率】+（5+0.1*Lv）%

|cff00bdec【主动施放】使用技能后，接下来(3+0.1*Lv)次伤害必定免伤

]],
	--技能图标
    art = [[bmfy.blp]],
	--特效4
	effect4 = [[参考赤灵的不灭佛隐，同时只能触发一个，不能叠加]],
    value = {3.1,5},
}
function mt:on_cast_start()
    local skill = self
    local hero = self.owner
    -- self.damage_cnt = 0
    self.trg = hero:add_buff('不灭佛隐')
    {
        value = self.value,
        source = hero,
        skill = self,
        effect = self.effect,
    }
end    
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end

local mt = ac.buff['不灭佛隐']
mt.cover_type = 0
mt.cover_max = 1
-- mt.keep = true

function mt:on_add()
    local target = self.target
    local hero = self.target
    self.eff = target:add_effect('origin',self.effect)
    -- print('注册受伤害事件')
    self.trg = hero:event '受到伤害前效果' (function(trg, damage)
        -- print(self.value)
        if self.value>0 then 
            if not hero.bmfy_flg then 
                hero:add('免伤几率',100)
                hero:add('免伤几率极限',100)
                hero.bmfy_flg = true
            end    
            self.value = self.value -1
        else
            self:remove()
        end    
    end)    

end

function mt:on_remove()
    local target = self.target
    target:add('免伤几率',-100)  
    target:add('免伤几率极限',-100)
    target.bmfy_flg = false  
    if self.eff then self.eff:remove() self.eff = nil end
    if self.trg then self.trg:remove() self.trg = nil end
end
function mt:on_cover(new)
	if new.value > self.value then
		self.value = new.value
	end
	return false
end