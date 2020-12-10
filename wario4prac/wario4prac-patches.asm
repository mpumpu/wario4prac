    .org 0x80007CC :: .area 2h :: nop :: .endarea  ;don't block softreset (after defeating diva)
    .org 0x80035F0 :: .area 2h :: mov r0,#0x12 :: .endarea ;nintendo logo skip
    .org 0x801D340 :: .area 2h :: b 0x801D3FC :: .endarea ;disable L+Up in Debug mode (instant stage win)
    .org 0x8075E5C :: .area 2h :: mov r1,#0x0 :: .endarea ;ignore save progress - chestpiece 1
    .org 0x8075E84 :: .area 2h :: mov r1,#0x0 :: .endarea ;ignore save progress - chestpiece 2
    .org 0x8075EAC :: .area 2h :: mov r1,#0x0 :: .endarea ;ignore save progress - chestpiece 3
    .org 0x8075ED4 :: .area 2h :: mov r1,#0x0 :: .endarea ;ignore save progress - chestpiece 4
    .org 0x8075EFC :: .area 2h :: mov r1,#0x0 :: .endarea ;ignore save progress - CD
    .org 0x802901C :: .area 2h :: b 0x8029048 :: .endarea ;ignore save progress - keyzer
    .org 0x8081452 :: .area 2h :: mov r2,#0x0 :: .endarea ;don't change boss completion state after defeat
    .org 0x807491A :: .area 2h :: cmp r0,#0xF :: .endarea ;mute 1 HP nagging sound
    .org 0x80759B0 :: .area 2h :: cmp r0,#0xF :: .endarea ;don't die (impossible death condition)
    .org 0x8072E34 :: .area 2h :: mov r0,#0x1 :: .endarea ;s-hard unlock
    .org 0x807B24A :: .area 2h :: mov r0,#0x2 :: .endarea ;unlock pyramid
    .org 0x8081460 :: .area 2h :: nop :: .endarea ;don't change map position after defeating bosses
    .org 0x8081564 :: .area 4h :: nop :: nop :: .endarea ;don't change map position after defeating diva
    .org 0x807A11E :: .area 2h :: mov r0,#0xA :: .endarea ;boss door cutscene skip
    .org 0x8012226 :: .area 2h :: mov r0,#0x0 :: .endarea ;boss door skip part 1
    .org 0x807244A :: .area 2h :: nop :: .endarea ;boss door skip part 2
    .org 0x807256A :: .area 2h :: mov r0,#0x8 :: .endarea ;boss door skip part 3
    .org 0x8072584 :: .area 2h :: cmp r0,#0x0 :: .endarea ;boss door skip part 4 (36-framer)
    .org 0x807A10A :: .area 2h :: mov r0,#0xA :: .endarea ;level entry 1st cutscene skip
    .org 0x8079C7E :: .area 2h :: mov r0,#0x13 :: .endarea ;level entry 2nd cutscene skip
    .org 0x80926FC :: .area 2h :: nop :: .endarea ;fast save delete
    .org 0x8074528 :: .area 2h :: cmp r0,#0x0 :: .endarea ;fast unpause in bosses
    .org 0x807B110 :: .area 2h :: b 0x807B204 :: .endarea ;remove black borders on world map
    .org 0x807B8BE :: .area 2h :: nop :: .endarea ;no walk animation on main map
    .org 0x807C024 :: .area 2h :: nop :: .endarea ;quick world entry on main map
    .org 0x8084D9C :: .area 2h :: nop :: .endarea ;no walk animation on passage screen, right
    .org 0x8084DC6 :: .area 2h :: nop :: .endarea ;no walk animation on passage screen, left
    .org 0x80852EE :: .area 2h :: nop :: .endarea ;quick passage entry 1
    .org 0x808533A :: .area 2h :: nop :: .endarea ;quick passage entry 2
    .org 0x8085384 :: .area 2h :: nop :: .endarea ;quick passage entry 3
    .org 0x80854D6 :: .area 2h :: nop :: .endarea ;quick passage exit 1
    .org 0x8085522 :: .area 2h :: nop :: .endarea ;quick passage exit 2
    .org 0x8085560 :: .area 2h :: nop :: .endarea ;quick passage exit 3
    .org 0x8091976 :: .area 2h :: nop :: .endarea ;fadeout shortener, quicker boot
    .org 0x8091932 :: .area 2h :: cmp r0,#0x0 :: .endarea ;fadeout shortener, quicker boot 2
    .org 0x8075A9C :: .area 2h :: b 0x8075B1A :: .endarea ;don't enter coin dropping phase when out of time
    .org 0x806B4B4 :: .area 4h :: cmp r0,0xF :: beq 0x806B4C4 :: .endarea ;new condition for roomreset function

    .org 0x80875D8 :: .area 2h :: nop :: .endarea ;allow karaoke
    .org 0x8087E84 :: .area 2h :: nop :: .endarea ;show karaoke
    .org 0x808A538 :: .area 2h :: nop :: .endarea ;play minigames with <5000 money
    .org 0x808A71C :: .area 2h :: sub r0,#0x0 :: .endarea ;f2p minigames
    .org 0x809049C :: .area 2h :: b 0x80904D6 :: .endarea ;free shop items
    .org 0x809000C :: .area 2h :: nop :: .endarea ;enable all shop items
    .org 0x808A922 :: .area 2h :: b 0x808A98E :: .endarea ;no discount for minigames (due to spoiled-rotten completion state)