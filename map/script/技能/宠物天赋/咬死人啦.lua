local mt = ac.skill['咬死人啦']
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
	skill_type = "资源+成长",
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 200,
	--作用在人身上
	strong_hero = true,
	--属性加成
 ['攻击%'] = 20,
	--介绍
	tip = [[
|cffffe799【攻击】+20%

|cff00ff00经常咬死队友的宠物，使主人赔了不少医药费|cffff0000（扣光木头，+2%全伤加深），|cffffff00队友增加500木头

]],
	--技能图标
	art = [[douniuquan.blp]],
	--特效
    effect = [[LascerateNoSound.mdx]],
    --全伤加深
    value = 2,
    --木头
    ex_wood = 500,
}
function mt:on_add()
    local skill = self
    local hero = self.owner
end
function mt:on_cast_start()
    local skill = self
    local p = self.owner.owner
    local peon = self.owner
    local hero = p.hero
    hero:add('全伤加深',self.value)
    for i=1,10 do 
        local pp = ac.player(i)
        if pp:is_player() then 
            --自己清空木头 其他人加500木头
            if pp == p then 
                pp.hero:add_wood(-p.wood)
            else 
                pp.hero:add_wood(self.ex_wood)
            end    
        end  
    end      
            

end
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
