.n64
.open "Mario Kart 64 (U) [!].z64", "speedhack\!SpeedHack.z64", 0
.include "speedhack\fastswap.asm"

.definelabel PAYLOAD_ROM, 		0x00BE9160
.definelabel PAYLOAD_RAM, 		0x80400000
.definelabel DMA_FUNC,    		0x80001158
.definelabel DMA_MAX_LENGTH, 	0x16EA0
.definelabel Printf, 			0x800D6420

//original hook placement
.org 0x34BC //RAM address 0x800028BC
J GlobalCustomCode
NOP


//title screen hook
.org 0x957D0 //RAM address 0x80094BD0
J CustomCodeTitleScreen
NOP



//ingame hook
.org 0x2A74  //RAM address 0x80001E74
J InGameCustomCode
NOP

.org 0x17EC //RAM address 0x80000BEC
LUI a0, 0x8040 //RAM address
LUI a1, hi(PAYLOAD_ROM)
ADDIU a1, a1, lo(PAYLOAD_ROM) //DMA from ROM address 0x00BE9160
LUI a2, hi(DMA_MAX_LENGTH)
JAL DMA_FUNC
ADDIU a2, lo(DMA_MAX_LENGTH)
J OriginalBootFunction
NOP

.headersize 0x7F816EA0
.org 0x80400000
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
JAL speedHack
NOP
LW ra, 0x001C (sp)
ADDIU sp, sp, 0x20
J 0x80094BD8 //jump back to where we were
NOP
NOP

GlobalCustomCode:
ADDIU sp, sp, -0x20
SW ra, 0x001C (sp) //push ra to the stack
//custom code here
//
LW ra, 0x001C (sp) //pop ra from the stack
ADDIU sp, sp, 0x20
J 0x8000286C //tells the game where to jump back to, dont remove
NOP

InGameCustomCode:
ADDIU sp, sp, -0x20
SW ra, 0x001C (sp) //push ra to the stack
JAL 0x80093E20 //tells the game where to jump back to, dont remove
NOP
//
JAL speedHack
//
NOP
LW ra, 0x001C (sp) //pop ra from the stack
ADDIU sp, sp, 0x20
J 0x80001E7C
NOP





.align 0x10
.importobj "fastswap.o"
.close
