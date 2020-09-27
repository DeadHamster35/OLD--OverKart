.n64
.open "Mario Kart 64 (U) [!].z64", "speedhack\!SpeedHack.z64", 0
.include "speedhack\fastswap.asm"

.definelabel PAYLOAD_ROM, 		0x00BE9160
.definelabel PAYLOAD_RAM, 		0x80400000
.definelabel DMA_FUNC,    		0x80001158
.definelabel DMA_MAX_LENGTH, 	0x16EA0
.definelabel Printf, 			0x800D6420

.org 0x34BC //RAM address 0x800028BC
J CustomCode
NOP

.org 0x17EC //RAM address 0x80000BEC
LUI a0, 0x8040 //RAM address
LUI a1, hi(PAYLOAD_ROM)
ADDIU a1, a1, lo(PAYLOAD_ROM) //DMA from ROM address 0x00BE9160
LUI a2, hi(DMA_MAX_LENGTH)
JAL DMA_FUNC
ADDIU a2, lo(DMA_MAX_LENGTH) //
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


.headersize 0x7F816EA0
.org 0x80400024
CustomCode:
JAL speedHack
NOP
J 0x8000286C //tells the game where to jump back to, dont remove
NOP



.headersize 0x7F816EA0
.org 0x80408EA0
.importobj "fastswap.o"
