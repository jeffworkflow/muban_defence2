--血条亮红色
local new_ui = class.panel:builder{
    x = 1440,--屏幕界面X坐标
    y = 300,--屏幕界面Y坐标
    w = 334*1.4,
    h = 206*1.9,
    level = 1,
    is_show = true,
    normal_image = 'Transparent.tga',
    total_damage = 0,
    player_info = {
        [1] = {id=1,color = '|cfffff9e7', bg_path = [[image\red.tga]],damage = 0,rank = 0,rate = 0},
        [2] = {id=2,color = '|cfffff9e7', bg_path = [[image\blue.tga]],damage = 0,rank = 0,rate = 0},
        [3] = {id=3,color = '|cfffff9e7', bg_path = [[image\indigo.tga]],damage = 0,rank = 0,rate = 0},
        [4] = {id=4,color = '|cfffff9e7', bg_path = [[image\purple.tga]],damage = 0,rank = 0,rate = 0},
        [5] = {id=5,color = '|cfffff9e7', bg_path = [[image\yellow.tga]],damage = 0,rank = 0,rate = 0},
        [6] = {id=6,color = '|cfffff9e7', bg_path = [[image\orange.tga]],damage = 0,rank = 0,rate = 0},
    },
    fresh = function(self)
        
        --改变总伤害
        self.bg.zongsh_p.zongsh_t.damage:set_text(('%s [%s]'):format(bn2str(self.total_damage),'100%'))
        -- local temp = ac.table_copy(self.player_info)
        local temp = {}
        for i,data in ipairs(self.player_info) do 
            if ac.player(data.id):is_player() then 
                table.insert(temp,{id = data.id,color = data.color,bg_path = data.bg_path,damage=data.damage,rate = data.rate})
            end
        end
        --排序
        table.sort(temp,function(a,b)
            return a.damage>b.damage 
        end)

        for i,tab in ipairs(self.bg.player_damages) do 
            -- print(i,tab,temp,temp[i])
            tab:set_normal_image(temp[i].bg_path)
            tab:set_width(temp[i].rate/100*420)
            tab.player:set_text(temp[i].color..ac.player(temp[i].id):get_name()..'|r')
            tab.player.damage:set_text((temp[i].color..'%s [%s%%]|r'):format(bn2str(temp[i].damage),temp[i].rate))  
        end

    end,
    init_data =function(self)
        self.total_damage = 0 
        for i,data in ipairs(self.player_info) do 
            data.damage = 0 
            data.rank = 0 
            data.rate = 0 
        end
        for i,tab in ipairs(self.bg.player_damages) do 
            tab:set_width(1)
        end
    end,

    --伤害列表bg
    bg = {
        -- x = 0,--屏幕界面X坐标
        -- y = 0,--屏幕界面Y坐标
        -- w = 0,
        -- h = 0,
        level = 1,
        type = 'texture',
        normal_image = [[image\ui_shlb.tga]],
        --title 总伤害
        title = {
            x = 170,--屏幕界面X坐标
            y = 25,--屏幕界面Y坐标
            w = 80,
            h = 80,
            level = 3,
            type = 'text',
            text = '|cfff18f24BOSS伤害列表|r', --文本内容
            -- align = 0, --对齐方式
            font_size = 14, --字体大小
        },
        --总伤害 底色+文字
        zongsh_p = {
            x = 25,--屏幕界面X坐标
            y = 91,--屏幕界面Y坐标
            w = 420,
            h = 32,
            level = 1,
            type = 'texture',
            normal_image = [[image\redz.tga]],
            zongsh_t = {
                x = 10,--屏幕界面X坐标
                -- y = 70,--屏幕界面Y坐标
                -- w = 80,
                -- h = 80,
                level = 3,
                type = 'text',
                text = '总伤害|r',
                font_size = 14, --字体大小
                damage = {
                    x = 320,--屏幕界面X坐标
                    -- y = 70,--屏幕界面Y坐标
                    w = 80,
                    h = 80,
                    level = 3,
                    align = 2,
                    type = 'text',
                    text = '0  [100%]',
                    font_size = 14, --字体大小
                },
            },
        },
        create_player_damage = function(self)
            local panel = self
            -- print('sfaefeeeeeeeeeeeeeeeeeeeeee',self.parent.player_info)
            panel.player_damages = panel.player_damages or {}
            local index = 0
            for i=1,6 do 
                local p = ac.player(i)
                if p:is_player() then 
                    -- print('玩家名字',i,index,ac.player(i):get_name())
                    local award_ui = class.panel:builder
                    {
                        x = 25,--屏幕界面X坐标
                        y = 131 + index*40,--屏幕界面Y坐标
                        w = 1 or math.random(50,420),
                        h = 32,
                        parent = self,
                        level = 1,
                        type = 'texture',
                        normal_image = self.parent.player_info[i].bg_path,
                        alpha = 0.8,
                        player = {
                            x = 10,--屏幕界面X坐标
                            y = 5,
                            level = 3,
                            type = 'text',
                            text = self.parent.player_info[i].color..ac.player(i):get_name()..'|r',
                            font_size = 12, --字体大小
                            damage = {
                                x = 320,--屏幕界面X坐标
                                w = 80,
                                level = 3,
                                align = 2,
                                type = 'text',
                                text = self.parent.player_info[i].color..'0  [0%]',
                                font_size = 12, --字体大小
                            },
                        },
                    }
                    table.insert(panel.player_damages,award_ui)
                    index = index + 1 
                end
            end
        end,
    },

}
new_ui.bg:create_player_damage()
new_ui:hide()


-- 万：代表的是10的四次方。 
-- 亿：代表的是10的八次方。 
-- 兆：代表的是10的十二次方。 
-- 京：代表的是10的十六次方。 
-- 垓：代表的是10的二十次方。 
-- 杼：代表的是10的二十四次方。 
-- 穰：代表的是10的二十八次方。 
-- 沟：代表的是10的三十二次方。 
-- 涧：代表的是10的三十六次方。 
-- 正：代表的是10的四十次方。 
-- 载：代表的是10的四十四次方。
    --
local dw = {
    [0] = ' ',
    [4] = '万',
    [8] = '亿',
    [12] = '兆',
    [16] = '京',
    [20] = '垓',
    [24] = '杼',
    [28] = '穰',
    [32] = '沟',
    [36] = '涧',
    [40] = '正',
    [44] = '载',
} 
--数字转换 
function bn2str(value)
    local str = ''
	local value = tonumber(value)
	if type(value) == 'string' then 
		return str
    end	

    for i=11,0,-1 do
        if value >= 10^(4*i) then
            -- print('a为10的幂次数,dw[a],value:',a,dw[i*4],value)
            if value > 10^((i*4)+3) then
                str = str..(' %.1f'):format(value/10^(i*4))..dw[i*4]
            elseif value > 10^((i*4)+2) then
                str = str..(' %.2f'):format(value/10^(i*4))..dw[i*4]
            elseif value > 10^((i*4)+1) then
                str = str..(' %.3f'):format(value/10^(i*4))..dw[i*4]
            elseif value > 10^((i*4)-0) then
                str = str..(' %.4f'):format(value/10^(i*4))..dw[i*4]
            end
            break
        end
    end
    -- print('数据：',str)
    return str
end

if not ac.ui then 
    ac.ui = {}
end
local damage_units ={}
--单位受到伤害时统计
function ac.ui:add_damage_total(u)
    -- print('111',u:get_name(),u.handle)
    if not u then 
        return 
    end

    if damage_units[u.handle] then 
        print('已有数据',u:get_name(),u.handle)
        return 
    end
    damage_units[u.handle] = u
    --显示ui
    new_ui:show()
    --每一秒刷新一次统计数据
    if not new_ui.trg then 
        new_ui.trg = ac.loop(1000,function()
            new_ui:fresh()
        end)
    end
    --注册受到伤害事件
    u:event '伤害计算完毕' (function(_,damage)
        local source = damage.source
        local p = source.owner 
        -- print('伤害计算完毕:',source,p,damage.current_damage)
        new_ui.total_damage = (new_ui.total_damage or 0 ) + damage.current_damage
        local id = p:get()
        if new_ui.player_info[id] then 
            new_ui.player_info[id].damage = new_ui.player_info[id].damage + damage.current_damage
        end
        --刷新所有玩家的rate 
        for i,data in ipairs(new_ui.player_info) do 
            data.rate = string.format("%.f",(data.damage / new_ui.total_damage * 100))
        end
        -- new_ui.player_info[id].rate =string.format("%.f",(new_ui.player_info[id].damage / new_ui.total_damage * 100))
    end)
    u:event '单位-死亡'(function(self)
        damage_units[u.handle] = nil
        local ix=0
        for i,u in pairs(damage_units) do 
            ix = ix + 1
        end
        if ix == 0 then 
            new_ui:fresh()
            if new_ui.trg then
                new_ui.trg:remove()
                new_ui.trg = nil
            end
            --等待10秒隐藏面板
            ac.wait(10*1000,function()
                new_ui:hide()
                --初始化ui数据
                new_ui:init_data()
            end)
        end
    end)
end

ac.wait(0,function()
    ac.game:event '单位-创建' (function(self, u)
        if _in(u:get_name(),ac.attack_boss) then 
            ac.ui:add_damage_total(u)
        end
    end)
    --如果是马甲单位，则只会有第一次单位-创建 回调。剩下都为单位-创建前 
    -- ac.game:event '单位-创建前' (function(self, u)
    --     if _in(u.name,ac.attack_boss) then 
    --         ac.ui:add_damage_total(u)
    --     end
    -- end)
end)
