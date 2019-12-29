
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
    '神魂修炼','古老的铭文',nil,nil,
    nil,nil,nil,nil,
    '吞噬神丹','彩蛋','超级彩蛋',
}

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

local mt = ac.skill['扭蛋']
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