local mt = ac.skill['妖精之球']
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
	skill_type = "被动,无敌",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 2.5,
	--忽略技能冷却
	ignore_cool_save = true,
	--属性加成
['护甲%'] = 5,
	--介绍
	tip = [[

|cffffff00【护甲】+5%

|cff00bdec【唯一被动】被攻击（55-Lv）次后开启一下技能|r|cffffff00（0.5秒内免疫任何伤害）|r

]],
	--技能图标
    art = [[xwsy.blp]],
    wtf_cnt = function(self)
        return 55-self.level
    end,
    time = 0.5,
	--特效4
	effect4 = [[唯一被动]],
}
function mt:on_upgrade()
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
    self.trg = hero:add_buff '唯一免伤几率' {
        value = skill.wtf_cnt,
        skill = skill
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

local mt = ac.buff['唯一免伤几率']
mt.cover_type = 1
mt.cover_max = 1
function mt:on_add()
    local target = self.target
    local hero = self.target
    local skill = self.skill
    self.trg = hero:event '受到伤害效果' (function(trg, damage)
        -- if skill.name == '妖精之球' then
        --     print('测试升级时，有没有多注册受伤害事件')
        -- end
        if skill:is_cooling() then 
            return 
        end    
        local cast = skill:create_cast()
        -- print('受到伤害',self.wtf_cnt)
        if skill.wtf_cnt>0 then 
            skill.wtf_cnt = skill.wtf_cnt -1
        else
            --添加免伤buff
            self.buff = hero:add_buff('免伤几率')
            {
                value = 100,
                time = skill.time,
                source = hero,
                skill = skill,
            }
            --创建施法表，重新取施法时的数据
            skill.wtf_cnt = cast.wtf_cnt
            skill:active_cd()
        end    
    end)    
end

function mt:on_remove()
    local target = self.target 
    if self.buff then self.buff:remove() self.buff = nil   end
    if self.trg then self.trg:remove() self.trg = nil end
end
function mt:on_cover(new)
	return new.value < self.value
end


local mt = ac.buff['免伤几率']
mt.cover_type = 1
mt.cover_max = 1
-- mt.keep = true

function mt:on_add()
    local target = self.target
    local hero = self.target
    target:add('免伤几率',self.value)  
    target:add('免伤几率极限',self.value)  
end

function mt:on_remove()
    local target = self.target 
    target:add('免伤几率',-self.value)   
    target:add('免伤几率极限',-self.value)   
end
function mt:on_cover(new)
	return new.value > self.value
end
