
require '平台.奖励.无尽.牛刀小试'
require '平台.奖励.无尽.驾轻就熟'


local mt = ac.skill['无尽模式']
mt{
    is_spellbook = 1,
    is_order = 2,
    art = [[wjms.blp]],
    tip = [[

点击查看 |cff00ffff无尽成就|r，主要通过 |cffffff00不断挑战无尽模式|r 获得
    ]],
    
}
mt.skills = {
    '牛刀小试','驾轻就熟'
}
