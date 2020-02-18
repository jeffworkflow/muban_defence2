--起始id
--存档物品库
local item_list = {
    --名字 = 生成个数 装备类型 装备等级 图标 基础属性
['霓光刀']={num=20,type1 = '武器',lv = 1,art = 'yiji1.blp',attr = {['攻击']=2000000}},
['霓光甲']={num=20,type1 = '衣服',lv = 1,art = 'yiji2.blp',attr = {['护甲']=1000}},
['霓光面罩']={num=20,type1 = '头盔',lv = 1,art = 'yiji3.blp',attr = {['技能基础伤害']=1000000}},
['霓光靴']={num=20,type1 = '鞋子',lv = 1,art = 'yiji4.blp',attr = {['移动速度']=25,['护甲']=500}},
['霓光腰带']={num=20,type1 = '腰带',lv = 1,art = 'yiji5.blp',attr = {['生命上限']=3000000}},
['霓光之钩']={num=20,type1 = '手套',lv = 1,art = 'yiji6.blp',attr = {['攻击速度']=25,['护甲']=500}},

['血腥三月镰']={num=20,type1 = '武器',lv = 2,art = 'erji1.blp',attr = {['攻击']=4000000}},
['血腥三月甲']={num=20,type1 = '衣服',lv = 2,art = 'erji2.blp',attr = {['护甲']=2000}},
['血腥三月面罩']={num=20,type1 = '头盔',lv = 2,art = 'erji3.blp',attr = {['技能基础伤害']=2000000}},
['血腥三月鞋']={num=20,type1 = '鞋子',lv = 2,art = 'erji4.blp',attr = {['移动速度']=50,['护甲']=1000}},
['血腥三月腰带']={num=20,type1 = '腰带',lv = 2,art = 'erji5.blp',attr = {['生命上限']=6000000}},
['血腥三月护手']={num=20,type1 = '手套',lv = 2,art = 'erji6.blp',attr = {['攻击速度']=50,['护甲']=1000}},

['银霜法杖']={num=20,type1 = '武器',lv = 3,art = 'sanji1.blp',attr = {['攻击']=8000000}},
['银霜甲']={num=20,type1 = '衣服',lv = 3,art = 'sanji2.blp',attr = {['护甲']=4000}},
['银霜头盔']={num=20,type1 = '头盔',lv = 3,art = 'sanji3.blp',attr = {['技能基础伤害']=4000000}},
['银霜鞋']={num=20,type1 = '鞋子',lv = 3,art = 'sanji4.blp',attr = {['移动速度']=100,['护甲']=2000}},
['银霜腰带']={num=20,type1 = '腰带',lv = 3,art = 'sanji5.blp',attr = {['生命上限']=12000000}},
['银霜护手']={num=20,type1 = '手套',lv = 3,art = 'sanji6.blp',attr = {['攻击速度']=100,['护甲']=2000}},

['菲普斯的法杖']={num=20,type1 = '武器',lv = 4,art = 'siji1.blp',attr = {['攻击']=16000000}},
['菲普斯的战甲']={num=20,type1 = '衣服',lv = 4,art = 'siji2.blp',attr = {['护甲']=8000}},
['菲普斯的面具']={num=20,type1 = '头盔',lv = 4,art = 'siji3.blp',attr = {['技能基础伤害']=8000000}},
['菲普斯的鞋子']={num=20,type1 = '鞋子',lv = 4,art = 'siji4.blp',attr = {['移动速度']=200,['护甲']=4000}},
['菲普斯的护腰']={num=20,type1 = '腰带',lv = 4,art = 'siji5.blp',attr = {['生命上限']=24000000}},
['菲普斯的护手']={num=20,type1 = '手套',lv = 4,art = 'siji6.blp',attr = {['攻击速度']=200,['护甲']=4000}},
}
--起始id
local start_id = 1 
local max = 0
for name, data in pairs(item_list) do 
    max = data.num * 4 + max
end   
max = max + start_id
local ids = {}
for i=start_id,max do 
	ids[i] = i
end	

for i=start_id,max do 
	local randindex = math.random(start_id,max)
	local temp = ids[randindex];
	ids[randindex] = ids[i];
	ids[i] = temp;
end

-- for i = start_id,max do 
--     print(i,ids[i])
-- end    


local com_func = {
    -- '（0.6+装备等级*0.4）*特殊属性加成b（查看工作表“品质”）'
    ['特殊属性百分比'] = {0.6,0.4},
    -- '（（装备等级-1）*6+（装备品质-1）*3'
    ['地图等级需求'] = {6,3},
    --装备评分公式=100*等级*（主要属性波动百分比）+100*附加属性数量*（0.6+装备等级*0.4）*特殊属性加成b（查看工作表“品质”）
    ['装备评分'] = {100,100},
}

local color_attr = {
--品质 = 品质数值 物品模型 最小词条数 最大词条数 词条值因数
['白'] = {1,[[File00000376 - W.mdx]],0,1,1,2},
['蓝'] = {2,[[File00000376 - B.mdx]],2,3,0.6,2},
['金'] = {3,[[File00000376 - Y.mdx]],4,5,0.5,2},
['暗金'] = {4,[[File00000376 - RC.mdx]],6,8,0.45,2},
}

local max_attribute = {
	['杀敌数加成']= 10,
['木头加成']= 10,
['魔丸加成']= 10,
['物品获取率']= 10,
['吸血']= 10,
['暴击几率']= 2.5,
['技暴几率']= 2.5,
['暴击伤害']= 5,
['技暴伤害']= 5,
['全伤加深']= 7.5,
['减伤']= 2.5,
['免伤几率']= 2.5,
['闪避']= 2.5,
['每秒回血']= 5,
['触发概率加成']= 5,
['技能冷却']= 5,
['攻击速度']= 25,
['分裂伤害']= 20,
['物理伤害加深']= 15,
['技能伤害加深']= 15,
['对BOSS额外伤害']= 7.5,
['全属性']= 500000,
['杀怪加全属性']= 20,
['攻击加全属性']= 120,
['每秒加全属性']= 400,
['力量']= 1000000,
['杀怪加力量']= 40,
['攻击加力量']= 240,
['每秒加力量']= 800,
['敏捷']= 1000000,
['杀怪加敏捷']= 40,
['攻击加敏捷']= 240,
['每秒加敏捷']= 800,
['智力']= 1000000,
['杀怪加智力']= 40,
['攻击加智力']= 240,
['每秒加智力']= 800,
['攻击']= 2000000,
['杀怪加攻击']= 80,
['每秒加攻击']= 1600,
['护甲']= 1000,
['每秒加护甲']= 1,
['攻击减甲']= 35,
['攻击间隔']= -0.03,
['生命恢复']= 350000,
['攻击回血']= 350000,
['杀怪回血']= 350000,
['减少周围护甲']= 200,
['伤害减少']= 350000,
['攻击距离']= 25,
['移动速度']= 25,
['多重射']= 1,

}

local base_attr =[[
力量 敏捷 智力 全属性 生命 生命上限 生命恢复 生命脱战恢复 魔法 
魔法上限 魔法脱战恢复 攻击 护甲 魔抗 攻击间隔 攻击距离 移动速度 减耗 破甲 
破魔 护盾 技能基础伤害 多重射 额外连锁 额外范围 攻击回血 杀怪回血 基础金币 积分加成 熟练度加成
召唤物 
杀怪加力量 杀怪加敏捷 杀怪加智力 杀怪加全属性 杀怪加护甲 杀怪加攻击
每秒加金币 每秒加木头 每秒加力量 每秒加敏捷 每秒加智力 每秒加全属性 每秒加护甲 每秒加攻击
攻击加金币 攻击加木头 攻击加力量 攻击加敏捷 攻击加智力 攻击加全属性 攻击加护甲
攻击减甲
减少周围护甲
额外杀敌数
每秒加魔丸 
多重暴击
]]
--字符串是否包含 字符串 字符串 字符串
function finds(str,...)
	local flag = false
	if not str or type(str) =='table' or  type(str) =='function' then 
		return flag
	end	
	for key , value in pairs{...} do
		local _, q=string.find(str, value)
		if _ then 
			flag= true
			break
		end	
	end
	return flag
end

function bignum2string(value)
	local value = tonumber(value)
	if type(value) == 'string' then 
		return 
    end	
    --每个装备的评分
    if value < 10000 then
        return math.tointeger(value) or ('%.2f'):format(value)
	elseif value < 100000000 then
        return value % 10000 == 0 and ('%.0f'):format(value/10000)..'万' or ('%.1f'):format(value/10000)..'万'
    else
        return value % 100000000 == 0 and ('%.0f'):format(value/100000000)..'亿' or ('%.1f'):format(value/100000000)..'亿'
    end
end

local function lni_item()
	local lni_str = ''
    local temp_max_attr ={}
    local str = [[['default']
item_type = '消耗品'
category = '存档']]
    lni_str = lni_str .. str..'\n'
	for key,val in pairs(max_attribute) do
		table.insert(temp_max_attr,{key,val})
	end
	
	for name,data in pairs(item_list) do
        --每个物品 的物品数量  ['霞光刀']={num=20,type1 = '武器',lv = 1,art = 'al.tip',['攻击']=2,['护甲'] = 3},
        for i=1,data.num do
            for color,color_tab in pairs(color_attr) do 
                lni_str = lni_str .. "['"..name..ids[start_id].."']"..'\n'
                lni_str = lni_str .. "s_id = "..ids[start_id]..""..'\n'
                start_id = start_id + 1
                lni_str = lni_str .. "title = "..name..""..'\n'
                lni_str = lni_str .. "type1 = '"..data.type1.."'"..'\n'
                lni_str = lni_str .. "lv = "..data.lv..""..'\n'
                lni_str = lni_str .. "art = '"..data.art.."'"..'\n'
                --主要属性浮动%
                local main_attr_per = math.random(50,150)
                lni_str = lni_str .. "main_attr_per = "..main_attr_per..""..'\n'

                --处理主要属性
                local main_attr_tab = {}
                for k1,v1 in pairs(data.attr) do 
                    v1 = v1 * main_attr_per/100 
                    v1 = math.tointeger(v1) or ('%.2f'):format(v1)
                    table.insert(main_attr_tab,{k1,v1})
                end    

                --处理color赋值 品质数值 物品模型 最小词条数 最大词条数 词条值因数
                lni_str = lni_str .. "color = '"..color.."'"..'\n'
                lni_str = lni_str .. "color_lv = "..color_tab[1]..""..'\n'
                lni_str = lni_str .. "specail_model = [["..color_tab[2].."]]"..'\n'
                lni_str = lni_str .. "min_attr_num = "..color_tab[3]..""..'\n'
                lni_str = lni_str .. "max_attr_num = "..color_tab[4]..""..'\n'
                lni_str = lni_str .. "attr_a = "..color_tab[5]..""..'\n'
                lni_str = lni_str .. "model_size = "..color_tab[6]..""..'\n'

                --随机词条：每个物品的 词缀数,重复的话，重复的数值加上去
                local attr_num = math.random(color_tab[3],color_tab[4])
                lni_str = lni_str .. "attr_num = "..attr_num..""..'\n'

                local item = {}
                for n = 1, attr_num do
                    local rd = math.random(1,#temp_max_attr)
                    local key1 = temp_max_attr[rd][1] --取到特殊属性 key
                    local val1 = temp_max_attr[rd][2] --取到特殊属性 val
                    --特殊属性百分比 '（0.6+装备等级*0.4）*特殊属性加成b（查看工作表“品质”）'
                    local vv = val1 * (com_func['特殊属性百分比'][1] + data.lv*com_func['特殊属性百分比'][1])*color_tab[5]   
                    vv = math.tointeger(vv) or ('%.2f'):format(vv)
                    local ok = true
                    for i,tab in ipairs(item) do 
                        if tab[1] == key1 then
                            ok = false 
                            if tab[2]> vv then
                                tab[1] = vv
                            end
                        end 
                    end        
                    if ok then 
                        table.insert(item,{key1,vv})
                    end    
                end	
                --装备评分 装备评分公式=100*等级*（主要属性波动百分比）+100*附加属性数量*（0.6+装备等级*0.4）*特殊属性加成b（查看工作表“品质”）
                local pf = com_func['装备评分'][1] * data.lv * main_attr_per/100 + com_func['装备评分'][2]*attr_num*(com_func['特殊属性百分比'][1] + data.lv*com_func['特殊属性百分比'][1])*color_tab[5]
                pf = string.format('%.f',pf)
                lni_str = lni_str .. "pf = "..pf..""..'\n'
                --地图等级需求 '（（装备等级-1）*6+（装备品质-1）*3'
                local need_map_level = (data.lv-1)*com_func['地图等级需求'][1] + (color_tab[1]-1)*com_func['地图等级需求'][2]
                
                lni_str = lni_str .. "need_map_level = "..need_map_level..""..'\n'

                --生成tip
                lni_str = lni_str .. 'tip = [['..'\n'
                lni_str = lni_str .. '|cffffe799评分：|r'..pf..'\n'
                lni_str = lni_str .. '%map_level_tip%'..'\n'
                lni_str = lni_str .. '|cffffe799属性：|r'..'\n'
                for i,tab in ipairs(main_attr_tab)do 
                    local per_str = finds(base_attr,tab[1])  and '' or '%'
                    if tonumber(tab[2]) < 0 then 
                        lni_str = lni_str  .."|cffffff00"..bignum2string(tab[2])..per_str..' |r'.. tab[1] ..'\n'
                    else     
                        lni_str = lni_str  .."|cffffff00+"..bignum2string(tab[2])..per_str..' |r'.. tab[1] ..'\n'
                    end    
                end
                if #item > 0 then 
                    lni_str = lni_str .. ''
                    -- lni_str = lni_str .. '\n|cffffe799额外属性：|r'..'\n'
                end
                for i,tab in ipairs(item) do    
                    local per_str = finds(base_attr,tab[1])  and '' or '%'
                    if tonumber(tab[2]) < 0 then 
                        lni_str = lni_str  .."|cffffff00"..bignum2string(tab[2])..per_str..' |r'.. tab[1] ..'\n'
                    else     
                        lni_str = lni_str  .."|cffffff00+"..bignum2string(tab[2])..per_str..' |r'.. tab[1] ..'\n'
                    end    
                end
                lni_str = lni_str .. '\n|cff00ff00点击进行穿戴|cffff0000（只存档穿戴后的装备）|cff00ff00，按Tab查看效果'..'\n'
                lni_str = lni_str .. ']]'..'\n'

                --合并属性条
                local temp = {}
                for i,tab in ipairs(main_attr_tab) do 
                    table.insert(item,tab)
                end 
                for i,tab in ipairs(item) do 
                    local key = tab[1]
                    local val = tab[2]
                    if not temp[key] then 
                        temp[key] = val
                    else 
                        temp[key] = temp[key] + val
                    end    
                end    
                --生成 属性 lni 
                lni_str = lni_str .. "attr = {"..'\n'
                for key,val in pairs(temp)do
                    lni_str = lni_str .. "'"..key .."' = " .. val ..',\n'
                end
                lni_str = lni_str .. "}"
                --lni_str = lni_str .. "'"..key1 .."' = " .. random_val ..'\n'
                lni_str = lni_str .. '\n'
            end    
		end	
	end
	print(lni_str)

end

local function main()
	 lni_item()

end    

main()

