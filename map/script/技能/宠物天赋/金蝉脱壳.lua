local mt = ac.skill['金蝉脱壳']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    --最大等级
   max_level = 5,
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 500,
	--流派
	skill_type = "成长",
	--耗蓝
	cost = 0,
	--冷却时间
    cool = 450,
    -- cool = 4,
	--作用在人身上
	strong_hero = true,
	--属性加成
 ['全属性%'] = 5,
	--介绍
	tip = [[ 
|cffffe799【全属性】+5%

|cff00ff00获得|cffffff00【5%当前属性值】|cff00ff00的属性

]],
	--技能图标
    art = [[jinchan.blp]],
    effect =[[az_juli01.mdx]]
}
function mt:on_add()
    local skill = self
    local hero = self.owner
end
function mt:on_cast_start()
    local skill = self
    local hero = self.owner
    local p = self.owner.owner
    hero = p.hero
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

end
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
