local unit_class = require('types.unit').__index

local player_class = require('ac.player').__index

local item_class = require 'types.item'

--句柄管理器
local handle_manager = handle_manager_class.create()

local build_class

local color_map = {
    ['N']   = '<N级>',
    ['R']   = '<|cff00bdecR级|r>',
    ['SR']  = '<|cffdf19d0SR级|r>',
    ['SSR'] = '<|cffffff00SSR级|r>',
}

local level_map = {
    ['N']   = 1,
    ['R']   = 2,
    ['SR']  = 3,
    ['SSR'] = 4,
}

local price_map = {
    ['N']   = 250,
    ['R']   = 500,
    ['SR']  = 2500,
    ['SSR'] = 5000,
}

race_map = {}

for name,data in pairs(ac.table.unit) do
    if data.race and not data.is_special then
        local list = race_map[data.race] or {}
        table.insert(list,name)
        race_map[data.race] = list
    end
end

for race,list in pairs(race_map) do
    table.sort(list,function (a,b)
        return a < b
    end)
end

for i = 1, 16 do
    local player = ac.player(i)

    player.build_map = {}
    player.build_map2 = {}
end

local score_map = {
    ['月之骑士'] = 1,
    ['巨魔战将'] = 1,
    ['鱼人夜行者'] = 1,
    ['冰女'] = 1,
    ['美杜莎'] = 1,
}
--建筑类
build_class = {


    --创建一个建筑
    create = function (player,name,point)

        local has = false
        local name2 = name .. '（皮肤）'
        if score_map[name] then
            if player.arch_list and (player.arch_list[name2] or 0) > 0 then
                has = true
            end
            if player.bill_item and (player.bill_item[name2] or 0) > 0 then 
                has = true 
            end 
        else
            if player.bill_item and (player.bill_item[name2] or 0) > 0 then
                has = true
            end
        end

        if has then
            name = name2
        end

        local unit = player:create_unit(name,point,270)

        if unit == nil  then
            return
        end

        local skill = unit:add_skill(name2,'英雄',4)
        if skill then
            if has then
                skill:set_level(2)
            else
                skill:disable()
            end
        end

        local data = ac.table.unit[unit:get_name()]

        if data.rank then
            japi.EXSetUnitArrayString(base.string2id(unit.id), 61, 0, unit:get_name() .. ' (' .. data.rank ..')')
        end

        setmetatable(data,{__index = build_class})

        unit:set('移动速度',0)

        --添加一个星级技能
        unit:add_skill('提升星级','英雄',8)

        --都添加一个物品栏
        unit:add_ability 'AInv'

        --默认1星级
        unit:set_star_level(1)

        unit.handle_id = handle_manager:allocate()


        player.build_map[unit.handle_id] = unit

        local real_name = name:gsub('（皮肤）','')

        local count = player.build_map2[real_name] or 0

        player.build_map2[real_name] = count + 1


        player:event_notify('玩家-创建建筑', player, unit)

        --ac.dummy:issue_order('ensnare',unit)

        unit.born_point = unit:get_point()
        unit.blink_timer = ac.loop(1000, function()
            unit:blink(unit.born_point)
        end)

        return unit
    end,

    remove = function (self)
        if self.removed then
            return
        end

        local player = self:get_owner()

        local id = self.handle_id
        if id then
            player.build_map[id] = nil
            handle_manager:free(id)
            self.handle_id = nil

            local name = self:get_name()
            local real_name = name:gsub('（皮肤）','')

            local count = player.build_map2[real_name] or 1

            player.build_map2[real_name] = count - 1

        end

        player:event_notify('玩家-删除建筑', player, self)

        unit_class.remove(self)
        self.blink_timer:remove()


    end,


    --创建建造物品 给英雄
    create_item = function (hero,name)
        local data = ac.table.unit[name]
        if data == nil or data.is_build == nil then
            return
        end

        local art = get_unit_slk(name,'Art')
        local model = get_unit_slk(name,'file') or ''
        local item = hero:add_item('建造')
        item:set_sell_price(price_map[data.rank or ''] or price_map['N'])

        item.build = name

        function item:get_tip()

            --引用了本地玩家 不要引用返回值做任何计算
            local player = ac.player.self

            local color = color_map[data.rank or ''] or data.rank or ''
            local tip = ''
            local list = race_map[data.race]
            if list then
                tip = '羁绊 : '
                for i,n in ipairs(list) do
                    if n ~= name then
                        local count = player.build_map2[n] or 0
                        if count > 0 then
                            n = '|cffffcc00' .. n .. '|r'
                        end
                        tip = tip .. n .. ' '
                    end
                end
            end
            local name2 = name
            local count = player.build_map2[name] or 0
            if count > 0 then
                name2 = '|cffffcc00' .. name .. '|r'
            end

            local str = string.format(
                '英雄 : %s|n属性 : %s|n种族 : %s|n%s|n稀有度 : %s|n|cff808080使用即可召唤该英雄|r',
                name2,
                data.main_attribute,
                data.race,
                tip,
                color
            )
            return item_class.get_tip(self,str)
        end
        function item:get_title()
            return '召唤卡片-' .. self.build
        end


        item:set_art(art)

        item:update()
        item:set_model(model)
        item:set_size(0.8)
        item:update_ui()

        item.timer = ac.loop(1000,function ()
			item:update()
		end)

        return item
    end,

    --转换物品为建筑
    convert_build = function (item,point)
        local hero = item.owner
        if hero == nil then
            return
        end
        local player = hero:get_owner()
        local name = item.build
        if name == nil then
            return
        end

        --创建一个建筑
        local build = build_class.create(player,name,point)

        if build == nil then
            return
        end

        local eff = point:effect
        {
            model = [[effect\AZ_Lina(2)_T1_MagicMatrix.mdx]],
        }
        eff:remove()

        build:setAlpha(0)
        ac.wait(500,function ()
            build:setAlpha(100)
            local buff = build:find_buff('渐隐')
            if buff then
                buff.origin_alpha = 100
            end
        end)

        --读取物品信息
        build:load_item_info(item)

        return build
    end,

    --建筑转换为物品 并给予 hero
    convert_item = function (self,hero)
        local item = ac.build.create_item(hero,self:get_name())
        if item == nil then
            return
        end

        self:save_info_to_item(item)
        self:remove()
        return item
    end,


    --读取信息
    load_item_info = function (self,item)
        local info = item.info

        if info == nil then
            return
        end

        self:set('生命',info.hp)
        self:set('魔法',info.mp)
        self:set_star_level(info.level)
        self:add_exp(info.exp)

        self:add('基础力量',info.str or 0)
        self._str = info.str
        self:add('攻击速度',info._asd or 0)
        self._asd = info.asd

        self.all_out_damage = info.all_out_damage

        self.catch_soul = info.catch_soul
        self.swyz = info.swyz

        for index,value in ipairs(info.skill) do
            local skill = self:find_skill(value.name,'英雄')
            if skill and value.cd > 0 then
                skill:set_cd(value.cd)
            end
        end

        for index,value in ipairs(info.item) do
            local name = value.name
            local item
            if value.build then
                item = ac.build.create_item(self,value.build)
                if item then
                    item.info = value.info
                end
            else
                item = self:add_item(name)
                if item and value.cd and value.cd > 0 then
                    item.skill:set_cd(value.cd)
                end
            end
            if item and value.slot_id and item.slot_id ~= value.slot_id then
                item:set_slot(value.slot_id)
            end
        end

    end,

    --保存信息到物品里
    save_info_to_item = function (self,item)
        local info = {}
        info.hp = self:get('生命')
        info.mp = self:get('魔法')
        info.all_out_damage = self.all_out_damage
        info.str = self._str
        info.asd = self._asd

        info.skill = {}
        for i = 1,12 do
            local skill = self:find_skill(i,'英雄')
            if skill then
                table.insert(info.skill, {name = skill:get_name(),cd = skill:get_cd()})
            end
        end

        local list = self:find_item()
        info.item = {}
        for i,object in ipairs(list) do
            local item_info = {
                name = object:get_name(),
                slot_id =  object.slot_id,
                cd = object.skill:get_cd(),
            }
            if object.build then
                item_info.build = object.build
                item_info.info = object.info
            end
            table.insert(info.item,item_info)
        end

        info.level = self:get_star_level()

        info.exp = self:get_exp()

        info.catch_soul = self.catch_soul
        info.swyz = self.swyz

        item.info = info
    end,


    get_rank_level = function (self)
        return level_map[self.rank or 'N'] or 1
    end,


}
setmetatable(build_class,{__index = unit_class})

ac.build = build_class


function player_class:each_build()
	local result = {}
    local map = self.build_map
    if map then
        for id,unit in pairs(map) do
            if unit.handle_id and not unit._is_illusion then
                table.insert(result,unit)
            end
        end
        table.sort(result,function (a,b)
            return a.handle_id < b.handle_id
        end)
    end

	local n = 0
	return function (t, v)
		n = n + 1
		return t[n]
	end, result
end
