-- local Base64 = require 'ac.Base64'
local japi = require 'jass.japi'
local player = require 'ac.player'
ac.server ={}
--读取玩家的商城道具
local item = {
    {'JBLB','金币礼包'},
    {'MCLB','木材礼包'},
    {'YJZZ','永久赞助'},
    {'YJCJZZ','永久超级赞助'},
    {'HDJ','皇帝剑'},
    {'HDD','皇帝刀'},
    {'JSYYY','绝世阳炎翼'},
    {'LHHMY','轮迴幻魔翼'},
    {'XLSF','限量首充'},
    {'SCDLB','首充大礼包'},

    {'GL','骨龙'},
    {'XWK','小悟空'},

    {'YXZZB','至尊宝'},
    {'YXGL','鬼厉'},
    {'YXJX','剑仙'},
    {'YXZSB','剑仙直升包'},

    {'SXS','神仙水'},
    {'SZDLB','神装大礼包'},
    {'SJDLB','神技大礼包'},
    {'XBXFX','寻宝小飞侠'},
    
    {'GFQLLY','孤风青龙领域'},
    {'YYCLLY','远影苍龙领域'},

    {'ZLTZ','真龙天子'},
    {'QTDS','齐天大圣A'},
    {'QTDSB','齐天大圣B'},

    {'BBDLB','百变英雄礼包'},
    {'SJBCLB','赛季补偿礼包'},

    --key,key_name,地图等级要求
    {'WXHP','五星好评礼包',3},
    {'XHB','夏侯霸',5},
    {'YJ','虞姬',10},
    {'TJXM','太极熊猫',15},
    {'DRJ','狄仁杰',25},
    {'YND','伊利丹',32},

    {'hjblj','惊虹奔雷剑',20},
    {'xyxyy','玄羽绣云翼',30},
    
    {'ltly','龙腾领域',13},
    {'fsrlly','飞沙热浪领域',17},
    {'lxytly','灵霄烟涛领域',22},

    {'fxlhj','飞星雷火剑',26},
    {'byjhy','白羽金虹翼',28},

    {'gg','关公',35},
    {'jbl','加百列',42},
    {'cxwxly','赤霞万象领域',37},
    
-- {'gd','肝帝',60},
}


local cus_key = {
    -- key     名字    奖励  所需值 地图等级 奖励  所需值 地图等级
    {'cntsb','士兵',{['吕布'] = {1,2}}},
    {'cntqs','骑士',{['熊灵分裂'] = {2,4}}},
    {'cntzj','主教',{['梅卡托克'] = {3,6}}},
    {'cntbl','堡垒',{['爱国者导弹'] = {4,8}}},
    {'cntgw','国王',{['张飞'] = {5,9}}},
    {'cnthh','皇后',{['熊灵攻击减甲'] = {6,10}}},
    {'cntcq','传奇',{['金克丝'] = {7,11}}},
    {'cntwglf','万古流芳',{['炮台多重射'] = {8,12}}},
    {'cntcfrs','超凡入圣',{['貂蝉'] = {9,13}}},
    {'cntgsyj','冠世一绝',{['熊灵粉碎击'] = {10,14}}},
    {'cntcjql','超绝群伦',{['杰拉米'] = {10,15}}},

    {'timesb','士兵时长'},
    {'timeqs','骑士时长'},
    {'timezj','主教时长'},
    {'timebl','堡垒时长'},
    {'timegw','国王时长'},
    {'timehh','皇后时长'},
    {'timecq','传奇时长'},
    {'timewglf','万古流芳时长'},
    {'timecfrs','超凡入圣时长'},
    {'timegsyj','冠世一绝时长'},
    {'timecjql','超绝群伦时长'},

    {'wxnd','无限难度'},
    {'cwjn','宠物技能'},
                             --奖励        所需值 所需地图等级 返回值
    {'cwjnc','宠物纪念册',{ ['宠物纪念册'] = {1,5,value = function(self,p) return p:Map_GetServerValue('cwjnc') end}}},
    {'wsdmt','我是大魔头',{ ['我是大魔头'] = {1,1,value = function(self,p) return math.min(p:Map_GetMapLevel()*1,p:Map_GetServerValue('wsdmt')) end}}},
  
    {'hjkg','黄金矿工',{ ['黄金矿工'] = {1,1,value = function(self,p) return math.min(p:Map_GetMapLevel()*1,p:Map_GetServerValue('hjkg')) end}}},
    {'sdz','书呆子',{ ['书呆子'] = {1,1,value = function(self,p) return math.min(p:Map_GetMapLevel()*1,p:Map_GetServerValue('sdz')) end}}},
    {'jxz','剑瞎子',{ ['剑瞎子'] = {1,1,value = function(self,p) return math.min(p:Map_GetMapLevel()*1,p:Map_GetServerValue('jxz')) end}}},
    {'cmgdxgn','采蘑菇的小姑娘',{ ['采蘑菇的小姑娘'] = {1,1,value = function(self,p) return math.min(p:Map_GetMapLevel()*1,p:Map_GetServerValue('cmgdxgn')) end}}},
    {'ndrs','扭蛋人生',{ ['扭蛋人生'] = {1,1,value = function(self,p) return math.min(p:Map_GetMapLevel()*1,p:Map_GetServerValue('ndrs')) end}}},
    {'dutu','du徒',{ ['du徒'] = {1,1,value = function(self,p) return math.min(p:Map_GetMapLevel()*1,p:Map_GetServerValue('dutu'))  end}}},
    
    {'qhzr','强悍之人',{ ['强悍之人'] = {1,1,value = function(self,p) return math.min(p:Map_GetMapLevel()*1,p:Map_GetServerValue('qhzr'))  end}}},
    {'xn','血牛',{ ['血牛'] = {1,1,value = function(self,p) return math.min(p:Map_GetMapLevel()*1,p:Map_GetServerValue('xn'))  end}}},
    {'ycmjbm','一出门就被秒',{ ['一出门就被秒'] = {1,1,value = function(self,p) return math.min(p:Map_GetMapLevel()*1,p:Map_GetServerValue('ycmjbm'))  end}}},
    {'jsmj','绝世魔剑',{ ['绝世魔剑'] = {1,1,value = function(self,p) return math.min(p:Map_GetMapLevel()*1,p:Map_GetServerValue('jsmj'))  end}}},


    {'cdwq','存档武器'},
    {'cdyd','存档腰带'},
    {'cdxz','存档鞋子'},
    {'cdyf','存档衣服'},
    {'cdtk','存档头盔'},
    {'cdst','存档手套'},

    {'sldwb','挖宝熟练度',{
            --奖励  所需值 地图等级
            ['东皇钟'] = {3000,3},
            ['轩辕剑'] = {9000,6},
            ['缚妖索'] = {18000,9},
            ['青莲宝色旗'] = {30000,12},
            ['莫邪宝剑'] = {45000,15},
            ['盘古斧'] = {63000,18},
            ['招妖幡'] = {84000,21},
            ['昊天塔'] = {108000,24},
            ['太极符印'] = {135000,27},
            ['崆峒印'] = {165000,30},
        }
    },

    {'sldks','看书熟练度',{
            --奖励  所需值 地图等级
            ['血雾领域'] = {1000,1},
            ['龙腾领域'] = {6000,4},
            ['迦蓝领域'] = {14000,7},
            ['极寒领域'] = {25000,10},
            ['黄龙天翔领域'] = {39000,13},
            ['焚魂镇妖领域'] = {56000,16},
            ['真武青焰领域'] = {76000,19},
            ['琉光十色领域'] = {99000,22},
            ['孤风青龙领域'] = {125000,25},
            ['远影苍龙领域'] = {154000,28},
        }
    },
    {'slddz','打造熟练度',{
        --奖励  所需值 地图等级
            ['熔炉炎刀'] = {2000,2},
            ['冰莲穿山剑'] = {7500,5},
        }
    },
    {'sldzs','种树熟练度',{
        --奖励  所需值 地图等级
            ['热血青年'] = {2000,2},
            ['逆天改命'] = {7500,5},
        }
    },
    {'sldbp','白嫖熟练度',{
        --奖励  所需值 地图等级
            ['风速狗'] = {2000,2},
            ['兜兜猪'] = {7500,5},
        }
    },
    {'sldytz','摇骰子熟练度',{
        --奖励  所需值 地图等级
            ['热血青年'] = {2000,2},
            ['逆天改命'] = {7500,5},
        }
    },



    {'fty','番天印',{ ['番天印'] = {1,1,value = function(self,p) return math.min(p:Map_GetMapLevel()*1,p:Map_GetServerValue('fty')) end}}},
    {'zjzt','战舰之舵',{ ['战舰之舵'] = {1,1,value = function(self,p) return math.min(p:Map_GetMapLevel()*1,p:Map_GetServerValue('zjzt')) end}}},
    {'ltc','量天尺',{ ['量天尺'] = {1,1,value = function(self,p) return math.min(p:Map_GetMapLevel()*1,p:Map_GetServerValue('ltc')) end}}},
    {'xkwz','虚空王座',{ ['虚空王座'] = {1,1,value = function(self,p) return math.min(p:Map_GetMapLevel()*1,p:Map_GetServerValue('xkwz')) end}}},
    {'ty','天眼',{ ['天眼'] = {1,1,value = function(self,p) return math.min(p:Map_GetMapLevel()*1,p:Map_GetServerValue('ty')) end}}},
    {'xyzx','血羽之心',{ ['血羽之心'] = {1,1,value = function(self,p) return math.min(p:Map_GetMapLevel()*1,p:Map_GetServerValue('xyzx')) end}}},
    {'tszx','天神之息',{ ['天神之息'] = {1,1,value = function(self,p) return math.min(p:Map_GetMapLevel()*1,p:Map_GetServerValue('tszx')) end}}},
    {'msz','灭世者',{ ['灭世者'] = {1,1,value = function(self,p) return math.min(p:Map_GetMapLevel()*1,p:Map_GetServerValue('msz')) end}}},
    {'yzzx','宇宙之心',{ ['宇宙之心'] = {1,1,value = function(self,p) return math.min(p:Map_GetMapLevel()*1,p:Map_GetServerValue('yzzx')) end}}},
    {'tcslg','太初锁灵鼓',{ ['太初锁灵鼓'] = {1,1,value = function(self,p) return math.min(p:Map_GetMapLevel()*1,p:Map_GetServerValue('tcslg')) end}}},

    --自定义服务器用到的内容
    {'cntwb','挖宝'},
    {'today_cntwb','今日挖宝'},
    {'today_cntwbrank','今日挖宝排名'},

    {'qd','签到',{
        --奖励  所需值 地图等级
            ['签到'] = {1,1,value = function(self,p) return math.min(p:Map_GetMapLevel()*20,(p.cus_server['签到'] or 0)) end},
            ['开始签到'] = {2,1},
            ['每日一签'] = {5,3},
        }
    },
}

--11存档信息
if record_11 then 
    item = {
        {'vip','满赞'},
        {'20000956','金币礼包'},
        {'20000955','木材礼包'},
      
        {'cxwxly','赤霞万象领域',37},
        
    -- {'gd','肝帝',60},
    }
    -- print(item[1][1],item[1][2],ac.player(1):Map_HasMallItem(item[1][1]))
    table.insert(cus_key,{'exp','地图经验'})
    table.insert(cus_key,{'level','地图等级'})
    print(ac.player(1):Map_GetServerValue('sjjh'))
end 

ac.cus_server_key = cus_key
ac.mall = item 

--通过key取 name 和 是否商城道具
function ac.server.key2name(key)
    local res
    local is_mall
    --取自定义key,value
    for i,v in ipairs(ac.cus_server_key) do 
        if v[1] == key then 
            res = v[2]
            break
        end
    end  
    --取自定义key,value)
    for i,v in ipairs(ac.mall) do 
        if v[1] == key then 
            res = v[2]
            break
        end
    end     
    return  res
end  
--通过 name 取 key
function ac.server.name2key(name) 
    local res
    --取自定义key,value
    for i,v in ipairs(ac.cus_server_key) do 
        if v[2] == name then 
            res = v[1]
            break
        end
    end  
    --取自定义key,value
    for i,v in ipairs(ac.mall) do 
        if v[2] == name then 
            res = v[1]
            break
        end
    end   
    return  res
end

