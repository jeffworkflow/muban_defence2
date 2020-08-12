--破损的箱子
ac.wait(30,function()
    for i=1,10 do 
        local rect = ac.rect.j_rect('xiangzi'..i)
        local u = ac.player(16):create_unit('破损的箱子',rect)
        u:add_restriction('魔免')
        u:add_restriction('定身')
        u:event '受到伤害开始'(function(_,damage)
            if not damage:is_common_attack() then 
                return true
            end
        
        end)
        
        u:event '单位-死亡'(function(_,unit,killer)
            local p = killer.owner
            local hero =p.hero
            hero:add('力量%',1)
            hero:add('敏捷%',1)
            hero:add('智力%',1)
            p:sendMsg('|cffebb608【系统】|r|cff00ff00隐藏的箱子被打爆了，恭喜获得|cffff0000 全属性+1%',5)

            --彩蛋
            p.kill_psdxz = (p.kill_psdxz or 0) +1
            if p.kill_psdxz == 5 then 
                --触发 破损的箱子
                local skl = hero:find_skill('破损的箱子',nil,true) 
                if not skl  then 
                    ac.game:event_notify('技能-插入魔法书',hero,'彩蛋','破损的箱子')
                end
            end
        end)
    end
end)
--卡牌大师
local cnt = 0
ac.game:event '单位-死亡'(function(_,unit,killer)
    if unit:get_name() ~='城堡守卫' then 
        return 
    end
    local p = killer.owner
    cnt = cnt + 1 
    if cnt == 50 then 
        ac.player.self:sendMsg('恭喜卡牌大师到来',5)
        --创建卡牌大师
        local x,y = ac.rect.j_rect('kpds'):get_point():get()
        local shop = ac.shop.create('卡牌大师',x,y,270)
        local it = shop:add_sell_item('免费刷新',9)
        it:on_cast_start()

        _:remove()
    end
end)



--物品名称
local mt = ac.skill['免费刷新']
mt{
--特殊id
type_id = 'EX04',    
--等久
level = 1,
--图标
art = [[BTNJBSX.blp]],
--说明
tip = [[|cffFFE799【使用说明】：|r

|cffff0000点击直接进入最终挑战，挑战成功后游戏直接胜利|r

|cffcccccc请确保已经有足够的实力|r
|cffcccccc请确保木头足够再购买，否则技能会进入CD，切勿瞎点|r]],
--物品类型
item_type = '神符',
is_order = 1,
--目标类型
target_type = ac.skill.TARGET_TYPE_NONE,
shop_count = 0, --初始个数
--冷却
cool = 0,
content_tip = '',
--商店名词缀
-- store_affix = '最终的挑战',
}
local function get_status(tab,name)
    local ok 
    local str = table.concat(tab, ",")
    if not finds(str,name) then 
        ok = true
    end
    return ok
end

function mt:on_cast_start()
    local hero = self.owner
    local p = hero:get_owner()
    local seller = self.seller
    --随机3个不同名卡片
    local list = {}
    local i = 0 
    while true do 
        local name = ac.all_card[math.random(#ac.all_card)]
        local ok = get_status(list,name)
        if ok then 
            i = i + 1
            table.insert(list,name)
            seller.sell[i] = name
            if i == 3 then 
                break
            end
        end
    end
    seller:fresh()
end
