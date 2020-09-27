.n64
.open "E:\mk64\Code\TriclonHacks\Mario Kart 64 (U) [!].z64", "E:\mk64\Code\TriclonHacks\MOD - Mario Kart 64 (U) [!].z64", 0
.include "Hotswap Patch\library\MarioKart.asm"
.include "Hotswap Patch\library\MarioKartStats.asm"
.include "Hotswap Patch\library\MarioKartControls.asm"
.include "Hotswap Patch\library\OverKart.asm"

.definelabel PAYLOAD_ROM, 		0x00BE9160
.definelabel PAYLOAD_RAM, 		0x80400000
.definelabel DMA_FUNC,    		0x80001158
.definelabel DMA_MAX_LENGTH, 	     0x16EA0



//original hook placement
//.org 0x34BC //RAM address 0x800028BC
//J GlobalCustomCode
//NOP




//title screen hook
.org 0x957D0 //RAM address 0x80094BD0
J CustomCodeTitleScreen
NOP

//1p
.org 0x2214  //RAM address
J race1P
NOP

//2p
.org 0x269C  //RAM address
J race2P
NOP

//mp
.org 0x28F8  //RAM address
J raceMP
NOP






// overwrite boot function

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
//JAL titleMenu
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
//JAL allRun
NOP
LW ra, 0x001C (sp) //pop ra from the stack
ADDIU sp, sp, 0x20
J 0x8000286C //tells the game where to jump back to, dont remove
NOP






race1P:
ADDIU sp, sp, -0x20
SW ra, 0x001C (sp) //push ra to the stack
NOP
//JAL gameCode
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
//JAL gameCode
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
//JAL gameCode
NOP
LW ra, 0x001C (sp) //pop ra from the stack
ADDIU sp, sp, 0x20
LUI v0, 0x800E
LW v0, 0xC5E8 (v0)
J 0x80001D00
NOP






titleMenu:
addi   sp, sp, 0xffb8 //Store registers
sw   a0, 0x0028(sp)
sw   a1, 0x002c(sp)
sw   a2, 0x0030(sp)
sw   a3, 0x0034(sp)
sw   ra, 0x0038(sp)
sw   t6, 0x003c(sp) //Free up T6 for use
//sw   t7, 0x0040(sp)



//Display a semi-transparent background for the menu
lui   a0, 0x8015 //Load dlistBuffer from to 0x80150298 to a0
lw   a0, 0x0298(a0)
ori   a1, zero, 0x1c //x1
ori   a2, zero, 0xc //y1
ori   a3, zero, 0x11c //x2
ori   t6, zero, 0xdc //y2
sw   t6, 0x0010(sp) //(argument passing starts at offset of 0x10 in stack)
sw   zero, 0x0014(sp) //u32 r
sw   zero, 0x0018(sp) //u32 g
sw   zero, 0x001c(sp) //u32 b
ori   t6, zero, 0xc8 //transparency
sw   t6, 0x0020(sp)
jal    0x80098df8 //Call drawBox function 0x80098DF8
nop
lui   a0, 0x8015 //Store dlistBuffer back to 0x80150298
sw   v0, 0x0298(a0)



//Display menu border left
lui   a0, 0x8015 //Load dlistBuffer from to 0x80150298 to a0
lw   a0, 0x0298(a0)
ori   a1, zero, 0x1c //x1
ori   a2, zero, 0xc //y1
ori   a3, zero, 0x1e //x2
ori   t6, zero, 0xdc //y2
sw   t6, 0x0010(sp) //(argument passing starts at offset of 0x10 in stack)
ori   t6, zero, 0x80 //color
sw   t6, 0x0014(sp) //u32 r
sw   t6, 0x0018(sp) //u32 g
sw   t6, 0x001c(sp) //u32 b
ori   t6, zero, 0xff
sw   t6, 0x0020(sp) //transparency
jal    0x80098df8 //Call drawBox function 0x80098DF8
nop
lui   a0, 0x8015 //Store dlistBuffer back to 0x80150298
sw   v0, 0x0298(a0)

//Display menu border right
lui   a0, 0x8015 //Load dlistBuffer from to 0x80150298 to a0
lw   a0, 0x0298(a0)
ori   a1, zero, 0x11c //x1
ori   a2, zero, 0xc //y1
ori   a3, zero, 0x11e //x2
ori   t6, zero, 0xdc //y2
sw   t6, 0x0010(sp) //(argument passing starts at offset of 0x10 in stack)
ori   t6, zero, 0x80 //color
sw   t6, 0x0014(sp) //u32 r
sw   t6, 0x0018(sp) //u32 g
sw   t6, 0x001c(sp) //u32 b
ori   t6, zero, 0xff
sw   t6, 0x0020(sp) //transparency
jal    0x80098df8 //Call drawBox function 0x80098DF8
nop
lui   a0, 0x8015 //Store dlistBuffer back to 0x80150298
sw   v0, 0x0298(a0)

//Display  menu border bottom
lui   a0, 0x8015 //Load dlistBuffer from to 0x80150298 to a0
lw   a0, 0x0298(a0)
ori   a1, zero, 0x1c //x1
ori   a2, zero, 0xda //y1
ori   a3, zero, 0x11c //x2
ori   t6, zero, 0xdc //y2
sw   t6, 0x0010(sp) //(argument passing starts at offset of 0x10 in stack)
ori   t6, zero, 0x80 //color
sw   t6, 0x0014(sp) //u32 r
sw   t6, 0x0018(sp) //u32 g
sw   t6, 0x001c(sp) //u32 b
ori   t6, zero, 0xff
sw   t6, 0x0020(sp) //transparency
jal    0x80098df8 //Call drawBox function 0x80098DF8
nop
lui   a0, 0x8015 //Store dlistBuffer back to 0x80150298
sw   v0, 0x0298(a0)


//Display menu border top
lui   a0, 0x8015 //Load dlistBuffer from to 0x80150298 to a0
lw   a0, 0x0298(a0)
ori   a1, zero, 0x1c //x1
ori   a2, zero, 0xc //y1
ori   a3, zero, 0x11c //x2
ori   t6, zero, 0xe //y2
sw   t6, 0x0010(sp) //(argument passing starts at offset of 0x10 in stack)
ori   t6, zero, 0x80 //color
sw   t6, 0x0014(sp) //u32 r
sw   t6, 0x0018(sp) //u32 g
sw   t6, 0x001c(sp) //u32 b
ori   t6, zero, 0xff
sw   t6, 0x0020(sp) //transparency
jal    0x80098df8 //Call drawBox function 0x80098DF8
nop
lui   a0, 0x8015 //Store dlistBuffer back to 0x80150298
sw   v0, 0x0298(a0)



//Display menu seperator between battle kart and credit title and tabs
lui   a0, 0x8015 //Load dlistBuffer from to 0x80150298 to a0
lw   a0, 0x0298(a0)
ori   a1, zero, 0x1c //x1
ori   a2, zero, 0x2a //y1
ori   a3, zero, 0x11c //x2
ori   t6, zero, 0x2c //y2
sw   t6, 0x0010(sp) //(argument passing starts at offset of 0x10 in stack)
ori   t6, zero, 0x80 //color
sw   t6, 0x0014(sp) //u32 r
sw   t6, 0x0018(sp) //u32 g
sw   t6, 0x001c(sp) //u32 b
ori   t6, zero, 0xff
sw   t6, 0x0020(sp) //transparency
jal    0x80098df8 //Call drawBox function 0x80098DF8
nop
lui   a0, 0x8015 //Store dlistBuffer back to 0x80150298
sw   v0, 0x0298(a0)

//Display menu seperator between tabs and rest of menu
lui   a0, 0x8015 //Load dlistBuffer from to 0x80150298 to a0
lw   a0, 0x0298(a0)
ori   a1, zero, 0x1c //x1
ori   a2, zero, 0x40 //y1
ori   a3, zero, 0x11c //x2
ori   t6, zero, 0x42 //y2
sw   t6, 0x0010(sp) //(argument passing starts at offset of 0x10 in stack)
ori   t6, zero, 0x80 //color
sw   t6, 0x0014(sp) //u32 r
sw   t6, 0x0018(sp) //u32 g
sw   t6, 0x001c(sp) //u32 b
ori   t6, zero, 0xff
sw   t6, 0x0020(sp) //transparency
jal    0x80098df8 //Call drawBox function 0x80098DF8
nop
lui   a0, 0x8015 //Store dlistBuffer back to 0x80150298
sw   v0, 0x0298(a0)
jr  ra

//.align 0x10
//.importobj "Hotswap Patch\MarioKart.o"




.close
