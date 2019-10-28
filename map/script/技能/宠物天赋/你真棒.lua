local mt = ac.skill['你真棒']
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
	skill_type = "物品",
	--被动
	passive = true,
	--耗蓝
	cost = 100,
	--忽略技能冷却
	ignore_cool_save = true,
	--作用在人身上
	strong_hero = true,
	--属性加成
 ['杀怪加全属性'] = {10,20,30,40,50},
 ['护甲'] = 25,
 ['伤害减少'] = 5000,
	--介绍
	tip = [[|cffffff00【杀怪加全属性】+10*Lv
【护甲】+500
【伤害减少】+5000|r

|cff00bdec被动效果：攻击10%几率造成范围技能伤害
伤害公式：（力量*10+10000）*Lv|r

|cff00ff00凌波微步：按D向鼠标方向飘逸500码距离|r]],
	--技能图标
	art = [[ReplaceableTextures\CommandButtons\BTNHeroMountainKing.blp]],
	--特效
	effect = [[jn_tf1.mdx]],
}
function mt:on_add()
    local skill = self
    local hero = self.owner
end
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
