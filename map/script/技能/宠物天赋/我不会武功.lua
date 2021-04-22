local mt = ac.skill['我不会武功']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    is_order= 1,
    --最大等级
   max_level = 1,
	--流派
	skill_type = "技能触发类",
	--耗蓝
	cost = 0,
	--忽略技能冷却
	ignore_cool_save = true,
	--作用在人身上
	strong_hero = true,
	--属性加成
 ['攻击距离'] = 50,
	--介绍
tip = [[ 
|cffffe799攻击距离+50

|cff00ff00点击送给你一本|cffffff00随机功法

]],
	--技能图标
	art = [[buhuiwugong.blp]],
    --冷却
    cool = 300,
}
function mt:on_cast_start()
    local hero =self.owner
    local p = hero.owner  
    local list = ac.all_skill
    --添加给购买者
    local name = list[math.random(#list)]
    local new_skl = ac.item.add_skill_item(name,hero)
    p:sendMsg('|cffebb608【系统】|r |cff00ff00获得了'..new_skl.color_name..'|r',4)
end




