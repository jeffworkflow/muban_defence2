local mt = ac.skill['不朽镜像']
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
	color = "天赋",
	--技能类型
	skill_type = "天赋",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--伤害
	damage = function(self)
  return (self.owner:get('敏捷')*5+10000)* self.level
end,
	--属性加成
 ['移动速度'] = 50,
 ['暴击几率'] = 5,
 ['暴击伤害'] = 50,
	--介绍
	tip = [[|cffffff00【移动速度】+50
【暴击几率】+5%
【暴击伤害】+50%

|cff00ffff【被动效果】攻击10%几率制造幻影迷惑对手，持续8s
幻影属性=英雄全属性*（1+0.1*lv）
幻影同时继承英雄的生命/护甲/分裂伤害/攻击减甲/暴击几率/暴击伤害/会心几率/会心伤害/物品获取率/木头加成/金币加成/杀敌数加成/魔丸加成

|cff00ff00【月球漫步】按D向鼠标方向飘逸500码距离]],
	--技能图标
	art = [[jingxiang.blp]],
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
