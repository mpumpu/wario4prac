    REG_MAIN       equ 0x0878F980
    
    ADDR_PASSAGE   equ 0x03000002
    ADDR_MAPPOS    equ 0x03000003
    ADDR_CURLVL    equ 0x03000004
    ADDR_LANGUAGE  equ 0x03000016 ;0=en 1=jp
    ADDR_BGMOFF    equ 0x0300001C ;=1 to mute
    ADDR_SOFTRESET equ 0x0300001E ;0=enabled, 1=disabled
    ADDR_TIMERON   equ 0x03000047 ;=1 yes
    ADDR_LEVELS    equ 0x03000A68
    ADDR_CHESTS    equ 0x03000C07
    ADDR_PAUSED    equ 0x03000C35 ;=1 yes
    ADDR_BOSSWEP   equ 0x03000C38 ;=0 if no weapon
    ADDR_MENU9     equ 0x03000C3A ;=9 when in the file select
    ADDR_GAMESTATE equ 0x03000C3C
    ADDR_INLEVEL   equ 0x03000C3F ;=1 yes
    ADDR_KEY       equ 0x03001844 ; +2 for same? +4 for pressed
    ADDR_HEALTH    equ 0x03001910
    ADDR_FROGPAUSE equ 0x030019F6
    ADDR_FADEOUT   equ 0x03003C4C
    
    KEY_A          equ 0x1
    KEY_B          equ 0x2
    KEY_SELECT     equ 0x4
    KEY_START      equ 0x8
    KEY_RIGHT      equ 0x10
    KEY_LEFT       equ 0x20
    KEY_UP         equ 0x40
    KEY_DOWN       equ 0x80
    KEY_R          equ 0x100
    KEY_L          equ 0x200
    ; OFFSET_KEY_A   equ 0
    ; OFFSET_KEY_B   equ 1
    ; OFFSET_KEY_SELECT equ 2
    ; OFFSET_KEY_START equ 3
    ; OFFSET_KEY_RIGHT equ 4
    ; OFFSET_KEY_LEFT equ 5
    ; OFFSET_KEY_UP equ 6
    ; OFFSET_KEY_DOWN equ 7
    ; OFFSET_KEY_R equ 8
    ; OFFSET_KEY_L equ 9