.n64
.open "E:\mk64\Code\OverKart\ROM\stock.z64", "E:\mk64\Code\OverKart\ROM\BASE.z64", 0
.include "OverKart\library\MarioKart.asm"
.include "OverKart\library\MarioKartStats.asm"
.include "OverKart\library\OKHeader.asm"
.include "OverKart\library\OKAssembly.asm"


.definelabel PAYLOAD_ROM, 		0x00C00000
.definelabel PAYLOAD_RAM, 		0x80400000
.definelabel DMA_FUNC,    		0x80001158
.definelabel DMA_MAX_LENGTH, 	     0x16EA0
.definelabel Printf, 			0x800D6420


.org 0x113FBA
.halfword 0x8080
.org 0x113FCE
.byte 0x00




//original hook placement
.org 0x34BC //RAM address 0x800028BC
J GlobalCustomCode
NOP




//title screen hook
.org 0x957D0 //RAM address 0x80094BD0
J CustomCodeTitleScreen
NOP


//trophyscreen

//.org 0x124C34 //Ram address 802815F4
//JAL printGPTimeParent
//NOP
//LW ra, 0x14 (sp)
//ADDIU sp, sp, 0x18
//JR ra
//NOP


//1p
.org 0x2214
J race1P
NOP

//2p
.org 0x269C
J race2P
NOP

//mp
.org 0x28F8
J raceMP
NOP


.org 0x17EC //RAM address 0x80000BEC
LUI a0, 0x8040 //RAM address
LUI a1, hi(PAYLOAD_ROM)
ADDIU a1, a1, lo(PAYLOAD_ROM) //DMA from ROM address 0x00C00000
LUI a2, hi(EndRAMData - StartRAMData)
JAL DMA_FUNC
ADDIU a2, lo(EndRAMData - StartRAMData)
J OriginalBootFunction
NOP








.headersize 0x7F800000
.org 0x80400000



StartRAMData:
bannerN:
.import "OverKart\\textures\\banner_n.mio0.bin"        ;;  324
bannerU:
.import "OverKart\\textures\\banner_U.mio0.bin"        ;;  311
set0:
.import "OverKart\\textures\\set0.mio0.bin"            ;;  87c
set1:
.import "OverKart\\textures\\set1.mio0.bin"            ;;  7f5
set2:
.import "OverKart\\textures\\set2.mio0.bin"            ;;  7fc
set3:
.import "OverKart\\textures\\set3.mio0.bin"            ;;  808
set4:
.import "OverKart\\textures\\set4.mio0.bin"            ;;  800


OriginalBootFunction: //we overwrite this when DMAing our code
//therefore, make sure it gets ran or the game wont boot
LUI    T6, 0x8030
LUI    AT, 0x1FFF
ORI    AT, AT, 0xFFFF
ADDIU t6, t6, 0x9F80
AND t7, t6, at
LUI at, 0x8015
J 0x800012AC //jump back to where execution should be on boot
SW t7, 0x02B4 (at)


CustomCodeTitleScreen:
ADDIU sp, sp, -0x20
SW ra, 0x001C (sp)
JAL	0x80095574 //run what we overwrote with our hook
NOP
JAL titleMenu
NOP
LW ra, 0x001C (sp)
ADDIU sp, sp, 0x20
J 0x80094BD8 //jump back to where we were
NOP
NOP

GlobalCustomCode:
ADDIU sp, sp, -0x20
SW ra, 0x001C (sp) //push ra to the stack
NOP
JAL allRun
NOP
LW ra, 0x001C (sp) //pop ra from the stack
ADDIU sp, sp, 0x20
J 0x8000286C //tells the game where to jump back to, dont remove
NOP

race1P:
ADDIU sp, sp, -0x20
SW ra, 0x001C (sp) //push ra to the stack
NOP
JAL gameCode
NOP
LW ra, 0x001C (sp) //pop ra from the stack
ADDIU sp, sp, 0x20
LUI a0, 0x800E
LHU a0, 0xC520 (a0)
LUI a1, 0x800E
J 0x8000161C
NOP


race2P:
ADDIU sp, sp, -0x20
SW ra, 0x001C (sp) //push ra to the stack
NOP
JAL gameCode
NOP
LW ra, 0x001C (sp) //pop ra from the stack
ADDIU sp, sp, 0x20
LUI t3, 0x800E
LW t3, 0xC5E8 (t3)
J 0x80001AA4
NOP




raceMP:
ADDIU sp, sp, -0x20
SW ra, 0x001C (sp) //push ra to the stack
NOP
JAL gameCode
NOP
LW ra, 0x001C (sp) //pop ra from the stack
ADDIU sp, sp, 0x20
LUI v0, 0x800E
LW v0, 0xC5E8 (v0)
J 0x80001D00
NOP



.align 0x10
.importobj "OverKart\OverKart.o"
.align 0x10
.importobj "OverKart\MarioKartMenu.o"
.align 0x10
.importobj "OverKart\MarioKartPractice.o"
.align 0x10
.importobj "OverKart\MarioKartStats.o"
.align 0x10
.importobj "OverKart\MarioKartAI.o"
.align 0x10
.importobj "OverKart\CustomLevels.o"
.align 0x10
.importobj "OverKart\MarioKart3D.o"
.align 0x10
.importobj "OverKart\SharedFunctions.o"
.align 0x10
.importobj "OverKart\MarioKartObjects.o"

.align 0x10
DisplayHop:
MOVE  $a0, $s1
JAL   DisplayObject
MOVE  $a1, $s0
J     0x802A34D4
NOP

.align 0x10
CollisionHop:
LW    $t4, 0xbc($a3)
MOVE  $a0, $a3
LW    $ra, 0x1c($sp)
JAL  RedCoinCollide
MOVE  $a1, $s0
J     0x802A0D44
LW    $ra, 0x1c($sp)


DisplayHopTable:
.word 0x802A31E4, 0x802A31FC, 0x802A3214, 0x802A32EC
.word 0x802A3318, 0x802A3330, 0x802A3348, 0x802A34C0
.word 0x802A3378, 0x802A34D4, 0x802A34D4, 0x802A34D4
.word 0x802A34D4, 0x802A3390, 0x802A33A4, 0x802A33B8
.word 0x802A33CC, 0x802A322C, 0x802A33E4, 0x802A34D4  //19
.word 0x802A34D4, 0x802A33FC, 0x802A34D4, 0x802A3428
.word 0x802A3244, 0x802A34D4, 0x802A325C, 0x802A328C
.word 0x802A32A4, 0x802A32BC, 0x802A32D4, 0x802A3274
.word 0x802A34D4, 0x802A3414, 0x802A34D4, 0x802A345C
.word 0x802A3440, 0x802A34AC, 0x802A3470, 0x802A3484  //39
.word 0x802A3360, 0x802A34D4, 0x802A3498, 0x802A3300
.word 0x802A33E4, DisplayHop, 0x802A33E4, 0x802A33E4
.word 0x802A33E4, 0x802A33E4, 0x802A33E4, 0x802A33E4
.word 0x802A33E4, 0x802A33E4, 0x802A33E4, 0x802A33E4
.word 0x802A33E4, 0x802A33E4, 0x802A33E4, 0x802A33E4 //59
.word 0x802A33E4, 0x802A33E4, 0x802A33E4, 0x802A33E4
.word 0x802A33E4, 0x802A33E4, 0x802A33E4, 0x802A33E4
.word 0x802A33E4, 0x802A33E4, 0x802A33E4, 0x802A33E4
.word 0x802A33E4, 0x802A33E4, 0x802A33E4, 0x802A33E4
.word 0x802A33E4, 0x802A33E4, 0x802A33E4, 0x802A33E4  //79
.word 0x802A33E4, 0x802A33E4, 0x802A33E4, 0x802A33E4
.word 0x802A33E4, 0x802A33E4, 0x802A33E4, 0x802A33E4
.word 0x802A33E4, 0x802A33E4, 0x802A33E4, 0x802A33E4
.word 0x802A33E4, 0x802A33E4, 0x802A33E4, 0x802A33E4
.word 0x802A33E4, 0x802A33E4, 0x802A33E4, 0x802A33E4 //99


CollisionJumpTable:
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09D4
.word 0x802A04E0, 0x802A063C, 0x802A0858, 0x802A04AC
.word 0x802A0968, 0x802A0D40, 0x802A0CBC, 0x802A0AA4
.word 0x802A0D40, 0x802A0D40, 0x802A0D40, 0x802A0D40
.word 0x802A0D40, 0x802A09B0, 0x802A0D40, 0x802A0D40 //19
.word 0x802A0D40, 0x802A098C, 0x802A0D40, 0x802A09B0
.word 0x802A09B0, 0x802A0D40, 0x802A09B0, 0x802A09B0
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0
.word 0x802A0D40, 0x802A0D40, 0x802A0D40, 0x802A0D40
.word 0x802A0D40, 0x802A0D40, 0x802A0D40, 0x802A0D40 //39
.word 0x802A0744, 0x802A0C34, 0x802A09B0, 0x802A09B0
.word 0x802A09B0, CollisionHop, 0x802A09B0, 0x802A09B0
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0 //59
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0 //79
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0
.word 0x802A09B0, 0x802A09B0, 0x802A09B0, 0x802A09B0 //99

AddObjectTable:
.word 0x80296F28, 0x80296F6C, 0x80296F9C, 0x80296E40
.word 0x80296E6C, 0x80296E88, 0x80296ED8, 0x80296DDC
.word 0x802971FC, 0x8029721C, 0x802971D8, 0x8029716C
.word 0x8029721C, 0x80296E5C, 0x8029721C, 0x8029721C
.word 0x8029721C, 0x80296FCC, 0x8029721C, 0x8029721C  //19
.word 0x8029721C, 0x8029721C, 0x8029721C, 0x8029713C
.word 0x80296FF4, 0x8029721C, 0x80297024, 0x8029707C
.word 0x802970AC, 0x802970DC, 0x8029710C, 0x8029704C
.word 0x8029721C, 0x8029721C, 0x8029721C, 0x80296DA8
.word 0x8029721C, 0x8029721C, 0x8029721C, 0x8029721C  //39
.word 0x8029721C, 0x802971B0, 0x8029721C, 0x80296E20
.word 0x8029721C, 0x8029721C, 0x8029721C, 0x8029721C
.word 0x8029721C, 0x8029721C, 0x8029721C, 0x8029721C
.word 0x8029721C, 0x8029721C, 0x8029721C, 0x8029721C
.word 0x8029721C, 0x8029721C, 0x8029721C, 0x8029721C  //59
.word 0x8029721C, 0x8029721C, 0x8029721C, 0x8029721C
.word 0x8029721C, 0x8029721C, 0x8029721C, 0x8029721C
.word 0x8029721C, 0x8029721C, 0x8029721C, 0x8029721C
.word 0x8029721C, 0x8029721C, 0x8029721C, 0x8029721C
.word 0x8029721C, 0x8029721C, 0x8029721C, 0x8029721C  //79
.word 0x8029721C, 0x8029721C, 0x8029721C, 0x8029721C
.word 0x8029721C, 0x8029721C, 0x8029721C, 0x8029721C
.word 0x8029721C, 0x8029721C, 0x8029721C, 0x8029721C
.word 0x8029721C, 0x8029721C, 0x8029721C, 0x8029721C
.word 0x8029721C, 0x8029721C, 0x8029721C, 0x8029721C  //99
EndRAMData:




.headersize 0
.align 0x10
previewN:
.import "OverKart\\textures\\preview_n.mio0.bin"       ;;  c10
.align 0x10
previewU:
.import "OverKart\\textures\\preview_U.mio0.bin"       ;;  c64
.align 0x10
LogoROM:
.import "OverKart\\data\\logo.bin" ;; 0x3888
.align 0x10
CoinROM:
.import "OverKart\\data\\coin.bin" ;; 0x4F0
RCSpriteROM:
.import "OverKart\\data\\coinsprite.bin" ;; 0x4F0



.org 0xD00000
.word 0
.close
