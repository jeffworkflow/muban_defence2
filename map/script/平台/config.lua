-- local Base64 = require 'ac.Base64'
local japi = require 'jass.japi'
local player = require 'ac.player'
ac.server ={}
--读取玩家的商城道具
local item = {
    {'JBLB','金币礼包',1},
    {'MCLB','木材礼包',1},
    
    {'SCLB','首充礼包',1},
    {'CZLB','成长礼包',1},

    {'CJZZ','初级赞助',1},
    {'GJZZ','高级赞助',1},
    {'TXZCBG','藏宝阁通行证',1},
    {'TXZCJG','藏经阁通行证',1},
    {'TXZJZ','剑冢通行证',1},
    {'TXZBHG','百花宫通行证',1},
    {'TXZLG','龙宫通行证',1},
    {'TXZZECB','罪恶城堡通行证',1},

    {'JX','剑仙',1},
    {'TZ','天尊',1},
    {'HKJLB','黑科技礼包',1},
    
    {'YZJL','元祖巨龙',1},
    {'YS','月神',1},
    {'YJSH','御剑守护',1},

    
    --反作弊
    {'XBDFX','寻宝大飞侠',1},
    --key,key_name,地图等级要求,只要地图等级达到就可以生效
    {'WXHP','五星好评礼包',3,true},

    {'HG','黄盖',5,true},
    {'GY','关羽',10,true},
    {'DLTS','堕落天使',15,true},
    {'JBL','加百列',20,true},
    {'WZJ','王昭君',25,true},
    {'YDN','雅典娜',30,true},
    
    {'DJSCLB','地图等级首充礼包',12,true},
    {'DJCZLB','地图等级成长礼包',18,true},
    {'DJCJZZ','地图等级初级赞助',28,true},
    {'DJGJZZ','地图等级高级赞助',35,true},
    {'DJYJSH','商城御剑守护',23,true},
    {'GD','肝帝',60,true},

    {'DJMLXD','魔灵限定',7,true},
    {'SDS','圣斗士',40,true},
    {'DJYGJL','地图等级元祖巨龙',7,true},
    
}


local cus_key = {
    -- key     名字    奖励  所需值 地图等级 奖励  所需值 地图等级
    {'cntsb','士兵',{['吕布'] = {1,2}}},
    {'cntqs','骑士',{['熊灵分裂'] = {2,4}}},
    {'cntzj','主教',{['鬼剑愁'] = {3,6}}},
    {'cntbl','堡垒',{['爱国者导弹'] = {4,8}}},
    {'cntgw','国王',{['张飞'] = {5,9}}},
    {'cnthh','皇后',{['熊灵攻击减甲'] = {6,10}}},
    {'cntcq','传奇',{['金克丝'] = {7,11}}},
    {'cntwglf','万古流芳',{['炮台多重射'] = {8,12}}},
    {'cntcfrs','超凡入圣',{['貂蝉'] = {9,13}}},
    {'cntgsyj','冠世一绝',{['熊灵粉碎击'] = {10,14}}},
    {'cntcjql','超绝群伦',{['杰拉米'] = {10,15}}},

    {'zdlsb','士兵战斗力'},
    {'zdlqs','骑士战斗力'},
    {'zdlzj','主教战斗力'},
    {'zdlbl','堡垒战斗力'},
    {'zdlgw','国王战斗力'},
    {'zdlhh','皇后战斗力'},
    {'zdlcq','传奇战斗力'},
    {'zdlwglf','万古流芳战斗力'},
    {'zdlcfrs','超凡入圣战斗力'},
    {'zdlgsyj','冠世一绝战斗力'},
    {'zdlcjql','超绝群伦战斗力'},

    {'cwjn','宠物技能'},
                             --奖励        所需值 所需地图等级 返回值
    {'cwjnc','宠物纪念册',{ ['宠物纪念册'] = {1,1,value = function(self,p) return p:Map_GetServerValue('cwjnc') end}}},

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
            ['东皇钟'] = {1500,3},
            ['轩辕剑'] = {4500,6},
            ['缚妖索'] = {9000,9},
            ['青莲宝色旗'] = {15000,12},
            ['莫邪宝剑'] = {22500,15},
            ['盘古斧'] = {31500,18},
            ['招妖幡'] = {42000,21},
            ['昊天塔'] = {54000,24},
            ['太极符印'] = {67500,27},
            ['崆峒印'] = {82500,30},
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
            ['熔炉炎刀'] = {1500,2},
            ['冰莲穿山剑'] = {6000,5},
            ['紫阳白涛剑'] = {12800,8},
            ['霜之哀伤'] = {22000,11},
            ['熔炉流星刀'] = {33600,14},
            ['冰魂火焰枪'] = {47600,17},
            ['霸王莲龙锤'] = {64000,20},
            ['方天画戟'] = {82800,23},
            ['桃花天香棒'] = {104000,26},
            ['苍雷噬金枪'] = {127600,29},

        }
    },
    {'sldzs','种树熟练度',{
        --奖励  所需值 地图等级
            ['热血青年'] = {1000,1},
            ['逆天改命'] = {4800,4},
            ['横扫六合'] = {11200,7},
            ['北斗七星'] = {20000,10},
            ['战神崛起'] = {31200,13},
            ['战神无敌'] = {44800,16},
            ['毁天灭地'] = {60800,19},
            ['爆肝之王'] = {79200,22},
            ['真龙天子'] = {100000,25},
            ['大至尊'] = {123200,28},
        }
    },
    {'sldbp','白嫖熟练度',{
        --奖励  所需值 地图等级
            ['风速狗'] = {2000,2},
            ['兜兜猪'] = {7500,5},
            ['星空麋鹿'] = {16000,8},
            ['烈焰凤凰'] = {27500,11},
            ['地狱蜘蛛'] = {42000,14},
            ['紫霜龙鹰'] = {59500,17},
            ['炎宿朱雀'] = {80000,20},
            ['苍魂青龙'] = {103500,23},
            ['晶蓝天马'] = {130000,26},
            ['金角天马'] = {159500,29},
        }
    },
    {'sldytz','摇骰子熟练度',{
        --奖励  所需值 地图等级
            ['小精灵之翼'] = {3000,3},
            ['火精灵之翼'] = {9000,6},
            ['杰拉米之翼'] = {18000,9},
            ['暗羽翼'] = {30000,12},
            ['光羽翼'] = {45000,15},
            ['玄羽绣云翼'] = {63000,18},
            ['绝世阳炎翼'] = {84000,21},
            ['龙吟双型翼'] = {108000,24},
            ['金鳞双型翼'] = {135000,27},
            ['赤魔双型翼'] = {165000,30},
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
    --活动
    {'mljpz','魔灵精品粽',{ ['魔灵精品粽'] = {1,1,value = function(self,p) return p:Map_GetServerValue('mljpz') end}}},
    --绝世神剑
    {'jssj','绝世神剑',{ ['绝世神剑'] = {1,1,value = function(self,p) return math.min(p:Map_GetMapLevel()*1,p:Map_GetServerValue('jssj'))  end}}},

    
    {'wxnd','无限难度'},
    {'tgxz','通关勋章',{
        --奖励  所需值 地图等级
            ['士兵勋章'] = {1,5,rate = 20, type = '二进制权限'},
            ['骑士勋章'] = {2,6,rate = 18, type = '二进制权限'},
            -- ['1作弊'] = {3,1,rate = 100, type = '二进制权限'},
            ['主教勋章'] = {4,7,rate = 16, type = '二进制权限'},
            ['堡垒勋章'] = {5,8,rate = 14, type = '二进制权限'},
            ['国王勋章'] = {6,9,rate = 12, type = '二进制权限'},
            ['皇后勋章'] = {7,10,rate = 10, type = '二进制权限'},
            ['传奇勋章'] = {8,11,rate = 8, type = '二进制权限'},
            ['万古流芳勋章'] = {9,12,rate = 6, type = '二进制权限'},
            ['超凡入圣勋章'] = {10,13,rate = 4, type = '二进制权限'},
            ['冠世一绝勋章'] = {11,14,rate = 2, type = '二进制权限'},
            ['超绝群伦勋章'] = {12,15,rate = 0, type = '二进制权限'},
        }
    },
    
    {'tlmk','贪婪魔窟',{
        --奖励  所需值 地图等级
            ['开拓者'] = {25,10},
            ['冒险家'] = {50,15},
            ['大冒险家'] = {100,20},
            ['冒险大师'] = {360,25},
        }
    },
    {'tlmklj','贪婪魔窟累计',{
            --奖励  所需值 地图等级
            ['拾荒者'] = {250,15},
            ['拾荒狂魔'] = {500,20},
            ['收藏家'] = {1000,25},
            ['大收藏家'] = {3600,30},
        }
    },
    {'axjf','爱心积分',{
            --奖励  所需值 地图等级
            ['救救孩子'] = {1000,10},
            ['关爱萌新'] = {2500,12},
            ['新人辅导员'] = {5000,14},
            ['无私奉献'] = {10000,16},
            ['爱心之星'] = {20000,18},
            ['爱心大使'] = {30000,20},
        }
    },
    {'mlzb','魔灵争霸',{
            --奖励  所需值 地图等级
            ['嗜血狂魔'] = {250,6},
            ['小魔灵'] = {500,9},
        }
    },
    --自定义服务器用到的内容
    {'today_mlzb','今日魔灵争霸'},
    {'today_mlzbrank','今日魔灵争霸排名'},

    {'today_axjf','今日爱心积分'},
    {'today_axjfrank','今日爱心积分排名'},

    {'today_tlmk','今日贪婪魔窟'},
    {'today_tlmkrank','今日贪婪魔窟排名'},

    
    {'xdzc','新的征程'},
    {'today_xdzc','今日新的征程'},
    {'today_xdzcrank','今日新的征程排名'},
    {'xdzcjl','新的征程奖励'},

    {'cntwb','挖宝'},
    {'today_cntwb','今日挖宝'},
    {'today_cntwbrank','今日挖宝排名'},

    {'cntks','看书'},
    {'today_cntks','今日看书'},
    {'today_cntksrank','今日看书排名'},

    {'cntdz','打造'},
    {'today_cntdz','今日打造'},
    {'today_cntdzrank','今日打造排名'},

    {'cntzs','种树'},
    {'today_cntzs','今日种树'},
    {'today_cntzsrank','今日种树排名'},

    {'cntbp','白嫖'},
    {'today_cntbp','今日白嫖'},
    {'today_cntbprank','今日白嫖排名'},
    
    {'cntytz','摇骰子'},
    {'today_cntytz','今日摇骰子'},
    {'today_cntytzrank','今日摇骰子排名'},

    {'qd','签到',{
        --奖励  所需值 地图等级
            ['签到'] = {1,1,value = function(self,p) return math.min(p:Map_GetMapLevel()*20,(p.cus_server['签到'] or 0)) end},
            ['开始签到'] = {2,1},
            ['每日一签'] = {5,3},
            ['我爱签到'] = {10,5},
            ['签到小弟'] = {20,7},
            ['签到小哥'] = {30,9},
            ['签到小达人'] = {45,11},
            ['签到大哥'] = {60,13},
            ['签到大佬'] = {75,15},
            ['签到大王'] = {90,17},
            ['签到大圣'] = {100,19},
        }
    },
    {'level','地图等级'}
}

--11存档信息
if record_11 then 
    item = {
        -- {'vip','满赞'},
        -- {'20000956','金币礼包'},
        -- {'20000955','木材礼包'},
      
        -- {'cxwxly','赤霞万象领域',37},
        
    -- {'gd','肝帝',60},
    }
    -- print(item[1][1],item[1][2],ac.player(1):Map_HasMallItem(item[1][1]))
    table.insert(cus_key,{'exp','地图经验'})
    table.insert(cus_key,{'level','地图等级'})
    print(ac.player(1):Map_GetServerValue('sjjh'))
end 

ac.server_key = cus_key
ac.mall = item 

--通过key取 name 和 是否商城道具
function ac.server.key2name(key)
    local res
    local is_mall
    --取自定义key,value
    for i,v in ipairs(ac.server_key) do 
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
    for i,v in ipairs(ac.server_key) do 
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

--通过 name 取 key
function ac.server.get_tab(name) 
    local res
    --取自定义key,value
    for i,v in ipairs(ac.server_key) do 
        if v[2] == name then 
            res = v
            break
        end
    end  
    --取自定义key,value
    for i,v in ipairs(ac.mall) do 
        if v[2] == name then 
            res = v
            break
        end
    end   
    return  res
end
