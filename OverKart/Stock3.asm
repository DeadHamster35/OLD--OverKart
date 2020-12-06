.n64
.open "E:\mk64\Code\OverKart\ROM\stock.z64", "E:\mk64\Code\OverKart\ROM\BASE.z64", 0
.include "OverKart\library\MarioKart.asm"
.include "OverKart\library\MarioKartStats.asm"
.include "OverKart\library\MarioKartControls.asm"
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
LUI a2, hi(DMA_MAX_LENGTH)
JAL DMA_FUNC
ADDIU a2, lo(DMA_MAX_LENGTH)
J OriginalBootFunction
NOP

.headersize 0x7F800000
.org 0x80400000
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
.importobj "OverKart\MarioKartMenu.o"
.importobj "OverKart\MarioKartPractice.o"
.importobj "OverKart\MarioKartStats.o"
.importobj "OverKart\MarioKartAI.o"
.importobj "OverKart\CustomLevels.o"

.headersize 0
previewN:
.import "OverKart\\textures\\preview_n.mio0.bin"       ;;  c10
previewU:
.import "OverKart\\textures\\preview_U.mio0.bin"       ;;  c64


.close
