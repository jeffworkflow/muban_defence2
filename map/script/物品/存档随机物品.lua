--起始id
--存档物品库
local start_id = 1 
local item_list = {
    --名字 = 生成个数 装备类型 装备等级 图标 基础属性
	['刀']={num=20,type1 = '武器',lv = 1,art = 'sshixiezhu.blp',attr = {['攻击']=2,['护甲'] = 3}},
	['甲']={num=20,type1 = '衣服',lv = 1,art = 'sshixiezhu.blp',attr = {['攻击']=2,['护甲'] = 3}},
	

}

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
['白'] = {1,[[daFile00000376 - W.mdx]],0,1,1},
['蓝'] = {2,[[daFile00000376 - B.mdx]],2,3,0.6},
['金'] = {3,[[daFile00000376 - Y.mdx]],4,5,0.5},
['暗金'] = {4,[[daFile00000376 - RC.mdx]],6,8,0.45},
}

local max_attribute = {
	['力量']	=	10000,--默认基础值  
	['敏捷']	=	10000,--默认基础值
	['智力']	=	10000,--默认基础值
	['生命上限']    = 100000,--默认基础值
	['生命恢复']    = 500,--默认基础值
	['魔法上限']    = 100000,--默认基础值
	['魔法恢复']    = 500,--默认基础值
	['攻击']       = 100000, --默认基础值
	['护甲']       = 1000, --默认基础值
	['魔抗']	   = 1000, --默认基础值
	['攻击间隔']    = -0.5, --默认基础值
	['攻击速度']    = 2000, --默认基础值
	['攻击距离']    = 2000, --默认基础值
	['移动速度']    = 522, --默认基础值 
	['减耗']       = 200,  --默认基础值 减少扣篮量
	['吸血']       = 100,  --默认%
	['溅射']       = 100,  --默认%
	['格挡']       = 100,  --默认%
	['格挡伤害']    = 100,  --默认%
	['暴击']       = 100,   --默认%
	['暴击伤害']    = 100,  --默认%
	['破甲']       = 100,  --默认表示为基础值  破加伤害计算时，默认0,增加属性时，若用add[破甲%]，将无效。伤害计算时，直接扣掉点数
	['穿透']       = 100,  --默认表示为% 穿透，伤害计算时，穿透/100 再扣除
	['护盾']       = 1000,  --默认表示为基础值 
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
                lni_str = lni_str .. "['"..name..start_id.."']"..'\n'
                lni_str = lni_str .. "s_id = "..start_id..""..'\n'
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
                lni_str = lni_str .. "pf = "..pf..""..'\n'
                --地图等级需求 '（（装备等级-1）*6+（装备品质-1）*3'
                local need_map_level = (data.lv-1)*com_func['地图等级需求'][1] + (color_tab[1]-1)*com_func['地图等级需求'][2]
                lni_str = lni_str .. "need_map_level = "..need_map_level..""..'\n'

                --生成tip
                lni_str = lni_str .. 'tip = [['..'\n'
                lni_str = lni_str .. '装备评分：'..pf..'\n'
                lni_str = lni_str .. '地图等级需求：'..need_map_level..'\n'
                lni_str = lni_str .. '主要属性：'..'\n'
                for i,tab in ipairs(main_attr_tab)do
                    lni_str = lni_str  .."+"..bignum2string(tab[2])..' '.. tab[1] ..'\n'
                end
                if #item > 0 then 
                    lni_str = lni_str .. '附加属性：'..'\n'
                end
                for i,tab in ipairs(item) do    
                    local per_str = finds(base_attr,tab[1])  and '' or '%'
                    if tab[1] == '攻击间隔' then 
                        lni_str = lni_str  ..""..bignum2string(tab[2])..per_str..' '.. tab[1] ..'\n'
                    else     
                        lni_str = lni_str  .."+"..bignum2string(tab[2])..per_str..' '.. tab[1] ..'\n'
                    end    
                end
                lni_str = lni_str .. '点击进行穿戴，按Tab查看穿戴效果'..'\n'
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

