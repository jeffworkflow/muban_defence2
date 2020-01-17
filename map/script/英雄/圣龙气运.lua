
--魔法书
local mt = ac.skill['圣龙气运']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[slqy.blp]],
    title = '圣龙气运',
    tip = [[

点击查看 |cff00ff00圣龙气运|r
    ]],
}
mt.skills = {
    '神魂修炼','古老的铭文','套装熔炼','踢馆',
    '突破','狩猎','战就战','吞噬神丹',
    '扭蛋1','彩蛋','超级彩蛋',
    --第六幕、扭蛋、赌博
    --神技入体
}

--'二郎','七郎','判官','马面','牛头','夜叉','辟邪','狐仙','龙女','刑天'
local mt = ac.skill['战就战']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[caidan.blp]],
    title = '战就战',
    tip = [[

点击查看 |cff00ff00战就战|r
    ]],
    
}
mt.skills = {'火炎之力','水寒之力','暴风之力','天雷之力','生命之力','死亡之力','光明之力','黑暗之力','时间之力','空间之力'}

local mt = ac.skill['狩猎']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[caidan.blp]],
    title = '狩猎',
    tip = [[

点击查看 |cff00ff00狩猎|r
    ]],
}
mt.skills = {'狩猎1','狩猎2','狩猎3','狩猎4','狩猎5','狩猎6','狩猎7','狩猎8','狩猎9','狩猎10'}


local mt = ac.skill['突破']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[tupo.blp]],
    title = '突破',
    tip = [[

点击查看 |cff00ff00突破|r
    ]],
}
mt.skills = {'魔胎','半魔','原魔','真魔','天魔','魔主','魔君','魔尊','魔王','魔帝'}

local mt = ac.skill['踢馆']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[tiguan1.blp]],
    title = '踢馆',
    tip = [[

点击查看 |cff00ff00踢馆|r
    ]],
}
mt.skills = {
    '藏宝阁','藏经阁','剑冢','百花宫','龙宫','罪恶城堡'
}

local mt = ac.skill['藏宝阁']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[cangbaoge.blp]],
    title = '藏宝阁',
    tip = [[

点击查看 |cff00ff00藏宝阁|r
    ]],
}
mt.skills = {}

local mt = ac.skill['藏经阁']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[cangjingge.blp]],
    title = '藏经阁',
    tip = [[

点击查看 |cff00ff00藏经阁|r
    ]],
}
mt.skills = {}

local mt = ac.skill['剑冢']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[jianzhong.blp]],
    title = '剑冢',
    tip = [[

点击查看 |cff00ff00剑冢|r
    ]],
}
mt.skills = {}

local mt = ac.skill['百花宫']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[baihuacun.blp]],
    title = '百花宫',
    tip = [[

点击查看 |cff00ff00百花宫|r
    ]],
}
mt.skills = {}

local mt = ac.skill['龙宫']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[longgong.blp]],
    title = '龙宫',
    tip = [[

点击查看 |cff00ff00龙宫|r
    ]],
}
mt.skills = {}

local mt = ac.skill['罪恶城堡']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[lswjs.blp]],
    title = '罪恶城堡',
    tip = [[

点击查看 |cff00ff00罪恶城堡|r
    ]],
}
mt.skills = {}

local mt = ac.skill['扭蛋1']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[gjnd.blp]],
    title = '扭蛋',
    tip = [[

点击查看 |cff00ff00扭蛋|r
    ]],
}
mt.skills = {}

local mt = ac.skill['彩蛋']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[caidan.blp]],
    title = '彩蛋',
    tip = [[

点击查看 |cff00ff00彩蛋|r
    ]],
}
mt.skills = {}

local mt = ac.skill['扭蛋1']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[gjnd.blp]],
    title = '扭蛋',
    tip = [[

点击查看 |cff00ff00扭蛋|r
    ]],
}
mt.skills = {}

local mt = ac.skill['异火']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[huo4.blp]],
    title = '异火',
    tip = [[

点击查看 |cff00ff00异火|r
    ]],
}
mt.skills = {}

local mt = ac.skill['吞噬神丹']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[icon\tunshi.blp]],
    title = '吞噬神丹',
    tip = [[

点击查看 |cff00ff00吞噬神丹|r
    ]],
}
mt.skills = {}

local mt = ac.skill['神技入体']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[guoshi.blp]],
    title = '神技入体',
    tip = [[

点击查看 |cff00ff00神技入体|r
    ]],
}
mt.skills = {}
local all_attr = ''
for attr_k,attr_v in pairs(ac.unit.attribute) do 
    all_attr = all_attr ..attr_k..' '
end    
ac.game:event '玩家-注册英雄' (function(_, player, hero)
	hero:add_skill('圣龙气运','英雄',11)
	-- hero:add_skill('魔法书demo','英雄')
	
	for k,val in ipairs(ac.devil_deal) do
		for _,data in ipairs(val) do    
			local name = data[1]
            local skl = hero:find_skill(name,nil,true)
            for k1,v1 in pairs(skl) do 
                if type(k1) == 'string' and finds(all_attr,k1) then 
                    data[3] = k1
                    data[4] = v1
                    break
                end
            end      

            skl:set('extr_tip','\n|cffFFE799【状态】：|r|cffff0000未激活|r')
			skl:set('tip','%extr_tip% \n\n|cffFFE799【奖励】：|r|cff00ff00+'..(finds(ac.base_attr,data[3]) and data[4] or (data[4]..'%'))..data[3]..'|r\n\n')
			skl:fresh_tip()
		end	
	end	
end)