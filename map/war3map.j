globals
//globals from BzAPI:
constant boolean LIBRARY_BzAPI=true
trigger array BzAPI__DamageEventQueue
integer BzAPI__DamageEventNumber= 0
//endglobals from BzAPI
//globals from JapiConstantLib:
constant boolean LIBRARY_JapiConstantLib=true
integer array i_1
integer array i_2
integer array i_3
integer array i_4
integer array i_5
integer array i_6
integer array i_7
integer array i_8
integer array i_9
integer array i_10
integer array i_11
integer array i_12
integer array i_13
integer array i_14
integer array i_15
integer array i_16
integer array i_17
integer array i_18
integer array i_19
integer array i_20
integer array i_21
integer array i_22
integer array i_23
integer array i_24
integer array i_25
integer array i_26
integer array i_27
integer array i_28
integer array i_29
integer array i_30
integer array i_31
integer array i_32

//endglobals from JapiConstantLib
//globals from Mtpplayername:
constant boolean LIBRARY_Mtpplayername=true
//endglobals from Mtpplayername
//globals from YDTriggerSaveLoadSystem:
constant boolean LIBRARY_YDTriggerSaveLoadSystem=true
hashtable YDHT
hashtable YDLOC
//endglobals from YDTriggerSaveLoadSystem
//globals from japi:
constant boolean LIBRARY_japi=true
hashtable japi_ht=InitHashtable()
integer japi__key=StringHash("jass")
//endglobals from japi
//globals from LocalActionLib:
constant boolean LIBRARY_LocalActionLib=true
constant hashtable LocalActionLib__ht=japi_ht
constant integer LocalActionLib__key=StringHash("jass")
//endglobals from LocalActionLib
    // User-defined
integer udg_i= 0
    // Generated
trigger gg_trg_japi_________u= null
trigger gg_trg____japi___u= null
trigger gg_trg_______japi___u= null
trigger gg_trg_api= null
trigger gg_trg_get_name= null
trigger gg_trg_lua= null
string array Player_name

trigger l__library_init
rect gg_rct_yingxiong1= null
rect gg_rct_yingxiong2= null
rect gg_rct_yingxiong3= null
rect gg_rct_yingxiong4= null
rect gg_rct_yingxiong5= null
rect gg_rct_yingxiong6= null
rect gg_rct_yingxiong7= null
rect gg_rct_yingxiong8= null
rect gg_rct_yingxiong9= null
rect gg_rct_yingxiong10= null
rect gg_rct_yingxiong11= null
rect gg_rct_yingxiong12= null
rect gg_rct_yingxiong13= null
rect gg_rct_yingxiong14= null
rect gg_rct_yingxiong15= null
rect gg_rct_yingxiong16= null
rect gg_rct_yingxiong17= null
rect gg_rct_yingxiong18= null
rect gg_rct_yingxiong19= null
rect gg_rct_yingxiong20= null
rect gg_rct_xuanrenjingtou= null
rect gg_rct_xrcs= null
rect gg_rct_npc1= null
rect gg_rct_zxzw= null
rect gg_rct_zxzw1= null
rect gg_rct_zxzw2= null
rect gg_rct_zxzw3= null
rect gg_rct_npc2= null
rect gg_rct_npc3= null
rect gg_rct_npc4= null
rect gg_rct_npc5= null
rect gg_rct_npc6= null
rect gg_rct_npc7= null
rect gg_rct_npc8= null
rect gg_rct_npc9= null
rect gg_rct_npc10= null
rect gg_rct_npc11= null
rect gg_rct_npc12= null
rect gg_rct_npc13= null
rect gg_rct_npc14= null
rect gg_rct_npc15= null
rect gg_rct_jg2_jd= null
rect gg_rct_sylh= null
rect gg_rct_sylh1= null
rect gg_rct_yanhuang= null
rect gg_rct_yanhuang1= null
rect gg_rct_miyiyang= null
rect gg_rct_miyiyang1= null
rect gg_rct_jingpo= null
rect gg_rct_jingpo1= null
rect gg_rct_jingpo2= null
rect gg_rct_tianshu= null
rect gg_rct_tianshu1= null
rect gg_rct_shixiezhu= null
rect gg_rct_shixiezhu1= null
rect gg_rct_shixiezhu2= null
rect gg_rct_shaohuogun= null
rect gg_rct_shaohuogun1= null
rect gg_rct_lgfsg1= null
rect gg_rct_lgfnpc11= null
rect gg_rct_lgfnpc16= null
rect gg_rct_lgfnpc14= null
rect gg_rct_lgfnpc18= null
rect gg_rct_lgfnpc15= null
rect gg_rct_lgfnpc17= null
rect gg_rct_lgfnpc12= null
rect gg_rct_lgfnpc13= null
rect gg_rct_lgfsg2= null
rect gg_rct_lgfnpc21= null
rect gg_rct_lgfnpc26= null
rect gg_rct_lgfnpc24= null
rect gg_rct_lgfnpc28= null
rect gg_rct_lgfnpc25= null
rect gg_rct_lgfnpc27= null
rect gg_rct_lgfnpc22= null
rect gg_rct_lgfnpc23= null
rect gg_rct_lgfsg3= null
rect gg_rct_lgfnpc31= null
rect gg_rct_lgfnpc36= null
rect gg_rct_lgfnpc34= null
rect gg_rct_lgfnpc38= null
rect gg_rct_lgfnpc35= null
rect gg_rct_lgfnpc37= null
rect gg_rct_lgfnpc32= null
rect gg_rct_lgfnpc33= null
rect gg_rct_lgfsg4= null
rect gg_rct_lgfnpc41= null
rect gg_rct_lgfnpc46= null
rect gg_rct_lgfnpc44= null
rect gg_rct_lgfnpc48= null
rect gg_rct_lgfnpc45= null
rect gg_rct_lgfnpc47= null
rect gg_rct_lgfnpc42= null
rect gg_rct_lgfnpc43= null
rect gg_rct_lgfsg5= null
rect gg_rct_lgfnpc51= null
rect gg_rct_lgfnpc56= null
rect gg_rct_lgfnpc54= null
rect gg_rct_lgfnpc58= null
rect gg_rct_lgfnpc55= null
rect gg_rct_lgfnpc57= null
rect gg_rct_lgfnpc52= null
rect gg_rct_lgfnpc53= null
rect gg_rct_lgfsg6= null
rect gg_rct_lgfnpc61= null
rect gg_rct_lgfnpc66= null
rect gg_rct_lgfnpc64= null
rect gg_rct_lgfnpc68= null
rect gg_rct_lgfnpc65= null
rect gg_rct_lgfnpc67= null
rect gg_rct_lgfnpc62= null
rect gg_rct_lgfnpc63= null
rect gg_rct_shaohuogun2= null
rect gg_rct_chiyanjia= null
rect gg_rct_chiyanjia1= null
rect gg_rct_chiyanjia2= null
rect gg_rct_chongwu= null
rect gg_rct_lgfbh1= null
rect gg_rct_lgfbh2= null
rect gg_rct_lgfbh3= null
rect gg_rct_lgfbh4= null
rect gg_rct_lgfbh5= null
rect gg_rct_lgfbh6= null
rect gg_rct_bhhl1= null
rect gg_rct_bhhl= null
rect gg_rct_yijie1= null
rect gg_rct_yijie= null
rect gg_rct_yandi1= null
rect gg_rct_yandi= null
rect gg_rct_ronglian44= null
rect gg_rct_ronglian4= null
rect gg_rct_ronglian33= null
rect gg_rct_ronglian3= null
rect gg_rct_ronglian22= null
rect gg_rct_ronglian2= null
rect gg_rct_ronglian11= null
rect gg_rct_ronglian1= null
rect gg_rct_zxzw4= null
rect gg_rct_zxzw5= null
rect gg_rct_zxzw6= null
rect gg_rct_F2cs= null
rect gg_rct_cg1= null
rect gg_rct_cg2= null
rect gg_rct_cg3= null
rect gg_rct_cgboss4= null
rect gg_rct_jg1= null
trigger gg_trg_______u= null
rect gg_rct_cbg1= null
rect gg_rct_cbg3= null
rect gg_rct_cbg2= null
rect gg_rct_cbg4= null
rect gg_rct_cbt2= null
rect gg_rct_cjg1= null
rect gg_rct_cjg2= null
rect gg_rct_cjg3= null
rect gg_rct_cjg4= null
rect gg_rct_cjg5= null
rect gg_rct_cjg6= null
rect gg_rct_jianzhong1= null
rect gg_rct_jianzhong2= null
rect gg_rct_jianzhong3= null
rect gg_rct_jianzhong4= null
rect gg_rct_bhg1= null
rect gg_rct_bhg2= null
rect gg_rct_bhg3= null
rect gg_rct_bhg4= null
rect gg_rct_bhg5= null
rect gg_rct_bhg7= null
rect gg_rct_bhg6= null
rect gg_rct_longgong1= null
rect gg_rct_longgong2= null
rect gg_rct_longgong3= null
rect gg_rct_longgong8= null
rect gg_rct_longgong7= null
rect gg_rct_longgong6= null
rect gg_rct_longgong5= null
rect gg_rct_longgong4= null
rect gg_rct_zeds1= null
rect gg_rct_zeds2= null
rect gg_rct_zeds3= null
rect gg_rct_zeds4= null
rect gg_rct_zeds5= null
rect gg_rct_zeds7= null
rect gg_rct_zeds6= null
rect gg_rct_zeds8= null
rect gg_rct_tupo= null
rect gg_rct_tupo1= null
rect gg_rct_tupo2= null
rect gg_rct_shoulei11= null
rect gg_rct_shoulei12= null
rect gg_rct_shoulei13= null
rect gg_rct_shoulei14= null
rect gg_rct_shoulei15= null
rect gg_rct_shoulei16= null
rect gg_rct_shoulei21= null
rect gg_rct_shoulei22= null
rect gg_rct_shoulei23= null
rect gg_rct_shoulei24= null
rect gg_rct_shoulei25= null
rect gg_rct_shoulei26= null
rect gg_rct_shoulei31= null
rect gg_rct_shoulei32= null
rect gg_rct_shoulei33= null
rect gg_rct_shoulei34= null
rect gg_rct_shoulei35= null
rect gg_rct_shoulei36= null
rect gg_rct_shoulei41= null
rect gg_rct_shoulei42= null
rect gg_rct_shoulei43= null
rect gg_rct_shoulei44= null
rect gg_rct_shoulei45= null
rect gg_rct_shoulei46= null
rect gg_rct_shoulei51= null
rect gg_rct_shoulei52= null
rect gg_rct_shoulei53= null
rect gg_rct_shoulei54= null
rect gg_rct_shoulei55= null
rect gg_rct_shoulei56= null
rect gg_rct_shoulei61= null
rect gg_rct_shoulei62= null
rect gg_rct_shoulei63= null
rect gg_rct_shoulei64= null
rect gg_rct_shoulei65= null
rect gg_rct_shoulei66= null
rect gg_rct_shoulei71= null
rect gg_rct_shoulei72= null
rect gg_rct_shoulei73= null
rect gg_rct_shoulei74= null
rect gg_rct_shoulei75= null
rect gg_rct_shoulei76= null
rect gg_rct_shoulei81= null
rect gg_rct_shoulei82= null
rect gg_rct_shoulei83= null
rect gg_rct_shoulei84= null
rect gg_rct_shoulei85= null
rect gg_rct_shoulei86= null
rect gg_rct_shoulei91= null
rect gg_rct_shoulei92= null
rect gg_rct_shoulei94= null
rect gg_rct_shoulei95= null
rect gg_rct_shoulei96= null
rect gg_rct_shoulei101= null
rect gg_rct_shoulei102= null
rect gg_rct_shoulei103= null
rect gg_rct_shoulei104= null
rect gg_rct_shoulei105= null
rect gg_rct_shoulei106= null
rect gg_rct_shoulei93= null
rect gg_rct_zhanjiuzhan= null
rect gg_rct_zhanjiuzhan1= null
rect gg_rct_zhanjiuzhan2= null
rect gg_rct_moshen1= null
rect gg_rct_moshen2= null
rect gg_rct_moshen3= null
rect gg_rct_dujie1= null
rect gg_rct_moshen4= null
rect gg_rct_dujie2= null
rect gg_rct_ronglian105= null
rect gg_rct_ronglian104= null
rect gg_rct_ronglian101= null
rect gg_rct_ronglian102= null
rect gg_rct_ronglian106= null
rect gg_rct_ronglian103= null
rect gg_rct_ronglian107= null
rect gg_rct_huohai= null
rect gg_rct_jueshishenjian= null
rect gg_rct_jueshishenjian1= null
rect gg_rct_xiangzi1= null
rect gg_rct_xiangzi2= null
rect gg_rct_xiangzi3= null
rect gg_rct_xiangzi4= null
rect gg_rct_xiangzi5= null
rect gg_rct_xiangzi6= null
rect gg_rct_xiangzi7= null
rect gg_rct_xiangzi8= null
rect gg_rct_xiangzi9= null
rect gg_rct_xiangzi10= null
rect gg_rct_cbt3= null
rect gg_rct_zuqiu= null
rect gg_rct_zuqiu1= null
rect gg_rct_zuqiu2= null
rect gg_rct_sylz1= null
rect gg_rct_sylz= null
rect gg_rct_moku= null
rect gg_rct_moku1= null
rect gg_rct_moku2= null
rect gg_rct_moku3= null
rect gg_rct_moku4= null
rect gg_rct_moku5= null
rect gg_rct_zhuzi= null
rect gg_rct_yingxiong21= null
rect gg_rct_saijiboss1= null
rect gg_rct_saijiboss2= null
rect gg_rct_jiao2= null
rect gg_rct_jiao3= null
rect gg_rct_jiao4= null
rect gg_rct_jiao5= null
rect gg_rct_jiao1= null
rect gg_rct_jiao6= null
rect gg_rct_kpds= null
rect gg_rct_cbt5= null
rect gg_rct_shengxiao= null
rect gg_rct_shengxiao2= null
rect gg_rct_yingxiong22= null


camerasetup gg_cam_Camera_001= null

endglobals

    
    native SetHeroLevels takes code f returns nothing 
    native TeleportCaptain takes real x, real y returns nothing
    native GetUnitGoldCost takes integer unitid returns integer

//library BzAPI ends
//library JapiConstantLib:
    function JapiConstantLib_init_memory takes nothing returns nothing
         set i_1[8191]=0
 set i_2[8191]=0
 set i_3[8191]=0
 set i_4[8191]=0
 set i_5[8191]=0
 set i_6[8191]=0
 set i_7[8191]=0
 set i_8[8191]=0
 set i_9[8191]=0
 set i_10[8191]=0
 set i_11[8191]=0
 set i_12[8191]=0
 set i_13[8191]=0
 set i_14[8191]=0
 set i_15[8191]=0
 set i_16[8191]=0
 set i_17[8191]=0
 set i_18[8191]=0
 set i_19[8191]=0
 set i_20[8191]=0
 set i_21[8191]=0
 set i_22[8191]=0
 set i_23[8191]=0
 set i_24[8191]=0
 set i_25[8191]=0
 set i_26[8191]=0
 set i_27[8191]=0
 set i_28[8191]=0
 set i_29[8191]=0
 set i_30[8191]=0
 set i_31[8191]=0
 set i_32[8191]=0

    endfunction
    function JapiConstantLib_init takes nothing returns integer
        call ExecuteFunc("JapiConstantLib_init_memory")
        return 1
    endfunction

//library JapiConstantLib ends
//library Mtpplayername:
    function Mtpplayername__initgetname takes nothing returns nothing
        local integer i= 0
        local string name
        set i=0
        loop
            exitwhen ( i > 12 )
            set i=i + 1
            
            set name="|cff000000" + GetPlayerName(ConvertedPlayer(i)) + "|r"
            set Player_name[i]=name
        endloop
    endfunction

//library Mtpplayername ends
//library YDTriggerSaveLoadSystem:
    function YDTriggerSaveLoadSystem__Init takes nothing returns nothing
            set YDHT=InitHashtable()
        set YDLOC=InitHashtable()
    endfunction

//library YDTriggerSaveLoadSystem ends
//library japi:



    
    
     function Call takes string str returns nothing
        call UnitId(str)
    endfunction
    //获取鼠标在地图中的x轴
     function GetMouseX takes nothing returns real
        call SaveStr(japi_ht, japi__key, 0, "()R")
        call UnitId(("GetMouseX")) // INLINED!!
        return LoadReal(japi_ht, japi__key, 0)
    endfunction
    //获取鼠标在地图中的y轴
     function GetMouseY takes nothing returns real
        call SaveStr(japi_ht, japi__key, 0, "()R")
        call UnitId(("GetMouseY")) // INLINED!!
        return LoadReal(japi_ht, japi__key, 0)
    endfunction
    
    
    
    
    //==========================================================================
     function EXGetUnitAbility takes unit u,integer abilityId returns integer
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(u))
        call SaveInteger(japi_ht, japi__key, 2, abilityId)
        call SaveStr(japi_ht, japi__key, 0, "(II)I")
        call UnitId(("EXGetUnitAbility")) // INLINED!!
        return LoadInteger(japi_ht, japi__key, 0)
    endfunction
    
    // yd japi ==================================================================
    // 技能----------------------------------------------------
    
    ///<summary>技能属性 [JAPI]</summary>
  function YDWEGetUnitAbilityState takes unit u,integer abilcode,integer data_type returns real
        call SaveInteger(japi_ht, japi__key, 1, EXGetUnitAbility(u , abilcode))
        call SaveInteger(japi_ht, japi__key, 2, data_type)
        call SaveStr(japi_ht, japi__key, 0, "(II)R")
        call UnitId(("EXGetAbilityState")) // INLINED!!
		return LoadReal(japi_ht, japi__key, 0)
	endfunction
	///<summary>技能数据 (整数) [JAPI]</summary>
  function YDWEGetUnitAbilityDataInteger takes unit u,integer abilcode,integer level,integer data_type returns integer
        call SaveInteger(japi_ht, japi__key, 1, EXGetUnitAbility(u , abilcode))
        call SaveInteger(japi_ht, japi__key, 2, level)
        call SaveInteger(japi_ht, japi__key, 3, data_type)
        call SaveStr(japi_ht, japi__key, 0, "(III)I")
        call UnitId(("EXGetAbilityDataInteger")) // INLINED!!
		return LoadInteger(japi_ht, japi__key, 0)
	endfunction
	///<summary>技能数据 (实数) [JAPI]</summary>
  function YDWEGetUnitAbilityDataReal takes unit u,integer abilcode,integer level,integer data_type returns real
        call SaveInteger(japi_ht, japi__key, 1, EXGetUnitAbility(u , abilcode))
        call SaveInteger(japi_ht, japi__key, 2, level)
        call SaveInteger(japi_ht, japi__key, 3, data_type)
        call SaveStr(japi_ht, japi__key, 0, "(III)R")
        call UnitId(("EXGetAbilityDataReal")) // INLINED!!
		return LoadReal(japi_ht, japi__key, 0)
    endfunction
	///<summary>技能数据 (字符串) [JAPI]</summary>
  function YDWEGetUnitAbilityDataString takes unit u,integer abilcode,integer level,integer data_type returns string
        call SaveInteger(japi_ht, japi__key, 1, EXGetUnitAbility(u , abilcode))
        call SaveInteger(japi_ht, japi__key, 2, level)
        call SaveInteger(japi_ht, japi__key, 3, data_type)
        call SaveStr(japi_ht, japi__key, 0, "(III)S")
        call UnitId(("EXGetAbilityDataString")) // INLINED!!
		return LoadStr(japi_ht, japi__key, 0)
	endfunction
	///<summary>设置技能属性 [JAPI]</summary>
  function YDWESetUnitAbilityState takes unit u,integer abilcode,integer data_type,real value returns nothing
        call SaveInteger(japi_ht, japi__key, 1, EXGetUnitAbility(u , abilcode))
        call SaveInteger(japi_ht, japi__key, 2, data_type)
        call SaveReal(japi_ht, japi__key, 3, value)
        call SaveStr(japi_ht, japi__key, 0, "(IIR)V")
        call UnitId(("EXSetAbilityState")) // INLINED!!
    endfunction
	///<summary>设置技能数据 (整数) [JAPI]</summary>
  function YDWESetUnitAbilityDataInteger takes unit u,integer abilcode,integer level,integer data_type,integer value returns nothing
        call SaveInteger(japi_ht, japi__key, 1, EXGetUnitAbility(u , abilcode))
        call SaveInteger(japi_ht, japi__key, 2, level)
        call SaveInteger(japi_ht, japi__key, 3, data_type)
        call SaveInteger(japi_ht, japi__key, 4, value)
        call SaveStr(japi_ht, japi__key, 0, "(IIII)V")
        call UnitId(("EXSetAbilityDataInteger")) // INLINED!!
    endfunction
	///<summary>设置技能数据 (实数) [JAPI]</summary>
  function YDWESetUnitAbilityDataReal takes unit u,integer abilcode,integer level,integer data_type,real value returns nothing
        call SaveInteger(japi_ht, japi__key, 1, EXGetUnitAbility(u , abilcode))
        call SaveInteger(japi_ht, japi__key, 2, level)
        call SaveInteger(japi_ht, japi__key, 3, data_type)
        call SaveReal(japi_ht, japi__key, 4, value)
        call SaveStr(japi_ht, japi__key, 0, "(IIIR)V")
        call UnitId(("EXSetAbilityDataReal")) // INLINED!!
    endfunction
	///<summary>设置技能数据 (字符串) [JAPI]</summary>
  function YDWESetUnitAbilityDataString takes unit u,integer abilcode,integer level,integer data_type,string value returns nothing
        call SaveInteger(japi_ht, japi__key, 1, EXGetUnitAbility(u , abilcode))
        call SaveInteger(japi_ht, japi__key, 2, level)
        call SaveInteger(japi_ht, japi__key, 3, data_type)
        call SaveStr(japi_ht, japi__key, 4, value)
        call SaveStr(japi_ht, japi__key, 0, "(IIIS)V")
        call UnitId(("EXSetAbilityDataString")) // INLINED!!
    endfunction
	
    
    //设置技能变身数据A
     function EXSetAbilityAEmeDataA takes integer ability_handle,integer value returns boolean
        call SaveInteger(japi_ht, japi__key, 1, ability_handle)
        call SaveInteger(japi_ht, japi__key, 2, value)
        call SaveStr(japi_ht, japi__key, 0, "(II)B")
        call UnitId(("EXSetAbilityAEmeDataA")) // INLINED!!
        return LoadBoolean(japi_ht, japi__key, 0)
    endfunction
    
    //单位变身
     function YDWEUnitTransform takes unit u,integer abilcode,integer targetid returns nothing
		call UnitAddAbility(u, abilcode)
		call YDWESetUnitAbilityDataInteger(u , abilcode , 1 , 117 , GetUnitTypeId(u))
		call EXSetAbilityAEmeDataA(EXGetUnitAbility(u , abilcode) , GetUnitTypeId(u))
		call UnitRemoveAbility(u, abilcode)
		call UnitAddAbility(u, abilcode)
		call EXSetAbilityAEmeDataA(EXGetUnitAbility(u , abilcode) , targetid)
		call UnitRemoveAbility(u, abilcode)
	endfunction
    
    // 单位-------------------------------------------------------
    
    //暂停单位
     function EXPauseUnit takes unit unit_handle,boolean flag returns nothing
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(unit_handle))
        call SaveBoolean(japi_ht, japi__key, 2, flag)
        call SaveStr(japi_ht, japi__key, 0, "(IB)V")
        call UnitId(("EXPauseUnit")) // INLINED!!
    endfunction
    
    //获取单位字符串
     function EXGetUnitString takes integer unitcode,integer Type returns string
        call SaveInteger(japi_ht, japi__key, 1, unitcode)
        call SaveInteger(japi_ht, japi__key, 2, Type)
        call SaveStr(japi_ht, japi__key, 0, "(II)S")
        call UnitId(("EXGetUnitString")) // INLINED!!
        return LoadStr(japi_ht, japi__key, 0)
    endfunction
    
       //设置单位字符串
     function EXSetUnitString takes integer unitcode,integer Type,string value returns boolean
        call SaveInteger(japi_ht, japi__key, 1, unitcode)
        call SaveInteger(japi_ht, japi__key, 2, Type)
        call SaveStr(japi_ht, japi__key, 3, value)
        call SaveStr(japi_ht, japi__key, 0, "(IIS)B")
        call UnitId(("EXSetUnitString")) // INLINED!!
        return LoadBoolean(japi_ht, japi__key, 0)
    endfunction
    
    //获取单位实数
     function EXGetUnitReal takes integer unitcode,integer Type returns real
        call SaveInteger(japi_ht, japi__key, 1, unitcode)
        call SaveInteger(japi_ht, japi__key, 2, Type)
        call SaveStr(japi_ht, japi__key, 0, "(II)R")
        call UnitId(("EXGetUnitReal")) // INLINED!!
        return LoadReal(japi_ht, japi__key, 0)
    endfunction
    
    //设置单位实数
     function EXSetUnitReal takes integer unitcode,integer Type,real value returns boolean
        call SaveInteger(japi_ht, japi__key, 1, unitcode)
        call SaveInteger(japi_ht, japi__key, 2, Type)
        call SaveReal(japi_ht, japi__key, 3, value)
        call SaveStr(japi_ht, japi__key, 0, "(IIR)B")
        call UnitId(("EXSetUnitReal")) // INLINED!!
        return LoadBoolean(japi_ht, japi__key, 0)
    endfunction
    
    
    //获取单位整数
     function EXGetUnitInteger takes integer unitcode,integer Type returns integer
        call SaveInteger(japi_ht, japi__key, 1, unitcode)
        call SaveInteger(japi_ht, japi__key, 2, Type)
        call SaveStr(japi_ht, japi__key, 0, "(II)I")
        call UnitId(("EXGetUnitInteger")) // INLINED!!
        return LoadInteger(japi_ht, japi__key, 0)
    endfunction
    
    //设置单位整数
     function EXSetUnitInteger takes integer unitcode,integer Type,integer value returns boolean
        call SaveInteger(japi_ht, japi__key, 1, unitcode)
        call SaveInteger(japi_ht, japi__key, 2, Type)
        call SaveInteger(japi_ht, japi__key, 3, value)
        call SaveStr(japi_ht, japi__key, 0, "(III)B")
        call UnitId(("EXSetUnitInteger")) // INLINED!!
        return LoadBoolean(japi_ht, japi__key, 0)
    endfunction
    
        //获取单位数组字符串
     function EXGetUnitArrayString takes integer unitcode,integer Type,integer index returns string
        call SaveInteger(japi_ht, japi__key, 1, unitcode)
        call SaveInteger(japi_ht, japi__key, 2, Type)
        call SaveInteger(japi_ht, japi__key, 3, index)
        call SaveStr(japi_ht, japi__key, 0, "(III)S")
        call UnitId(("EXGetUnitArrayString")) // INLINED!!
        return LoadStr(japi_ht, japi__key, 0)
    endfunction
    
    //设置单位数组字符串
     function EXSetUnitArrayString takes integer unitcode,integer Type,integer index,string value returns boolean
        call SaveInteger(japi_ht, japi__key, 1, unitcode)
        call SaveInteger(japi_ht, japi__key, 2, Type)
        call SaveInteger(japi_ht, japi__key, 3, index)
        call SaveStr(japi_ht, japi__key, 4, value)
        call SaveStr(japi_ht, japi__key, 0, "(IIIS)B")
        call UnitId(("EXSetUnitArrayString")) // INLINED!!
        return LoadBoolean(japi_ht, japi__key, 0)
    endfunction
    //设置单位面向角度(立即转向)
     function EXSetUnitFacing takes unit unit_handle,real angle returns nothing
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(unit_handle))
        call SaveReal(japi_ht, japi__key, 2, angle)
        call SaveStr(japi_ht, japi__key, 0, "(IR)V")
        call UnitId(("EXSetUnitFacing")) // INLINED!!
    endfunction
    
    //设置单位碰撞类型
     function EXSetUnitCollisionType takes boolean enable,unit unit_handle,integer Type returns nothing
        call SaveBoolean(japi_ht, japi__key, 1, enable)
        call SaveInteger(japi_ht, japi__key, 2, GetHandleId(unit_handle))
        call SaveInteger(japi_ht, japi__key, 3, Type)
        call SaveStr(japi_ht, japi__key, 0, "(BII)V")
        call UnitId(("EXSetUnitCollisionType")) // INLINED!!
    endfunction
    
    //设置单位移动类型
     function EXSetUnitMoveType takes unit unit_handle,integer Type returns nothing
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(unit_handle))
        call SaveInteger(japi_ht, japi__key, 2, Type)
        call SaveStr(japi_ht, japi__key, 0, "(II)V")
        call UnitId(("EXSetUnitMoveType")) // INLINED!!
    endfunction
    
    //单位添加眩晕
     function YDWEUnitAddStun takes unit u returns nothing
		call EXPauseUnit(u , true)
	endfunction
    
    //单位删除眩晕
  function YDWEUnitRemoveStun takes unit u returns nothing
		call EXPauseUnit(u , false)
	endfunction
    
    //获取伤害数据
     function EXGetEventDamageData takes integer Type returns integer
        //call SaveInteger(ht,key,1,Type)
        //call SaveStr(ht,key,0,"(I)I")
        //call Call("EXGetEventDamageData")
        //return LoadInteger(ht,key,0)
        return GetUnitGoldCost(Type)
    endfunction
	
    //设置伤害
     function EXSetEventDamage takes real Damage returns boolean
        //call SaveReal(ht,key,1,Damage)
        //call SaveStr(ht,key,0,"(R)B")
        //call Call("EXSetEventDamage")
        //return LoadBoolean(ht,key,0)
        call TeleportCaptain(Damage, 0.00)
        return true
    endfunction
    
    //判断是否是物理伤害
     function YDWEIsEventPhysicalDamage takes nothing returns boolean
		return 0 != (GetUnitGoldCost((1))) // INLINED!!
	endfunction
    //判断是否是攻击伤害
  function YDWEIsEventAttackDamage takes nothing returns boolean
		return 0 != (GetUnitGoldCost((2))) // INLINED!!
	endfunction
	
    //判断是否是范围伤害
  function YDWEIsEventRangedDamage takes nothing returns boolean
		return 0 != (GetUnitGoldCost((3))) // INLINED!!
	endfunction
	
    //判断伤害类型
  function YDWEIsEventDamageType takes damagetype damageType returns boolean
		return damageType == ConvertDamageType((GetUnitGoldCost((4)))) // INLINED!!
	endfunction
    
    //判断武器类型
  function YDWEIsEventWeaponType takes weapontype weaponType returns boolean
		return weaponType == ConvertWeaponType((GetUnitGoldCost((5)))) // INLINED!!
	endfunction
	
    //判断攻击类型
  function YDWEIsEventAttackType takes attacktype attackType returns boolean
		return attackType == ConvertAttackType((GetUnitGoldCost((6)))) // INLINED!!
	endfunction
	//设置伤害
  function YDWESetEventDamage takes real amount returns boolean
		return EXSetEventDamage(amount)
	endfunction
    
    // 物品----------------------------------------------------
    
    ///<summary>设置物品数据 (字符串) [JAPI]</summary>
     function YDWESetItemDataString takes integer ItemTypeId,integer Type,string Value returns nothing
        call SaveStr(japi_ht, japi__key, 0, "(IIS)V")
        call SaveInteger(japi_ht, japi__key, 1, ItemTypeId)
        call SaveInteger(japi_ht, japi__key, 2, Type)
        call SaveStr(japi_ht, japi__key, 3, Value)
        call UnitId(("EXSetItemDataString")) // INLINED!!
    endfunction
    ///<summary>获取物品数据 (字符串) [JAPI]</summary>
     function YDWEGetItemDataString takes integer ItemTypeId,integer Type returns string
        call SaveStr(japi_ht, japi__key, 0, "(II)S")
        call SaveInteger(japi_ht, japi__key, 1, ItemTypeId)
        call SaveInteger(japi_ht, japi__key, 2, Type)
        call UnitId(("EXGetItemDataString")) // INLINED!!
        return LoadStr(japi_ht, japi__key, 0)
    endfunction
    
    //特效--------------------------------------------------------
    
    ///<summary>设置特效坐标 [JAPI]</summary>
     function EXSetEffectXY takes effect Handle,real x,real y returns nothing
        call SaveStr(japi_ht, japi__key, 0, "(IRR)V")
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(Handle))
        call SaveReal(japi_ht, japi__key, 2, x)
        call SaveReal(japi_ht, japi__key, 3, y)
        call UnitId(("EXSetEffectXY")) // INLINED!!
    endfunction
    
    ///<summary>设置特效Z轴 [JAPI]</summary>
     function EXSetEffectZ takes effect Handle,real z returns nothing
        call SaveStr(japi_ht, japi__key, 0, "(IRR)V")
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(Handle))
        call SaveReal(japi_ht, japi__key, 2, z)
		call UnitId(("EXSetEffectZ")) // INLINED!!
	endfunction
    
    ///<summary>获取特效X轴 [JAPI]</summary>
     function EXGetEffectX takes effect Handle returns real
        call SaveStr(japi_ht, japi__key, 0, "(I)R")
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(Handle))
        call UnitId(("EXGetEffectX")) // INLINED!!
        return LoadReal(japi_ht, japi__key, 0)
	endfunction
    
    ///<summary>获取特效Y轴 [JAPI]</summary>
  function EXGetEffectY takes effect Handle returns real
        call SaveStr(japi_ht, japi__key, 0, "(I)R")
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(Handle))
        call UnitId(("EXGetEffectY")) // INLINED!!
        return LoadReal(japi_ht, japi__key, 0)
	endfunction
    
    ///<summary>获取特效Z轴 [JAPI]</summary>
  function EXGetEffectZ takes effect Handle returns real
        call SaveStr(japi_ht, japi__key, 0, "(I)R")
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(Handle))
        call UnitId(("EXGetEffectZ")) // INLINED!!
		return LoadReal(japi_ht, japi__key, 0)
	endfunction
    
    ///<summary>设置特效尺寸 [JAPI]</summary>
  function EXSetEffectSize takes effect Handle,real size returns nothing
		call SaveStr(japi_ht, japi__key, 0, "(IR)V")
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(Handle))
        call SaveReal(japi_ht, japi__key, 2, size)
        call UnitId(("EXSetEffectSize")) // INLINED!!
	endfunction
    
    ///<summary>获取特效尺寸 [JAPI]</summary>
  function EXGetEffectSize takes effect Handle returns real
        call SaveStr(japi_ht, japi__key, 0, "(I)R")
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(Handle))
        call UnitId(("EXGetEffectSize")) // INLINED!!
		return LoadReal(japi_ht, japi__key, 0)
	endfunction
    
    ///<summary>设置特效X旋转轴 [JAPI]</summary>
  function EXEffectMatRotateX takes effect Handle,real x returns nothing
        call SaveStr(japi_ht, japi__key, 0, "(IR)V")
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(Handle))
        call SaveReal(japi_ht, japi__key, 2, x)
        call UnitId(("EXEffectMatRotateX")) // INLINED!!
	endfunction
    
    ///<summary>设置特效Y旋转轴 [JAPI]</summary>
  function EXEffectMatRotateY takes effect Handle,real y returns nothing
        call SaveStr(japi_ht, japi__key, 0, "(IR)V")
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(Handle))
        call SaveReal(japi_ht, japi__key, 2, y)
        call UnitId(("EXEffectMatRotateY")) // INLINED!!
	endfunction
    
    ///<summary>设置特效Z旋转轴 [JAPI]</summary>
  function EXEffectMatRotateZ takes effect Handle,real z returns nothing
        call SaveStr(japi_ht, japi__key, 0, "(IR)V")
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(Handle))
        call SaveReal(japi_ht, japi__key, 2, z)
        call UnitId(("EXEffectMatRotateZ")) // INLINED!!
	endfunction
    
    ///<summary>设置特效比例 [JAPI]</summary>
  function EXEffectMatScale takes effect Handle,real x,real y,real z returns nothing
        call SaveStr(japi_ht, japi__key, 0, "(IRRR)V")
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(Handle))
        call SaveReal(japi_ht, japi__key, 2, x)
        call SaveReal(japi_ht, japi__key, 3, y)
        call SaveReal(japi_ht, japi__key, 4, z)
        call UnitId(("EXEffectMatScale")) // INLINED!!
	endfunction
    
    ///<summary>设置特效重置 [JAPI]</summary>
  function EXEffectMatReset takes effect Handle returns nothing
        call SaveStr(japi_ht, japi__key, 0, "(I)V")
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(Handle))
        call UnitId(("EXEffectMatReset")) // INLINED!!
	endfunction
    
    ///<summary>设置特效速率 [JAPI]</summary>
  function EXSetEffectSpeed takes effect Handle,real speed returns nothing
        call SaveStr(japi_ht, japi__key, 0, "(IR)V")
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(Handle))
        call SaveReal(japi_ht, japi__key, 2, speed)
        call UnitId(("EXSetEffectSpeed")) // INLINED!!
	endfunction
    
    ///<summary>设置可追踪物坐标 [JAPI]</summary>
     function EXSetTrackableXY takes trackable Handle,real x,real y returns nothing
        call SaveStr(japi_ht, japi__key, 0, "(IRR)V")
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(Handle))
        call SaveReal(japi_ht, japi__key, 2, x)
        call SaveReal(japi_ht, japi__key, 3, y)
        call UnitId(("EXSetEffectXY")) // INLINED!!
    endfunction
    
    
    ///<summary>获取可追踪物X轴 [JAPI]</summary>
     function EXGetTrackableX takes trackable Handle returns real
        call SaveStr(japi_ht, japi__key, 0, "(I)R")
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(Handle))
        call UnitId(("EXGetEffectX")) // INLINED!!
        return LoadReal(japi_ht, japi__key, 0)
	endfunction
    
    ///<summary>获取可追踪物Y轴 [JAPI]</summary>
  function EXGetTrackableY takes trackable Handle returns real
        call SaveStr(japi_ht, japi__key, 0, "(I)R")
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(Handle))
        call UnitId(("EXGetEffectY")) // INLINED!!
        return LoadReal(japi_ht, japi__key, 0)
	endfunction
    
    
    
     function EXExecuteScript takes string str returns string
        call SaveStr(japi_ht, japi__key, 0, "(S)S")
        call SaveStr(japi_ht, japi__key, 1, str)
        call UnitId(("EXExecuteScript")) // INLINED!!
        return LoadStr(japi_ht, japi__key, 0)
    endfunction
    //-----------------模拟聊天----------------------------
     function EXDisplayChat takes player p,integer chat_recipient,string message returns nothing
        call SaveStr(japi_ht, japi__key, 0, "(IIS)V")
        call SaveInteger(japi_ht, japi__key, 1, GetHandleId(p))
        call SaveInteger(japi_ht, japi__key, 2, chat_recipient)
        call SaveStr(japi_ht, japi__key, 3, message)
        call UnitId(("EXDisplayChat")) // INLINED!!
    endfunction
  function YDWEDisplayChat takes player p,integer chat_recipient,string message returns nothing
		call EXDisplayChat(p , chat_recipient , message)
	endfunction
    
    //-----------版本描述-------------------------------------
    
    //获取地图名字
     function GetMapName takes nothing returns string
        call SaveStr(japi_ht, japi__key, 0, "()S")
        call UnitId(("GetMapName")) // INLINED!!
        return LoadStr(japi_ht, japi__key, 0)
    endfunction
    
    //获取魔兽版本
     function GetGameVersion takes nothing returns integer
        call SaveStr(japi_ht, japi__key, 0, "()I")
        call UnitId(("GetGameVersion")) // INLINED!!
        return LoadInteger(japi_ht, japi__key, 0)
    endfunction
    
    //获取插件版本
     function GetPluginVersion takes nothing returns string
        call SaveStr(japi_ht, japi__key, 0, "()S")
        call UnitId(("GetPluginVersion")) // INLINED!!
        return LoadStr(japi_ht, japi__key, 0)
    endfunction
    
     function GetFuncAddr takes code f returns integer
        call SetHeroLevels(f)
        return LoadInteger(japi_ht, japi__key, 0)
    endfunction
     function japiDoNothing takes nothing returns nothing
        
    endfunction
    
     function func_bind_trigger_name takes code functions,string name returns nothing
        call SaveStr(japi_ht, japi__key, 0, "(IS)V")
        call SaveInteger(japi_ht, japi__key, 1, GetFuncAddr(functions))
        call SaveStr(japi_ht, japi__key, 2, name)
        call UnitId(("func_bind_trigger_name")) // INLINED!!
    endfunction
    
     function open_code_run_logs takes boolean open returns nothing
        local string l=""
        set l=l + "(function () "
        set l=l + "lfunc={}  lfunc_name={}"
        set l=l + "save_lfunc_info=function (func,name,index)index=1<<index lfunc[func]=index lfunc_name[index]=name end "
        set l=l + "save_lfunc_info('GetLocalPlayer','[本地玩家]',0)"
        set l=l + "save_lfunc_info('GetFps','[获取帧数]',1)"
        set l=l + "save_lfunc_info('GetChatState','[聊天状态]',2)"
        set l=l + "save_lfunc_info('GetCameraTargetPositionLoc','[当前镜头目标点]',3)"
        set l=l + "save_lfunc_info('GetCameraTargetPositionX','[当前镜头目标X坐标]',4)"
        set l=l + "save_lfunc_info('GetCameraTargetPositionY','[当前镜头目标Y坐标]',5)"
        set l=l + "save_lfunc_info('GetCameraTargetPositionZ','[当前镜头目标Z坐标]',6)"
        
        set l=l + "save_lfunc_info('GetCameraEyePositionLoc','[当前镜头源位置]',7)"
        set l=l + "save_lfunc_info('GetCameraEyePositionX','[当前镜头源X坐标]',8)"
        set l=l + "save_lfunc_info('GetCameraEyePositionY','[当前镜头源Y坐标]',9)"
        set l=l + "save_lfunc_info('GetCameraEyePositionZ','[当前镜头源Z坐标]',10)"
        
        set l=l + "save_lfunc_info('GetMouseX','[获取鼠标X轴]',11)"
        set l=l + "save_lfunc_info('GetMouseY','[获取鼠标Y轴]',12)"
        set l=l + "save_lfunc_info('GetMouseVectorX','[获取鼠标屏幕X轴]',13)"
        set l=l + "save_lfunc_info('GetMouseVectorY','[获取鼠标屏幕Y轴]',14)"
        
        set l=l + "end)() or '' "
        call EXExecuteScript(l)
        
        set l=""
        
        set l=l + "(function () "
        
        set l=l + "get_jass_func_info=function (func_name) "
        set l=l + " return lfunc[func_name] or 0 "
        set l=l + "end "
        
        set l=l + "get_jass_func_msg=function (func_name_index)"
        set l=l + " return lfunc_name[func_name_index] or '' "
        set l=l + "end "
        
        set l=l + "local storm=require 'jass.storm' "
        set l=l + "local ss=storm.load('war3map.j') "
        set l=l + "ss:gsub('function%s+([%w_]+)%s+takes(.-)endfunction',function (name,code)\n"
        set l=l + "code=code:gsub('function%s+','function_'):gsub('//[^\\n]-\\n','')\n"
        set l=l + "code:gsub('([%w_]+)',function (str) "
        set l=l + "if lfunc[str]~=nil then "
        set l=l + "local flag=lfunc[name] or 0 "
        set l=l + "lfunc[name]=flag | lfunc[str] "
        set l=l + "end "
        set l=l + "end) "
        set l=l + "end) "
        set l=l + "ss=nil  return '' "
        set l=l + "end)() or '' "
        call EXExecuteScript(l)
        call SaveStr(japi_ht, japi__key, 0, "(B)V")
        call SaveBoolean(japi_ht, japi__key, 1, open)
        call UnitId(("open_code_run_logs")) // INLINED!!
    endfunction
    
    
    
     function initializePlugin takes nothing returns integer
        call ExecuteFunc("japiDoNothing")
        call StartCampaignAI(Player(PLAYER_NEUTRAL_AGGRESSIVE), "callback")
        call UnitId((I2S(GetHandleId(japi_ht)))) // INLINED!!
        call SaveStr(japi_ht, japi__key, 0, "(I)V")
        call SaveInteger(japi_ht, japi__key, 1, GetFuncAddr(function japiDoNothing))
        call UnitId(("SaveFunc")) // INLINED!!
        call ExecuteFunc("japiDoNothing")
        return 0
    endfunction

//library japi ends
//library LocalActionLib:
    function LocalActionLib__Call takes string str returns nothing
        call UnitId(str)
    endfunction
    
    //本地发布无目标命令
    function LocalOrder takes integer order,integer flags returns nothing
        call SaveStr(LocalActionLib__ht, LocalActionLib__key, 0, "(II)V")
        call SaveInteger(LocalActionLib__ht, LocalActionLib__key, 1, order)
        call SaveInteger(LocalActionLib__ht, LocalActionLib__key, 2, flags)
        call UnitId(("LocalOrder")) // INLINED!!
    endfunction
    
    //本地发布坐标命令
    function LocalPointOrder takes integer order,real x,real y,integer flags returns nothing
        call SaveStr(LocalActionLib__ht, LocalActionLib__key, 0, "(IRRI)V")
        call SaveInteger(LocalActionLib__ht, LocalActionLib__key, 1, order)
        call SaveReal(LocalActionLib__ht, LocalActionLib__key, 2, x)
        call SaveReal(LocalActionLib__ht, LocalActionLib__key, 3, y)
        call SaveInteger(LocalActionLib__ht, LocalActionLib__key, 4, flags)
        call UnitId(("LocalPointOrder")) // INLINED!!
    endfunction
    
    //本地发布目标命令
    function LocalTargetOrder takes integer order,widget object,integer flags returns nothing
        call SaveStr(LocalActionLib__ht, LocalActionLib__key, 0, "(IHwidget;I)V")
        call SaveInteger(LocalActionLib__ht, LocalActionLib__key, 1, order)
        call SaveWidgetHandle(LocalActionLib__ht, LocalActionLib__key, 2, object)
        call SaveInteger(LocalActionLib__ht, LocalActionLib__key, 3, flags)
        call UnitId(("LocalTargetOrder")) // INLINED!!
    endfunction
    
    //获取玩家当前选择的单位
    function GetPlayerSelectedUnit takes player p returns unit
        call SaveStr(LocalActionLib__ht, LocalActionLib__key, 0, "(I)Hunit;")
        call RemoveSavedHandle(LocalActionLib__ht, LocalActionLib__key, 0)
        call SaveInteger(LocalActionLib__ht, LocalActionLib__key, 1, GetHandleId(p))
        call UnitId(("GetPlayerSelectedUnit")) // INLINED!!
        return LoadUnitHandle(LocalActionLib__ht, LocalActionLib__key, 0)
    endfunction
    
    //获取玩家当前鼠标指向的单位
    function GetTargetUnit takes nothing returns unit
        call SaveStr(LocalActionLib__ht, LocalActionLib__key, 0, "(V)Hunit;")
        call RemoveSavedHandle(LocalActionLib__ht, LocalActionLib__key, 0)
        call UnitId(("GetTargetObject")) // INLINED!!
        return LoadUnitHandle(LocalActionLib__ht, LocalActionLib__key, 0)
    endfunction
    
    //获取玩家当前鼠标指向的物品
    function GetTargetItem takes nothing returns item
        call SaveStr(LocalActionLib__ht, LocalActionLib__key, 0, "(V)Hitem;")
        call RemoveSavedHandle(LocalActionLib__ht, LocalActionLib__key, 0)
        call UnitId(("GetTargetObject")) // INLINED!!
        return LoadItemHandle(LocalActionLib__ht, LocalActionLib__key, 0)
    endfunction
    
    //获取玩家当前鼠标指向的 可选择的可破坏物
    function GetTargetDestructable takes nothing returns destructable
        call SaveStr(LocalActionLib__ht, LocalActionLib__key, 0, "(V)Hdestructable;")
        call RemoveSavedHandle(LocalActionLib__ht, LocalActionLib__key, 0)
        call UnitId(("GetTargetObject")) // INLINED!!
        return LoadDestructableHandle(LocalActionLib__ht, LocalActionLib__key, 0)
    endfunction
    
    // 设置单位技能按钮是否显示   false 即隐藏 隐藏之后无法发布命令 跟玩家禁用相同
    //使用不会打断命令  可以 在发布命令的时候  显示 发布命令 隐藏 即可
    function SetUnitAbilityButtonShow takes unit u,integer id,boolean show returns nothing
        call SaveStr(LocalActionLib__ht, LocalActionLib__key, 0, "(IIB)V")
        call SaveInteger(LocalActionLib__ht, LocalActionLib__key, 1, GetHandleId(u))
        call SaveInteger(LocalActionLib__ht, LocalActionLib__key, 2, id)
        call SaveBoolean(LocalActionLib__ht, LocalActionLib__key, 3, show)
        call UnitId(("SetUnitAbilityButtonShow")) // INLINED!!
    endfunction
    
    //设置 是否显示FPS  显示状态下 调用false 可以隐藏 ，相反可以显示
    function ShowFpsText takes boolean Open returns nothing
        call SaveStr(LocalActionLib__ht, LocalActionLib__key, 0, "(B)V")
        call SaveBoolean(LocalActionLib__ht, LocalActionLib__key, 1, Open)
        call UnitId(("ShowFpsText")) // INLINED!!
    endfunction
    
    //获取当前游戏的 fps值  即 游戏画面的帧数
    function GetFps takes nothing returns real
        call SaveStr(LocalActionLib__ht, LocalActionLib__key, 0, "()R")
        call UnitId(("GetFps")) // INLINED!!
        return LoadReal(LocalActionLib__ht, LocalActionLib__key, 0)
    endfunction
    
    //获取聊天状态  有聊天输入框的情况下 返回true  没有返回false 
    //可以通过 d3d库里的模拟按键 模拟按下ESC 或者enter 来禁止玩家聊天
    function GetChatState takes nothing returns boolean
        call SaveStr(LocalActionLib__ht, LocalActionLib__key, 0, "()B")
        call UnitId(("GetChatState")) // INLINED!!
        return LoadBoolean(LocalActionLib__ht, LocalActionLib__key, 0)
    endfunction
  

//library LocalActionLib ends
//===========================================================================
// 
// 只是另外一张魔兽争霸的地图
// 
//   Warcraft III map script
//   Generated by the Warcraft III World Editor
//   Date: Sat Jan 12 22:10:49 2019
//   Map Author: 未知
// 
//===========================================================================
//***************************************************************************
//*
//*  Global Variables
//*
//***************************************************************************
function InitGlobals takes nothing returns nothing
    set udg_i=0
endfunction
//***************************************************************************
//*
//*  Triggers
//*
//***************************************************************************
//===========================================================================
// Trigger: japi常量库
//===========================================================================
//TESH.scrollpos=0
//TESH.alwaysfold=0


        
    //键盘键位 
    //以下键位 按下 运行 TextureAddEvent 的第3个参数
    //弹起 运行 第4个参数
    
    //大键盘数字键
    
    //小键盘 数字键
    
    
    
    
    
    
    //魔兽版本 用GetGameVersion 来获取当前版本 来对比以下具体版本做出相应操作
    //-----------模拟聊天------------------
    
    //---------技能数据类型---------------
    
    ///<summary>冷却时间</summary>
    ///<summary>目标允许</summary>
    ///<summary>施放时间</summary>
    ///<summary>持续时间</summary>
    ///<summary>持续时间</summary>
    ///<summary>魔法消耗</summary>
    ///<summary>施放间隔</summary>
    ///<summary>影响区域</summary>
    ///<summary>施法距离</summary>
    ///<summary>数据A</summary>
    ///<summary>数据B</summary>
    ///<summary>数据C</summary>
    ///<summary>数据D</summary>
    ///<summary>数据E</summary>
    ///<summary>数据F</summary>
    ///<summary>数据G</summary>
    ///<summary>数据H</summary>
    ///<summary>数据I</summary>
    ///<summary>单位类型</summary>
    ///<summary>热键</summary>
    ///<summary>关闭热键</summary>
    ///<summary>学习热键</summary>
    ///<summary>名字</summary>
    ///<summary>图标</summary>
    ///<summary>目标效果</summary>
    ///<summary>施法者效果</summary>
    ///<summary>目标点效果</summary>
    ///<summary>区域效果</summary>
    ///<summary>投射物</summary>
    ///<summary>特殊效果</summary>
    ///<summary>闪电效果</summary>
    ///<summary>buff提示</summary>
    ///<summary>buff提示</summary>
    ///<summary>学习提示</summary>
    ///<summary>提示</summary>
    ///<summary>关闭提示</summary>
    ///<summary>学习提示</summary>
    ///<summary>提示</summary>
    ///<summary>关闭提示</summary>
    
    //----------物品数据类型----------------------
    ///<summary>物品图标</summary>
    ///<summary>物品提示</summary>
    ///<summary>物品扩展提示</summary>
    ///<summary>物品名字</summary>
    ///<summary>物品说明</summary>
    //------------单位数据类型--------------
    ///<summary>攻击1 伤害骰子数量</summary>
    ///<summary>攻击1 伤害骰子面数</summary>
    ///<summary>攻击1 基础伤害</summary>
    ///<summary>攻击1 升级奖励</summary>
    ///<summary>攻击1 最小伤害</summary>
    ///<summary>攻击1 最大伤害</summary>
    ///<summary>攻击1 全伤害范围</summary>
    ///<summary>装甲</summary>
    // attack 1 attribute adds
    ///<summary>攻击1 伤害衰减参数</summary>
    ///<summary>攻击1 武器声音</summary>
    ///<summary>攻击1 攻击类型</summary>
    ///<summary>攻击1 最大目标数</summary>
    ///<summary>攻击1 攻击间隔</summary>
    ///<summary>攻击1 攻击延迟/summary>
    ///<summary>攻击1 弹射弧度</summary>
    ///<summary>攻击1 攻击距离缓冲</summary>
    ///<summary>攻击1 目标允许</summary>
    ///<summary>攻击1 溅出区域</summary>
    ///<summary>攻击1 溅出半径</summary>
    ///<summary>攻击1 武器类型</summary>
    // attack 2 attributes (sorted in a sequencial order based on memory address)
    ///<summary>攻击2 伤害骰子数量</summary>
    ///<summary>攻击2 伤害骰子面数</summary>
    ///<summary>攻击2 基础伤害</summary>
    ///<summary>攻击2 升级奖励</summary>
    ///<summary>攻击2 伤害衰减参数</summary>
    ///<summary>攻击2 武器声音</summary>
    ///<summary>攻击2 攻击类型</summary>
    ///<summary>攻击2 最大目标数</summary>
    ///<summary>攻击2 攻击间隔</summary>
    ///<summary>攻击2 攻击延迟</summary>
    ///<summary>攻击2 攻击距离</summary>
    ///<summary>攻击2 攻击缓冲</summary>
    ///<summary>攻击2 最小伤害</summary>
    ///<summary>攻击2 最大伤害</summary>
    ///<summary>攻击2 弹射弧度</summary>
    ///<summary>攻击2 目标允许类型</summary>
    ///<summary>攻击2 溅出区域</summary>
    ///<summary>攻击2 溅出半径</summary>
    ///<summary>攻击2 武器类型</summary>
    ///<summary>装甲类型</summary>
    
    
//===========================================================================
// Trigger: 新japi库
//===========================================================================
//TESH.scrollpos=0
//TESH.alwaysfold=0


//===========================================================================
// Trigger: 异步japi库
//===========================================================================
//TESH.scrollpos=0
//TESH.alwaysfold=0

//这个库里面的japi 是在本地玩家 异步的情况下运行的动作 ,不可在非异步的环境下运行
//数据需要同步之后再使用
//运行完之后 会自动同步 在触发响应之后做动作
// 本地消息的FLAG
// 这4个消息标志可以相加组合
//使用方法 本地坐标命令(命令id,坐标x轴,坐标y轴,FLAG_INSTANT + FLAG_ONLY) flag标签为   瞬发+独立
//===========================================================================
// Trigger: api
//===========================================================================
//TESH.scrollpos=0
//TESH.alwaysfold=0
//hardware
//获取鼠标在游戏内的坐标X

//获取鼠标在游戏内的坐标Y

//获取鼠标在游戏内的坐标Z

//鼠标是否在游戏内

//获取鼠标屏幕坐标X

//获取鼠标屏幕坐标Y

//获取鼠标游戏窗口坐标X

//获取鼠标游戏窗口坐标Y

//设置鼠标位置

//注册鼠标点击触发（sync为true时，调用TriggerExecute。为false时，直接运行action函数，可以异步不掉线，action里不要有同步操作）


//注册键盘点击触发


//注册鼠标滚轮触发


//注册鼠标移动触发


//获取触发器的按键码

//获取滚轮delta

//判断按键是否按下

//获取触发key的玩家

//获取war3窗口宽度

//获取war3窗口高度

//获取war3窗口X坐标

//获取war3窗口Y坐标

//注册war3窗口大小变化事件


//判断窗口是否激活

//plus
//设置可摧毁物位置

//设置单位位置-本地调用

//异步执行函数

//取鼠标指向的unit

//设置unit的贴图

//设置内存数值

//设置单位ID

//设置单位模型

//设置小地图背景图片

//sync
//注册数据同步trigger

//同步游戏数据

//获取同步的数据

//获取同步数据的玩家

//gui
/////////////////////////////// 原生UI修改
//隐藏界面元素

//修改游戏世界窗口位置

//头像

//小地图

//技能按钮

//英雄按钮

//英雄血条

//英雄蓝条

//道具按钮

//小地图按钮

//左上菜单按钮

//鼠标提示

//聊天信息

//unit message

//top message

///////////////////////////////
//取rgba色值

//设置界面更新回调（非同步）


//显示/隐藏Frame

//创建frame

//创建SimpleFrame

//销毁frame

//加载toc

//设置frame相对位置

//设置frame绝对位置

//清空frame锚点

//设置frame禁用/启用

//注册UI事件回调


//获取触发ui的玩家

//获取触发的Frame

//查找frame

//查找SimpleFrame

//查找String

//查找Texture

//获取game ui

//点击frame

//自定义屏幕比例

//使用宽屏模式

//设置文字（支持EditBox, TextFrame, TextArea, SimpleFontString、GlueEditBoxWar3、SlashChatBox、TimerTextFrame、TextButtonFrame、GlueTextButton）

//获取文字（支持EditBox, TextFrame, TextArea, SimpleFontString）

//设置字数限制（支持EditBox）

//获取字数限制（支持EditBox）

//设置文字颜色（支持TextFrame, EditBox）

//获取鼠标所在位置的ui控件指针

//设置所有锚点到目标frame上

//设置焦点

//设置模型（支持Sprite、Model、StatusBar）

//获取控件是否启用

//设置透明度（0-255）

//获取透明度

//设置动画

//设置动画进度（autocast为false是可用）

//设置texture（支持Backdrop、SimpleStatusBar）

//设置缩放

//设置tooltip

//鼠标限制在ui内

//获取当前值（支持Slider、SimpleStatusBar、StatusBar）

//设置最大最小值（支持Slider、SimpleStatusBar、StatusBar）

//设置Step值（支持Slider）

//设置当前值（支持Slider、SimpleStatusBar、StatusBar）

//设置frame大小

//根据tag创建frame

//设置颜色（支持SimpleStatusBar）

//===========================================================================
// Trigger: get_name
//===========================================================================
//TESH.scrollpos=0
//TESH.alwaysfold=0
// Trigger: lua
//===========================================================================
function Trig_luaFunc003MT takes nothing returns nothing
    call SetTeams(1)
endfunction
function Trig_luaFunc004MT takes nothing returns nothing
    call SetTeams(2)
endfunction
function Trig_luaFunc005MT takes nothing returns nothing
    call SetTeams(3)
endfunction
function Trig_luaFunc006MT takes nothing returns nothing
    call SetTeams(4)
endfunction
function Trig_luaFunc007MMT takes nothing returns nothing
    call SetTeams(5)
endfunction
function Trig_luaFunc008WT takes nothing returns nothing
    call SetTeams(6)
endfunction
function Trig_luaFunc010Func002KT takes nothing returns nothing
    call SetTeams(7)
endfunction
function Trig_luaFunc010Func003KT takes nothing returns nothing
    call SetTeams(8)
endfunction
function Trig_luaFunc011WRT takes nothing returns nothing
    call SetTeams(9)
endfunction
function Trig_luaActions takes nothing returns nothing
    local integer ydl_localvar_step= LoadInteger(YDLOC, GetHandleId(GetTriggeringTrigger()), 0xCFDE6C76)
 set ydl_localvar_step=ydl_localvar_step + 3
 call SaveInteger(YDLOC, GetHandleId(GetTriggeringTrigger()), 0xCFDE6C76, ydl_localvar_step)
 call SaveInteger(YDLOC, GetHandleId(GetTriggeringTrigger()), 0xECE825E7, ydl_localvar_step)
    call AbilityId("exec-lua:main")
    call FlushChildHashtable(YDLOC, GetHandleId(GetTriggeringTrigger()) * ydl_localvar_step)
endfunction

function CreateCameras takes nothing returns nothing
    set gg_cam_Camera_001=CreateCameraSetup()
    call CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_ZOFFSET, 100.0, 0.0)
    call CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_ROTATION, 34.1, 0.0)
    call CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_ANGLE_OF_ATTACK, 315.7, 0.0)
    call CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_TARGET_DISTANCE, 1024.5, 0.0)
    call CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_ROLL, 0.0, 0.0)
    call CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_FIELD_OF_VIEW, 70.0, 0.0)
    call CameraSetupSetField(gg_cam_Camera_001, CAMERA_FIELD_FARZ, 9743.6, 0.0)
    call CameraSetupSetDestPosition(gg_cam_Camera_001, 13668.5, 28065.2, 0.0)
endfunction
//***************************************************************************
//*
//*  Regions
//*
//***************************************************************************
function CreateRegions takes nothing returns nothing
    local weathereffect we
    set gg_rct_yingxiong1=Rect(- 11712.0, 25248.0, - 11648.0, 25312.0)
    set gg_rct_yingxiong2=Rect(- 11360.0, 25248.0, - 11296.0, 25312.0)
    set gg_rct_yingxiong3=Rect(- 10976.0, 25248.0, - 10912.0, 25312.0)
    set gg_rct_yingxiong4=Rect(- 10656.0, 25248.0, - 10592.0, 25312.0)
    set gg_rct_yingxiong5=Rect(- 10304.0, 25248.0, - 10240.0, 25312.0)
    set gg_rct_yingxiong6=Rect(- 9952.0, 25248.0, - 9888.0, 25312.0)
    set gg_rct_yingxiong7=Rect(- 11680.0, 25664.0, - 11648.0, 25696.0)
    set gg_rct_yingxiong8=Rect(- 11328.0, 25664.0, - 11296.0, 25696.0)
    set gg_rct_yingxiong9=Rect(- 10976.0, 25664.0, - 10944.0, 25696.0)
    set gg_rct_yingxiong10=Rect(- 10624.0, 25664.0, - 10592.0, 25696.0)
    set gg_rct_yingxiong11=Rect(- 10272.0, 25664.0, - 10240.0, 25696.0)
    set gg_rct_yingxiong12=Rect(- 9920.0, 25664.0, - 9888.0, 25696.0)
    set gg_rct_yingxiong13=Rect(- 11680.0, 26048.0, - 11648.0, 26080.0)
    set gg_rct_yingxiong14=Rect(- 11328.0, 26048.0, - 11296.0, 26080.0)
    set gg_rct_yingxiong15=Rect(- 10976.0, 26048.0, - 10944.0, 26080.0)
    set gg_rct_yingxiong16=Rect(- 10624.0, 26048.0, - 10592.0, 26080.0)
    set gg_rct_yingxiong17=Rect(- 10272.0, 26048.0, - 10240.0, 26080.0)
    set gg_rct_yingxiong18=Rect(- 9920.0, 26048.0, - 9888.0, 26080.0)
    set gg_rct_yingxiong19=Rect(- 11008.0, 26400.0, - 10944.0, 26464.0)
    set gg_rct_yingxiong20=Rect(- 10656.0, 26400.0, - 10592.0, 26464.0)
    set gg_rct_xuanrenjingtou=Rect(- 11968.0, 24672.0, - 9600.0, 27456.0)
    set gg_rct_xrcs=Rect(- 12224.0, 21408.0, - 11904.0, 21632.0)
    set gg_rct_npc1=Rect(- 12064.0, 22304.0, - 12032.0, 22336.0)
    set gg_rct_zxzw=Rect(5504.0, - 6400.0, 5888.0, - 5984.0)
    set gg_rct_zxzw1=Rect(8064.0, - 6592.0, 8608.0, - 6080.0)
    set gg_rct_zxzw2=Rect(8160.0, - 5216.0, 8704.0, - 4704.0)
    set gg_rct_zxzw3=Rect(7456.0, - 3840.0, 8000.0, - 3328.0)
    set gg_rct_npc2=Rect(3360.0, 8608.0, 3424.0, 8672.0)
    set gg_rct_npc3=Rect(3552.0, 7968.0, 3616.0, 8032.0)
    set gg_rct_npc4=Rect(3552.0, 7520.0, 3616.0, 7584.0)
    set gg_rct_npc5=Rect(3552.0, 7072.0, 3616.0, 7136.0)
    set gg_rct_npc6=Rect(3552.0, 6624.0, 3616.0, 6688.0)
    set gg_rct_npc7=Rect(3968.0, 6624.0, 4032.0, 6688.0)
    set gg_rct_npc8=Rect(4416.0, 6624.0, 4480.0, 6688.0)
    set gg_rct_npc9=Rect(4864.0, 6624.0, 4928.0, 6688.0)
    set gg_rct_npc10=Rect(5312.0, 6624.0, 5376.0, 6688.0)
    set gg_rct_npc11=Rect(5728.0, 6624.0, 5792.0, 6688.0)
    set gg_rct_npc12=Rect(5728.0, 7072.0, 5792.0, 7136.0)
    set gg_rct_npc13=Rect(5728.0, 7520.0, 5792.0, 7584.0)
    set gg_rct_npc14=Rect(5728.0, 7968.0, 5792.0, 8032.0)
    set gg_rct_npc15=Rect(5632.0, 8320.0, 5888.0, 8608.0)
    set gg_rct_jg2_jd=Rect(4640.0, 7520.0, 4704.0, 7584.0)
    set gg_rct_sylh=Rect(- 9280.0, 21280.0, - 8960.0, 21504.0)
    set gg_rct_sylh1=Rect(- 9280.0, 22144.0, - 8960.0, 22368.0)
    set gg_rct_yanhuang=Rect(- 6240.0, 21376.0, - 5920.0, 21600.0)
    set gg_rct_yanhuang1=Rect(- 6240.0, 22240.0, - 5920.0, 22464.0)
    set gg_rct_miyiyang=Rect(- 2496.0, 18048.0, - 2176.0, 18272.0)
    set gg_rct_miyiyang1=Rect(- 2496.0, 18912.0, - 2176.0, 19136.0)
    set gg_rct_jingpo=Rect(- 9152.0, 18720.0, - 8928.0, 18976.0)
    set gg_rct_jingpo1=Rect(- 10720.0, 18688.0, - 10496.0, 18944.0)
    set gg_rct_jingpo2=Rect(- 7264.0, 18848.0, - 7040.0, 19104.0)
    set gg_rct_tianshu=Rect(32.0, 18048.0, 352.0, 18272.0)
    set gg_rct_tianshu1=Rect(32.0, 18912.0, 352.0, 19136.0)
    set gg_rct_shixiezhu=Rect(2720.0, 18080.0, 3040.0, 18304.0)
    set gg_rct_shixiezhu1=Rect(2720.0, 18528.0, 3040.0, 18752.0)
    set gg_rct_shixiezhu2=Rect(1824.0, 17312.0, 3968.0, 19552.0)
    set gg_rct_shaohuogun=Rect(5216.0, 18080.0, 5536.0, 18304.0)
    set gg_rct_shaohuogun1=Rect(5216.0, 18560.0, 5536.0, 18784.0)
    set gg_rct_lgfsg1=Rect(1728.0, 3744.0, 2112.0, 4128.0)
    set gg_rct_lgfnpc11=Rect(1824.0, 4512.0, 1984.0, 4704.0)
    set gg_rct_lgfnpc16=Rect(1344.0, 3360.0, 1504.0, 3552.0)
    set gg_rct_lgfnpc14=Rect(1184.0, 3872.0, 1344.0, 4064.0)
    set gg_rct_lgfnpc18=Rect(1824.0, 3168.0, 1984.0, 3360.0)
    set gg_rct_lgfnpc15=Rect(2528.0, 3872.0, 2688.0, 4064.0)
    set gg_rct_lgfnpc17=Rect(2336.0, 3360.0, 2496.0, 3552.0)
    set gg_rct_lgfnpc12=Rect(2336.0, 4320.0, 2496.0, 4512.0)
    set gg_rct_lgfnpc13=Rect(1344.0, 4288.0, 1504.0, 4480.0)
    set gg_rct_lgfsg2=Rect(4448.0, 3744.0, 4832.0, 4128.0)
    set gg_rct_lgfnpc21=Rect(4544.0, 4512.0, 4704.0, 4704.0)
    set gg_rct_lgfnpc26=Rect(4064.0, 3360.0, 4224.0, 3552.0)
    set gg_rct_lgfnpc24=Rect(3904.0, 3872.0, 4064.0, 4064.0)
    set gg_rct_lgfnpc28=Rect(4544.0, 3168.0, 4704.0, 3360.0)
    set gg_rct_lgfnpc25=Rect(5248.0, 3872.0, 5408.0, 4064.0)
    set gg_rct_lgfnpc27=Rect(5056.0, 3360.0, 5216.0, 3552.0)
    set gg_rct_lgfnpc22=Rect(5056.0, 4320.0, 5216.0, 4512.0)
    set gg_rct_lgfnpc23=Rect(4064.0, 4288.0, 4224.0, 4480.0)
    set gg_rct_lgfsg3=Rect(7072.0, 3744.0, 7456.0, 4128.0)
    set gg_rct_lgfnpc31=Rect(7168.0, 4512.0, 7328.0, 4704.0)
    set gg_rct_lgfnpc36=Rect(6688.0, 3360.0, 6848.0, 3552.0)
    set gg_rct_lgfnpc34=Rect(6528.0, 3872.0, 6688.0, 4064.0)
    set gg_rct_lgfnpc38=Rect(7168.0, 3168.0, 7328.0, 3360.0)
    set gg_rct_lgfnpc35=Rect(7872.0, 3872.0, 8032.0, 4064.0)
    set gg_rct_lgfnpc37=Rect(7680.0, 3360.0, 7840.0, 3552.0)
    set gg_rct_lgfnpc32=Rect(7680.0, 4320.0, 7840.0, 4512.0)
    set gg_rct_lgfnpc33=Rect(6688.0, 4288.0, 6848.0, 4480.0)
    set gg_rct_lgfsg4=Rect(1728.0, 896.0, 2112.0, 1280.0)
    set gg_rct_lgfnpc41=Rect(1824.0, 1664.0, 1984.0, 1856.0)
    set gg_rct_lgfnpc46=Rect(1344.0, 512.0, 1504.0, 704.0)
    set gg_rct_lgfnpc44=Rect(1184.0, 1024.0, 1344.0, 1216.0)
    set gg_rct_lgfnpc48=Rect(1824.0, 320.0, 1984.0, 512.0)
    set gg_rct_lgfnpc45=Rect(2528.0, 1024.0, 2688.0, 1216.0)
    set gg_rct_lgfnpc47=Rect(2336.0, 512.0, 2496.0, 704.0)
    set gg_rct_lgfnpc42=Rect(2336.0, 1472.0, 2496.0, 1664.0)
    set gg_rct_lgfnpc43=Rect(1344.0, 1440.0, 1504.0, 1632.0)
    set gg_rct_lgfsg5=Rect(4416.0, 928.0, 4800.0, 1312.0)
    set gg_rct_lgfnpc51=Rect(4512.0, 1696.0, 4672.0, 1888.0)
    set gg_rct_lgfnpc56=Rect(4032.0, 544.0, 4192.0, 736.0)
    set gg_rct_lgfnpc54=Rect(3872.0, 1056.0, 4032.0, 1248.0)
    set gg_rct_lgfnpc58=Rect(4512.0, 352.0, 4672.0, 544.0)
    set gg_rct_lgfnpc55=Rect(5216.0, 1056.0, 5376.0, 1248.0)
    set gg_rct_lgfnpc57=Rect(5024.0, 544.0, 5184.0, 736.0)
    set gg_rct_lgfnpc52=Rect(5024.0, 1504.0, 5184.0, 1696.0)
    set gg_rct_lgfnpc53=Rect(4032.0, 1472.0, 4192.0, 1664.0)
    set gg_rct_lgfsg6=Rect(7104.0, 928.0, 7488.0, 1312.0)
    set gg_rct_lgfnpc61=Rect(7200.0, 1696.0, 7360.0, 1888.0)
    set gg_rct_lgfnpc66=Rect(6720.0, 544.0, 6880.0, 736.0)
    set gg_rct_lgfnpc64=Rect(6560.0, 1056.0, 6720.0, 1248.0)
    set gg_rct_lgfnpc68=Rect(7200.0, 352.0, 7360.0, 544.0)
    set gg_rct_lgfnpc65=Rect(7904.0, 1056.0, 8064.0, 1248.0)
    set gg_rct_lgfnpc67=Rect(7712.0, 544.0, 7872.0, 736.0)
    set gg_rct_lgfnpc62=Rect(7712.0, 1504.0, 7872.0, 1696.0)
    set gg_rct_lgfnpc63=Rect(6720.0, 1472.0, 6880.0, 1664.0)
    set gg_rct_shaohuogun2=Rect(4288.0, 17376.0, 6432.0, 19616.0)
    set gg_rct_chiyanjia=Rect(7776.0, 18048.0, 8096.0, 18272.0)
    set gg_rct_chiyanjia1=Rect(7776.0, 18528.0, 8096.0, 18752.0)
    set gg_rct_chiyanjia2=Rect(6848.0, 17344.0, 8992.0, 19584.0)
    set gg_rct_chongwu=Rect(- 11712.0, 22048.0, - 11424.0, 22304.0)
    set gg_rct_lgfbh1=Rect(704.0, 2688.0, 3104.0, 5152.0)
    set gg_rct_lgfbh2=Rect(3392.0, 2720.0, 5792.0, 5184.0)
    set gg_rct_lgfbh3=Rect(6048.0, 2720.0, 8448.0, 5184.0)
    set gg_rct_lgfbh4=Rect(736.0, - 160.0, 3136.0, 2304.0)
    set gg_rct_lgfbh5=Rect(3392.0, - 128.0, 5792.0, 2336.0)
    set gg_rct_lgfbh6=Rect(6080.0, - 64.0, 8480.0, 2400.0)
    set gg_rct_bhhl1=Rect(7776.0, 28320.0, 8064.0, 28608.0)
    set gg_rct_bhhl=Rect(7776.0, 27616.0, 8064.0, 27904.0)
    set gg_rct_yijie1=Rect(5216.0, 28352.0, 5504.0, 28640.0)
    set gg_rct_yijie=Rect(5216.0, 27648.0, 5504.0, 27936.0)
    set gg_rct_yandi1=Rect(2624.0, 28320.0, 2912.0, 28608.0)
    set gg_rct_yandi=Rect(2624.0, 27616.0, 2912.0, 27904.0)
    set gg_rct_ronglian44=Rect(64.0, 28352.0, 352.0, 28640.0)
    set gg_rct_ronglian4=Rect(64.0, 27648.0, 352.0, 27936.0)
    set gg_rct_ronglian33=Rect(- 2976.0, 28320.0, - 2688.0, 28608.0)
    set gg_rct_ronglian3=Rect(- 2976.0, 27616.0, - 2688.0, 27904.0)
    set gg_rct_ronglian22=Rect(- 2944.0, 25792.0, - 2656.0, 26080.0)
    set gg_rct_ronglian2=Rect(- 2944.0, 25088.0, - 2656.0, 25376.0)
    set gg_rct_ronglian11=Rect(96.0, 25792.0, 384.0, 26080.0)
    set gg_rct_ronglian1=Rect(96.0, 25088.0, 384.0, 25376.0)
    set gg_rct_zxzw4=Rect(6208.0, - 4352.0, 6592.0, - 3968.0)
    set gg_rct_zxzw5=Rect(6880.0, - 5376.0, 7264.0, - 4960.0)
    set gg_rct_zxzw6=Rect(6944.0, - 6560.0, 7392.0, - 6144.0)
    set gg_rct_F2cs=Rect(4640.0, 8032.0, 4704.0, 8096.0)
    set gg_rct_cg1=Rect(2016.0, 14912.0, 2336.0, 15264.0)
    set gg_rct_cg2=Rect(4352.0, 14912.0, 4672.0, 15264.0)
    set gg_rct_cg3=Rect(6912.0, 14848.0, 7232.0, 15200.0)
    set gg_rct_cgboss4=Rect(4352.0, 14528.0, 4672.0, 14880.0)
    set gg_rct_jg1=Rect(4224.0, 12256.0, 4832.0, 12800.0)
    set gg_rct_cbg1=Rect(- 10784.0, 11584.0, - 10720.0, 11648.0)
    set gg_rct_cbg3=Rect(- 11488.0, 12672.0, - 10048.0, 13408.0)
    set gg_rct_cbg2=Rect(- 11488.0, 11776.0, - 10048.0, 12512.0)
    set gg_rct_cbg4=Rect(- 10784.0, 13568.0, - 10720.0, 13632.0)
    set gg_rct_cbt2=Rect(3296.0, 6368.0, 6176.0, 8416.0)
    set gg_rct_cjg1=Rect(- 4672.0, 12160.0, - 4608.0, 12224.0)
    set gg_rct_cjg2=Rect(- 5504.0, 12704.0, - 5120.0, 13056.0)
    set gg_rct_cjg3=Rect(- 4096.0, 12704.0, - 3712.0, 13056.0)
    set gg_rct_cjg4=Rect(- 5600.0, 13792.0, - 5216.0, 14144.0)
    set gg_rct_cjg5=Rect(- 4064.0, 13792.0, - 3680.0, 14144.0)
    set gg_rct_cjg6=Rect(- 4672.0, 14656.0, - 4608.0, 14720.0)
    set gg_rct_jianzhong1=Rect(- 10720.0, 5152.0, - 10688.0, 5184.0)
    set gg_rct_jianzhong2=Rect(- 11776.0, 5760.0, - 11328.0, 6176.0)
    set gg_rct_jianzhong3=Rect(- 10080.0, 5792.0, - 9632.0, 6208.0)
    set gg_rct_jianzhong4=Rect(- 10720.0, 7040.0, - 10688.0, 7072.0)
    set gg_rct_bhg1=Rect(- 5024.0, 4480.0, - 4960.0, 4544.0)
    set gg_rct_bhg2=Rect(- 5184.0, 5792.0, - 4832.0, 6176.0)
    set gg_rct_bhg3=Rect(- 3648.0, 6400.0, - 3296.0, 6784.0)
    set gg_rct_bhg4=Rect(- 5408.0, 6624.0, - 5056.0, 7008.0)
    set gg_rct_bhg5=Rect(- 4448.0, 7456.0, - 4096.0, 7840.0)
    set gg_rct_bhg7=Rect(- 5856.0, 7744.0, - 5696.0, 7904.0)
    set gg_rct_bhg6=Rect(- 4448.0, 6624.0, - 4096.0, 7008.0)
    set gg_rct_longgong1=Rect(- 11264.0, - 1696.0, - 11136.0, - 1568.0)
    set gg_rct_longgong2=Rect(- 12448.0, - 1088.0, - 12032.0, - 672.0)
    set gg_rct_longgong3=Rect(- 12160.0, 320.0, - 11744.0, 768.0)
    set gg_rct_longgong8=Rect(- 8192.0, - 480.0, - 7840.0, - 64.0)
    set gg_rct_longgong7=Rect(- 8576.0, 352.0, - 8160.0, 768.0)
    set gg_rct_longgong6=Rect(- 9312.0, 832.0, - 8896.0, 1312.0)
    set gg_rct_longgong5=Rect(- 9920.0, - 1280.0, - 9536.0, - 832.0)
    set gg_rct_longgong4=Rect(- 10688.0, - 320.0, - 10240.0, 128.0)
    set gg_rct_zeds1=Rect(- 768.0, - 992.0, - 704.0, - 896.0)
    set gg_rct_zeds2=Rect(- 2304.0, - 1184.0, - 1920.0, - 768.0)
    set gg_rct_zeds3=Rect(- 3008.0, - 320.0, - 2528.0, 224.0)
    set gg_rct_zeds4=Rect(- 2112.0, 832.0, - 1696.0, 1312.0)
    set gg_rct_zeds5=Rect(- 4192.0, - 192.0, - 3680.0, 192.0)
    set gg_rct_zeds7=Rect(- 4736.0, 800.0, - 4384.0, 1184.0)
    set gg_rct_zeds6=Rect(- 3584.0, 960.0, - 3200.0, 1312.0)
    set gg_rct_zeds8=Rect(- 4384.0, - 1824.0, - 4000.0, - 1440.0)
	set gg_rct_tupo=Rect(10336.0, 18112.0, 10656.0, 18336.0)
    set gg_rct_tupo1=Rect(10336.0, 18592.0, 10656.0, 18816.0)
    set gg_rct_tupo2=Rect(9408.0, 17408.0, 11552.0, 19648.0)
	set gg_rct_shoulei11=Rect(10880.0, 4000.0, 10944.0, 4064.0)
    set gg_rct_shoulei12=Rect(10112.0, 4576.0, 10304.0, 4800.0)
    set gg_rct_shoulei13=Rect(11424.0, 4576.0, 11616.0, 4800.0)
    set gg_rct_shoulei14=Rect(11456.0, 3424.0, 11648.0, 3648.0)
    set gg_rct_shoulei15=Rect(10144.0, 3392.0, 10336.0, 3616.0)
    set gg_rct_shoulei16=Rect(10816.0, 5632.0, 11008.0, 5856.0)
    set gg_rct_shoulei21=Rect(14016.0, 4000.0, 14080.0, 4064.0)
    set gg_rct_shoulei22=Rect(13248.0, 4576.0, 13440.0, 4800.0)
    set gg_rct_shoulei23=Rect(14560.0, 4576.0, 14752.0, 4800.0)
    set gg_rct_shoulei24=Rect(14592.0, 3424.0, 14784.0, 3648.0)
    set gg_rct_shoulei25=Rect(13280.0, 3392.0, 13472.0, 3616.0)
    set gg_rct_shoulei26=Rect(13952.0, 5632.0, 14144.0, 5856.0)
    set gg_rct_shoulei31=Rect(17088.0, 4032.0, 17152.0, 4096.0)
    set gg_rct_shoulei32=Rect(16320.0, 4608.0, 16512.0, 4832.0)
    set gg_rct_shoulei33=Rect(17632.0, 4608.0, 17824.0, 4832.0)
    set gg_rct_shoulei34=Rect(17664.0, 3456.0, 17856.0, 3680.0)
    set gg_rct_shoulei35=Rect(16352.0, 3424.0, 16544.0, 3648.0)
    set gg_rct_shoulei36=Rect(17024.0, 5664.0, 17216.0, 5888.0)
    set gg_rct_shoulei41=Rect(17152.0, 8512.0, 17216.0, 8576.0)
    set gg_rct_shoulei42=Rect(16384.0, 9088.0, 16576.0, 9312.0)
    set gg_rct_shoulei43=Rect(17696.0, 9088.0, 17888.0, 9312.0)
    set gg_rct_shoulei44=Rect(17728.0, 7936.0, 17920.0, 8160.0)
    set gg_rct_shoulei45=Rect(16416.0, 7904.0, 16608.0, 8128.0)
    set gg_rct_shoulei46=Rect(17088.0, 10144.0, 17280.0, 10368.0)
    set gg_rct_shoulei51=Rect(14080.0, 8512.0, 14144.0, 8576.0)
    set gg_rct_shoulei52=Rect(13312.0, 9088.0, 13504.0, 9312.0)
    set gg_rct_shoulei53=Rect(14624.0, 9088.0, 14816.0, 9312.0)
    set gg_rct_shoulei54=Rect(14656.0, 7936.0, 14848.0, 8160.0)
    set gg_rct_shoulei55=Rect(13344.0, 7904.0, 13536.0, 8128.0)
    set gg_rct_shoulei56=Rect(14016.0, 10144.0, 14208.0, 10368.0)
    set gg_rct_shoulei61=Rect(10912.0, 8512.0, 10976.0, 8576.0)
    set gg_rct_shoulei62=Rect(10144.0, 9088.0, 10336.0, 9312.0)
    set gg_rct_shoulei63=Rect(11456.0, 9088.0, 11648.0, 9312.0)
    set gg_rct_shoulei64=Rect(11488.0, 7936.0, 11680.0, 8160.0)
    set gg_rct_shoulei65=Rect(10176.0, 7904.0, 10368.0, 8128.0)
    set gg_rct_shoulei66=Rect(10848.0, 10144.0, 11040.0, 10368.0)
    set gg_rct_shoulei71=Rect(10912.0, 12992.0, 10976.0, 13056.0)
    set gg_rct_shoulei72=Rect(10144.0, 13568.0, 10336.0, 13792.0)
    set gg_rct_shoulei73=Rect(11456.0, 13568.0, 11648.0, 13792.0)
    set gg_rct_shoulei74=Rect(11488.0, 12416.0, 11680.0, 12640.0)
    set gg_rct_shoulei75=Rect(10176.0, 12384.0, 10368.0, 12608.0)
    set gg_rct_shoulei76=Rect(10848.0, 14624.0, 11040.0, 14848.0)
    set gg_rct_shoulei81=Rect(14080.0, 12992.0, 14144.0, 13056.0)
    set gg_rct_shoulei82=Rect(13312.0, 13568.0, 13504.0, 13792.0)
    set gg_rct_shoulei83=Rect(14624.0, 13568.0, 14816.0, 13792.0)
    set gg_rct_shoulei84=Rect(14656.0, 12416.0, 14848.0, 12640.0)
    set gg_rct_shoulei85=Rect(13344.0, 12384.0, 13536.0, 12608.0)
    set gg_rct_shoulei86=Rect(14016.0, 14624.0, 14208.0, 14848.0)
    set gg_rct_shoulei91=Rect(17152.0, 12992.0, 17216.0, 13056.0)
    set gg_rct_shoulei92=Rect(16384.0, 13568.0, 16576.0, 13792.0)
    set gg_rct_shoulei94=Rect(17728.0, 12416.0, 17920.0, 12640.0)
    set gg_rct_shoulei95=Rect(16416.0, 12384.0, 16608.0, 12608.0)
    set gg_rct_shoulei96=Rect(17088.0, 14624.0, 17280.0, 14848.0)
    set gg_rct_shoulei101=Rect(16480.0, 17088.0, 16544.0, 17152.0)
    set gg_rct_shoulei102=Rect(15712.0, 17664.0, 15904.0, 17888.0)
    set gg_rct_shoulei103=Rect(17024.0, 17664.0, 17216.0, 17888.0)
    set gg_rct_shoulei104=Rect(17056.0, 16512.0, 17248.0, 16736.0)
    set gg_rct_shoulei105=Rect(15744.0, 16480.0, 15936.0, 16704.0)
    set gg_rct_shoulei106=Rect(16416.0, 18720.0, 16608.0, 18944.0)
    set gg_rct_shoulei93=Rect(17696.0, 13568.0, 17888.0, 13792.0)
	set gg_rct_zhanjiuzhan=Rect(10304.0, 20384.0, 10624.0, 20608.0)
    set gg_rct_zhanjiuzhan1=Rect(10304.0, 20864.0, 10624.0, 21088.0)
    set gg_rct_zhanjiuzhan2=Rect(9376.0, 19680.0, 11520.0, 21920.0)
	set gg_rct_moshen1=Rect(- 6080.0, 26304.0, - 6016.0, 26368.0)
    set gg_rct_moshen2=Rect(- 6080.0, 27840.0, - 6016.0, 27904.0)
    set gg_rct_moshen3=Rect(- 6080.0, 24640.0, - 6016.0, 24704.0)
    set gg_rct_dujie1=Rect(- 8544.0, - 4896.0, - 8480.0, - 4832.0)
	set gg_rct_moshen4=Rect(- 7008.0, 23808.0, - 5088.0, 28544.0)
    set gg_rct_dujie2=Rect(- 9440.0, - 5632.0, - 7488.0, - 3936.0)
	set gg_rct_ronglian105=Rect(12672.0, 16448.0, 12864.0, 16672.0)
    set gg_rct_ronglian104=Rect(13984.0, 16480.0, 14176.0, 16704.0)
    set gg_rct_ronglian101=Rect(13408.0, 17056.0, 13472.0, 17120.0)
    set gg_rct_ronglian102=Rect(12640.0, 17632.0, 12832.0, 17856.0)
    set gg_rct_ronglian106=Rect(13344.0, 18688.0, 13536.0, 18912.0)
    set gg_rct_ronglian103=Rect(13952.0, 17632.0, 14144.0, 17856.0)
    set gg_rct_ronglian107=Rect(16448.0, 19168.0, 16576.0, 19264.0)
	set gg_rct_huohai=Rect(2752.0, 22976.0, 2880.0, 23072.0)
	set gg_rct_jueshishenjian=Rect(- 4992.0, - 6112.0, - 4864.0, - 5984.0)
    set gg_rct_jueshishenjian1=Rect(- 3648.0, - 5248.0, - 3520.0, - 5120.0)
	set gg_rct_xiangzi1=Rect(- 12864.0, 21952.0, - 12832.0, 21984.0)
    set gg_rct_xiangzi2=Rect(5312.0, - 6528.0, 5344.0, - 6496.0)
    set gg_rct_xiangzi3=Rect(5184.0, 9568.0, 5248.0, 9632.0)
    set gg_rct_xiangzi4=Rect(- 10432.0, 14080.0, - 10400.0, 14112.0)
    set gg_rct_xiangzi5=Rect(- 5120.0, 13728.0, - 5088.0, 13760.0)
    set gg_rct_xiangzi6=Rect(- 11968.0, 7264.0, - 11936.0, 7296.0)
    set gg_rct_xiangzi7=Rect(- 4576.0, 4256.0, - 4544.0, 4288.0)
    set gg_rct_xiangzi8=Rect(- 12384.0, 256.0, - 12352.0, 288.0)
    set gg_rct_xiangzi9=Rect(- 5024.0, - 1280.0, - 4992.0, - 1216.0)
    set gg_rct_xiangzi10=Rect(3328.0, 12352.0, 3360.0, 12384.0)
	set gg_rct_cbt3=Rect(3616.0, 8384.0, 6176.0, 8704.0)
	set gg_rct_zuqiu=Rect(- 4800.0, - 2016.0, - 3616.0, - 1216.0)
    set gg_rct_zuqiu1=Rect(- 4928.0, - 1696.0, - 4832.0, - 1504.0)
    set gg_rct_zuqiu2=Rect(- 3584.0, - 1696.0, - 3488.0, - 1504.0)
	set gg_rct_sylz=Rect(7808.0, 25088.0, 8096.0, 25376.0)
    set gg_rct_sylz1=Rect(7808.0, 25792.0, 8096.0, 26080.0)
	set gg_rct_moku=Rect(12480.0, 27136.0, 12640.0, 27296.0)
    set gg_rct_moku1=Rect(11168.0, 27904.0, 13184.0, 28416.0)
    set gg_rct_moku2=Rect(11168.0, 26080.0, 11744.0, 27872.0)
    set gg_rct_moku3=Rect(13408.0, 26144.0, 13984.0, 27680.0)
    set gg_rct_moku4=Rect(11776.0, 25984.0, 12960.0, 26528.0)
	set gg_rct_moku5=Rect(11136.0, 25952.0, 13984.0, 27680.0)
	set gg_rct_zhuzi=Rect(5472.0, - 5888.0, 5536.0, - 5824.0)
	set gg_rct_yingxiong21=Rect(- 10272.0, 26400.0, - 10240.0, 26432.0)
	set gg_rct_saijiboss1=Rect(13568.0, 28032.0, 13664.0, 28128.0)
	set gg_rct_saijiboss2=Rect(12960.0, 27648.0, 13120.0, 27776.0)
	set gg_rct_jiao2=Rect(11104.0, - 96.0, 11552.0, 288.0)
    set gg_rct_jiao3=Rect(10400.0, - 2656.0, 10880.0, - 2176.0)
    set gg_rct_jiao4=Rect(12512.0, - 1760.0, 13024.0, - 1280.0)
    set gg_rct_jiao5=Rect(11200.0, - 1632.0, 11616.0, - 1280.0)
    set gg_rct_jiao1=Rect(10432.0, 928.0, 10848.0, 1376.0)
    set gg_rct_jiao6=Rect(- 4992.0, 8192.0, - 4832.0, 8320.0)
	set gg_rct_kpds=Rect(- 1792.0, 224.0, - 1600.0, 416.0)
	set gg_rct_cbt5=Rect(- 10784.0, 13920.0, - 10720.0, 13984.0)
	set gg_rct_shengxiao=Rect(16192.0, - 3936.0, 16352.0, - 3776.0)
    set gg_rct_shengxiao2=Rect(15424.0, - 4640.0, 17120.0, - 3072.0)
	set gg_rct_yingxiong22=Rect(- 11328.0, 26400.0, - 11296.0, 26432.0)
endfunction

//===========================================================================
function InitTrig_lua takes nothing returns nothing
    set gg_trg_lua=CreateTrigger()
    call DoNothing()
    call TriggerAddAction(gg_trg_lua, function Trig_luaActions)
call func_bind_trigger_name(function Trig_luaActions , "lua")

endfunction
//===========================================================================
function InitCustomTriggers takes nothing returns nothing
    //Function not found: call InitTrig_japi_________u()
    //Function not found: call InitTrig____japi___u()
    //Function not found: call InitTrig_______japi___u()
    //Function not found: call InitTrig_api()
    //Function not found: call InitTrig_get_name()
    call InitTrig_lua()
endfunction
//===========================================================================
function RunInitializationTriggers takes nothing returns nothing
    call ConditionalTriggerExecute(gg_trg_lua)
endfunction
//***************************************************************************
//*
//*  Players
//*
//***************************************************************************
function InitCustomPlayerSlots takes nothing returns nothing
    // Player 0
    call SetPlayerStartLocation(Player(0), 0)
    call SetPlayerColor(Player(0), ConvertPlayerColor(0))
    call SetPlayerRacePreference(Player(0), RACE_PREF_NIGHTELF)
    call SetPlayerRaceSelectable(Player(0), false)
    call SetPlayerController(Player(0), MAP_CONTROL_USER)
    // Player 1
    call SetPlayerStartLocation(Player(1), 1)
    call SetPlayerColor(Player(1), ConvertPlayerColor(1))
    call SetPlayerRacePreference(Player(1), RACE_PREF_NIGHTELF)
    call SetPlayerRaceSelectable(Player(1), false)
    call SetPlayerController(Player(1), MAP_CONTROL_USER)
    // Player 2
    call SetPlayerStartLocation(Player(2), 2)
    call SetPlayerColor(Player(2), ConvertPlayerColor(2))
    call SetPlayerRacePreference(Player(2), RACE_PREF_NIGHTELF)
    call SetPlayerRaceSelectable(Player(2), false)
    call SetPlayerController(Player(2), MAP_CONTROL_USER)
    // Player 3
    call SetPlayerStartLocation(Player(3), 3)
    call SetPlayerColor(Player(3), ConvertPlayerColor(3))
    call SetPlayerRacePreference(Player(3), RACE_PREF_NIGHTELF)
    call SetPlayerRaceSelectable(Player(3), false)
    call SetPlayerController(Player(3), MAP_CONTROL_USER)
    // Player 4
    call SetPlayerStartLocation(Player(4), 4)
    call SetPlayerColor(Player(4), ConvertPlayerColor(4))
    call SetPlayerRacePreference(Player(4), RACE_PREF_NIGHTELF)
    call SetPlayerRaceSelectable(Player(4), false)
    call SetPlayerController(Player(4), MAP_CONTROL_USER)
    // Player 5
    call SetPlayerStartLocation(Player(5), 5)
    call SetPlayerColor(Player(5), ConvertPlayerColor(5))
    call SetPlayerRacePreference(Player(5), RACE_PREF_NIGHTELF)
    call SetPlayerRaceSelectable(Player(5), false)
    call SetPlayerController(Player(5), MAP_CONTROL_USER)
    // Player 10
    call SetPlayerStartLocation(Player(10), 6)
    call SetPlayerColor(Player(10), ConvertPlayerColor(10))
    call SetPlayerRacePreference(Player(10), RACE_PREF_NIGHTELF)
    call SetPlayerRaceSelectable(Player(10), false)
    call SetPlayerController(Player(10), MAP_CONTROL_COMPUTER)
    // Player 11
    call SetPlayerStartLocation(Player(11), 7)
    call SetPlayerColor(Player(11), ConvertPlayerColor(11))
    call SetPlayerRacePreference(Player(11), RACE_PREF_NIGHTELF)
    call SetPlayerRaceSelectable(Player(11), false)
    call SetPlayerController(Player(11), MAP_CONTROL_COMPUTER)
endfunction
function InitCustomTeams takes nothing returns nothing
    // Force: TRIGSTR_009
    call SetPlayerTeam(Player(0), 0)
    call SetPlayerState(Player(0), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(1), 0)
    call SetPlayerState(Player(1), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(2), 0)
    call SetPlayerState(Player(2), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(3), 0)
    call SetPlayerState(Player(3), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(4), 0)
    call SetPlayerState(Player(4), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(5), 0)
    call SetPlayerState(Player(5), PLAYER_STATE_ALLIED_VICTORY, 1)
    call SetPlayerTeam(Player(10), 0)
    call SetPlayerState(Player(10), PLAYER_STATE_ALLIED_VICTORY, 1)
    //   Allied
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(0), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(1), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(2), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(3), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(5), true)
    call SetPlayerAllianceStateAllyBJ(Player(4), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(5), Player(10), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(0), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(1), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(2), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(3), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(4), true)
    call SetPlayerAllianceStateAllyBJ(Player(10), Player(5), true)
    //   Shared Vision
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(0), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(1), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(2), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(3), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(5), true)
    call SetPlayerAllianceStateVisionBJ(Player(4), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(5), Player(10), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(0), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(1), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(2), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(3), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(4), true)
    call SetPlayerAllianceStateVisionBJ(Player(10), Player(5), true)
    // Force: TRIGSTR_010
    call SetPlayerTeam(Player(11), 1)
endfunction
function InitAllyPriorities takes nothing returns nothing
    call SetStartLocPrioCount(0, 4)
    call SetStartLocPrio(0, 0, 1, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrio(0, 1, 2, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(0, 2, 4, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(0, 3, 5, MAP_LOC_PRIO_LOW)
    call SetStartLocPrioCount(1, 2)
    call SetStartLocPrio(1, 0, 0, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(1, 1, 5, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrioCount(2, 1)
    call SetStartLocPrio(2, 0, 5, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrioCount(3, 1)
    call SetStartLocPrio(3, 0, 4, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrioCount(4, 1)
    call SetStartLocPrio(4, 0, 3, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrioCount(5, 1)
    call SetStartLocPrio(5, 0, 2, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrioCount(6, 2)
    call SetStartLocPrio(6, 0, 0, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(6, 1, 2, MAP_LOC_PRIO_HIGH)
    call SetStartLocPrioCount(7, 2)
    call SetStartLocPrio(7, 0, 0, MAP_LOC_PRIO_LOW)
    call SetStartLocPrio(7, 1, 2, MAP_LOC_PRIO_HIGH)
endfunction
//***************************************************************************
//*
//*  Main Initialization
//*
//***************************************************************************
//===========================================================================
function main takes nothing returns nothing
    call JapiConstantLib_init()
    call initializePlugin()
    call SetCameraBounds(- 14336.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), - 7680.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM), 18432.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), 29184.0 - GetCameraMargin(CAMERA_MARGIN_TOP), - 14336.0 + GetCameraMargin(CAMERA_MARGIN_LEFT), 29184.0 - GetCameraMargin(CAMERA_MARGIN_TOP), 18432.0 - GetCameraMargin(CAMERA_MARGIN_RIGHT), - 7680.0 + GetCameraMargin(CAMERA_MARGIN_BOTTOM))
    call SetDayNightModels("Environment\\DNC\\DNCLordaeron\\DNCLordaeronTerrain\\DNCLordaeronTerrain.mdl", "Environment\\DNC\\DNCLordaeron\\DNCLordaeronUnit\\DNCLordaeronUnit.mdl")
    call NewSoundEnvironment("Default")
    call SetAmbientDaySound("LordaeronSummerDay")
    call SetAmbientNightSound("LordaeronSummerNight")
    call SetMapMusic("Music", true, 0)
    call CreateCameras()
    call CreateRegions()
    call InitBlizzard()

call ExecuteFunc("Mtpplayername__initgetname")
call ExecuteFunc("YDTriggerSaveLoadSystem__Init")

    set udg_i=0 // INLINED!!
    call InitTrig_lua() // INLINED!!
    call ConditionalTriggerExecute(gg_trg_lua) // INLINED!!
endfunction
//***************************************************************************
//*
//*  Map Configuration
//*
//***************************************************************************
function config takes nothing returns nothing
    call SetMapName("魔灵降世")
    call SetMapDescription("没有说明")
    call SetPlayers(12)
    call SetTeams(12)
    call SetGamePlacement(MAP_PLACEMENT_TEAMS_TOGETHER)
    call DefineStartLocation(0, 0.0, 0.0)
    call DefineStartLocation(1, 0.0, 0.0)
    call DefineStartLocation(2, 0.0, 0.0)
    call DefineStartLocation(3, 0.0, 0.0)
    call DefineStartLocation(4, 0.0, 0.0)
    call DefineStartLocation(5, 0.0, 0.0)
    call DefineStartLocation(6, 0.0, 0.0)
    call DefineStartLocation(7, 0.0, 0.0)
    call DefineStartLocation(8, 0.0, 0.0)
    // Player setup
    call InitCustomPlayerSlots()
    call InitCustomTeams()
    call InitAllyPriorities()
endfunction




//Struct method generated initializers/callers:

