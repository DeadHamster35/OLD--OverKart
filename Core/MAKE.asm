.n64
.open "Core\ROM\stock.z64", "Core\ROM\mod.z64", 0
.include "Core\library\MarioKart.asm"
.include "Core\library\MarioKartStats.asm"
.include "Core\library\OKHeader.asm"
.include "Core\library\OKAssembly.asm"
.include "Core\library\SubProgram.asm"


.definelabel PAYLOAD_ROM, 		0x00C00000
.definelabel PAYLOAD_RAM, 		0x80400000
.definelabel DMA_FUNC,    		0x80001158
.definelabel DMA_MAX_LENGTH, 	     0x16EA0
.definelabel Printf, 			0x800D6420

.definelabel EXCEPTION_HANDLER, 0xD1DB8
.definelabel ROM_TO_RAM, 0x7ffff400
.definelabel RAM_TO_ROM, -0x7ffff400
.definelabel exceptionHandleJumpback,  EXCEPTION_HANDLER + ROM_TO_RAM + 0x8
.definelabel boot_flag, 0x80102054 //Flag ran in menu to ensure game has booted and DMA copy of code to expansion pak is complete



//This code runs from a hook into the exception handler, if the main battle kart code has been DMAed, then the custom code that hooks into the exception handler is jumped to and allowed to run
.org 0xE9E80
exceptionHandlerBootCheck:
    LUI k0, hi(boot_flag)
    LBU k0, lo(boot_flag) (k0) //Check if boot has finished and GS code has been copied from rom to ram by waiting for controllers to be set up
    BEQ k0, zero, @@branch_boot_finished //If boot has finisehd
        NOP
        J exceptionHandlerLoop //Jump to custom code
        NOP
    @@branch_boot_finished:
    //If boot has not yet finished completely (e.g. if title screen has not been reached yet), overwrite some of the main game code right after boot

    //Enable mirror mode
    LUI k0, 0x8019
    LI k1, 0xFF00
    SH k1, 0xED12 (k0)
    //Force crash screen to always display
    LI k0, 0x08001192
    LUI k1, 0x8000
    sw k0, 0x45F0 (k1)


    J exceptionHandleJumpback //Otherwise jump back to exception handler
    NOP





//original hook placement
.org 0x34BC //RAM address 0x800028BC
J GlobalCustomCode
NOP




//title screen hook
.org 0x957D0 //RAM address 0x80094BD0
J CustomCodeTitleScreen
NOP

//menu with print hook
.org 0x95858
J MenuPrintJump
NOP





.org 0x2440
    JAL 0x80028F70

.org 0x25E8
    JAL 0x80028F70

.org 0x2800
    JAL 0x80028F70



.org 0x1106F0
JAL draw_kart3p

.org 0x110A34
JAL draw_kart4p

.org 0x110708
JAL draw_kart3PAfter

.org 0x110A4C
JAL draw_kart4PAfter


.org 0x218C8
JAL checkDMA3PHelp
.org 0x21BF0
JAL checkDMA4PHelp

.org 0x021210
NOP
.org 0x021578
NOP
.org 0x22774
NOP
.org 0x0228E0
NOP

.org 0x125548
JAL draw_kart
.org 0x10F23C
JAL draw_kart
.org 0x10F524
JAL draw_kart
.org 0x10FB30
JAL draw_kart
.org 0x110128
JAL draw_kart

.org 0x125580
JAL draw_kartAfter
.org 0x10F254
JAL draw_kartAfter
.org 0x10F53C
JAL draw_kartAfter
.org 0x10FB48
JAL draw_kartAfter
.org 0x110140
JAL draw_kartAfter


.org 0x10F81C
JAL draw_kart2P
.org 0x10FE44
JAL draw_kart2P
.org 0x11040C
JAL draw_kart2P

.org 0x10F834
JAL draw_kart2PAfter
.org 0x10FE5C
JAL draw_kart2PAfter
.org 0x110424
JAL draw_kart2PAfter

//NOP if statments in the draw_kart function
.org 0x021FDC
    NOP
.org 0x0220AC
    NOP
.org 0x022178
    NOP

//NOP if statements in the draw_kartP2 function
.org 0x02226C
    NOP
.org 0x02233C
    NOP
.org 0x022408
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
LUI a2, hi(EndRAMData - StartRAMData)
JAL DMA_FUNC
ADDIU a2, lo(EndRAMData - StartRAMData)
J OriginalBootFunction
NOP








.headersize 0x7F800000
.org 0x80400000



StartRAMData:

.align 0x10
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

.align 0x10
CustomCodeTitleScreen:
ADDIU sp, sp, -0x20
SW ra, 0x001C (sp)
JAL	0x80095574 //run what we overwrote with our hook
NOP
JAL titleMenu
NOP
LI a0, 1
SB a0, boot_flag
LW ra, 0x001C (sp)
ADDIU sp, sp, 0x20
J 0x80094BD8 //jump back to where we were
NOP
NOP

.align 0x10
MenuPrintJump:
ADDIU sp, sp, -0x20
SW ra, 0x001C (sp) //push ra to the stack
NOP
JAL MenuPrint
NOP
LW ra, 0x001C (sp) //pop ra from the stack
ADDIU sp, sp, 0x20
jr ra
NOP

.align 0x10
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

.align 0x10
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

.align 0x10
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



.align 0x10
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
.align 0x10
.importobj "Core\Core.o"
.align 0x10
.importobj "Core\MarioKartMenu.o"
.align 0x10
.importobj "Core\MarioKartPractice.o"
.align 0x10
.importobj "Core\MarioKart3D.o"
.align 0x10
.importobj "Core\SharedFunctions.o"
.align 0x10
.importobj "Core\MarioKartObjects.o"

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
JAL  CollideObject
MOVE  $a1, $s0
J     0x802A0D44
LW    $ra, 0x1c($sp)

//Runs in exception handler (like a Gameshark), necessary for some stuff
exceptionHandlerLoop:

    // //Force mode to always be GP
    SW zero, 0x800DC53C

    //Force 8 characters to load in VS mode (from Rain)
    LUI k0, 0x340C
    LUI k1, 0x8004
    SW k0, 0xC538 (k1)

    //Force characters 5-8 to be 0x90 AI
    LUI k0, 0x8010
    LI k1, 0x90
    SB k1, 0xA0F0 (k0)
    SB k1, 0xAEC8 (k0)
    SB k1, 0xBCA0 (k0)
    SB k1, 0xCA78 (k0)

    J exceptionHandleJumpback
    NOP


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
.org 0xD00000
.word 0
.close
