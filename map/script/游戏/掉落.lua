
local function table_copy(tbl) 
    local res = {} 
    if tbl then 
        for k, v in pairs(tbl) do 
            if type(v) == 'table' then
                res[k] = table_copy(v)
            else
                res[k] = v
            end
        end 
    end 
    return res 
end

local function item_self_skill(item,unit,time)
    local timer = ac.wait((time or 100) * 1000,function (timer)
        -- print(123333,item.owner)
        if item.owner == nil then 
            item:item_remove()
        end 
    end)
    item._self_skill_timer = timer 

    --处理偷窃完的物品位置
    if ac.game['偷窃'] then 
        if unit then 
            item:setPoint(unit:get_point())
        end    
    end
end 
--统一漂浮文字显示
local function on_texttag(string,color,hero)
    local color = color or '白'
    --颜色代码
    local color_rgb = {
        ['红'] = { r = 255, g = 0, b = 0,},
        ['绿'] = { r = 0, g = 255, b = 0,},
        ['蓝'] = { r = 0, g = 189, b = 236,},
        ['青'] = { r = 0, g = 255, b = 255,},
        ['紫'] = { r = 223, g = 25, b = 208,},
        ['橙'] = { r = 255, g = 204, b = 0,},
        ['棕'] = { r = 166, g = 125, b = 61,},
        ['粉'] = { r = 188, g = 143, b = 143,},
        ['白'] = { r = 255, g = 255, b = 255,},
        ['黑'] = { r = 136, g = 58, b = 0,},
        ['暗金'] = { r = 136, g = 58, b = 0,},
        ['金'] = { r = 255, g = 255, b = 0,},
        ['黄'] = { r = 255, g = 255, b = 0,},
        ['灰'] = { r = 204, g = 204, b = 204,},
        ['神'] = { r = 223, g = 25, b = 208,},

        ['天赋'] = { r = 223, g = 25, b = 208,},
        ['真天阶'] = { r = 223, g = 25, b = 208,},
        ['天阶'] = { r = 255, g = 0, b = 0,},
        ['地阶'] = { r = 255, g = 255, b = 0,},
        ['玄阶'] = { r = 0, g = 189, b = 236,},
        ['黄阶'] = { r = 255, g = 255, b = 255,},
    }

    local target = hero
    local x, y,z = target:get_point():get()
    -- local z = target:get_point():getZ()
    local tag = ac.texttag
    {
        string = string,
        size = 10,
        position = ac.point(x-200 , y+50, z + 30),
        red = color_rgb[color].r,
        green = color_rgb[color].g,
        blue = color_rgb[color].b,
        fade = 0.5,
        speed = 150,
        angle = 160,
        life = 2,
        time = ac.clock(),
    }
    return tag
end

ac.on_texttag =  on_texttag

--先列出所有奖励 再按概率抽取
local reward = {

    ['随机白装'] = function (player,hero,unit,is_on_hero)
        local list = ac.quality_item['白']
        if list == nil then 
            print('没有白色装备 添加失败')
            return 
        end 
        local name = list[math.random(#list)]
        --英雄死亡时 掉落在地上
        if not is_on_hero or (not hero:is_alive()) then 
            local item = ac.item.create_item(name,unit:get_point())
            -- item_self_skill(item,hero)
            if item.owner_ship then 
                item.owner_ship = player
            end  
        else
            --宠物打死的也掉人身上
            hero = hero:get_owner().hero
            hero:add_item(name,true)    
        end    
    end,
    ['随机蓝装'] = function (player,hero,unit,is_on_hero)
        local list = ac.quality_item['蓝']
        if list == nil then 
            print('没有蓝色装备 添加失败')
            return 
        end 
        local name = list[math.random(#list)]
        --英雄死亡时 掉落在地上
        if not is_on_hero or (not hero:is_alive()) then 
            local item = ac.item.create_item(name,unit:get_point())
            -- item_self_skill(item,hero)
            if item.owner_ship then 
                item.owner_ship = player
            end  
        else
            hero = hero:get_owner().hero
            hero:add_item(name,true)    
        end 
    end,


    ['随机金装'] = function (player,hero,unit,is_on_hero)
        local list = ac.quality_item['金']
        if list == nil then 
            print('没有金色装备 添加失败')
            return 
        end 
        local name = list[math.random(#list)]
        --英雄死亡时 掉落在地上
        if not is_on_hero or (not hero:is_alive()) then 
            local item = ac.item.create_item(name,unit:get_point())
            -- item_self_skill(item,hero)
            if item.owner_ship then 
                item.owner_ship = player
            end  
        else
            hero = hero:get_owner().hero
            hero:add_item(name,true)    
        end 
    end,

    ['随机红装'] = function (player,hero,unit,is_on_hero)
        local list = ac.quality_item['红']
        if list == nil then 
            print('没有红色装备 添加失败')
            return 
        end 
        local name = list[math.random(#list)]
        --英雄死亡时 掉落在地上
        if not is_on_hero or (not hero:is_alive()) then 
            local item = ac.item.create_item(name,unit:get_point())
            -- item_self_skill(item,hero)
            if item.owner_ship then 
                item.owner_ship = player
            end  
        else
            hero = hero:get_owner().hero
            hero:add_item(name,true)    
        end 
    end,
    ['随机技能'] = function (player,hero,unit,is_on_hero)
        local list = ac.all_skill
        if list == nil then 
            print('没有任何技能')
            return 
        end 
        local name = list[math.random(#list)]
        --英雄死亡时 掉落在地上
        if not is_on_hero or (not hero:is_alive()) then 
            local item = ac.item.create_skill_item(name,unit:get_point())
            -- item_self_skill(item,hero)
            if item.owner_ship then 
                item.owner_ship = player
            end  
        else
            hero = hero:get_owner().hero
            ac.item.add_skill_item(name,hero)
        end 
    end,
    ['吞噬丹'] = function (player,hero,unit,is_on_hero)
        local name = '吞噬丹'
        --英雄死亡时 掉落在地上
        if not is_on_hero or (not hero:is_alive()) then 
            local item = ac.item.create_item(name,unit:get_point())
            -- item_self_skill(item,hero)
            if item.owner_ship then 
                item.owner_ship = player
            end  
        else
            hero = hero:get_owner().hero
            hero:add_item(name,true)    
        end 
    end,
    ['强化石'] = function (player,hero,unit,is_on_hero)
        local name = '强化石'
        --英雄死亡时 掉落在地上
        if not is_on_hero or (not hero:is_alive()) then 
            local item = ac.item.create_item(name,unit:get_point())
            -- item_self_skill(item,hero)
        else
            hero = hero:get_owner().hero
            hero:add_item(name,true)    
        end 
    end,
    ['天谕'] = function (player,hero,unit,is_on_hero)
        local name = '天谕'
        --英雄死亡时 掉落在地上
        if not is_on_hero or (not hero:is_alive()) then 
            local item = ac.item.create_item(name,unit:get_point())
            -- item_self_skill(item,hero)
        else
            hero = hero:get_owner().hero
            hero:add_item(name,true)    
        end 
    end,
    ['召唤boss'] = function (player,hero,unit,is_on_hero)
        local name = '召唤boss'
        --英雄死亡时 掉落在地上
        if not is_on_hero or (not hero:is_alive()) then 
            local item = ac.item.create_item(name,unit:get_point())
            -- item_self_skill(item,hero)
        else
            hero = hero:get_owner().hero
            hero:add_item(name,true)    
        end 
    end,
    ['召唤练功怪'] = function (player,hero,unit,is_on_hero)
        local name = '召唤练功怪'
        --英雄死亡时 掉落在地上
        if not is_on_hero or (not hero:is_alive()) then 
            local item = ac.item.create_item(name,unit:get_point())
            -- item_self_skill(item,hero)
        else
            hero = hero:get_owner().hero
            hero:add_item(name,true)    
        end 
    end,
    ['级物品'] = function (player,hero,unit,is_on_hero,str)
        local lv = tonumber(string.sub(str,1,1))
        local color = ac.get_reward_name(ac.unit_reward['存档物品'])
        if not color then 
            return 
        end    
        local rand = math.random(#ac.save_item[lv][color])
        local name = ac.save_item[lv][color][rand]
        --掉落运动 
        ac.fall_move(name,unit:get_point(),ac.table.ItemData[name].specail_model)
        
    end,
}
ac.reward = reward
local function fall_move(it_name,where,model,is_skill,player)
    local point = where:get_point() - {math.random(360),math.random(200,500)}
    --运动
    local mvr = ac.mover.target
    {
        source = where:get_point(),
        target = point,
        model = model or [[Objects\InventoryItems\TreasureChest\treasurechest.mdl]],
        height = 400,
        speed = 300,
        skill = '掉落运动'
    }
    if not mvr then
        return
    end
    function mvr:on_finish()
        local it 
        if is_skill then 
            it = ac.item.create_skill_item(it_name,point)
        else
            it = ac.item.create_item(it_name,point)
        end
        
        if it.owner_ship then 
            it.owner_ship = player
        end  
    end
end    
ac.fall_move = fall_move

local unit_reward = {
    ['进攻怪'] =  {
        { rand = 2.5,      name = {
                { rand = 75, name = '随机白装'},
                { rand = 20, name = '随机蓝装'},
                { rand = 4, name = '随机金装'},
                { rand = 1, name = '随机红装'},
            }
        },
        { rand = 0.007,      name = '吞噬丹'},
        { rand = 0.01,      name = '天谕'},
        { rand = 0.04,      name = '强化石'},
        { rand = 0.01,      name = '随机技能'}
    },
    
    ['一棒男'] =  {{ rand = 25,      name = '吞噬丹'}},
    ['戴瑟提克'] =  {{ rand = 25,      name = '吞噬丹'}},
    ['格里弗'] =  {{ rand = 25,      name = '吞噬丹'}},
    ['克尔苏加德'] =  {{ rand = 25,      name = '吞噬丹'}},
    ['虚空诺亚'] =  {{ rand = 25,      name = '吞噬丹'}},

    ['存档物品'] = {
        { rand = 65,      name = '白'},
        { rand = 25,      name = '蓝'},
        { rand = 8,      name = '金'},
        { rand = 2,      name = '暗金'},
    },
    ['难1'] =  {{ rand = 1.5, name = {{ rand = 95,   name = '1级物品'},{ rand = 5,   name = '2级物品'}}}},
    ['难2'] =  {{ rand = 1.5, name = {{ rand = 90,   name = '1级物品'},{ rand = 10,   name = '2级物品'}}}},
    ['难3'] =  {{ rand = 1.5, name = {{ rand = 85,   name = '1级物品'},{ rand = 15,   name = '2级物品'}}}},
    ['难4'] =  {{ rand = 1.5, name = {{ rand = 75,   name = '1级物品'},{ rand = 20,   name = '2级物品'},{ rand = 5,   name = '3级物品'}}}},
    ['难5'] =  {{ rand = 1.5, name = {{ rand = 65,   name = '1级物品'},{ rand = 25,   name = '2级物品'},{ rand = 10,   name = '3级物品'}}}},
    ['难6'] =  {{ rand = 1.5, name = {{ rand = 55,   name = '1级物品'},{ rand = 30,   name = '2级物品'},{ rand = 15,   name = '3级物品'}}}},
    ['难7'] =  {{ rand = 1.5, name = {{ rand = 45,   name = '1级物品'},{ rand = 35,   name = '2级物品'},{ rand = 20,   name = '3级物品'}}}},
    ['难8'] =  {{ rand = 1.5, name = {{ rand = 30,   name = '1级物品'},{ rand = 40,   name = '2级物品'},{ rand = 25,   name = '3级物品'},{ rand = 5,   name = '4级物品'}}}},
    ['难9'] =  {{ rand = 1.5, name = {{ rand = 20,   name = '1级物品'},{ rand = 40,   name = '2级物品'},{ rand = 30,   name = '3级物品'},{ rand = 10,   name = '4级物品'}}}},
    ['难10'] =  {{ rand = 1.5, name = {{ rand = 10,   name = '1级物品'},{ rand = 40,   name = '2级物品'},{ rand = 35,   name = '3级物品'},{ rand = 15,   name = '4级物品'}}}},
    ['难11'] =  {{ rand = 1.5, name = {{ rand = 0,   name = '1级物品'},{ rand = 40,   name = '2级物品'},{ rand = 40,   name = '3级物品'},{ rand = 20,   name = '4级物品'}}}},

    ['藏宝阁小弟'] = {{rand =1.5,name = '藏宝图'}},
    ['藏宝阁阁主'] = {{rand =100,name = '藏宝图'}},
    ['藏宝图'] =  {	
        {    rand = 60.41, name = '无' },
        {    rand = 8, name = '随机物品',},
        {    rand = 8, name = { --'随机技能' 黄：55；玄：30:；地：12；天：3
                { rand = 55, name = '黄阶'},
                { rand = 30, name = '玄阶'},
                { rand = 12, name = '地阶'},
                { rand = 3, name = '天阶'},
        }}, 
        {    rand = 1, name = '杀怪加力量+300 攻击加力量+1200 每秒加力量+5000' },
        {    rand = 1, name = '杀怪加敏捷+300 攻击加敏捷+1200 每秒加敏捷+5000',},
        {    rand = 1, name = '杀怪加智力+300 攻击加智力+1200 每秒加智力+5000',},
        {    rand = 1, name = '杀怪加全属性+150 攻击加全属性+600 每秒加全属性+2500',},
        {    rand = 1, name = '杀怪加攻击+600 每秒加攻击+6000',},
        {    rand = 1, name = '每秒加护甲+5',},
        {    rand = 1, name = '攻击减甲+30',},

        {    rand = 1, name = '宠物经验书(小)*1',},
        {    rand = 1, name = '宠物经验书(大)*1',},
        {    rand = 2, name = '魔丸',},
        {    rand = 2, name = '木头',},

        {    rand = 1, name = '功法升级书*1',}, --lv1
        {    rand = 0.5, name = '功法连升书*1',}, --lv2
        {    rand = 0.35, name = '三眼赤痕*1',}, --lv1
        {    rand = 0.35, name = '火龙气息*1',}, --lv2
        {    rand = 0.25, name = '地魂融血丹*1',}, --lv1
        {    rand = 0.25, name = '天魂融血丹*1',}, --lv2

        {    rand = 1, name = '强化石*1',}, --lv2
        {    rand = 0.5, name = '天谕*1',}, --lv2
        {    rand = 0.2, name = '吞噬丹*1',}, --lv2

        --挖宝成就
        {    rand = 3.2, name = '勤劳的矿工',}, --lv2
        {    rand = 1.1, name = '挖宝小能手',}, --lv2
        {    rand = 0.67, name = '黑格的陨石',}, --lv2
        {    rand = 0.44, name = '法老的遗产',}, --超级彩蛋
        --彩蛋
        {    rand = 0.33, name = '挖宝达人',}, --500万全属性，物品获取率+50%	

        --可存档1个
        {    rand = 0.25, name = '黄金矿工',}, --500万全属性，物品获取率+50%

        --挖宝成就第五个超级牛逼
        {    rand = 0.2, name = 'ONE_PIECE',}, --500万全属性，物品获取率+50%	
   
    },

    ['藏经阁小弟'] = {{rand =1,name = '羊皮纸'},{rand =0.1,name = '无字天书'}},
    ['藏经阁少阁主'] = {{rand =90,name = '羊皮纸'},{rand =10,name = '无字天书'}},
    ['羊皮纸'] =  {	
        {    rand = 52.17, name = '无' },
        {    rand = 20, name = { --'随机技能' 黄：55；玄：30:；地：12；天：3
                { rand = 55, name = '黄阶'},
                { rand = 30, name = '玄阶'},
                { rand = 12, name = '地阶'},
                { rand = 3, name = '天阶'},
        }},
        
        {    rand = 5, name = '功法升级书*1',}, --lv2
        {    rand = 1, name = '功法连升书*1',}, --lv2
        {    rand = 1, name = '地魂融血丹*1',},
        {    rand = 1, name = '天魂融血丹*1',},
        {    rand = 0.5, name = '三眼赤痕*1',}, 
        {    rand = 0.5, name = '火龙气息*1',},

        {    rand = 1, name = '杀怪加力量+300 攻击加力量+1200 每秒加力量+5000' },
        {    rand = 1, name = '杀怪加敏捷+300 攻击加敏捷+1200 每秒加敏捷+5000',},
        {    rand = 1, name = '杀怪加智力+300 攻击加智力+1200 每秒加智力+5000',},
        {    rand = 1, name = '杀怪加全属性+150 攻击加全属性+600 每秒加全属性+2500',},
        {    rand = 1, name = '杀怪加攻击+600 每秒加攻击+10000',},
        {    rand = 1, name = '每秒加护甲+5',},
        {    rand = 1, name = '攻击减甲+30',},

        {    rand = 1, name = '宠物经验书(小)*1',},
        {    rand = 1, name = '宠物经验书(大)*1',},
        {    rand = 2, name = '魔丸',},
        {    rand = 2, name = '木头',},


        {    rand = 3.2, name = '百佛图',}, --成就
        {    rand = 1.1, name = '洗髓经',}, --成就
        {    rand = 0.67, name = '易筋经',}, --成就
        {    rand = 0.44, name = '天诀',}, --成就

        {    rand = 0.17, name = '鉴宝大师',}, --彩蛋

        {    rand = 0.15, name = '书呆子',}, --可存档，图标shudaizi.blp

        {    rand = 0.1, name = '七十二绝技',}, --超级成就，图标qishier.blp
    },
    ['无字天书'] =  {	
        {    rand = 44.8, name = '无' },
        {    rand = 20, name = { --'随机技能' 黄：3；玄：55:；地：30；天：12
                { rand = 3, name = '黄阶'},
                { rand = 55, name = '玄阶'},
                { rand = 30, name = '地阶'},
                { rand = 12, name = '天阶'},
        }}, 
        {    rand = 10, name = '功法升级书*1',}, --lv2
        {    rand = 2, name = '功法连升书*1',}, --lv2
        {    rand = 2, name = '地魂融血丹*1',},
        {    rand = 2, name = '天魂融血丹*1',},
        {    rand = 1, name = '三眼赤痕*1',}, 
        {    rand = 1, name = '火龙气息*1',},

        {    rand = 1, name = '杀怪加力量+600 攻击加力量+2400 每秒加力量+10000' },
        {    rand = 1, name = '杀怪加敏捷+600 攻击加敏捷+2400 每秒加敏捷+10000',},
        {    rand = 1, name = '杀怪加智力+600 攻击加智力+2400 每秒加智力+10000',},
        {    rand = 1, name = '杀怪加全属性+300 攻击加全属性+1200 每秒加全属性+5000',},
        {    rand = 1, name = '杀怪加攻击+1200 每秒加攻击+20000',},
        {    rand = 1, name = '每秒加护甲+10',},
        {    rand = 1, name = '攻击减甲+60',},

        {    rand = 0, name = '宠物经验书(小)*1',},
        {    rand = 2, name = '宠物经验书(大)*1',},
        {    rand = 2, name = '大魔丸',},
        {    rand = 2, name = '大木头',},

        {    rand = 1.7, name = '鉴宝大师',}, --可存档，图标shudaizi.blp

        {    rand = 1.5, name = '书呆子',}, --可存档，图标shudaizi.blp

        {    rand = 1, name = '七十二绝技',}
        
    },
    
    ['剑冢小弟'] = {{rand =0.75,name = '强化石*1'},{rand =0.05,name = '天谕*1'}},
    ['剑魔'] = {{rand =45,name = '强化石*1'},{rand =5,name = '天谕*1'}},

    ['装备升级'] =  {	
        {    rand = 0.25, name = '真·复制装备',},
        -- {    rand = 97.75, name = '无' },
        {    rand = 1, name = '随机物品',},
        {    rand = 0.5, name = '吞噬丹*1',},
        {    rand = 80.5, name = '复制装备',},
    },


    ['百花宫宫女'] = {{rand =1.4,name = '一颗神奇的种子*1'}},
    ['苏若颜'] = {{rand =100,name = '一颗神奇的种子*1'}},
    ['一颗神奇的种子'] =  {	
        {    rand = 51.81, name = '无' },
        {    rand = 5, name = '随机物品',},
        {    rand = 5, name = { --'随机技能' 黄：55；玄：30:；地：12；天：3
                { rand = 55, name = '黄阶'},
                { rand = 30, name = '玄阶'},
                { rand = 12, name = '地阶'},
                { rand = 3, name = '天阶'},
        }}, 
        {    rand = 4, name = '杀怪加力量+150 攻击加力量+600 每秒加力量+2500' },
        {    rand = 4, name = '杀怪加敏捷+150 攻击加敏捷+600 每秒加敏捷+2500',},
        {    rand = 4, name = '杀怪加智力+150 攻击加智力+600 每秒加智力+2500',},
        {    rand = 4, name = '杀怪加全属性+150 攻击加全属性+300 每秒加全属性+1250',},
        {    rand = 4, name = '杀怪加攻击+300 每秒加攻击+5000',},
        {    rand = 4, name = '每秒加护甲+2.5',},
        {    rand = 4, name = '攻击减甲+15',},

        {    rand = 0.5, name = '宠物经验书(小)*1',},
        {    rand = 0.5, name = '宠物经验书(大)*1',},
        {    rand = 0.5, name = '魔丸',},
        {    rand = 0.5, name = '木头',},

        {    rand = 0.5, name = '功法升级书*1',}, --lv2
        {    rand = 0.5, name = '功法连升书*1',}, --lv2
        {    rand = 0.25, name = '地魂融血丹*1',},
        {    rand = 0.25, name = '天魂融血丹*1',},
        {    rand = 0.25, name = '三眼赤痕*1',}, 
        {    rand = 0.25, name = '火龙气息*1',},

        {    rand = 3.2, name = '我爱养花种树',}, --成就
        {    rand = 1.1, name = '果实累累',}, --成就
        {    rand = 0.67, name = '辛勤的园丁',}, --成就
        {    rand = 0.44, name = '冷月葬花魂',}, --成就

        {    rand = 0.33, name = '园艺大师',}, --彩蛋

        {    rand = 0.25, name = '采蘑菇的小姑娘',}, --可存档
        {    rand = 0.2, name = '蚂蚁森林',}, --超级成就
        
    },
    
    ['龙宫守卫'] = {{rand =1.5,name = '扭蛋券(十连抽)*1'},{rand =0.1,name = '超级扭蛋券(十连抽)*1'}},
    ['哪吒'] = {{rand =90,name = '扭蛋券(十连抽)*1'},{rand =10,name = '超级扭蛋券(十连抽)*1'}},

    ['扭蛋券'] =  {	
        {    rand = 0.15, name = '多抽百次',},
        {    rand = 97.85, name = '无' },
        {    rand = 0.5, name = '吞噬丹*1',},
        {    rand = 0.5, name = '多抽十次',},
        {    rand = 1, name = '多抽一次',},

    },
    ['扭蛋'] = {
        {    rand = 32.241, name = '空蛋' },

        {    rand = 4, name = '魔丸',},
        {    rand = 4, name = '木头',},

        {    rand = 4, name = '力量+35000' },
        {    rand = 4, name = '敏捷+35000',},
        {    rand = 4, name = '智力+35000',},
        {    rand = 4, name = '杀怪加力量+4',},
        {    rand = 4, name = '杀怪加敏捷+4',},
        {    rand = 4, name = '杀怪加智力+4',},
        {    rand = 4, name = '攻击加力量+12',},
        {    rand = 4, name = '攻击加敏捷+12',},
        {    rand = 4, name = '攻击加智力+12',},
        {    rand = 4, name = '每秒加力量+20',},
        {    rand = 4, name = '每秒加敏捷+20',},
        {    rand = 4, name = '每秒加智力+20',},

        {    rand = 0.07, name = '力量+700000' },
        {    rand = 0.07, name = '敏捷+700000',},
        {    rand = 0.07, name = '智力+700000',},
        {    rand = 0.07, name = '杀怪加力量+40',},
        {    rand = 0.07, name = '杀怪加敏捷+40',},
        {    rand = 0.07, name = '杀怪加智力+40',},
        {    rand = 0.07, name = '攻击加力量+120',},
        {    rand = 0.07, name = '攻击加敏捷+120',},
        {    rand = 0.07, name = '攻击加智力+120',},
        {    rand = 0.07, name = '每秒加力量+200',},
        {    rand = 0.07, name = '每秒加敏捷+200',},
        {    rand = 0.07, name = '每秒加智力+200',},

        {    rand = 0.007, name = '力量+7000000' },
        {    rand = 0.007, name = '敏捷+7000000',},
        {    rand = 0.007, name = '智力+7000000',},
        {    rand = 0.007, name = '杀怪加力量+400',},
        {    rand = 0.007, name = '杀怪加敏捷+400',},
        {    rand = 0.007, name = '杀怪加智力+400',},
        {    rand = 0.007, name = '攻击加力量+1200',},
        {    rand = 0.007, name = '攻击加敏捷+1200',},
        {    rand = 0.007, name = '攻击加智力+1200',},
        {    rand = 0.007, name = '每秒加力量+2000',},
        {    rand = 0.007, name = '每秒加敏捷+2000',},
        {    rand = 0.007, name = '每秒加智力+2000',},

        {    rand = 1.4, name = '攻击+800000',},
        {    rand = 1.4, name = '杀怪加攻击+20',},
        {    rand = 1.4, name = '每秒加攻击+80',},
        {    rand = 0.07, name = '攻击+4000000',},
        {    rand = 0.07, name = '杀怪加攻击+80',},
        {    rand = 0.07, name = '每秒加攻击+400',},
        {    rand = 0.007, name = '攻击+40000000',},
        {    rand = 0.007, name = '杀怪加攻击+800',},
        {    rand = 0.007, name = '每秒加攻击+4000',},

        {    rand = 1.4, name = '护甲+100',},
        {    rand = 1.4, name = '每秒加护甲+0.2',},
        {    rand = 0.07, name = '护甲+400',},
        {    rand = 0.07, name = '每秒加护甲+0.4',},
        {    rand = 0.007, name = '护甲+4000',},
        {    rand = 0.007, name = '每秒加护甲+4',},

        {    rand = 0.5, name = '宠物经验书(小)',},
        -- {    rand = 0.01, name = '吞噬丹',},
        {    rand = 0.01, name = '随机技能',},
        {    rand = 0.7, name = '随机物品',}, --和商店一样 '凝脂剑','元烟剑','暗影','青涛魔剑','青虹紫霄剑'
        -- {    rand = 0.1, name = '神兵',},--lv1-lv5
        -- {    rand = 0.1, name = '神甲',},--lv1-lv5
        {    rand = 0.15, name = '功法升级书',}, --lv1
        {    rand = 0.05, name = '功法连升书',}, --lv2
        {    rand = 0.02, name = '一号熔炼石',},
        {    rand = 0.02, name = '二号熔炼石',},

        {    rand = 0.12, name = '红色小水滴',},--红色小水滴 吸血+10% 攻击回血+500000
        {    rand = 0.12, name = '黄金罗盘',},--暴击几率+2.5%，暴击伤害+35%
        {    rand = 0.12, name = '发光的草药',},--免伤几率+5%，每秒回血+5%
        {    rand = 0.12, name = '奇美拉的头颅',},--分裂伤害+50%，攻击速度+50%

        {    rand = 0.02, name = '倒霉蛋',},--木头+5555，魔丸+5555，杀敌数+5555
        {    rand = 0.1, name = '矮人的火枪',},--木头+5555，魔丸+5555，杀敌数+5555
    },

    ['超级扭蛋'] = {
        {    rand = 30.181, name = '空蛋' },

        {    rand = 2.5, name = '魔丸',},
        {    rand = 2.5, name = '木头',},

        {    rand = 4, name = '力量+500000' },
        {    rand = 4, name = '敏捷+500000',},
        {    rand = 4, name = '智力+500000',},
        {    rand = 4, name = '杀怪加力量+60',},
        {    rand = 4, name = '杀怪加敏捷+60',},
        {    rand = 4, name = '杀怪加智力+60',},
        {    rand = 4, name = '攻击加力量+180',},
        {    rand = 4, name = '攻击加敏捷+180',},
        {    rand = 4, name = '攻击加智力+180',},
        {    rand = 4, name = '每秒加力量+300',},
        {    rand = 4, name = '每秒加敏捷+300',},
        {    rand = 4, name = '每秒加智力+300',},

        {    rand = 0.07, name = '力量+10000000' },
        {    rand = 0.07, name = '敏捷+10000000',},
        {    rand = 0.07, name = '智力+10000000',},
        {    rand = 0.07, name = '杀怪加力量+1000',},
        {    rand = 0.07, name = '杀怪加敏捷+1000',},
        {    rand = 0.07, name = '杀怪加智力+1000',},
        {    rand = 0.07, name = '攻击加力量+3000',},
        {    rand = 0.07, name = '攻击加敏捷+3000',},
        {    rand = 0.07, name = '攻击加智力+3000',},
        {    rand = 0.07, name = '每秒加力量+5000',},
        {    rand = 0.07, name = '每秒加敏捷+5000',},
        {    rand = 0.07, name = '每秒加智力+5000',},

        {    rand = 0.007, name = '力量+60000000' },
        {    rand = 0.007, name = '敏捷+60000000',},
        {    rand = 0.007, name = '智力+60000000',},
        {    rand = 0.007, name = '杀怪加力量+10000',},
        {    rand = 0.007, name = '杀怪加敏捷+10000',},
        {    rand = 0.007, name = '杀怪加智力+10000',},
        {    rand = 0.007, name = '攻击加力量+30000',},
        {    rand = 0.007, name = '攻击加敏捷+30000',},
        {    rand = 0.007, name = '攻击加智力+30000',},
        {    rand = 0.007, name = '每秒加力量+50000',},
        {    rand = 0.007, name = '每秒加敏捷+50000',},
        {    rand = 0.007, name = '每秒加智力+50000',},

        {    rand = 2, name = '攻击+5000000',},
        {    rand = 2, name = '杀怪加攻击+400',},
        {    rand = 2, name = '每秒加攻击+2000',},
        {    rand = 0.07, name = '攻击+50000000',},
        {    rand = 0.07, name = '杀怪加攻击+4000',},
        {    rand = 0.07, name = '每秒加攻击+20000',},
        {    rand = 0.007, name = '攻击+400000000',},
        {    rand = 0.007, name = '杀怪加攻击+40000',},
        {    rand = 0.007, name = '每秒加攻击+200000',},

        {    rand = 2, name = '护甲+600',},
        {    rand = 2, name = '每秒加护甲+1.2',},
        {    rand = 0.07, name = '护甲+6000',},
        {    rand = 0.07, name = '每秒加护甲+12',},
        {    rand = 0.007, name = '护甲+60000',},
        {    rand = 0.007, name = '每秒加护甲+120',},

        {    rand = 0.5, name = '宠物经验书(大)',},
        {    rand = 0.05, name = '吞噬丹',},
        {    rand = 0.2, name = '随机技能',},
        {    rand = 1.5, name = '随机物品',}, --和商店一样 '凝脂剑','元烟剑','暗影','青涛魔剑','青虹紫霄剑'
        -- {    rand = 0.1, name = '神兵',},--lv6-lv10
        -- {    rand = 0.1, name = '神甲',},--lv6-lv10
        {    rand = 0.15, name = '功法升级书',}, --lv1
        {    rand = 0.15, name = '功法连升书',}, --lv2
        {    rand = 0.02, name = '三号熔炼石',},
        {    rand = 0.02, name = '四号熔炼石',},

        {    rand = 0.5, name = '地魂融血丹',}, --lv1
        {    rand = 0.5, name = '天魂融血丹',}, --lv2
        {    rand = 0.5, name = '三眼赤痕',}, --lv1
        {    rand = 0.5, name = '火龙气息',}, --lv2


        {    rand = 0.12, name = '玻璃大炮',},--红色小水滴 吸血+10% 攻击回血+500000
        {    rand = 0.12, name = '发光的蓝色灰烬',},--暴击几率+2.5%，暴击伤害+25%
        {    rand = 0.12, name = '诸界的毁灭者',},--免伤几率+5%，每秒回血+5%
        {    rand = 0.12, name = '末日的钟摆',},--分裂伤害+50%，攻击速度+50%

        {    rand = 0.02, name = '游戏王',},--木头+5555，魔丸+5555，杀敌数+5555
        {    rand = 0.1, name = '龙族血统',},--木头+5555，魔丸+5555，杀敌数+5555
    },
    
    ['城堡守卫'] = {{rand =1.5,name = '黑暗骰子*1'}},
    ['牛头马面'] = {{rand =100,name = '黑暗骰子*1'}},

    ['黑暗骰子'] =  {	
        {    rand = 51, name = '无' },
        {    rand = 10, name = '随机物品',},
        {    rand = 20, name = { --'随机技能' 黄：55；玄：30:；地：12；天：3
                { rand = 55, name = '黄阶'},
                { rand = 30, name = '玄阶'},
                { rand = 12, name = '地阶'},
                { rand = 3, name = '天阶'},
        }}, 
        {    rand = 1.5, name = '杀怪加力量+400 攻击加力量+1200 每秒加力量+2000' },
        {    rand = 1.5, name = '杀怪加敏捷+400 攻击加敏捷+1200 每秒加敏捷+2000',},
        {    rand = 1.5, name = '杀怪加智力+400 攻击加智力+1200 每秒加智力+2000',},
        {    rand = 1.5, name = '杀怪加全属性+200 攻击加全属性+600 每秒加全属性+1000',},
        {    rand = 1.5, name = '杀怪加攻击+600 每秒加攻击+3000',},
        {    rand = 1.5, name = '每秒加护甲+5',},
        {    rand = 1.5, name = '攻击减甲+30',},
        {    rand = 1, name = '宠物经验书(小)*1',},
        {    rand = 1, name = '宠物经验书(大)*1',},
        {    rand = 2, name = '魔丸',},
        {    rand = 2, name = '木头',},

        {    rand = 0.5, name = '杀敌数保本卡*1' },
        {    rand = 0.5, name = '木头保本卡*1' },
        {    rand = 0.5, name = '魔丸保本卡*1' },
        {    rand = 0.5, name = '全属性保本卡*1' },
        {    rand = 0.5, name = '杀敌数翻倍卡*1' },
        {    rand = 0.5, name = '木头翻倍卡*1' },
        {    rand = 0.5, name = '魔丸翻倍卡*1' },
        {    rand = 0.5, name = '全属性翻倍卡*1' },
        {    rand = 0.5, name = '炸弹卡*1' },
        {    rand = 0.5, name = '大炸弹卡*1' },
        {    rand = 0.5, name = '猜拳卡*1' },
        {    rand = 0.5, name = 'gg卡*1' },


        {    rand = 2, name = '一笔巨款',}, --lv2
        {    rand = 1.5, name = '玄远之学',}, --超级彩蛋
        {    rand = 0.25, name = '三冬暖',}, --超级彩蛋
        {    rand = 0.25, name = '源不断的本钱',}, --超级彩蛋

    },
    




    -- ------旧概率------------------
    -- ['熔炼石boss1'] = {{rand =100,name = '一号熔炼石'}},
    -- ['熔炼石boss2'] = {{rand =100,name = '二号熔炼石'}},
    -- ['熔炼石boss3'] = {{rand =100,name = '三号熔炼石'}},
    -- ['熔炼石boss4'] = {{rand =100,name = '四号熔炼石'}},


    ['奶牛'] = {
        {rand =0.3,name = '扭蛋券(十连抽)'},
        {rand =0.3,name = '扭蛋券(百连抽)'},
        {rand =0.3,name = '超级扭蛋券'},
        {rand =0.3,name = '超级扭蛋券(十连抽)'},
        {rand =0.3,name = '超级扭蛋券(百连抽)'},
    },

    ['随机物品'] =  {
        { rand = 100,      name = {
                { rand = 80, name = '随机白装'},
                { rand = 16, name = '随机蓝装'},
                { rand = 3.3, name = '随机金装'},
                { rand = 0.7, name = '随机红装'},
            }
        }
    },

    ['商店随机技能'] =  {
        { rand = 100,      name = '随机技能'}
    },
    ['商店随机物品'] =  {
        { rand = 100,      name = {
                { rand = 80, name = '白'},
                { rand = 16, name = '蓝'},
                { rand = 3.3, name = '金'},
                { rand = 0.7, name = '红'},
            }
        }
    },
    ['随机神符'] =  {
        {    rand = 11, name = '无敌' },
        {    rand = 11, name = '治疗',},
        {    rand = 11, name = '暴击',},
        {    rand = 11, name = '攻击',},
        {    rand = 11, name = '法术',},
        {    rand = 11, name = '减甲',},
        {    rand = 11, name = '中毒',},
        {    rand = 11, name = '沉默',},
        {    rand = 12, name = '定身',},
    },
    ['抽奖券'] =  {
        {    rand = 70,  name ={
                { rand = 0.5, name = '欧皇达人'},
                { rand = 99.5, name = '无'}, 
            }
        },
        {    rand = 5, name = '金币' },
        {    rand = 5, name = '经验',},
        {    rand = 10, name = '随机物品',},
        {    rand = 4, name = '随机技能',},
        {    rand = 1, name = '召唤boss',},
        {    rand = 1, name = '召唤练功怪',},
        {    rand = 1, name = '吞噬丹',},
        {    rand = 1, name = '宠物经验书',},
        {    rand = 2, name = '随机恶魔果实',},
    },
    

    ['炼化异火'] =  {
        {    rand = 20, name = '凡' },
        {    rand = 45, name = '玄' },
        {    rand = 20, name = '地',},
        {    rand = 15, name = '天',},
    },    

    ['星星之火守卫'] = {{rand =11,name = '星星之火碎片'}},
    ['陨落心炎守卫'] = {{rand =10,name = '陨落心炎碎片'}},
    ['三千焱炎火守卫'] = {{rand =9,name = '三千焱炎火碎片'}},
    ['虚无吞炎守卫'] = {{rand =8,name = '虚无吞炎碎片'}},

    ['星星之火boss'] = {
        {rand =50,name = '星星之火碎片*4'},
        {rand =50,name = '星星之火碎片*8'},
    },
    ['陨落心炎boss'] = {
        {rand =50,name = '陨落心炎碎片*4'},
        {rand =50,name = '陨落心炎碎片*8'}
    },
    ['三千焱炎火boss'] = {
        {rand =50,name = '三千焱炎火碎片*4'},
        {rand =50,name = '三千焱炎火碎片*8'},
    },
    ['虚无吞炎boss'] = {
        {rand =50,name = '虚无吞炎碎片*4'},
        {rand =50,name = '虚无吞炎碎片*8'},
    },
    ['陀舍古帝守卫'] = {
        {rand =50,name = '陀舍古帝碎片*4'},
        {rand =50,name = '陀舍古帝碎片*8'},
    },
    ['无尽火域守卫'] = {
        {rand =50,name = '无尽火域碎片*4'},
        {rand =50,name = '无尽火域碎片*8'},
    },

    
    ['红发'] = {{rand =100,name = '格里芬'}},
    ['黑胡子'] = {{rand =100,name = '黑暗项链'}},
    ['百兽'] = {{rand =100,name = '最强生物心脏'}},
    ['白胡子'] = {{rand =100,name = '白胡子的大刀'}},

    ['鸡'] = {
        {rand =0.2,name = '完美的鸡汤'},
        {rand =0.2,name = '完美的鸡头'},
        {rand =0.2,name = '完美的鸡翅'},
        {rand =0.2,name = '完美的鸡腿'},
        {rand =0.2,name = '完美的鸡蛋'},
    },
    
    ['井底之蛙'] =  {
        { rand = 5, name = '金'},
        { rand = 5, name = '红'},
        { rand = 5, name = '随机技能书'},
        { rand = 5, name = '点金石'},
        { rand = 5, name = '恶魔果实'},
        { rand = 5, name = '吞噬丹'},
        { rand = 5, name = '格里芬'},
        { rand = 5, name = '黑暗项链'},
        { rand = 5, name = '最强生物心脏'},
        { rand = 5, name = '白胡子的大刀'},
        { rand = 10, name = '井底之蛙'},
        { rand = 40, name = '无'},
    },

   
}
ac.unit_reward = unit_reward

--递归匹配唯一奖励
local function get_reward_name(tbl)
    local rand = math.random(1,100000) / 1000
    local num = 0
    for index,info in ipairs(tbl) do 
        num = num + info.rand 
        -- print("打印装备掉落概率",info.rand)
        if rand <= num then 
            if type(info.name) == 'string' then 
                return info.name,info.rand 
            elseif type(info.name) == 'table' then 
                return  get_reward_name(info.name)
            end 
            break 
        end 
    end 
end 

ac.get_reward_name = get_reward_name

--递归匹配多个奖励
local function get_reward_name_list(tbl,list,level)
    local level = level or 0
    local rand = math.random(1,100000) / 1000

    local num = 0
    for index,info in ipairs(tbl) do 
        num = num + info.rand 
        if rand <= num then 
            if type(info.name) == 'string' then 
                table.insert(list,info.name)
            elseif type(info.name) == 'table' then 
                get_reward_name_list(info.name,list,level + 1)
            end 
            if level > 0 then 
                break 
            end
        end 
    end 
end
ac.get_reward_name_list = get_reward_name_list


local function hero_kill_unit(tab,player,hero,unit,fall_rate,is_on_hero)

    local change_unit_reward = tab or unit_reward['进攻怪']
    change_unit_reward[1].rand = fall_rate
    local name = get_reward_name(change_unit_reward)
    if name then 
        local func
        for key,val in pairs(reward) do 
            if finds(name,key) then 
                func = reward[key]
                break
            end  
        end 
        if func then 
            -- print('掉落',name)
            func(player,hero,unit,is_on_hero,name)
        end 
    end 
    return name 
end 
--死亡掉落
ac.game:event '单位-死亡' (function (_,unit,killer)  
    if unit:is_hero() then 
        return 
    end 
    --无尽后，死亡不掉落任何东西
    if type(ac.creep['刷怪-无尽1']) == 'table' and ac.creep['刷怪-无尽1'].index >= 1 then 
        return 
    end
    local player = killer:get_owner()
    local dummy_unit = player.hero or ac.dummy
    -- print(unit,unit.category)
    -- 进攻怪 和 boss 掉落 日常掉落物品
    if unit.category and unit.category =='进攻怪' or unit.category =='boss'  then
        local fall_rate = unit.fall_rate *( 1 + dummy_unit:get('物品获取率')/100 )
        -- print('装备掉落概率：',fall_rate,unit.fall_rate)
        hero_kill_unit(unit_reward['进攻怪'],player,killer,unit,fall_rate)

        --存档型装备处理
        local str = ac.attack_boss and table.concat( ac.attack_boss, " ")
        if finds(str,unit:get_name()) then
            local fall_save_rate =unit.fall_save_rate and unit.fall_save_rate *( 1 + dummy_unit:get('物品获取率')/100 ) or 0
            
            fall_save_rate = 80 --测试
            
            --多次获得
            local cnt = math.floor(3+get_player_count()/2)
            ac.timer(200,cnt,function()
                print('存档物品掉落：',fall_save_rate)
                hero_kill_unit(unit_reward['难'..ac.g_game_degree_attr],player,killer,unit,fall_save_rate)
            end)
        end
    end

    --boss 额外掉落物品
    local tab = unit_reward[unit:get_name()]
    if not tab then 
        return 
    end      
    local tab = table_copy(tab)
    --概率提升
    for i,data in pairs(tab) do 
        if data.name == '藏宝图' then 
            tab[i].rand  = tab[i].rand * (1 + (player:get('藏宝图掉落概率') or 0)/100)
            print('藏宝图掉落概率：',tab[i].rand)
        elseif data.name == '羊皮纸' then 
            tab[i].rand  = tab[i].rand * (1 + (player:get('羊皮纸掉落概率') or 0)/100)
        elseif data.name == '无字天书' then 
            tab[i].rand  = tab[i].rand * (1 + (player:get('无字天书掉落概率') or 0)/100)
        elseif data.name == '强化石' then 
            tab[i].rand  = tab[i].rand * (1 + (player:get('强化石掉落概率') or 0)/100)
        elseif data.name == '天谕' then 
            tab[i].rand  = tab[i].rand * (1 + (player:get('天谕掉落概率') or 0)/100)
        elseif data.name == '一颗神奇的种子' then 
            tab[i].rand  = tab[i].rand * (1 + (player:get('一颗神奇的种子掉落概率') or 0)/100)
        elseif data.name == '扭蛋券(十连抽)' then 
            tab[i].rand  = tab[i].rand * (1 + (player:get('扭蛋券(十连抽)掉落概率') or 0)/100)
        elseif data.name == '超级扭蛋券(十连抽)' then 
            tab[i].rand  = tab[i].rand * (1 + (player:get('超级扭蛋券(十连抽)掉落概率') or 0)/100)
        elseif data.name == '黑暗骰子' then 
            tab[i].rand  = tab[i].rand * (1 + (player:get('黑暗骰子掉落概率') or 0)/100)
        end 
    end    

    local name = get_reward_name(tab) 
    if name then 
        if finds(name,'*') then 
            local _, _, it_name, cnt = string.find(name,"(%S+)%*(%d+)")
            --进行多个处理
            for i=1,tonumber(cnt) do 
                local it = ac.item.create_item(it_name,unit:get_point()) 
                if it.owner_ship then 
                    it.owner_ship = player
                end
            end    
        else
            local it = ac.item.create_item(name,unit:get_point())   
            if it.owner_ship then 
                it.owner_ship = player
            end  
        end    
    end    


end)



ac.game:event '单位-即将获得物品' (function (_,unit,item)
    on_texttag('获得 '..item.name,item.color,unit)
end )   

--自动优化内存，1小时后自动开启，物品3分钟后清理
-- local time = 30
-- local auto_clean_time = 30
-- ac.wait(time*1000,function() 
--     ac.flag_auto_item_recycle = true
--     --设置多面板数据
--     ac.game.multiboard:set_auto_tip()
--     --3分钟后，清理一次物品
--     ac.wait(auto_clean_time*1000,function()
--         ac.game:clear_item()
--     end)    
-- end)


ac.game:event '物品-创建'  (function (_,item)
    if not item then return end 
    if ac.flag_auto_item_recycle then 
        --练功房的物品除外
        if not ac.game:is_in_room(item) then 
            item.time_removed = auto_clean_time
        end    
    end    
    if item.time_removed then 
        item_self_skill(item,nil,item.time_removed)
    end    
end)
ac.game:event '单位-获得物品后' (function (_,unit,item)
    local timer = item._self_skill_timer 
    if timer then 
        timer:remove()
        item._self_skill_timer = nil 
    end 
end)

-- ac.game:event '单位-丢弃物品后' (function (_,unit,item)
--     if not item then return end 
--     if ac.flag_auto_item_recycle then 
--         --练功房的物品除外
--         -- print(item.name)
--         if not ac.game:is_in_room(item) then 
--             item.time_removed = auto_clean_time
--         end    
--     end    
--     if item.time_removed then 
--         item_self_skill(item,nil,item.time_removed)
--     end       
-- end)




--[[

--概率计算测试输出
for a = 1 , 5 do 

    local map = {}
    local count = 0
    for i = 0,1600 do 
        
        local name = get_reward_name(unit_reward['进攻怪'])
        if name then 
            local num = map[name] or 0
            num = num + 1
            map[name] = num
        end
       
    end 
    for name,num in pairs(map) do 
        print(name,num)
    end 

    print('------------------------')

    local map = {}
    local count = 0
    for i = 0,1600 do 
        local rand = math.random(100)
        if rand <= 2 then 
            local list = {}
            get_reward_name_list(unit_reward['复生野怪'],list,0)
            for index,name in ipairs(list) do 
                local num = map[name] or 0
                num = num + 1
                map[name] = num 
            end 
            count = count + 1
        end
    end 
    print("数量为",count)
    for name,num in pairs(map) do 
        print(name,num)
    end 

    print("============================")
end 
]]