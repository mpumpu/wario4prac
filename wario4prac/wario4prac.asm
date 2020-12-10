.gba
.include "wario4prac-consts.asm"
.open "build\WL4UT.gba", "wario4prac.gba", 0x08000000
.include "wario4prac-patches.asm"
.include "wario4prac-main.asm"
.close
