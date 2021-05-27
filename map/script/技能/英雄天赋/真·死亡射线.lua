local mt = ac.skill['真·死亡射线']
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
	color = "真天赋",
	--技能类型
	skill_type = "天赋",
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 3,
	--伤害
	damage = function(self)
  return (self.owner:get('智力')*15+10002)* self.level
end,
	--施法范围
	area = 500,
	--属性加成
 ['每秒加木头'] = {8,160},
 ['每秒加魔丸'] = {8,160},
 ['物品获取率'] = 100,
 ['每秒回血'] = 20,

	--介绍
	tip = [[|cffffff00【每秒加木头】+8*Lv
【每秒加魔丸】+8*Lv
【物品获取率】+100%
【每秒回血】+20%

|cff00ffff【被动效果】攻击10%几率造成范围技能伤害
【伤害公式】（智力*15+10000）*Lv

|cff00ff00【月球漫步】按D向鼠标方向飘逸500码距离]],
	--技能图标
	art = [[swsx.blp]],
	--特效4
	effect4 = [[参考希尔瓦娜斯的空间锁链]],
	effect =[[AZ_SSCrow_R.mdx]],
	count = 8, --空间连锁数量
}

--计算高度
local function get_hith(u)
    local weapon_launch = u.weapon and u.weapon['弹道出手']
    local launch_z = weapon_launch and weapon_launch[3] or u:get_slk('launchZ', 0)
    launch_z = u:get_high() + launch_z
    return launch_z
end

function mt:atk_pas_shot(target)
    local skill = self
    local hero = self.owner

	local ln = ac.lightning('LN07', hero, target,get_hith(hero),get_hith(target))
	ln:fade(-3)
	target:add_effect('origin',skill.effect):remove()
	target:damage
	{
		source = hero,
		skill = skill,
		damage = skill.damage,
		damage_type = '法术',
	}

	local count = self.count

	--已造成闪电链的单位保存进去
	local group = {}
	table.insert(group,target)
	ac.timer(200,count,function()
		u = ac.selector():in_range(target,700):is_enemy(hero)
		for index, value in ipairs(group) do
			u:is_not(value)
		end
		u = u:random()
		if not u then
			return
		end
		local ln = ac.lightning('LN07', target, u, get_hith(target),get_hith(u))
		ln:fade(-3)
		target = u
		target:add_effect('origin',skill.effect):remove()
		table.insert(group,target)
		target:damage
		{
			source = hero,
			skill = self,
			damage = skill.damage,
			damage_type = '法术',
		}
	end)
end



function mt:on_add()
    local skill = self
    local hero = self.owner
    
	self.trg = hero:event '造成伤害效果' (function(_,damage)
		if not damage:is_common_attack()  then 
			return 
		end 
		--技能是否正在CD
        if skill:is_cooling() then
			return 
		end
        --触发时修改攻击方式
		if math.random(100) <= self.chance then
            self:atk_pas_shot(damage.target)
			--0.5秒后再触发一次
			ac.wait(500,function()
				self:atk_pas_shot(damage.target)
			end)
            --激活cd
            skill:active_cd()
        end
    end)

end    

function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
    if self.trg1 then
        self.trg1:remove()
        self.trg1 = nil
    end
end

