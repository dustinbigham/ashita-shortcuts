--[[
* Ashita v4 companion addon for command shortcut aliases.
*
* This addon intentionally stays conservative around client and Ashita commands.
* It handles command aliases, target token cleanup, and explicitly aliased game actions
* that can be resolved through Ashita resources.
--]]

addon.name      = 'ashitashortcuts';
addon.author    = 'dustinbigham';
addon.version   = '2.2.15';
addon.desc      = 'Adds command shortcut aliases and action commands for Ashita.';
addon.link      = 'https://github.com/dustinbigham/ashita-shortcuts';

require('common');

local chat = require('chat');

local aliases = {
    c1    = { prefix = '/ma', name = 'Cure',          target = '<me>', friendly = true },
    c2    = { prefix = '/ma', name = 'Cure II',       target = '<me>', friendly = true },
    c3    = { prefix = '/ma', name = 'Cure III',      target = '<me>', friendly = true },
    c4    = { prefix = '/ma', name = 'Cure IV',       target = '<me>', friendly = true },
    c5    = { prefix = '/ma', name = 'Cure V',        target = '<me>', friendly = true },
    c6    = { prefix = '/ma', name = 'Cure VI',       target = '<me>', friendly = true },
    r1    = { prefix = '/ma', name = 'Raise',         target = '<t>'  },
    r2    = { prefix = '/ma', name = 'Raise II',      target = '<t>'  },
    r3    = { prefix = '/ma', name = 'Raise III',     target = '<t>'  },
    rr    = { prefix = '/ma', name = 'Reraise',       target = '<me>' },
    rr1   = { prefix = '/ma', name = 'Reraise',       target = '<me>' },
    rr2   = { prefix = '/ma', name = 'Reraise II',    target = '<me>' },
    rr3   = { prefix = '/ma', name = 'Reraise III',   target = '<me>' },

    a1    = { prefix = '/ma', name = 'Aero',          target = '<t>'  },
    a2    = { prefix = '/ma', name = 'Aero II',       target = '<t>'  },
    a3    = { prefix = '/ma', name = 'Aero III',      target = '<t>'  },
    a4    = { prefix = '/ma', name = 'Aero IV',       target = '<t>'  },
    a5    = { prefix = '/ma', name = 'Aero V',        target = '<t>'  },
    a6    = { prefix = '/ma', name = 'Aero VI',       target = '<t>'  },
    b1    = { prefix = '/ma', name = 'Blizzard',      target = '<t>'  },
    b2    = { prefix = '/ma', name = 'Blizzard II',   target = '<t>'  },
    b3    = { prefix = '/ma', name = 'Blizzard III',  target = '<t>'  },
    b4    = { prefix = '/ma', name = 'Blizzard IV',   target = '<t>'  },
    b5    = { prefix = '/ma', name = 'Blizzard V',    target = '<t>'  },
    b6    = { prefix = '/ma', name = 'Blizzard VI',   target = '<t>'  },
    f1    = { prefix = '/ma', name = 'Fire',          target = '<t>'  },
    f2    = { prefix = '/ma', name = 'Fire II',       target = '<t>'  },
    f3    = { prefix = '/ma', name = 'Fire III',      target = '<t>'  },
    f4    = { prefix = '/ma', name = 'Fire IV',       target = '<t>'  },
    f5    = { prefix = '/ma', name = 'Fire V',        target = '<t>'  },
    f6    = { prefix = '/ma', name = 'Fire VI',       target = '<t>'  },
    s1    = { prefix = '/ma', name = 'Stone',         target = '<t>'  },
    s2    = { prefix = '/ma', name = 'Stone II',      target = '<t>'  },
    s3    = { prefix = '/ma', name = 'Stone III',     target = '<t>'  },
    s4    = { prefix = '/ma', name = 'Stone IV',      target = '<t>'  },
    s5    = { prefix = '/ma', name = 'Stone V',       target = '<t>'  },
    s6    = { prefix = '/ma', name = 'Stone VI',      target = '<t>'  },
    t1    = { prefix = '/ma', name = 'Thunder',       target = '<t>'  },
    t2    = { prefix = '/ma', name = 'Thunder II',    target = '<t>'  },
    t3    = { prefix = '/ma', name = 'Thunder III',   target = '<t>'  },
    t4    = { prefix = '/ma', name = 'Thunder IV',    target = '<t>'  },
    t5    = { prefix = '/ma', name = 'Thunder V',     target = '<t>'  },
    t6    = { prefix = '/ma', name = 'Thunder VI',    target = '<t>'  },
    w1    = { prefix = '/ma', name = 'Water',         target = '<t>'  },
    w2    = { prefix = '/ma', name = 'Water II',      target = '<t>'  },
    w3    = { prefix = '/ma', name = 'Water III',     target = '<t>'  },
    w4    = { prefix = '/ma', name = 'Water IV',      target = '<t>'  },
    w5    = { prefix = '/ma', name = 'Water V',       target = '<t>'  },
    w6    = { prefix = '/ma', name = 'Water VI',      target = '<t>'  },
    ae1   = { prefix = '/ma', name = 'Aero',          target = '<t>'  },
    ae2   = { prefix = '/ma', name = 'Aero II',       target = '<t>'  },
    ae3   = { prefix = '/ma', name = 'Aero III',      target = '<t>'  },
    ae4   = { prefix = '/ma', name = 'Aero IV',       target = '<t>'  },
    ae5   = { prefix = '/ma', name = 'Aero V',        target = '<t>'  },
    ae6   = { prefix = '/ma', name = 'Aero VI',       target = '<t>'  },
    bl1   = { prefix = '/ma', name = 'Blizzard',      target = '<t>'  },
    bl2   = { prefix = '/ma', name = 'Blizzard II',   target = '<t>'  },
    bl3   = { prefix = '/ma', name = 'Blizzard III',  target = '<t>'  },
    bl4   = { prefix = '/ma', name = 'Blizzard IV',   target = '<t>'  },
    bl5   = { prefix = '/ma', name = 'Blizzard V',    target = '<t>'  },
    bl6   = { prefix = '/ma', name = 'Blizzard VI',   target = '<t>'  },
    fi1   = { prefix = '/ma', name = 'Fire',          target = '<t>'  },
    fi2   = { prefix = '/ma', name = 'Fire II',       target = '<t>'  },
    fi3   = { prefix = '/ma', name = 'Fire III',      target = '<t>'  },
    fi4   = { prefix = '/ma', name = 'Fire IV',       target = '<t>'  },
    fi5   = { prefix = '/ma', name = 'Fire V',        target = '<t>'  },
    fi6   = { prefix = '/ma', name = 'Fire VI',       target = '<t>'  },
    st1   = { prefix = '/ma', name = 'Stone',         target = '<t>'  },
    st2   = { prefix = '/ma', name = 'Stone II',      target = '<t>'  },
    st3   = { prefix = '/ma', name = 'Stone III',     target = '<t>'  },
    st4   = { prefix = '/ma', name = 'Stone IV',      target = '<t>'  },
    st5   = { prefix = '/ma', name = 'Stone V',       target = '<t>'  },
    st6   = { prefix = '/ma', name = 'Stone VI',      target = '<t>'  },
    th1   = { prefix = '/ma', name = 'Thunder',       target = '<t>'  },
    th2   = { prefix = '/ma', name = 'Thunder II',    target = '<t>'  },
    th3   = { prefix = '/ma', name = 'Thunder III',   target = '<t>'  },
    th4   = { prefix = '/ma', name = 'Thunder IV',    target = '<t>'  },
    th5   = { prefix = '/ma', name = 'Thunder V',     target = '<t>'  },
    th6   = { prefix = '/ma', name = 'Thunder VI',    target = '<t>'  },
    wa1   = { prefix = '/ma', name = 'Water',         target = '<t>'  },
    wa2   = { prefix = '/ma', name = 'Water II',      target = '<t>'  },
    wa3   = { prefix = '/ma', name = 'Water III',     target = '<t>'  },
    wa4   = { prefix = '/ma', name = 'Water IV',      target = '<t>'  },
    wa5   = { prefix = '/ma', name = 'Water V',       target = '<t>'  },
    wa6   = { prefix = '/ma', name = 'Water VI',      target = '<t>'  },
    ag    = { prefix = '/ma', name = 'Aeroga',        target = '<t>'  },
    ag1   = { prefix = '/ma', name = 'Aeroga',        target = '<t>'  },
    ag2   = { prefix = '/ma', name = 'Aeroga II',     target = '<t>'  },
    ag3   = { prefix = '/ma', name = 'Aeroga III',    target = '<t>'  },
    bg    = { prefix = '/ma', name = 'Blizzaga',      target = '<t>'  },
    bg1   = { prefix = '/ma', name = 'Blizzaga',      target = '<t>'  },
    bg2   = { prefix = '/ma', name = 'Blizzaga II',   target = '<t>'  },
    bg3   = { prefix = '/ma', name = 'Blizzaga III',  target = '<t>'  },
    fg    = { prefix = '/ma', name = 'Firaga',        target = '<t>'  },
    fg1   = { prefix = '/ma', name = 'Firaga',        target = '<t>'  },
    fg2   = { prefix = '/ma', name = 'Firaga II',     target = '<t>'  },
    fg3   = { prefix = '/ma', name = 'Firaga III',    target = '<t>'  },
    sg    = { prefix = '/ma', name = 'Stonega',       target = '<t>'  },
    sg1   = { prefix = '/ma', name = 'Stonega',       target = '<t>'  },
    sg2   = { prefix = '/ma', name = 'Stonega II',    target = '<t>'  },
    sg3   = { prefix = '/ma', name = 'Stonega III',   target = '<t>'  },
    tg    = { prefix = '/ma', name = 'Thundaga',      target = '<t>'  },
    tg1   = { prefix = '/ma', name = 'Thundaga',      target = '<t>'  },
    tg2   = { prefix = '/ma', name = 'Thundaga II',   target = '<t>'  },
    tg3   = { prefix = '/ma', name = 'Thundaga III',  target = '<t>'  },
    wg    = { prefix = '/ma', name = 'Waterga',       target = '<t>'  },
    wg1   = { prefix = '/ma', name = 'Waterga',       target = '<t>'  },
    wg2   = { prefix = '/ma', name = 'Waterga II',    target = '<t>'  },
    wg3   = { prefix = '/ma', name = 'Waterga III',   target = '<t>'  },

    d1    = { prefix = '/ma', name = 'Dia',           target = '<t>'  },
    d2    = { prefix = '/ma', name = 'Dia II',        target = '<t>'  },
    d3    = { prefix = '/ma', name = 'Dia III',       target = '<t>'  },
    di    = { prefix = '/ma', name = 'Dia',           target = '<t>'  },
    dia1  = { prefix = '/ma', name = 'Dia',           target = '<t>'  },
    dia2  = { prefix = '/ma', name = 'Dia II',        target = '<t>'  },
    dia3  = { prefix = '/ma', name = 'Dia III',       target = '<t>'  },
    dg    = { prefix = '/ma', name = 'Diaga',         target = '<t>'  },
    bi1   = { prefix = '/ma', name = 'Bio',           target = '<t>'  },
    bi2   = { prefix = '/ma', name = 'Bio II',        target = '<t>'  },
    bi3   = { prefix = '/ma', name = 'Bio III',       target = '<t>'  },
    poison  = { prefix = '/ma', name = 'Poison',      target = '<t>'  },
    poison1 = { prefix = '/ma', name = 'Poison',      target = '<t>'  },
    poison2 = { prefix = '/ma', name = 'Poison II',   target = '<t>'  },
    slp   = { prefix = '/ma', name = 'Sleep',         target = '<t>'  },
    slp1  = { prefix = '/ma', name = 'Sleep',         target = '<t>'  },
    slp2  = { prefix = '/ma', name = 'Sleep II',      target = '<t>'  },
    slg   = { prefix = '/ma', name = 'Sleepga',       target = '<t>'  },
    slg1  = { prefix = '/ma', name = 'Sleepga',       target = '<t>'  },
    slg2  = { prefix = '/ma', name = 'Sleepga II',    target = '<t>'  },
    sil   = { prefix = '/ma', name = 'Silence',       target = '<t>'  },
    para  = { prefix = '/ma', name = 'Paralyze',      target = '<t>'  },
    pna   = { prefix = '/ma', name = 'Paralyna',      target = '<me>', friendly = true },
    slw   = { prefix = '/ma', name = 'Slow',          target = '<t>'  },
    slw1  = { prefix = '/ma', name = 'Slow',          target = '<t>'  },
    slw2  = { prefix = '/ma', name = 'Slow II',       target = '<t>'  },
    bld   = { prefix = '/ma', name = 'Blind',         target = '<t>'  },
    bld1  = { prefix = '/ma', name = 'Blind',         target = '<t>'  },
    bld2  = { prefix = '/ma', name = 'Blind II',      target = '<t>'  },
    grv   = { prefix = '/ma', name = 'Gravity',       target = '<t>'  },
    grav  = { prefix = '/ma', name = 'Gravity',       target = '<t>'  },
    dsp   = { prefix = '/ma', name = 'Dispel',        target = '<t>'  },
    disp  = { prefix = '/ma', name = 'Dispel',        target = '<t>'  },
    stn   = { prefix = '/ma', name = 'Stun',          target = '<t>'  },
    dr    = { prefix = '/ma', name = 'Drain',         target = '<t>'  },
    asp   = { prefix = '/ma', name = 'Aspir',         target = '<t>'  },
    brn   = { prefix = '/ma', name = 'Burn',          target = '<t>'  },
    frst  = { prefix = '/ma', name = 'Frost',         target = '<t>'  },
    chk   = { prefix = '/ma', name = 'Choke',         target = '<t>'  },
    rsp   = { prefix = '/ma', name = 'Rasp',          target = '<t>'  },
    shk   = { prefix = '/ma', name = 'Shock',         target = '<t>'  },
    dwn   = { prefix = '/ma', name = 'Drown',         target = '<t>'  },
    flr   = { prefix = '/ma', name = 'Flare',         target = '<t>'  },
    frz   = { prefix = '/ma', name = 'Freeze',        target = '<t>'  },
    brst  = { prefix = '/ma', name = 'Burst',         target = '<t>'  },
    qk    = { prefix = '/ma', name = 'Quake',         target = '<t>'  },
    tor   = { prefix = '/ma', name = 'Tornado',       target = '<t>'  },
    fld   = { prefix = '/ma', name = 'Flood',         target = '<t>'  },

    pro1  = { prefix = '/ma', name = 'Protectra',     target = '<me>' },
    pro2  = { prefix = '/ma', name = 'Protectra II',  target = '<me>' },
    pro3  = { prefix = '/ma', name = 'Protectra III', target = '<me>' },
    pro4  = { prefix = '/ma', name = 'Protectra IV',  target = '<me>' },
    pro5  = { prefix = '/ma', name = 'Protectra V',   target = '<me>' },
    sh1   = { prefix = '/ma', name = 'Shellra',       target = '<me>' },
    sh2   = { prefix = '/ma', name = 'Shellra II',    target = '<me>' },
    sh3   = { prefix = '/ma', name = 'Shellra III',   target = '<me>' },
    sh4   = { prefix = '/ma', name = 'Shellra IV',    target = '<me>' },
    sh5   = { prefix = '/ma', name = 'Shellra V',     target = '<me>' },
    she1  = { prefix = '/ma', name = 'Shellra',       target = '<me>' },
    she2  = { prefix = '/ma', name = 'Shellra II',    target = '<me>' },
    she3  = { prefix = '/ma', name = 'Shellra III',   target = '<me>' },
    she4  = { prefix = '/ma', name = 'Shellra IV',    target = '<me>' },
    she5  = { prefix = '/ma', name = 'Shellra V',     target = '<me>' },
    bl    = { prefix = '/ma', name = 'Blink',         target = '<me>' },
    ss    = { prefix = '/ma', name = 'Stoneskin',     target = '<me>' },
    snk   = { prefix = '/ma', name = 'Sneak',         target = '<me>', friendly = true },
    ['in'] = { prefix = '/ma', name = 'Invisible',    target = '<me>', friendly = true },
    deod  = { prefix = '/ma', name = 'Deodorize',     target = '<me>', friendly = true },
    rf    = { prefix = '/ma', name = 'Refresh',       target = '<me>', friendly = true },
    rf1   = { prefix = '/ma', name = 'Refresh',       target = '<me>', friendly = true },
    ref   = { prefix = '/ma', name = 'Refresh',       target = '<me>', friendly = true },
    hst   = { prefix = '/ma', name = 'Haste',         target = '<me>', friendly = true },
    phx   = { prefix = '/ma', name = 'Phalanx',       target = '<me>' },
    phx2  = { prefix = '/ma', name = 'Phalanx II',    target = '<me>', friendly = true },
    enf   = { prefix = '/ma', name = 'Enfire',        target = '<me>' },
    enb   = { prefix = '/ma', name = 'Enblizzard',    target = '<me>' },
    ena   = { prefix = '/ma', name = 'Enaero',        target = '<me>' },
    ens   = { prefix = '/ma', name = 'Enstone',       target = '<me>' },
    ent   = { prefix = '/ma', name = 'Enthunder',     target = '<me>' },
    enw   = { prefix = '/ma', name = 'Enwater',       target = '<me>' },
    re1   = { prefix = '/ma', name = 'Regen',         target = '<me>', friendly = true },
    re2   = { prefix = '/ma', name = 'Regen II',      target = '<me>', friendly = true },
    re3   = { prefix = '/ma', name = 'Regen III',     target = '<me>', friendly = true },
    re4   = { prefix = '/ma', name = 'Regen IV',      target = '<me>', friendly = true },
    re5   = { prefix = '/ma', name = 'Regen V',       target = '<me>', friendly = true },

    holla  = { prefix = '/ma', name = 'Teleport-Holla', target = '<me>' },
    dem    = { prefix = '/ma', name = 'Teleport-Dem',   target = '<me>' },
    mea    = { prefix = '/ma', name = 'Teleport-Mea',   target = '<me>' },
    yhoat  = { prefix = '/ma', name = 'Teleport-Yhoat', target = '<me>' },
    altep  = { prefix = '/ma', name = 'Teleport-Altep', target = '<me>' },
    vahzl  = { prefix = '/ma', name = 'Teleport-Vahzl', target = '<me>' },
    jugner = { prefix = '/ma', name = 'Recall-Jugner',  target = '<me>' },
    pashh  = { prefix = '/ma', name = 'Recall-Pashh',   target = '<me>' },
    pash   = { prefix = '/ma', name = 'Recall-Pashh',   target = '<me>' },
    meri   = { prefix = '/ma', name = 'Recall-Meriph',  target = '<me>' },
    meriph = { prefix = '/ma', name = 'Recall-Meriph',  target = '<me>' },
    wp     = { prefix = '/ma', name = 'Warp',           target = '<me>' },
    wp1    = { prefix = '/ma', name = 'Warp',           target = '<me>' },
    wp2    = { prefix = '/ma', name = 'Warp II',        target = '<t>'  },
    esc    = { prefix = '/ma', name = 'Escape',         target = '<me>' },
    trac   = { prefix = '/ma', name = 'Tractor',        target = '<t>'  },

    carb  = { prefix = '/ma', name = 'Carbuncle',      target = '<me>' },
    ifr   = { prefix = '/ma', name = 'Ifrit',          target = '<me>' },
    gar   = { prefix = '/ma', name = 'Garuda',         target = '<me>' },
    tit   = { prefix = '/ma', name = 'Titan',          target = '<me>' },
    ram   = { prefix = '/ma', name = 'Ramuh',          target = '<me>' },
    lev   = { prefix = '/ma', name = 'Leviathan',      target = '<me>' },
    shv   = { prefix = '/ma', name = 'Shiva',          target = '<me>' },
    fen   = { prefix = '/ma', name = 'Fenrir',         target = '<me>' },
    diab  = { prefix = '/ma', name = 'Diabolos',       target = '<me>' },
    db    = { prefix = '/ma', name = 'Diabolos',       target = '<me>' },

    ichi  = { prefix = '/ma', name = 'Utsusemi: Ichi', target = '<me>' },
    ni    = { prefix = '/ma', name = 'Utsusemi: Ni',   target = '<me>' },
    utsu1 = { prefix = '/ma', name = 'Utsusemi: Ichi', target = '<me>' },
    utsu2 = { prefix = '/ma', name = 'Utsusemi: Ni',   target = '<me>' },

    ds   = { prefix = '/ja', name = 'Divine Seal',      target = '<me>' },
    es   = { prefix = '/ja', name = 'Elemental Seal',   target = '<me>' },
    mf   = { prefix = '/ja', name = 'Manafont',         target = '<me>' },
    cs   = { prefix = '/ja', name = 'Chainspell',       target = '<me>' },
    cv   = { prefix = '/ja', name = 'Convert',          target = '<me>' },
    conv = { prefix = '/ja', name = 'Convert',          target = '<me>' },
    af   = { prefix = '/ja', name = 'Astral Flow',      target = '<me>' },
    siph = { prefix = '/ja', name = 'Elemental Siphon', target = '<me>' },
    la   = { prefix = '/ja', name = 'Light Arts',       target = '<me>' },
    da   = { prefix = '/ja', name = 'Dark Arts',        target = '<me>' },
    pen  = { prefix = '/ja', name = 'Penury',           target = '<me>' },
    cel  = { prefix = '/ja', name = 'Celerity',         target = '<me>' },
    sa   = { prefix = '/ja', name = 'Sneak Attack',     target = '<me>' },
    sneakattack = { prefix = '/ja', name = 'Sneak Attack', target = '<me>' },
    tra  = { prefix = '/ja', name = 'Trick Attack',     target = '<me>' },
    trick = { prefix = '/ja', name = 'Trick Attack',    target = '<me>' },
    trickattack = { prefix = '/ja', name = 'Trick Attack', target = '<me>' },
    voke = { prefix = '/ja', name = 'Provoke',          target = '<t>'  },
    prov = { prefix = '/ja', name = 'Provoke',          target = '<t>'  },
    zerk = { prefix = '/ja', name = 'Berserk',          target = '<me>' },
    aggr = { prefix = '/ja', name = 'Aggressor',        target = '<me>' },
    defender = { prefix = '/ja', name = 'Defender',     target = '<me>' },
    boost = { prefix = '/ja', name = 'Boost',           target = '<me>' },
    cw1  = { prefix = '/ja', name = 'Curing Waltz',     target = '<me>', friendly = true },
    cw2  = { prefix = '/ja', name = 'Curing Waltz II',  target = '<me>', friendly = true },
    cw3  = { prefix = '/ja', name = 'Curing Waltz III', target = '<me>', friendly = true },
    cw4  = { prefix = '/ja', name = 'Curing Waltz IV',  target = '<me>', friendly = true },
    cw5  = { prefix = '/ja', name = 'Curing Waltz V',   target = '<me>', friendly = true },
    hw   = { prefix = '/ja', name = 'Healing Waltz',    target = '<me>', friendly = true },
    ast  = { prefix = '/pet', name = 'Assault',         target = '<t>'  },
    ret  = { prefix = '/pet', name = 'Retreat',         target = '<me>' },
    rel  = { prefix = '/pet', name = 'Release',         target = '<me>' },
    bpr  = { prefix = '/pet', name = 'Blood Pact: Rage', target = '<t>'  },
    bpw  = { prefix = '/pet', name = 'Blood Pact: Ward', target = '<me>' },
    fb   = { prefix = '/ws', name = 'Fast Blade',       target = '<t>'  },
    fast = { prefix = '/ws', name = 'Fast Blade',       target = '<t>'  },
    fastblade = { prefix = '/ws', name = 'Fast Blade',  target = '<t>'  },
    flat = { prefix = '/ws', name = 'Flat Blade',       target = '<t>'  },
    flb  = { prefix = '/ws', name = 'Flat Blade',       target = '<t>'  },
    flatblade = { prefix = '/ws', name = 'Flat Blade',  target = '<t>'  },
    cb   = { prefix = '/ws', name = 'Combo',            target = '<t>'  },
    combo = { prefix = '/ws', name = 'Combo',           target = '<t>'  },
    enpi = { prefix = '/ws', name = 'Tachi: Enpi',      target = '<t>'  },
    bd   = { prefix = '/ma', name = 'Bind',             target = '<t>'  },
    bnd  = { prefix = '/ma', name = 'Bind',             target = '<t>'  },
};

local prefix_aliases = {
    ma = '/ma',
    magic = '/ma',
    so = '/ma',
    song = '/ma',
    nin = '/ma',
    ninjutsu = '/ma',
    ja = '/ja',
    jobability = '/ja',
    pet = '/ja',
    ws = '/ws',
    weaponskill = '/ws',
    i = '/item',
    item = '/item',
};

local native_prefix_commands = {
    ma = true,
    magic = true,
    ja = true,
    jobability = true,
    pet = true,
    ws = true,
    weaponskill = true,
    i = true,
    item = true,
};

local target_aliases = {
    me = '<me>',
    self = '<me>',
    t = '<t>',
    bt = '<bt>',
    ft = '<ft>',
    st = '<st>',
    stpc = '<stpc>',
    stnpc = '<stnpc>',
    stp = '<stpt>',
    stpt = '<stpt>',
    sta = '<stal>',
    stal = '<stal>',
    lastst = '<lastst>',
    r = '<r>',
    pet = '<pet>',
    p0 = '<p0>',
    p1 = '<p1>',
    p2 = '<p2>',
    p3 = '<p3>',
    p4 = '<p4>',
    p5 = '<p5>',
    a10 = '<a10>',
    a11 = '<a11>',
    a12 = '<a12>',
    a13 = '<a13>',
    a14 = '<a14>',
    a15 = '<a15>',
    a20 = '<a20>',
    a21 = '<a21>',
    a22 = '<a22>',
    a23 = '<a23>',
    a24 = '<a24>',
    a25 = '<a25>',
};

local allowed_target_tokens = {};
for _, token in pairs(target_aliases) do
    allowed_target_tokens[token:lower()] = token;
end

local passthrough_commands = {
    acmd = true,
    addon = true,
    alias = true,
    allmaps = true,
    alliancecmd = true,
    ambient = true,
    aspect = true,
    attackoff = true,
    autofps = true,
    bind = true,
    blist = true,
    blacklist = true,
    breaklinkshell = true,
    chatmode = true,
    chains = true,
    changecall = true,
    chatfix = true,
    chatmon = true,
    checker = true,
    checkparam = true,
    cleancs = true,
    clock = true,
    cm = true,
    config = true,
    console = true,
    craftmon = true,
    dig = true,
    distance = true,
    drawdistance = true,
    echo = true,
    em = true,
    emote = true,
    equip = true,
    equipmon = true,
    expmon = true,
    fastcs = true,
    filterless = true,
    find = true,
    fish = true,
    fishaid = true,
    fps = true,
    help = true,
    hide = true,
    hideconsole = true,
    hticks = true,
    hxui = true,
    input = true,
    instantah = true,
    inv = true,
    jump = true,
    l = true,
    l2 = true,
    links = true,
    linkshell = true,
    load = true,
    logs = true,
    logout = true,
    luashitacast = true,
    lac = true,
    map = true,
    mipmap = true,
    mobdb = true,
    nocombat = true,
    nolock = true,
    nomount = true,
    p = true,
    party = true,
    partybuffs = true,
    paste = true,
    petinfo = true,
    pcmd = true,
    partycmd = true,
    quest = true,
    r = true,
    raw = true,
    recast = true,
    recruitlist = true,
    reload = true,
    reply = true,
    returnfaith = true,
    returntrust = true,
    rlist = true,
    sack = true,
    satchel = true,
    s = true,
    say = true,
    screenshot = true,
    sea = true,
    search = true,
    sh = true,
    shout = true,
    shutdown = true,
    statustimer = true,
    statustimers = true,
    stfu = true,
    t = true,
    targetlines = true,
    tell = true,
    timers = true,
    timestamp = true,
    tparty = true,
    unbind = true,
    unload = true,
    wardrobe = true,
    wardrobe2 = true,
    wardrobe3 = true,
    wardrobe4 = true,
    wardrobe5 = true,
    wardrobe6 = true,
    wardrobe7 = true,
    wardrobe8 = true,
    wait = true,
    yell = true,
    zonename = true,
};

local forwarded_commands = {};
local debug_enabled = false;
local resource_actions = nil;

local function join_args(args, first, last)
    if (first > last) then
        return '';
    end

    return table.concat(args, ' ', first, last);
end

local function to_roman(num)
    if (num == nil or num == 1) then
        return '';
    elseif (num == 2) then
        return 'ii';
    elseif (num == 3) then
        return 'iii';
    elseif (num == 4) then
        return 'iv';
    elseif (num == 5) then
        return 'v';
    elseif (num == 6) then
        return 'vi';
    end

    return tostring(num);
end

local function trim_name(name)
    if (name == nil) then
        return nil;
    end

    return name:gsub('^%s+', ''):gsub('%s+$', '');
end

local function strip_action_name(name)
    name = trim_name(name);
    if (name == nil or name == '') then
        return nil;
    end

    return name:gsub('[^%w]', ''):lower():gsub('(%d+)', function (num)
        return to_roman(tonumber(num));
    end);
end

local hostile_spell_names = {
    'Stone', 'Stone II', 'Stone III', 'Stone IV', 'Stone V', 'Stone VI',
    'Water', 'Water II', 'Water III', 'Water IV', 'Water V', 'Water VI',
    'Aero', 'Aero II', 'Aero III', 'Aero IV', 'Aero V', 'Aero VI',
    'Fire', 'Fire II', 'Fire III', 'Fire IV', 'Fire V', 'Fire VI',
    'Blizzard', 'Blizzard II', 'Blizzard III', 'Blizzard IV', 'Blizzard V', 'Blizzard VI',
    'Thunder', 'Thunder II', 'Thunder III', 'Thunder IV', 'Thunder V', 'Thunder VI',
    'Stonega', 'Stonega II', 'Stonega III',
    'Waterga', 'Waterga II', 'Waterga III',
    'Aeroga', 'Aeroga II', 'Aeroga III',
    'Firaga', 'Firaga II', 'Firaga III',
    'Blizzaga', 'Blizzaga II', 'Blizzaga III',
    'Thundaga', 'Thundaga II', 'Thundaga III',
    'Flare', 'Flare II', 'Freeze', 'Freeze II', 'Tornado', 'Tornado II',
    'Quake', 'Quake II', 'Burst', 'Burst II', 'Flood', 'Flood II',
    'Dia', 'Dia II', 'Dia III', 'Diaga',
    'Bio', 'Bio II', 'Bio III',
    'Poison', 'Poison II', 'Poisonga',
    'Sleep', 'Sleep II', 'Sleepga', 'Sleepga II',
    'Bind', 'Silence', 'Paralyze', 'Slow', 'Slow II',
    'Blind', 'Blind II', 'Gravity', 'Dispel', 'Stun', 'Break', 'Breakga',
    'Drain', 'Drain II', 'Aspir', 'Aspir II',
    'Burn', 'Frost', 'Choke', 'Rasp', 'Shock', 'Drown',
    'Absorb-STR', 'Absorb-DEX', 'Absorb-VIT', 'Absorb-AGI', 'Absorb-INT',
    'Absorb-MND', 'Absorb-CHR', 'Absorb-TP', 'Absorb-ACC',
    'Flash', 'Repose', 'Addle', 'Distract', 'Distract II', 'Frazzle', 'Frazzle II',
    'Katon: Ichi', 'Katon: Ni', 'Katon: San',
    'Hyoton: Ichi', 'Hyoton: Ni', 'Hyoton: San',
    'Huton: Ichi', 'Huton: Ni', 'Huton: San',
    'Doton: Ichi', 'Doton: Ni', 'Doton: San',
    'Raiton: Ichi', 'Raiton: Ni', 'Raiton: San',
    'Suiton: Ichi', 'Suiton: Ni', 'Suiton: San',
    'Kurayami: Ichi', 'Kurayami: Ni',
    'Hojo: Ichi', 'Hojo: Ni',
    'Jubaku: Ichi', 'Dokumori: Ichi', 'Aisha: Ichi',
    'Foe Requiem', 'Foe Requiem II', 'Foe Requiem III', 'Foe Requiem IV',
    'Foe Requiem V', 'Foe Requiem VI', 'Foe Requiem VII',
    'Foe Lullaby', 'Horde Lullaby',
    'Carnage Elegy', 'Battlefield Elegy',
    'Magic Finale',
    'Earth Threnody', 'Water Threnody', 'Wind Threnody', 'Fire Threnody',
    'Ice Threnody', 'Lightning Threnody', 'Light Threnody', 'Dark Threnody',
};

local hostile_spells = {};
for _, name in ipairs(hostile_spell_names) do
    local key = strip_action_name(name);
    if (key ~= nil) then
        hostile_spells[key] = true;
    end
end

local function is_hostile_spell_name(name)
    local key = strip_action_name(name);
    return key ~= nil and hostile_spells[key] == true;
end

local function is_ascii_action_name(name)
    if (name == nil or name == '') then
        return false;
    end

    return (name:match('^[%z\32-\126]+$') ~= nil and name:match('%a') ~= nil);
end

local function get_english_name(resource)
    if (resource == nil or resource.Name == nil) then
        return nil;
    end

    for _, index in ipairs({ 1, 0, 2 }) do
        local name = trim_name(resource.Name[index]);
        if (is_ascii_action_name(name)) then
            return name;
        end
    end

    return nil;
end

local function add_resource_action(key, action)
    if (key == nil or key == '') then
        return;
    end

    resource_actions[key] = resource_actions[key] or {};
    table.insert(resource_actions[key], action);
end

local function add_resource_names(resource, action)
    if (resource == nil or resource.Name == nil) then
        return;
    end

    for _, index in ipairs({ 0, 1, 2 }) do
        add_resource_action(strip_action_name(resource.Name[index]), action);
    end
end

local function get_targets(resource)
    if (resource == nil) then
        return 0;
    end

    return resource.Targets or resource.ValidTargets or 0;
end

local function can_target_self(resource)
    local targets = get_targets(resource);
    return (targets % 2) == 1;
end

local function build_resource_actions()
    if (resource_actions ~= nil) then
        return;
    end

    resource_actions = {};

    local resources = AshitaCore:GetResourceManager();
    if (resources == nil) then
        return;
    end

    for id = 1, 1024 do
        local spell = resources:GetSpellById(id);
        local name = get_english_name(spell);
        if (name ~= nil and name ~= '') then
            local hostile = is_hostile_spell_name(name);
            add_resource_names(spell, {
                prefix = '/ma',
                name = name,
                target = hostile and '<bt>' or (can_target_self(spell) and '<me>' or '<t>'),
                friendly = (not hostile) and can_target_self(spell),
                priority = 1,
            });
        end
    end

    for id = 0, 0x600 do
        local ability = resources:GetAbilityById(id);
        local name = get_english_name(ability);
        if (name ~= nil and name ~= '' and name:sub(1, 1) ~= '#') then
            local is_ws = id <= 0x200;
            add_resource_names(ability, {
                prefix = is_ws and '/ws' or '/ja',
                name = name,
                target = is_ws and '<t>' or (can_target_self(ability) and '<me>' or '<t>'),
                friendly = (not is_ws) and can_target_self(ability),
                priority = is_ws and 3 or 2,
            });
        end
    end
end

local function resolve_resource_action(name, forced_prefix)
    build_resource_actions();

    local key = strip_action_name(name);
    if (key == nil or resource_actions[key] == nil) then
        return nil;
    end

    local best = nil;
    for _, action in ipairs(resource_actions[key]) do
        if (forced_prefix == nil or action.prefix == forced_prefix) then
            if (best == nil or action.priority < best.priority) then
                best = action;
            end
        end
    end

    return best;
end

local function get_party_token_by_server_id(id)
    local party = AshitaCore:GetMemoryManager():GetParty();
    if (party == nil or id == nil or id == 0) then
        return nil;
    end

    for index = 0, 17 do
        if (party:GetMemberIsActive(index) ~= 0 and party:GetMemberServerId(index) == id) then
            if (index == 0) then
                return '<me>';
            elseif (index <= 5) then
                return ('<p%d>'):format(index);
            end

            local alliance = math.floor((index - 6) / 6) + 1;
            local member = (index - 6) % 6;
            return ('<a%d%d>'):format(alliance, member);
        end
    end

    return nil;
end

local function resolve_numeric_target(target)
    local id = tonumber(target);
    if (id == nil or id == 0) then
        return nil;
    end

    return get_party_token_by_server_id(id);
end

local function normalize_target(target)
    if (target == nil or target == '') then
        return nil, false;
    end

    local key = target:lower();
    if (target_aliases[key] ~= nil) then
        return target_aliases[key], true;
    end

    local alliance, member = key:match('^a([12])p([1-6])$');
    if (alliance ~= nil and member ~= nil) then
        return ('<a%s%s>'):format(alliance, tonumber(member) - 1), true;
    end

    if (target:match('^<.+>$') ~= nil) then
        return allowed_target_tokens[key], true;
    end

    if (target:match('^%d+$') ~= nil) then
        return resolve_numeric_target(target), true;
    end

    return nil, false;
end

local function should_passthrough_native_command(raw_command, key)
    if (not native_prefix_commands[key]) then
        return false;
    end

    if (raw_command:match('^/%S+%s+"[^"]+"') ~= nil) then
        return true;
    end

    if (raw_command:match('^/%S+%s+%S+%s+<[^>]+>%s*$') ~= nil) then
        return true;
    end

    return false;
end

local function queue_command(command)
    forwarded_commands[command:lower()] = true;
    if (debug_enabled) then
        print(chat.header(addon.name):append(chat.message('Queue: ')):append(chat.success(command)));
    end
    AshitaCore:GetChatManager():QueueCommand(1, command);
end

local function get_current_target_index()
    local target_manager = AshitaCore:GetMemoryManager():GetTarget();
    if (target_manager == nil) then
        return nil;
    end

    local target_index = target_manager:GetTargetIndex(0);
    if (target_index == nil or target_index == 0) then
        return nil;
    end

    return target_index;
end

local function has_current_target()
    return get_current_target_index() ~= nil;
end

local function is_current_target_friendly()
    local target_index = get_current_target_index();
    if (target_index == nil) then
        return false;
    end

    local entity = AshitaCore:GetMemoryManager():GetEntity();
    if (entity == nil) then
        return false;
    end

    local name = entity:GetName(target_index);
    if (name == nil or name == '') then
        return false;
    end

    local hpp = entity:GetHPPercent(target_index);
    if (hpp == nil or hpp == 0) then
        return false;
    end

    local party = AshitaCore:GetMemoryManager():GetParty();
    if (party ~= nil) then
        for i = 0, 17 do
            if (party:GetMemberIsActive(i) ~= 0 and party:GetMemberTargetIndex(i) == target_index) then
                return true;
            end
        end
    end

    local flags = entity:GetSpawnFlags(target_index);
    if (flags ~= nil) then
        if (bit.band(flags, 0x0001) ~= 0 or bit.band(flags, 0x0004) ~= 0 or bit.band(flags, 0x0008) ~= 0 or bit.band(flags, 0x0200) ~= 0) then
            return true;
        end
    end

    return false;
end

local function get_default_target(alias)
    if (alias.prefix == '/ma' and is_hostile_spell_name(alias.name)) then
        return has_current_target() and '<t>' or '<bt>';
    end

    if (alias.friendly and is_current_target_friendly()) then
        return '<t>';
    end

    return alias.target;
end

local function build_action_command(alias, target)
    local normalized = nil;
    if (target ~= nil and target ~= '') then
        normalized = normalize_target(target);
        if (normalized == nil) then
            return nil;
        end
    end

    return ('%s "%s" %s'):format(alias.prefix, alias.name, normalized or get_default_target(alias));
end

local function handle_double_slash(command, args)
    local key = nil;
    local first_arg = nil;

    if (command == '//') then
        if (#args < 2) then
            return nil;
        end
        key = args[2]:lower();
        first_arg = 3;
    else
        key = command:sub(3):lower();
        first_arg = 2;
    end

    local alias = aliases[key];
    if (alias == nil) then
        return nil;
    end

    local target = nil;
    if (#args >= first_arg) then
        target = join_args(args, first_arg, #args);
    end

    return build_action_command(alias, target);
end

local function handle_prefixed_command(command, key, args)
    local prefix = prefix_aliases[key];
    if (prefix == nil or #args < 2) then
        return nil;
    end

    local alias = aliases[args[2]:lower()];
    if (alias ~= nil) then
        local target = nil;
        if (#args > 2) then
            target = join_args(args, 3, #args);
        end

        return build_action_command(alias, target);
    end

    local action_name = nil;
    local target = nil;
    if (#args > 2) then
        local last_arg = args[#args];
        local _, is_target = normalize_target(last_arg);
        if (is_target) then
            action_name = join_args(args, 2, #args - 1);
            target = last_arg;
        else
            action_name = join_args(args, 2, #args);
        end
    else
        action_name = args[2];
    end

    local action = resolve_resource_action(action_name, prefix);
    if (action == nil and #args > 2) then
        action_name = join_args(args, 2, #args - 1);
        target = args[#args];
        action = resolve_resource_action(action_name, prefix);
    end

    if (action == nil) then
        return nil;
    end

    return build_action_command(action, target);
end

local function print_help()
    print(chat.header(addon.name):append(chat.message('Ashita command shortcuts are enabled.')));
    print(chat.header(addon.name):append(chat.message('Examples: /c1, /c1 stp, /bl2, /fg2, /rr, /rf p1, /pna stp, /tra, /fb')));
    print(chat.header(addon.name):append(chat.message('Debug: /ashitashortcuts debug or /asc debug')));
end

ashita.events.register('command', 'ashitashortcuts_command_cb', function (e)
    if (e.blocked) then
        return;
    end

    local forwarded_key = e.command:lower();
    if (forwarded_commands[forwarded_key]) then
        forwarded_commands[forwarded_key] = nil;
        return;
    end

    local command = e.command:match('^/%S+');
    if (command == nil) then
        return;
    end

    command = command:lower();
    local key = command:sub(2);
    if (should_passthrough_native_command(e.command, key)) then
        return;
    end

    local args = e.command:args();
    if (#args == 0) then
        return;
    end

    command = args[1]:lower();
    if (command == '/ashitashortcuts' or command == '/asc') then
        e.blocked = true;
        if (#args >= 2 and args[2]:lower() == 'debug') then
            debug_enabled = not debug_enabled;
            print(chat.header(addon.name):append(chat.message('Debug ')):append(chat.success(debug_enabled and 'enabled' or 'disabled')));
            return;
        end
        print_help();
        return;
    end

    if (command:sub(1, 1) ~= '/') then
        return;
    end

    local result = nil;
    key = command:sub(2);

    if (command:sub(1, 2) == '//') then
        result = handle_double_slash(command, args);
    else
        local alias = aliases[key];
        if (alias ~= nil) then
            local target = nil;
            if (#args > 1) then
                target = join_args(args, 2, #args);
            end
            result = build_action_command(alias, target);
        end

        result = result or handle_prefixed_command(command, key, args);
        if (result == nil and not passthrough_commands[key]) then
            local action = resolve_resource_action(key, nil);
            if (action ~= nil) then
                local target = nil;
                if (#args > 1) then
                    target = join_args(args, 2, #args);
                end
                result = build_action_command(action, target);
            end
        end
    end

    if (result == nil or result == e.command) then
        return;
    end

    e.blocked = true;
    queue_command(result);
end);
