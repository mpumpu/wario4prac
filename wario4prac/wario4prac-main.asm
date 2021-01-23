    .org    0x080001DC ;After input check
    ldr     r1,=#REG_MAIN+1
    mov     r0,r15 
    bx      r1
    .pool
    .org    REG_MAIN
    add     r0,#0xB
    push    {r3-r7,r0}
@statechangers:
    ldr     r3,=#ADDR_GAMESTATE
    ldrb    r4,[r3]
    cmp     r4,#0x19 :: beq @@bosscene    ;skip post-boss cutscenes
    cmp     r4,#0x1D :: beq @@tutscene    ;apply the above to post tutorial scene too, with a check to not mess up final cutscene
    cmp     r4,#0x14 :: beq @@introskip   ;skip new file intro, skip stage complete cutscenes
    cmp     r4,#0x23 :: beq @@debugmapfix ;don't let the player go out of mapscreen bounds
    cmp     r4,#0x2D :: beq @@credits     ;post credits titlescreen escape!!
    cmp     r4,#0x03 :: beq @@quitfix     ;fixes lock on save select if QUIT flag on file
    cmp     r4,#0x0A :: beq @@bgmswitch   ;music mute option
    b       @@end
@@tutscene:
    ldr     r3,=#ADDR_SOFTRESET
    ldrb    r4,[r3]
    cmp     r4,#0x01
    beq     @@end
    ldr     r3,=#ADDR_GAMESTATE
@@bosscene:
    mov     r4,#0x26 
    strb    r4,[r3]
    ldr     r3,=#0x03000025 ;prevent pyramid unlocking cutscene
    mov     r4,#0x02
    strb    r4,[r3]
    b       @@end
@@introskip:
    ldr     r5,=#0x03000013 ;=0 intro, =1 stage complete
    ldrb    r4,[r5]
    cmp     r4,#0x00
    bne     @@completeskip
    mov     r4,#0x00
    strb    r4,[r3]
    b       @@end
@@completeskip:
    mov     r4,#0x26 
    strb    r4,[r3]
    b       @@end
@@debugmapfix:
    ldr     r3,=#ADDR_PASSAGE
    ldrb    r4,[r3]
    cmp     r4,#0x00
    bne     @@end
    ldr     r3,=#ADDR_MAPPOS ;position check (left or right goes to 6 which is bugged)
    ldrb    r4,[r3]
    cmp     r4,#0x06
    bne     @@end
    mov     r4,#0x00        ;set position to tutorial stage
    strb    r4,[r3]
    b       @@end
@@credits:
    mov     r4,#0x00
    strb    r4,[r3]
    ldr     r3,=#0x03000025
    mov     r4,#0x02
    strb    r4,[r3]
    b       @@end
@@quitfix:
    ldr     r3,=#ADDR_MENU9
    ldrb    r4,[r3]
    cmp     r4,#0x09
    bne     @@end
    ldr     r3,=#ADDR_GAMESTATE
    mov     r4,#0x06
    strb    r4,[r3]
    b       @@end
@@bgmswitch:
    ldr     r3,=#ADDR_KEY
    ldrh    r3,[r3]
    ldr     r4,=#KEY_L
    and     r3,r4
    cmp     r3,#0x00
    beq     @@bgm_on
    ldr     r3,=#ADDR_BGMOFF
    mov     r4,#0x01
    strb    r4,[r3]
    b       @@end
@@bgm_on:
    ldr     r3,=#ADDR_BGMOFF
    mov     r4,#0x00
    strb    r4,[r3]
@@end:

@saveselect_skip:
    ldr     r3,=#ADDR_MENU9
    ldrb    r4,[r3]
    cmp     r4,#0x09
    bne     @@end
    ldr     r3,=#ADDR_KEY
    ldrh    r3,[r3]
    ldr     r4,=#KEY_SELECT
    and     r3,r4
    cmp     r3,#0x00
    bne     @@end
    ldr     r3,=#ADDR_GAMESTATE
    ldrb    r4,[r3]
    cmp     r4,#0x01
    bne     @@end
    mov     r4,#0x04
    strb    r4,[r3]
    ldr     r3,=#0x03000C3E
    mov     r4,#0x01
    strb    r4,[r3]
@@end:

@skip_fadeout_on_passage_entry:
    ldr     r3,=#ADDR_INLEVEL
    ldrb    r4,[r3]
    cmp     r4,#0x01
    beq     @@end
	cmp     r4,#0x0F ;case for roomreset workaround
    beq     @@end
    ldr     r3,=#0x030000D2
    ldrb    r4,[r3]
    cmp     r4,#0x01
    bne     @@end
    mov     r4,#0x08
    strb    r4,[r3]
@@end:

@other_fades: ;fade in on level entry
    ldr     r3,=#ADDR_FADEOUT
    ldrb    r4,[r3]
    cmp     r4,#0x6E
    bne     @@check2
    add     r3,#0x02
    ldrb    r4,[r3]
    cmp     r4,#0x82
    beq     @@fadeout1
@@check2:    ;barn door close on minigame / soundroom screen exit
    ldr     r3,=#ADDR_FADEOUT
    ldrb    r4,[r3]
    cmp     r4,#0x5
    bne     @@check3
    add     r3,#0x02
    ldrb    r4,[r3]
    cmp     r4,#0xEB
    beq     @@fadeout2
@@check3:   ;fade out on minigame room exit
    ldr     r3,=#ADDR_FADEOUT
    ldrb    r4,[r3]
    cmp     r4,#0x14
    bne     @@end
    add     r3,#0x02
    ldrb    r4,[r3]
    cmp     r4,#0xDC
    beq     @@fadeout2
    b        @@end
@@fadeout1:
    ldr     r3,=#ADDR_FADEOUT
    mov     r4,#0x00
    strb    r4,[r3]
    add     r3,#0x02
    mov     r4,#0xF0
    strb    r4,[r3]
    add     r3,#0x02
    mov     r4,#0x00
    strb    r4,[r3]
    add     r3,#0x02
    mov     r4,#0xA0
    strb    r4,[r3]
    b        @@end
@@fadeout2:
    ldr     r3,=#ADDR_FADEOUT
    mov     r4,#0x78
    strb    r4,[r3]
    add     r3,#0x02
    strb    r4,[r3]
    b        @@end
@@end:

@unlock_levels:
    ldr     r3,=#ADDR_LEVELS ;tutorial
    ldrb    r4,[r3]
    cmp     r4,#0x3F
    beq     @@end
    mov     r4,#0x3F
    strb    r4,[r3]
    add     r3,#0x18 :: strb r4,[r3] :: add r3,#0x04 :: strb r4,[r3] :: add r3,#0x04 :: strb r4,[r3] :: add r3,#0x04 :: strb r4,[r3] ;emerald
    add     r3,#0x0C :: strb r4,[r3] :: add r3,#0x04 :: strb r4,[r3] :: add r3,#0x04 :: strb r4,[r3] :: add r3,#0x04 :: strb r4,[r3] ;ruby
    add     r3,#0x0C :: strb r4,[r3] :: add r3,#0x04 :: strb r4,[r3] :: add r3,#0x04 :: strb r4,[r3] :: add r3,#0x04 :: strb r4,[r3] ;topaz
    add     r3,#0x0C :: strb r4,[r3] :: add r3,#0x04 :: strb r4,[r3] :: add r3,#0x04 :: strb r4,[r3] :: add r3,#0x04 :: strb r4,[r3] ;sapphire
    add     r3,#0x0C :: strb r4,[r3] ;golden passage
@@end: 

@boss_levels: 
    ldr     r3,=#ADDR_LEVELS+0x10 
    mov     r4,#0x07 :: strb r4,[r3] ;spoiled
    add     r3,#0x18 :: strb r4,[r3] ;cractus
    add     r3,#0x18 :: strb r4,[r3] ;cuckoo
    add     r3,#0x18 :: strb r4,[r3] ;aerodent
    add     r3,#0x18 :: strb r4,[r3] ;catbat

@boss_corridor_skip:
    ldr     r3,=#ADDR_MAPPOS ;corridoor position =4 is boss room
    ldrb    r4,[r3]
    cmp     r4,#0x04
    bne     @@end
    ldr     r3,=#ADDR_GAMESTATE
    ldrb    r4,[r3]
    cmp     r4,#0x01
    bne     @@end
    ldr     r3,=#0x03000025 ;=2 when in boss arena
    ldrb    r4,[r3]
    cmp     r4,#0x00
    bne     @@end
    ldr     r3,=#ADDR_KEY
    ldrh    r4,[r3,#0x04]
    ldrh    r3,[r3]
    ldr     r5,=#KEY_SELECT
    and     r3,r5
    cmp     r3,#0x00
    bne     @@end
    ldr     r3,=#0x03000021 ;[0021]
    mov     r4,#0x08
    strb    r4,[r3]
    add     r3,#0x04 ;[0025]
    mov     r4,#0x02
    strb    r4,[r3]
    add     r3,#0x23 ;[0048]
    mov     r4,#0x80
    strb    r4,[r3]
    ldr     r3,=#ADDR_GAMESTATE
    mov     r4,#0x06
    strb    r4,[r3]
@@end:

@boss_intro_skip:
    ldr     r3,=#ADDR_TIMERON
    ldrb    r4,[r3]
    cmp     r4,#0x00
    bne     @@end
    ldr     r3,=#ADDR_CURLVL
    ldrb    r4,[r3]
    cmp     r4,#0x05 :: beq @@cractus
    cmp     r4,#0x0B :: beq @@cuckoo
    cmp     r4,#0x11 :: beq @@aerodent
    cmp     r4,#0x17 :: beq @@catbat
    cmp     r4,#0x19 :: beq @@diva
    cmp     r4,#0x1A :: beq @@spoiled
    b       @@end
@@diva:
    ldr     r3,=#0x030001E9 ;descend state, starts with 2 ends with 4
    ldrb    r4,[r3]
    cmp     r4,#0x02
    bne     @@end
    mov     r4,#0x04
    strb    r4,[r3]
    ldr     r3,=#0x030001E8 ;diva y position
    mov     r4,#0xE0
    strb    r4,[r3]
    ldr     r3,=#ADDR_BOSSWEP ;--if boss weapon was purchased, don't do rest of the skip
    ldrb    r4,[r3]
    cmp     r4,#0x00
    bne     @@end
    ldr     r3,=#0x03000045 ;light ray fix
    mov     r4,#0x03
    strb    r4,[r3]
    add     r3,#0xBF ;post cat scene state [0104]
    mov     r4,#0x00
    strb    r4,[r3]
    add     r3,#0x5C ;fan hand fix [0160]
    mov     r4,#0xF4
    strb    r4,[r3]
    add     r3,#0x01 ;fan hand fix 2 [0161]
    mov     r4,#0xF2
    strb    r4,[r3]
    add     r3,#0x27  ;fan fix [0188]
    mov     r4,#0x1B
    strb    r4,[r3]
    add     r3,#0x74 ;cutscene progress? locks without [01FC]
    mov     r4,#0x72
    strb    r4,[r3]
    add     r3,#0xB  ;make the floating heads visible [0207]
    mov     r4,#0x01
    strb    r4,[r3]
    ldr     r3,=#0x03000A64  ;fast heads
    mov     r4,#0xBF
    strb    r4,[r3]
    b       @@end
@@aerodent:
    ldr     r3,=#0x03000183
    ldrb    r4,[r3]
    cmp     r4,#0x3B
    beq     @@aerodent_skip
    cmp     r4,#0x64
    beq     @@aerodent_skip
    cmp     r4,#0x1D
    beq     @@aerodent_skip
    b       @@end
@@aerodent_skip:
    mov     r4,#0x01
    strb    r4,[r3]
    ldr     r3,=#0x030000F7
    ldrb    r4,[r3]
    mov     r4,#0x1F
    strb    r4,[r3]
    b       @@end
@@catbat:
    ldr     r3,=#0x0300012D
    ldrb    r4,[r3]
    cmp     r4,#0x3C
    beq     @@catbat_skip
    cmp     r4,#0x14
    beq     @@catbat_skip
    cmp     r4,#0x60
    beq     @@catbat_skip
    b       @@end
@@catbat_skip:
    mov     r4,#0x01
    strb    r4,[r3]
    ldr     r3,=#0x030000F7
    mov     r4,#0x1F
    strb    r4,[r3]
    b       @@end
@@cuckoo:
    ldr     r3,=#0x0300012D
    ldrb    r4,[r3]
    cmp     r4,#0x3C
    beq     @@cuckoo_skip
    cmp     r4,#0x5A
    beq     @@cuckoo_skip
    b       @@end
@@cuckoo_skip:
    mov     r4,#0x01
    strb    r4,[r3]
    ldr     r3,=#0x030000F7
    mov     r4,#0x1F
    strb    r4,[r3]
    b       @@end
@@cractus:
    ldr     r3,=#0x03000157
    ldrb    r4,[r3]
    cmp     r4,#0x3C
    beq     @@cractus_skip
    b       @@end
@@cractus_skip:
    mov     r4,#0x01
    strb    r4,[r3]
    ldr     r3,=#0x030000F7
    mov     r4,#0x1F
    strb    r4,[r3]
    ldr     r3,=#0x03000A62
    mov     r4,#0x01
    strb    r4,[r3]
    b       @@end
@@spoiled:
    ldr     r3,=#0x03000157
    ldrb    r4,[r3]
    cmp     r4,#0x3C
    beq     @@spoiled_skip
    b       @@end
@@spoiled_skip:
    mov     r4,#0x01
    strb    r4,[r3]
    ldr     r3,=#0x030000F7
    mov     r4,#0x1F
    strb    r4,[r3]
    ldr     r3,=#0x03000A62
    mov     r4,#0x01
    strb    r4,[r3]
    b       @@end
@@end:

@diva_skip_2: ;skips the little wait time before the timer would start, to be used only with the wait skip, but before it
    ldr     r3,=#ADDR_PASSAGE
    ldrb    r4,[r3]
    cmp     r4,#0x05
    bne     @@end
    ldr     r3,=#ADDR_MAPPOS
    ldrb    r4,[r3]
    cmp     r4,#0x04
    bne     @@end
    ldr     r3,=#ADDR_BOSSWEP ;don't do it with a purchased weapon
    ldrb    r4,[r3]
    cmp     r4,#0x00
    bne     @@end
    ldr     r3,=#ADDR_SOFTRESET ;don't do it after defeating diva
    ldrb    r4,[r3]
    cmp     r4,#0x01
    beq     @@end
    ldr     r3,=#0x0300025F ;check if second to final diva phase
    ldrb    r4,[r3]
    cmp     r4,#0x00
    beq     @@end
    ldr     r3,=#0x03000207
    ldrb    r4,[r3]
    cmp     r4,#0x3C
    bne     @@end
    ldr     r3,=#ADDR_KEY ;hold L to skip the skip
    ldrh    r3,[r3]
    ldr     r4,=#KEY_L
    and     r3,r4
    cmp     r3,#0x00
    bne     @@no_diva3
    ldr     r3,=#0x03000207
    mov     r4,#0x00
    strb    r4,[r3]
    b       @@end
@@no_diva3: ;super lousy workaround if L button held not long enough
    ldr     r3,=#ADDR_SOFTRESET
    mov     r4,#0x02
    strb    r4,[r3]
@@end:

@boss_wait_skip:
    ldr     r3,=#ADDR_BOSSWEP ;don't do it with a purchased weapon
    ldrb    r4,[r3]
    cmp     r4,#0x00
    bne     @@end
    ldr     r3,=#ADDR_SOFTRESET ;don't do diva skip 3 if L was held for diva skip 2
    ldrb    r4,[r3]
    cmp     r4,#0x02
    beq     @@end
    ldr     r3,=#ADDR_MAPPOS ;don't do it in regular stages 
    ldrb    r4,[r3]
    cmp     r4,#0x04
    bne     @@end
    ldr     r3,=#ADDR_FROGPAUSE
    ldrb    r4,[r3]
    cmp     r4,#0xC8
    bne     @@end
    ldr     r3,=#ADDR_KEY ;hold L to skip the skip
    ldrh    r3,[r3]
    ldr     r4,=#KEY_L
    and     r3,r4
    cmp     r3,#0x00
    bne     @@end
    ldr     r3,=#0x03000B88 ;check if timer text should be moved up (would crash if done in skip)
    ldrb    r4,[r3]
    cmp     r4,#0xC8
    bne     @@skip
    mov     r4,#0x08
    strb    r4,[r3]
@@skip:
    ldr     r3,=#ADDR_FROGPAUSE
    mov     r4,#0x1
    strb    r4,[r3]
    ldr     r3,=#0x03000B84 ;boss timer position (top)
    mov     r4,#0xA8
    strb    r4,[r3]
    add     r3,#0x0B ;[0B8F]
    mov     r4,#0x05
    strb    r4,[r3]
    add     r3,#0x05 ;[0B94]
    mov     r4,#0x08
    strb    r4,[r3]
    add     r3,#0x01 ;[0B95]
    mov     r4,#0x00
    strb    r4,[r3]
    add     r3,#0x01 ;[0B96]
    mov     r4,#0x40
    strb    r4,[r3]
    add     r3,#0x01 ;[0B97]
    mov     r4,#0x01
    strb    r4,[r3]
    ldr     r3,=#ADDR_PASSAGE ;check if extra skips are necessary
    ldrb    r4,[r3]
    cmp     r4,#0x03
    beq     @@aerodent_skip_2
    cmp     r4,#0x05
    beq     @@diva_skip_3
    b       @@end
@@aerodent_skip_2:
    ldr     r3,=#0x03000139 ;check for low Y
    ldrb    r4,[r3]
    cmp     r4,#0x05
    bne     @@end
    sub     r3,#0x01 ;[0138] set position
    mov     r4,#0x74
    strb    r4,[r3]
    add     r3,#0x01 ;[0139] set position
    mov     r4,#0x04
    strb    r4,[r3] 
    add     r3,#0x1F  ;[0158] set size
    mov     r4,#0x0A
    strb    r4,[r3]
    add     r3,#0x2C ;[0184] set rat
    strb    r4,[r3]
    b       @@end
@@diva_skip_3:
    ldr     r3,=#0x030001EA ;adjust x
    mov     r4,#0xDC
    strb    r4,[r3]
    ldr     r3,=#0x030001E8 ;adjust y
    mov     r4,#0xD7
    strb    r4,[r3]
    ldr     r3,=#0x0300020A ;adjust how high she has to rise(?)
    mov     r4,#0x16
    strb    r4,[r3]
    b       @@end
@@end:

    .pool 

@debug_room:
    ldr     r3,=#ADDR_GAMESTATE
    ldrb    r4,[r3]
    cmp     r4,#0x23 ;corridor state
    bne     @@end
    ldr     r3,=#0x03003C15 ;map position x check
    ldrb    r4,[r3]
    cmp     r4,#0x0D
    bne     @@end
    ldr     r3,=#ADDR_PASSAGE ;world check
    ldrb    r4,[r3]
    cmp     r4,#0x00
    bne     @@end
    ldr     r3,=#ADDR_KEY
    ldrh    r4,[r3,#0x04]
    ldr     r5,=#KEY_SELECT
    and     r4,r5
    cmp     r4,#0x00
    beq     @@end
    ldr     r3,=#ADDR_MAPPOS
    mov     r4,#0x02
    strb    r4,[r3]
@@end:

@lang_select:
    ldr     r3,=#ADDR_GAMESTATE        
    ldrb    r4,[r3]
    cmp     r4,#0x30 ;musicroom state
    bne     @@end
    ldr     r3,=#ADDR_KEY
    ldrh    r4,[r3,#0x4]
    ldr     r5,=#KEY_SELECT
    and     r4,r5
    cmp     r4,#0x00
    beq     @@end
    ldr     r3,=#ADDR_LANGUAGE
    ldrb    r4,[r3]
    cmp     r4,#0x00
    beq     @@jp
    mov     r4,#0x00
    strb    r4,[r3]
    b       @@end
@@jp:
    mov     r4,#0x01
    strb    r4,[r3]
@@end:

@restore_heart:
    ldr     r3,=#ADDR_HEALTH 
    ldrb    r4,[r3]
    cmp     r4,#0x00
    bne     @@end
    mov     r4,#0x01
    strb    r4,[r3]
@@end:

@escape_timer:
    ldr     r3,=#0x03000BF0 ;x:xX
    ldrb    r4,[r3]
    cmp     r4,#0x00
    bne     @@end
    add     r3,#0x01     ;x:Xx
    ldrb    r4,[r3]
    cmp     r4,#0x00
    bne     @@end
    add     r3,#0x01     ;X:xx
    ldrb    r4,[r3]
    cmp     r4,#0x00
    bne     @@end
    ldr     r3,=#0x03000BEC
    mov     r4,#0x00
    strb    r4,[r3]
@@end:

@noclip:
    ldr     r3,=#ADDR_INLEVEL ;in a level?
    ldrb    r4,[r3]
    cmp     r4,#0x00
    beq     @@end
    ldr     r3,=#ADDR_PAUSED ;is the game paused?
    ldrb    r4,[r3]
    cmp     r4,#0x01
    beq     @@end
    ldr     r3,=#ADDR_SOFTRESET ;disallow debug in final cutscene
    ldrb    r4,[r3]
    cmp     r4,#0x01
    beq     @@end
    ldr     r3,=#ADDR_MAPPOS ;disallow on boss stages
    ldrb    r4,[r3]
    cmp     r4,#0x04
    beq     @@end
    ldr     r3,=#ADDR_FROGPAUSE ;disallow during frog/boss time freeze (nothing but trouble)
    ldrb    r4,[r3]
    cmp     r4,#0x00
    bne     @@end
    ldr     r3,=#ADDR_KEY
    ldrh    r4,[r3,#0x4]
    ldr     r5,=#KEY_L
    and     r4,r5
    cmp     r4,#0x00
    beq     @@end
    ldr     r3,=#ADDR_GAMESTATE
    ldrb    r4,[r3]
    cmp     r4,#0x08
    beq     @@end
    mov     r4,#0x08
    strb    r4,[r3] 
@@end:

@room_reset: ; gross code ahead lol
    ldr     r3,=#ADDR_INLEVEL ;in a level?
    ldrb    r4,[r3]
    cmp     r4,#0x00
    beq     @@end
    ldr     r3,=#ADDR_GAMESTATE ;allow only when in control
    ldrb    r4,[r3]
    cmp     r4,#0x02
    bne     @@end
    ldr     r3,=#ADDR_MAPPOS ;don't allow in boss rooms
    ldrb    r4,[r3]
    cmp     r4,#0x04
    beq     @@end
    ldr     r3,=#0x030019F7 ;don't allow when game frozen (entering vortex, exiting vortex, big board roll freeze)
    ldrb    r4,[r3]
    cmp     r4,#0x03
    beq     @@end
    ldr     r3,=#ADDR_KEY
    ldrh    r4,[r3,#0x04]
    ldrh    r3,[r3]
@@combo1: ;roomreset+blocks
    ldr     r5,=#KEY_UP
    and     r4,r5
    cmp     r4,#0x00
    beq     @@combo2
    cmp     r3,#0x44 ;select+up
    beq     @@reset_blocks
@@combo2: ;roomreset none
    ldr     r5,=#KEY_DOWN
    ldr     r3,=#ADDR_KEY
    ldrh    r4,[r3,#0x04]
    ldrh    r3,[r3]
    and     r4,r5
    cmp     r4,#0x00
    beq     @@end
    cmp     r3,#0x84 ;select+down
    beq     @@reset
    bne     @@end
@@reset_blocks:
    ldr     r3,=#ADDR_INLEVEL
    mov     r4,#0x0F
    strb    r4,[r3]
@@reset:
    ldr     r3,=#ADDR_GAMESTATE
    mov     r4,#0x00
    strb    r4,[r3]
    ldr     r3,=#0x03001898 ;put wario in walking state [1898]
    mov     r4,#0x00
    strb    r4,[r3]
    add     r3,#0x01 ;wario animations [1899]
    strb    r4,[r3]
    add     r3,#0x06 ;jump buffer [189F]
    strb    r4,[r3]
    add     r3,#0x16 ;X&Y speed zeroing [18AE]
    mov     r4,#0x00
    strb    r4,[r3]
    add     r3,#0x01
    strb    r4,[r3]
    add     r3,#0x01
    strb    r4,[r3]
    add     r3,#0x01
    strb    r4,[r3]
    add     r3,#0x01 ;walking environment [18B2]
    mov     r4,#0x00
    strb    r4,[r3]
@@end:

@room_reset_fix:
    ldr     r3,=#ADDR_INLEVEL 
    ldrb    r4,[r3]
    cmp     r4,#0x0F
    bne     @@end
    ldr     r3,=#ADDR_GAMESTATE ;do so when in control of wario
    ldrb    r4,[r3] 
    cmp     r4,#0x02 
    bne     @@end
    ldr     r3,=#ADDR_INLEVEL 
    mov     r4,#0x01
    strb    r4,[r3]
@@end:

@finish:
    ldr     r1,=#0x03000C41
    ldrb    r0,[r1]
    add     r0,#0x01
    strb    r0,[r1]
    ldr     r1,=#0x03000006
    ldrh    r0,[r1]
    add     r0,#0x1
    strh    r0,[r1]
    pop     {r0}
    pop     {r3-r7}
    bx      r0
    .pool
