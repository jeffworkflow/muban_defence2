
local runtime = require 'jass.runtime'
local hero = require 'types.hero'
local japi = require 'jass.japi'
local slk = require 'jass.slk'

hero.hero_list = {
	'亚瑟王','撼地神牛','不朽剑圣','暗夜寒星',
	'诸葛亮','布莱特','吕布','鬼剑愁',
	'张飞','金克丝','貂蝉','杰拉米',
	'黄盖','关羽','堕落天使','加百列',
	'王昭君','雅典娜','剑仙','天尊',
	'圣斗士','火焰之王'
}
local free_heros = {
	'亚瑟王','撼地神牛','不朽剑圣','暗夜寒星',
    '诸葛亮','布莱特'
}
--初始化免费英雄
for i=1,10 do 
	local p = ac.player(i)
	if p:is_player() then 
		if not p.mall then 
			p.mall = {}
		end 
		for i ,name in ipairs(free_heros) do 
			p.mall[name] = 1	
		end 
	end	
end		

--加载英雄的数据
function load_heroes()
	for _, name in ipairs(hero.hero_list) do
		-- print(name)
		local data = ac.table.UnitData[name]
		-- print(data)
		if data == nil then 
			-- print('缺少单位数据',name,debug.traceback())
		else 
			local hero_data = ac.hero.create(name)(data)
			-- print(hero_data)
			if hero_data ~= nil then 
				hero.hero_list[name] = hero_data
				-- select(2, xpcall(require, runtime.error_handle ,('英雄.%s.init'):format(name)))
				
				hero.hero_list[name].data = hero_data
				hero_data.name = name
				hero_data.file = name
				hero_data.slk = slk.unit[base.string2id(hero_data.id)]

				if japi.EXSetUnitArrayString then
					japi.EXSetUnitArrayString(base.string2id(hero_data.id), 10, 0, hero_data.production)
					japi.EXSetUnitInteger(base.string2id(hero_data.id), 10, 1)
					japi.EXSetUnitArrayString(base.string2id(hero_data.id), 61, 0, hero_data.name)
					japi.EXSetUnitInteger(base.string2id(hero_data.id), 61, 1)
				end
			end
		end	
	end

	--英雄总数
	hero.hero_count = #hero.hero_list
end

load_heroes()







