
ac.creep_list = {}
for name,data in pairs(ac.table.UnitData) do 
    if data.creep then 
        --支持二维数组
        if type(data.creep[1]) == 'table' then 
            for i,tab in ipairs(data.creep) do 
                table.insert(ac.creep_list,tab)
            end   
        else 
            table.insert(ac.creep_list,data.creep)
        end    
    end 
end 

table.sort(ac.creep_list,function (a,b)
    return a[2] < b[2]
end)
-- print_r(ac.creep_list)


local table = table
local rect = require 'types.rect'
local creeps = {}
creeps.group = {
	--区域,怪名*1,重生时间,面向,出生时间
	-- {'测试','甲虫*30',2},
    
	-- {'sjjh1', '鸡*15', 10, 2},
	-- {'sjjh2', '鸡*15', 10, 2},
    -- {'sjjh3', '鸡*15', 10, 2},
}
--插入 lua物编 刷怪信息
for i,data in ipairs(ac.creep_list) do 
    table.insert(creeps.group,data)
end    

--开始刷野
function creeps.start()
	--刷野玩家
	local creep_player = ac.player[13]
	--对每个野怪点分别计算
	for _, data in ipairs(creeps.group) do
		local rect_name, creeps_names, revive_time,face, start_time,player_id,fall_item = table.unpack(data)
		--刷怪区域
		local rct = rect_name == '测试' and ac.rect.create(1000,-500,2000,500) or rect.j_rect(rect_name)
		--野怪单位组
        local creep_groop = {}
        local creeps_datas = {}
        local fall_datas = {}
		--野怪数据
        for k,v in creeps_names:gmatch '(%S+)%*(%d+%s-)' do
            creeps_datas[k]=v
        end
        --掉落物品
        if fall_item then
            for k,v in fall_item:gmatch '(%S+)%*(%d+%s-)' do
                fall_datas[k]=v
            end
        end    
		--创建该野怪点的野怪
		local function create()
            for k,v in sortpairs(creeps_datas) do 
                local name  = k
                local max_cnt = tonumber(v)
                local count = max_cnt - (#creep_groop or 0)
                for i = 1, count do
                    local point = max_cnt == 1 and rct:get_point() or rct:get_random_point()
                    local u = ac.player(player_id or 13):create_unit(name, point, 270)
                    -- print(name,u)
                    --不主动进攻
                    -- u:add_ability 'A00V'
                    -- u:set_class('模拟死亡') --设置为模拟死亡
                    --设置面向角度
                    u:set_facing(face or 0)
                    --将单位添加进单位组
                    table.insert(creep_groop, u)
                    --监听这个单位挂掉
                    u:event '单位-死亡' (function(_,unit,killer)
                        --掉落物品
                        if fall_item then
                            for k,v in sortpairs(fall_datas) do 
                                for i=1,v do 
                                    ac.item.create_item(k,u:get_point())
                                end    
                            end    
                        end    
                        for _, uu in ipairs(creep_groop) do
                            if uu.handle == unit.handle then 
                                table.remove(creep_groop,_)
                                break
                            end    
                        end
                        unit:remove() --立即删除 不产生尸体
                    end)  
                end
            end    
		end
        
		--刷第一波野
        ac.wait((start_time or 0) * 1000, create)
        --每2秒检测一次，不满最大单位数量，就补充
        ac.loop((revive_time or 0) *1000,function(t)
            if ac.flag_endless then 
                t:remove()
                return
            end    
            create()
        end)
	end
end
--难度选择完，加载刷怪
ac.game:event '选择难度' (function(_,g_game_degree_name)
    creeps.start()
end)












