local mt = ac.skill['分身战刃']
mt{
    --初始等级
    level = 1,
    --最大等级
   max_level = 15,
    --触发几率
   chance = function(self) return 10*(1+self.owner:get('触发概率加成')/100) end,
    --伤害范围
   damage_area = 500,
	--类型
	item_type = "装备",
	--品质
	color = "蓝",
	--图标
	art = [[item\jineng205.blp]],
	--售价
	gold = 1000,
	--被动
	passive = true,
	--耗蓝
	cost = 0,
	--冷却时间
	cool = 2,
	--忽略技能冷却
	ignore_cool_save = true,
	--属性加成
 ['力量'] = 6000000,
 ['移动速度'] = 45,
 ['物理伤害加深'] = 35,

v1 = {6,20},
v2 = {5,8},
	--介绍
	tip = [[|cffffff00+%力量%|r 力量
|cffffff00+%移动速度%|r 移动速度
|cffffff00+%物理伤害加深% |cffffff00%|r 物理伤害加深

|cffffe799【被动-幻影】|r
攻击 %v1% %几率召唤幻影|cffffe799（强度和物品等级相关）|r，持续 %v2% S
]],
	--备注
	effect4 = [[参考技能“不朽镜像”
攻击、护甲、生命上限继承公式：0.5+0.05*Lv
其它属性=英雄]],
	--业务技能代码
}
mt.event_name = '造成伤害效果'
mt.chance = mt.v1
function mt:damage_start(damage)
	self.value = 0.7+0.07*self.level
    self.time = self.v2
    local skill = self
    local hero = self.owner
    local p = hero:get_owner()
    local source = hero:get_point()
    local u =  hero:create_illusion(source-{math.random(360),100})
	
    if not u then 
        print('无法创造出镜像')
        return 
    end
    local attribute ={
        ['攻击'] = hero:get('攻击') * self.value,
        ['护甲'] = hero:get('护甲') * self.value*0.5,
        ['攻击间隔'] = hero:get('攻击间隔'),
	
        ['攻击速度'] = hero:get('攻击速度'),
        ['生命上限'] = hero:get('生命上限')* self.value*0.5,
        ['魔法上限'] = hero:get('魔法上限')* self.value,
	
        ['生命恢复'] = hero:get('生命恢复')* self.value,
        ['魔法恢复'] = hero:get('魔法恢复')* self.value,
        ['移动速度'] = hero:get('移动速度'),
	

        ['暴击几率'] = hero:get('暴击几率'),
        ['暴击伤害'] = hero:get('暴击伤害'),
        ['会心几率'] = hero:get('会心几率'),
        ['会心伤害'] = hero:get('会心伤害'),

	
        ['物品获取率'] = hero:get('物品获取率'),
        ['木头加成'] = hero:get('木头加成'),
        ['金币加成'] = hero:get('金币加成'),
        ['杀敌数加成'] = hero:get('杀敌数加成'),
        ['魔丸加成'] = hero:get('魔丸加成'),
    }
	

    u:remove_ability 'AInv'

    --模型
    local model = hero:get_slk 'file'
	if not getextension(model) then 
		model = model..'.mdl'
	end	
	
    u:add_buff '召唤物'{
        model = model,
        time = self.time,
        attribute = attribute,
        remove_target = true,
        skill = self,
        follow = true,
        search_area = 500, 
    }
end
function mt:on_remove()
    local hero = self.owner
    local p = hero:get_owner()
    if self.trg then
        self.trg:remove()
        self.trg = nil
    end
end
