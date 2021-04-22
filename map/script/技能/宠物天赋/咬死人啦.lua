local mt = ac.skill['咬死人啦']
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
	skill_type = "资源+成长",
	--耗蓝
	cost = 0,
	--冷却时间
    cool = 180,
    target_type = ac.skill.TARGET_TYPE_POINT,
    target_data = "联盟 玩家单位",
    area = 200,
    range = 1000,
	--作用在人身上
	strong_hero = true,
	--属性加成
 ['攻击%'] = 20,
	--介绍
	tip = [[ 
|cffffe799【攻击】+20%

|cff00ff00经常咬死队友的宠物，使主人赔了不少医药费|cffff0000（减少500木头，+3%全伤加深），|cffffff00队友增加500木头

]],
	--技能图标
	art = [[douniuquan.blp]],
	--特效
    effect = [[Abilities\Spells\NightElf\shadowstrike\ShadowStrikeMissile.mdl]],
    effect2 = [[Abilities\Spells\NightElf\shadowstrike\ShadowStrike.mdl]],
    --全伤加深
    value = 3,
    --木头
    ex_wood = 500,
    --定身时间
    time = 15 
}
function mt:on_add()
    local skill = self
    local hero = self.owner
end
function mt:on_cast_start()
    local skill = self
    local p = self.owner.owner
    local peon = p.peon
    local hero = p.hero

    local target = ac.selector():in_range(self.target,self.area):allow_god():is_type('宠物'):is_not(peon):random()
    if not target  then
        p:sendMsg('只能对宠物使用',5)
        ac.wait(0,function()
            self:set_cd(0)
        end)
        return 
    end

    --发射投射物
    local mvr = ac.mover.target
    {
        source = self.owner,
        target = target,
        model = skill.effect,
        speed = 1000,
        height = 110,
        skill = skill,
        on_finish = function(self)
            ac.player.self:sendMsg('|cffebb608【系统】 |cff00ffff'..p:get_name()..'的宠物 |cff00ff00袭击了 |cff00ffff'..target.owner:get_name()..' 的宠物 |cff00ff00，赔偿了500木头',5)
            target:add_buff '定身'{
                time = skill.time,
                ref = 'overhead',
                model = skill.effect2
            }
            hero:add('全伤加深',skill.value)
            --目标加木头
            target.owner:add_wood(skill.ex_wood)
            --自己减木头
            p:add_wood(-skill.ex_wood)
        end
    }
   

end
function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
