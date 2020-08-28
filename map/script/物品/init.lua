require '物品.装备'
require '物品.消耗品'
require '物品.杂类'
require '物品.商店'
require '物品._常用'
require '物品.物品技能'
require '物品.物品技能2'
require '物品.存档随机物品'


local unit = require 'types.unit'



--创建技能物品
function ac.item.create_skill_item(name,poi,is)
    -- 技能需要被添加时部分信息才能被调用
    local skill = ac.dummy:add_skill(name,'隐藏')
    local tip = skill:get_simple_tip(ac.dummy,1)
    local title = skill:get_title(ac.dummy,1)
    local art = skill:get_art()
    local gold = skill.gold
    local color = skill.color
    local check_hecheng = skill.check_hecheng
    skill:remove()

    local skl = ac.skill['学习技能']
    skl._model = ac.skill_model[color]
    local item = ac.item.create_item('学习技能',poi,is)
    item.gold = gold
    item.color = color
    item.name = name
    item:set_name(name)
    item.skill_name = name
    item.tip =  (tip or '') .. '|cff808080当功法学满后，点击可替换已学功法，且功法等级可被继承|r' 
    item:set_art(art)
    item.art = art
    item.check_hecheng = skill.check_hecheng
	--混合图标处理
	local blend = item.blend or ac.blend_file[item.color or 'nil'] 
	if blend then 
		item.owner = ac.dummy
		item:add_blend(blend, 'frame', 2)
		item.owner = nil
    end
    
	--设置技能模型
	-- if item.color and item.cus_type == '技能' then 
	-- 	-- print('改变技能模型',item.color,ac.skill_model[item.color])
	-- 	item._model = ac.skill_model[item.color]
    -- end
    
    item:set_tip(item.tip)
    -- item:set_model() --刷新model
    
    item.item_type = '消耗品'
    --设置使用次数
    item:set_item_count(1)
    
    return item
    -- item:update()
    -- item:update_ui()
end 

--给英雄添加技能物品
--默认是 满格掉落地上，从商店购买时才阻止返回
--英雄死亡时，添加物品没法添加
function ac.item.add_skill_item(it,hero,source)
	if type(it) =='string'  then 	
		it = ac.item.create_skill_item(it,nil,true)
		it:hide()
		it.recycle = true
    end	
    hero:add_item(it,source)
    
    return it
end 

function unit.__index:add_skill_item(it,source)
	if type(it) =='string'  then 	
		it = ac.item.create_skill_item(it,nil,true)
		it:hide()
		it.recycle = true
    end	
    self:add_item(it,source)  
    return it
end    
