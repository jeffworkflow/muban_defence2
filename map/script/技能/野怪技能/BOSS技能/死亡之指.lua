local mt = ac.skill['死亡之指']
mt{
--施法信息
cast_start_time = 0,
--施法时长
cast_channel_time = 5, 
cast_shot_time = 0,
cast_finish_time = 0.0,

--施法动作
cast_animation = 'spell',
cast_animation_speed = 1,

--初始等级
level = 1,
--技能图标
art = [[icon\card\2\card2_3.blp]],
--技能说明
title = '死亡之指',
tip = [[
	难度3以上添加，参考天空的宝藏的死亡一指，每隔300秒
	（boss出现后，等待300秒后才施放第一次技能）对所有玩家施放一道闪电，
	造成攻击力*500的物理伤害，对基地有效，施法时间5秒（对自己播放一个超级大的预警圈，半径3000）
]],

damage = function(self)
    return self.owner:get('攻击')*500
end,  
--冷却
cool = 300,
area = 3000,
effect = [[Abilities\Spells\Demon\DemonBoltImpact\DemonBoltImpact.mdl]]
-- time = 5
}
-- mt.effect1 = [[Abilities\Spells\Other\ANrm\ANrmTarget.mdl]]

function mt:on_add()
	ac.wait(0,function()
		self:active_cd()
	end)
end

function mt:boss_skill_shot(old_point)
    local skill = self
    local hero = self.owner 
	print('开始释放死亡之指：',self:is_cooling())
    --计算高度
    local function get_hith(u)
        local weapon_launch = u.weapon and u.weapon['弹道出手']
        local launch_z = weapon_launch and weapon_launch[3] or u:get_slk('launchZ', 0)
        launch_z = u:get_high() + launch_z
        return launch_z
    end
    
    --死亡一指
	local function demon_bolt(u)
		if not u then print('单位u 为nil') return end 
		local ln = ac.lightning('TWLN', hero, u,get_hith(hero),get_hith(u))
		ln:fade(-5)
		-- u:add_effect('origin',[[AZ_SSCrow_D.mdx]]):remove()
		u:add_effect('origin',self.effect):remove()
		u:damage{
			source = hero,
			skill = self,
			damage = self.damage
		}
	end
	for i=1,6 do 
		local p = ac.player(i)
		if p.hero then 
			demon_bolt(p.hero) 
		end
	end
	--对基地造成伤害
	demon_bolt(ac.main_unit) 

end

function mt:on_cast_start()
	local hero = self.owner
	local skill =self
	
	--预警圈
	ac.warning_effect_circle
	{
		point = hero:get_point(),
		area = self.area,
		time = self.cast_channel_time,
	}
end

function mt:on_cast_shot()
    self:boss_skill_shot()
end

function mt:on_cast_stop()
    if self.eft then
        self.eft:remove()
	end

end

function mt:on_remove()
    local hero = self.owner
    if self.trg then
        self.trg:remove()
        self.trg = nil
	end
	
    if self.timer then
        self.timer:remove()
        self.timer = nil
	end
end



