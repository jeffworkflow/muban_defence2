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
	--冷却时间
	cool = 1,
	--伤害
	damage = function(self)
  return (self.owner:get('敏捷')*5+10000)* self.level
end,
	--施法范围
	area = 500,
	--属性加成
 ['移动速度'] = 50,
 ['暴击几率'] = 5,
 ['暴击伤害'] = 100,
	--介绍
	tip = [[|cffffff00【移动速度】+50
【暴击几率】+5%
【暴击伤害】+100%

|cff00ffff【被动效果】攻击10%几率制造幻影（强度和技能等级相关）迷惑对手

|cff00ff00【月球漫步】按D向鼠标方向飘逸500码距离]],
	--技能图标
    art = [[jingxiang.blp]],
    time =8,
    -- attr_mul = function(self)
    --     return 10*self.level
    -- end
}

function mt:atk_pas_shot(target)
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
    local source = hero:get_point()
    -- local u =  hero:create_illusion(source-{math.random(360),100})
    -- if not u then 
    --     print('无法创造出镜像')
    --     return 
    -- end
    local point = source:get_point()-{math.random(360),40}
    local u = p:create_unit('幻象马甲',point)
    if not u then 
        print('无法创造出镜像')
        return 
    end
    u:setColor(0,0,100)
    local attribute ={
        ['攻击'] = hero:get('攻击') * (1.6+self.level * 0.1),
        ['护甲'] = hero:get('护甲') * (0.1+self.level * 0.01),
        ['攻击间隔'] = hero:get('攻击间隔'),
        ['攻击速度'] = hero:get('攻击速度'),
        ['生命上限'] = hero:get('生命上限')* (0.1+self.level * 0.01),
        ['魔法上限'] = hero:get('魔法上限')* (0.8+self.level * 0.05),
        ['生命恢复'] = hero:get('生命恢复')* (0.8+self.level * 0.05),
        ['魔法恢复'] = hero:get('魔法恢复')* (0.8+self.level * 0.05),
        ['移动速度'] = hero:get('移动速度'),

        -- ['分裂伤害'] = hero:get('分裂伤害'),
        -- ['攻击减甲'] = hero:get('攻击减甲'), 
        ['暴击几率'] = hero:get('暴击几率'),
        ['暴击伤害'] = hero:get('暴击伤害'),
        ['会心几率'] = hero:get('会心几率'),
        ['会心伤害'] = hero:get('会心伤害'),

        ['物品获取率'] = hero:get('物品获取率'),
        ['木头加成'] = hero:get('木头加成'),
        ['金币加成'] = hero:get('金币加成'),
        ['杀敌数加成'] = hero:get('杀敌数加成'),
        ['魔丸加成'] = hero:get('魔丸加成'),--新资源

    }

    u:remove_ability 'AInv'
    -- local data = ac.table.UnitData['公共变身单位']
    -- local hero_data = hero.data
    -- --名字
    -- if japi.EXSetUnitArrayString then
    --     japi.EXSetUnitArrayString(base.string2id(data.id), 10, 0, hero_data.production)
    --     japi.EXSetUnitInteger(base.string2id(data.id), 10, 1)
    --     japi.EXSetUnitArrayString(base.string2id(data.id), 61, 0, hero_data.name)
    --     japi.EXSetUnitInteger(base.string2id(data.id), 61, 1)
    -- end

    --模型
    local model = hero:get_slk 'file'
	if not getextension(model) then 
		model = model..'.mdl'
	end	
    u:add_buff "召唤物"{
        model = model,
        time = self.time,
        attribute = attribute,
        -- attr_mul=self.attr_mul,
        remove_target = true,
        skill = self,
        follow = true,
        search_area = 500, --搜敌路径
    }
	
    
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
end