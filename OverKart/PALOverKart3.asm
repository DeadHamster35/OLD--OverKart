.n64
.open "E:\mk64\Code\OverKart\ROM\Mario Kart 64 (E) (V1.1) [!].z64", "E:\mk64\Code\OverKart\ROM\MOD - Mario Kart 64 (E) (V1.1) [!].z64", 0
.include "OverKart\library\PALMarioKart.asm"
.include "OverKart\library\PALMarioKartStats.asm"
.include "OverKart\library\PALMarioKartControls.asm"
.include "OverKart\library\PALOKHeader.asm"
.include "OverKart\library\OKAssembly.asm"

.definelabel PAYLOAD_ROM, 		0x00BE9380
.definelabel PAYLOAD_RAM, 		0x80400000
.definelabel DMA_FUNC,    		0x80001138
.definelabel DMA_MAX_LENGTH, 	     0x16EA0
.definelabel Printf, 			0x800D6420




//Store the OverKart64 header at 0xBF8E44  -- "OK64" and version number







//original hook placement
.org 0x349C
J GlobalCustomCode
NOP




//title screen hook
.org 0x957D0 //RAM address 0x80094BD0
J CustomCodeTitleScreen
NOP

//1p
.org 0x21F4  //RAM address
J race1P
NOP

//2p
.org 0x267C  //RAM address
J race2P
NOP

//mp
.org 0x28D8
J raceMP
NOP


.org 0x17CC //RAM address 0x80000BEC
LUI a0, 0x8040 //RAM address
LUI a1, hi(PAYLOAD_ROM)
ADDIU a1, a1, lo(PAYLOAD_ROM) //DMA from ROM address 0x00BE9160
LUI a2, hi(DMA_MAX_LENGTH)
JAL DMA_FUNC
ADDIU a2, lo(DMA_MAX_LENGTH)
J OriginalBootFunction
NOP



.headersize 0x7F816C80
.org 0x80400000

bannerN:

bannerU:

previewN:

previewU:

set0:

set1:

set2:

set3:

set4:




.align 0x10

OriginalBootFunction: //we overwrite this when DMAing our code
//therefore, make sure it gets ran or the game wont boot
LUI    T6, 0x8030
LUI    AT, 0x1FFF
ORI    AT, AT, 0xFFFF
ADDIU t6, t6, 0x9F80
AND t7, t6, at
LUI at, 0x8015
J 0x8000128C //jump back to where execution should be on boot
SW t7, 0x0314 (at)


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
J 0x8000284C //tells the game where to jump back to, dont remove
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
J 0x800015FC
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
J 0x80001A84
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
J 0x80001CE0
NOP



.align 0x10
.importobj "OverKart\OverKart.o"
.importobj "OverKart\MarioKartMenu.o"
.importobj "OverKart\MarioKartPractice.o"
.importobj "OverKart\MarioKartStats.o"
.importobj "OverKart\MarioKartAI.o"
.importobj "OverKart\CustomLevels.o"



.close
