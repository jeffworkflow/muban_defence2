local mt = ac.skill['666']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    --最大等级
   max_level = 1,
	--流派
	skill_type = "技能触发类",
	--耗蓝
	cost = 0,
	--作用在人身上
	strong_hero = true,
	passive = true,
	--属性加成
 ['物理伤害加深系数'] = 20,
 ['黑暗骰子重复获得概率'] = 10,
	--介绍

tip = [[ 
	|cffffe799闪避+10%
	
	|cff00ff00使得英雄，每隔几秒（1-10秒）对周围1000码的随机几个敌人（1-20）个，进行闪电攻击，使用闪电链（Abilities\Spells\Orc\LightningBolt\LightningBoltMissile.mdl）
	

]],
	--技能图标
	art = [[sxs.blp]],
}