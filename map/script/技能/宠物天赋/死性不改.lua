local mt = ac.skill['死性不改']
mt{
    --必填
    is_skill = true,
    --初始等级
    level = 1,
    is_order= 1,
    --最大等级
   max_level = 5,
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 500,
	--流派
	skill_type = "资源",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--忽略技能冷却
	ignore_cool_save = true,
	--作用在人身上
	strong_hero = true,
	--属性加成
 ['会心几率'] = 2.5,
	--介绍
	tip = [[ 
|cffffe799【会心几率】+2.5%

|cffffff00翻倍几率提升了一些，|cff00ff00凉凉是不可能凉凉的，这辈子都不可能凉凉的

]],
	--技能图标
    art = [[dugou.blp]],
    ['木头翻倍概率'] = 2,
    ['魔丸翻倍概率'] = 2,
    ['杀敌数翻倍概率'] = 2,
    ['全属性翻倍概率'] = 1,
}
function mt:on_add()
    local skill = self
    local hero = self.owner
    local p=hero:get_owner()
end
function mt:on_remove()
    local hero = self.owner
    local p=hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
