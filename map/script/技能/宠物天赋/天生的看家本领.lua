local mt = ac.skill['天生的看家本领']
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
 ['攻击%'] = 20,
	--介绍
	tip = [[ 
|cffffe799【攻击】+20%

|cff00ff00杀死进攻怪额外获得|cffffff0015木*游戏难度

]],
	--技能图标
    art = [[keji.blp]],
    ex_wood = function()
        return (ac.g_game_degree_attr or 1)*15
    end
}
function mt:on_add()
    local skill = self
    local hero = self.owner
    local p = self.owner.owner
    p.hero:add('杀死进攻怪加木头',self.ex_wood)
end
function mt:on_remove()
    local hero = self.owner
    local p = self.owner.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
    p.hero:add('杀死进攻怪加木头',-self.ex_wood)
end
