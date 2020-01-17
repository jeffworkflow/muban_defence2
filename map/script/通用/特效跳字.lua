local list = {
    ['物理'] = {'red', 26, 1.7},--后缀 间距 模型大小 红
    ['物爆'] = {'red', 36, 3,45,3.2},--暴击+红
    ['法术'] = {'blue', 30, 2.2},--蓝
    ['法爆'] = {'blue', 36, 3,45,3.2},--暴击+蓝
    ['真伤'] = {'white', 26, 0.8},--白
    ['会心'] = {'yellow', 40, 1.7,55,2.1},--暴击+黄
}

ac.texttag_jump = function(data)
    local point = data.point
    local player = data.player
    local x_base = 0
    local h = nil
    local mst = ''
    local damage = data.str
    local strs = nil
    
    --防卡
    if not player.texttag_jump then
        player.texttag_jump = 0
    end
    player.texttag_jump = player.texttag_jump + 1
    if player.texttag_jump > 10 then 
        return 
    end

    local is_crit = data.is_crit and 'b' or ''
    --大数字转小数字+w
    local val = tonumber(data.str)
    if val < 100000 then
        val =  math.tointeger(val) or ('%.0f'):format(val)
        val = is_crit .. val 
    elseif val < 1000000000 then
        val =  is_crit ..('%.0f'):format(val/10000)..'w'
    else
        val =  is_crit ..('%.0f'):format(val/100000000)..'y' 
    end

    --异步字符串
    if player == ac.player.self or data.target == ac.player.self.hero then
        mst = nil
    end 
    --随机位置
    if math.random(2) == 1 then
        x_base = math.random(-90,-40)
    else
        x_base = math.random(30)
    end 
    --随机高度
    local h = 100 + math.random(-20,50)

    local str = '' .. val
    local name = list[data.type][1]

    for num in string.gmatch(str, "%w") do
        local x = num == 'b' and list[data.type][4] or list[data.type][2]
        local size = num == 'b' and list[data.type][5] or list[data.type][3]
        local x1,y1 = point:get()
        -- print('特效y位置:',y1)
        ac.effect_ex
        {
            point = point - {0,x_base},
            model = mst or (('F2_model\\Mtp_%s_%s.mdx'):format(name,num)),
            high = h,
            size = size,
        }:remove()
        x_base = x_base + x
    end
end
 
ac.game:event '显示伤害特效'(function(_,damage)
    -- print('加载跳字')
    local type = '物理'
    local is_crit 
    --=====================
    --先真实伤害
    if damage.real_damage then
        type = '真伤'
    elseif damage:is_heart_crit() then  
        type = '会心'
        is_crit = true
    elseif damage.damage_type == '物理' then
        type = damage:is_physicals_crit() and '物爆' or '物理'
        is_crit = damage:is_physicals_crit() 
    elseif damage.damage_type == '法术' then
        type = damage:is_spells_crit() and '法爆' or '法术'
        is_crit = damage:is_spells_crit() 
    end
    --伤害特效文字显示
    ac.texttag_jump{
        str = damage.current_damage,
        point = damage.target:get_point(),
        player = damage.source.owner,
        type = type,
        is_crit = is_crit,
        target = damage.target,
    }
end)


--防卡
ac.loop(33,function()
    for i=1,10 do 
        local p = ac.player(i)
        if p:is_player() then 
            p.texttag_jump = 0
        end
    end
end)