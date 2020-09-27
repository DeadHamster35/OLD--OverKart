//This patch is all about surviving as long as you can in a battle mode while killing the cpus as many times as possible

import mk64_lib
import sys

//Read in command line arguments
input_file = '../Unaltered_Roms/Mario Kart 64.z64'
output_file = 'MK64_hot_potato_battle.z64'


//Load rom
mk64rom = mk64_lib.rom(input_file)


exception_handler_preamble_hook_address = mk64rom.get_address(0x03400008) + mk64rom.rom_to_ram
exception_handler_preamble_jumpback_address = exception_handler_preamble_hook_address + 0x8

return_to_hook_address_2p =  hex(0x269C + mk64rom.rom_to_ram + 0x8)
return_to_hook_address_3p_4p =  hex(0x28F8 + mk64rom.rom_to_ram + 0x8)



//Mario Kart 64 (U/NTSC)
end_of_rom_address = 0xC00000
dma_copy_function_address = 0x80001158 //
custom_code_address = 0x800E9280 //Find some blank region of the first 1MB of the ram, such as PAL VI or debug code that is unused
ram_codeblock_addr = 0x80600000 //Normally the start of the expansion pack address
dmaed_code_rom_to_ram = ram_codeblock_addr - end_of_rom_address
mk64rom.rom_to_ram = dmaed_code_rom_to_ram




romaddr_hex_str = format(end_of_rom_address, '08x')  //The rest of this code creates the code to copy from rom into ram using dma copy
ramaddr_hex_str = format(ram_codeblock_addr, '08x')
//exceptionhadleraddr_hex_str = format(exception_handler_preamble_hook_address, '08x')
exceptionhadlerjumpbackaddr_hex_str = format(exception_handler_preamble_jumpback_address, '08x')
custom_code_address_hex_string = format(custom_code_address, '08x')




codeblock_addr = end_of_rom_address



//Memory map

//0x80102000 - 2 bytes - Max HP
//0x80102002 - 2 bytes - P1 HP/score
//0x80102004 - 2 bytes - P2 HP/score
//0x80102006 - 2 bytes - P3 HP/score
//0x80102008 - 2 bytes - P4 HP/score

//0x8010200A - 2 bytes - Team 1 HP/Score
//0x8010200A - 2 bytes - Team 2 HP/Score

//0x80102010 - 4 bytes - Max timer
//0x80102014 - 4 bytes - Timer


//0x801020C0 - 4 bytes - Player 1 Bot controller input
//0x801020C4 - 4 bytes - Player 2 Bot controller input
//0x801020C8 - 4 bytes - Player 3 Bot controller input
//0x801020CC - 4 bytes - Player 4 Bot controller input
//0x801020D0 - 1 byte - Player 1 Bot status (1=ON, 0=OFF)
//0x801020D1 - 1 byte - Player 2 Bot status (1=ON, 0=OFF)
//0x801020D2 - 1 byte - Player 3 Bot status (1=ON, 0=OFF)
//0x801020D3 - 1 byte - Player 4 Bot status (1=ON, 0=OFF)
//0x801020D4 - 1 byte - Player 1 Bot timer
//0x801020D5 - 1 byte - Player 2 Bot timer
//0x801020D6 - 1 byte - Player 3 Bot timer
//0x801020D7 - 1 byte - Player 4 Bot timer
//0x801020D8 - 1 byte - Player 1 Bot steering state (0 = go straight, 1 = turn left, 2 = turn right)
//0x801020D9 - 1 byte - Player 2 Bot steering state (0 = go straight, 1 = turn left, 2 = turn right)
//0x801020DA - 1 byte - Player 3 Bot steering state (0 = go straight, 1 = turn left, 2 = turn right)
//0x801020DB - 1 byte - Player 4 Bot steering state (0 = go straight, 1 = turn left, 2 = turn right)

//0x801020E0 - 1 byte - Item menu selection (0, 1, 2, ect. as you go down the menu)
//0x801020E1 - 1 byte - Game menu selection (0, 1, 2, ect. as you go down the menu)
//0x801020E2 - 1 byte - Options menu selection (0, 1, 2, ect. as you go down the menu)
//0x801020E3 - 1 byte - Bots menu selection (0, 1, 2, ect. as you go down the menu)


//0x801020F0 - 1 byte - Banana item toggle (0=OFF, 1=ON)
//0x801020F1 - 1 byte - Banana Bunch item toggle (0=OFF, 1=ON)
//0x801020F2 - 1 byte - Single Green shells item toggle (0=OFF, 1=ON)
//0x801020F3 - 1 byte - 3 Green Shells item toggle (0=OFF, 1=ON)
//0x801020F4 - 1 byte - Single Red Shell item toggle (0=OFF, 1=ON)
//0x801020F5 - 1 byte - Fake item box item toggle (0=OFF, 1=ON)
//0x801020F6 - 1 byte - Star item toggle (0=OFF, 1=ON)
//0x801020F7 - 1 byte - Ghost item toggle (0=OFF, 1=ON)

//0x80102100 - 1 byte - Who was hit last (and the hot potato) (0=nobody, 1=P2, 2=P2, 3=P3, 4=P4)
//0x80102104 - 2 bytes - Hot potato  countdown
//0x80102108 - 2 bytes - Hot potato  countdown default

//0x8010210C - 1 byte - Game Tempo (0 = Default, 1 = 30 FPS, 2 = 60 FPS)
//0x8010210D - 1 byte - Title menu y-axis movement in progress? (0 = no, 1 = yes)
//0x8010210E - 1 byte - Title menu x-axis movement in progress? (0 = no, 1 = left, 2=right, 4=done)
//0x8010210F - 1 byte - Max distance you can move in y in menu
//0x80102110 - 1 byte - Minimap (0= OFF, 1=ON)

//0x80102111 - 1 byte - Widescreen (0=OFF, 1=ON)
//0x80102112 - 1 byte - Antialiasing (0=OFF, 1=ON)
//0x80102113 - 1 byte - Music in 3 & 4 Player mode (0=OFF, 1=ON)
//0x80102114 - 1 byte - Multiple players can select same character (0=OFF, 1=ON)
//0x80102115 - 1 byte - Infinite green shells (0=OFF, 1=ON)
//0x80102116 - 1 byte - Flat courses (0=OFF, 1=ON)
//0x80102117 - 1 byte - Automatic Items (0=OFF, 1=ON)
//0x80102118 - 1 byte - Menu page (0=first page, 1=2nd page, and so on and so forth...)
//0x80102119 - 1 byte - Menu page movement in progress?
//0x8010211A - 1 byte - Game mode (0=traditional, 1=hot potato, and so on and so forth...)
//0x8010211B - 1 byte - Game scoring (0=Stock, 1=Time)
//0x8010211C - 1 byte - Ludicrous speed (0=OFF, 1=ON)







//codeblock_addr = 0xE9E80 //Somewhere in PAL VI code that goes unused in NTSC (seems to be the best so far, use this so I can use the debugger code)
//codeblock_addr = 0x121f4 //Path following function which gives us plenty of space to overwrite
//codeblock_addr = 0x120f4
// codeblock_addr = 0xC00000 //End of rom

// //Hook into boot
// code = ['j ' + hex(codeblock_addr+mk64rom.rom_to_ram), 'nop']
// mk64rom.insert_code(0x17EC, code)


//Store acsii text in rom
text_address = 0x800EB800 + mk64rom.ram_to_rom
text_code = [0x434F554E, 0x54444F57, 0x4E202020, 0x20202000]
mk64rom.insert_code(text_address + 0x00, text_code)  //Set text "COUNTDOWN" + spaces
text_code = [0x48500000]
mk64rom.insert_code(text_address + 0x10, text_code)  //Set text "HP"
text_code = [0x434F554E, 0x54444F57, 0x4E000000]
mk64rom.insert_code(text_address + 0x14, text_code) //Set text "COUNTDOWN" with no spaces
text_code = [0x4C000000]
mk64rom.insert_code(text_address + 0x20, text_code) //set text for "L"
text_code = [0x53544152, 0x0000000]
mk64rom.insert_code(text_address + 0x24, text_code) //Set text for "STAR"
text_code = [0x47484F53, 0x54000000]
mk64rom.insert_code(text_address + 0x2C, text_code) //Set text for "GHOST"
text_code = [0x42414E41, 0x4E410000]
mk64rom.insert_code(text_address + 0x34, text_code) //Set text for "BANANA"
text_code = [0x4F464600]
mk64rom.insert_code(text_address + 0x40, text_code) //Set text for "OFF"
text_code = [0x4F4E0000]
mk64rom.insert_code(text_address + 0x44, text_code) //Set text for "ON"
text_code = [0x42415454, 0x4C45204B, 0x41525420, 0x36340000, 0x00007632, 0x2E302042, 0x59205452, 0x49434C4F, 0x4E000000]
mk64rom.insert_code(text_address + 0x48, text_code) //Set text for "BATTLE KART 64 v2.0 BY TRICLON"
text_code = [0x57494445, 0x53435245, 0x454E0000]
mk64rom.insert_code(text_address + 0x6C, text_code) //Set text for "WIDESCREEN"
text_code = [0x44495341, 0x424C4520, 0x41410000, 0x00000000]
mk64rom.insert_code(text_address + 0x78, text_code) //Set text for "DISABLE AA"
text_code = [0x33502F34, 0x50204D55, 0x53494300]
mk64rom.insert_code(text_address + 0x88, text_code) //Set text for "3P/4P MUSIC"
text_code = [0x53414D45, 0x20434841, 0x52530000]
mk64rom.insert_code(text_address + 0x94, text_code) //Set text for "SAME CHARS"
text_code = [0x494E462E, 0x472E5348, 0x454C4C53, 0x00000000]
mk64rom.insert_code(text_address + 0xA4, text_code) //Set text for "INF. G. SHELLS"
text_code = [0x464C4154, 0x20434F55, 0x52534553, 0x00000000]
mk64rom.insert_code(text_address + 0xB4, text_code) //Set text for "FLAT COURSES"
text_code = [0x4155544F, 0x2D495445, 0x4D530000]
mk64rom.insert_code(text_address + 0xC4, text_code) //Set text for "AUTO-ITEMS"
text_code = [0x484F5420, 0x504F5441, 0x544F0000]
mk64rom.insert_code(text_address + 0xD0, text_code) //Set text for "HOT POTATO"
text_code = [0x54524144, 0x4954494F, 0x4E414C00]
mk64rom.insert_code(text_address + 0xDC, text_code) //Set text for "TRADITIONAL"
text_code = [0x4D4F4445, 0x00000000]
mk64rom.insert_code(text_address + 0xE8, text_code) //Set text for "MODE"
text_code = [0x4F505449, 0x4F4E5300]
mk64rom.insert_code(text_address + 0xF0, text_code) //Set text for "OPTIONS"
text_code = [0x5A000000]
mk64rom.insert_code(text_address + 0xF8, text_code) //Set text for "<<Z"
text_code = [0x52000000]
mk64rom.insert_code(text_address + 0xFC, text_code) //Set text for "R>>"
text_code = [0x47414D45, 0x00000000]
mk64rom.insert_code(text_address + 0x100, text_code) //Set text for "GAME"
text_code = [0x2D2D2D2D,0x2D2D2D2D,0x2D2D2D2D,0x2D2D2D2D,0x2D2D2D2D,0x2D2D2D2D,0x2D2D2D2D, 0x00000000]
mk64rom.insert_code(text_address + 0x108, text_code) //Set text for a bunch of underscores
text_code = [0x49202020,0x20202020,0x49000000]
mk64rom.insert_code(text_address + 0x128, text_code) //Set text side of menu tab
text_code = [0x42414E41, 0x4E412042, 0x554E4348, 0x00000000]
mk64rom.insert_code(text_address + 0x134, text_code) //Set text for "BANANA BUNCH"
text_code = [0x47524545, 0x4E205348, 0x454C4C00, 0x00000000]
mk64rom.insert_code(text_address + 0x144, text_code) //Set text for "GREEN SHELL"
text_code = [0x3320472E, 0x5348454C, 0x4C530000]
mk64rom.insert_code(text_address + 0x154, text_code) //Set text for "3 G.SHELLS"
text_code = [0x52454420, 0x5348454C, 0x4C000000]
mk64rom.insert_code(text_address + 0x160, text_code) //Set text for "RED SHELL"
text_code = [0x46414B45, 0x20495445, 0x4D20424F, 0x58000000]
mk64rom.insert_code(text_address + 0x16C, text_code) //Set text for "FAKE ITEM BOX"
text_code = [0x47414D45, 0x2054454D, 0x504F0000]
mk64rom.insert_code(text_address + 0x17C, text_code) //Set text for "GAME TEMPO"
text_code = [0x44454641, 0x554C5400]
mk64rom.insert_code(text_address + 0x188, text_code) //Set text for "DEFAULT"
text_code = [0x33302046, 0x50530000]
mk64rom.insert_code(text_address + 0x190, text_code) //Set text for "30 FPS"
text_code = [0x36302046, 0x50530000]
mk64rom.insert_code(text_address + 0x198, text_code) //Set text for "60 FPS"
text_code = [0x424F5453, 0x00000000]
mk64rom.insert_code(text_address + 0x1A0, text_code) //Set text for "BOTS"
text_code = [0x504C4159, 0x45522031, 0x00000000]
mk64rom.insert_code(text_address + 0x1A8, text_code) //Set text for "PLAYER 1"
text_code = [0x504C4159, 0x45522032, 0x00000000]
mk64rom.insert_code(text_address + 0x1B4, text_code) //Set text for "PLAYER 2"
text_code = [0x504C4159, 0x45522033, 0x00000000]
mk64rom.insert_code(text_address + 0x1C0, text_code) //Set text for "PLAYER 3"
text_code = [0x504C4159, 0x45522034, 0x00000000]
mk64rom.insert_code(text_address + 0x1CC, text_code) //Set text for "PLAYER 4"
text_code = [0x54455354, 0x204D4F44, 0x45000000, 0x00000000]
mk64rom.insert_code(text_address + 0x1D8, text_code) //Set text for "TEST MODE"
text_code = [0x54494D45, 0x5220284D, 0x494E2900, 0x00000000]
mk64rom.insert_code(text_address + 0x1E8, text_code) //Set text for "TIMER (MIN)"
text_code = [0x4D415820, 0x53434F52, 0x45000000]
mk64rom.insert_code(text_address + 0x1F8, text_code) //Set text for "MAX SCORE"
text_code = [0x4D494E49, 0x4D415000]
mk64rom.insert_code(text_address + 0x204, text_code) //Set text for "MINIMAP"
text_code = [0x53434F52, 0x494E4700]
mk64rom.insert_code(text_address + 0x20C, text_code) //Set text for "SCORING"
text_code = [0x53544F43, 0x4B000000]
mk64rom.insert_code(text_address + 0x214, text_code) //Set text for "STOCK"
text_code = [0x54494D45, 0x20202020, 0x20200000]
mk64rom.insert_code(text_address + 0x21C, text_code) //Set text for "TIME"
text_code = [0x48495400, 0x00000000]
mk64rom.insert_code(text_address + 0x228, text_code) //Set text for "HIT"
text_code = [0x4C554449, 0x43524F55, 0x53205350, 0x45454400]
mk64rom.insert_code(text_address + 0x230, text_code) //Set text for "LUDICROUS SPEED"
text_code = [0x3A000000]
mk64rom.insert_code(text_address + 0x240, text_code) //Set text for ":", a single semicolon
text_code = [0x3A300000]
mk64rom.insert_code(text_address + 0x244, text_code) //Set text for ":", a single semicolon with a zero after it
text_code = [0x53554444, 0x454E2020, 0x20202020, 0x20204445, 0x41544800]
mk64rom.insert_code(text_address + 0x248, text_code) //Set text for "SUDDEN DEATH"


//Test inserting custom code written by Dead Hamster into a game mode
func_deadhamster_test_code = [
	addi   $sp, $sp, 0xff80 //Store registers in stack
	sw   $ra, 0x006c($sp)
	sw   $at, 0x0070($sp)


	// 3C018070,
	// 0xC4200100,
	0x3C01800E,
	0xE4202650,
	0x3C01800E,
	0xE4202654,
	0x3C01800E,
	0xE4202658,
	0x3C01800E,
	0xE420265C,
	0x3C01800E,
	0xE4202660,
	0x3C01800E,
	0xE4202664,
	0x3C01800E,
	0xE4202668,
	0x3C01800E,
	0xE420266C,
	0x3C01800F,
	0xA4206A4E,
	0x3C01800F,
	0xC42269C4,
	0x44800000,
	0x46001032,
	0x45000002,
	0x24020001,
	0x00001025,
	0x304200FF,
	0x1440000B,
	0x00000000,
	0x3C01800F,
	0xC42269CC,
	0x44800000,
	0x46001032,
	0x45000002,
	0x24020001,
	0x00001025,
	0x304200FF,
	0x10400010,
	0x00000000,
	0x3C02800F,
	0x84426912,
	0x44820000,
	0x46800020,
	0x3C0100C0,
	0xC4220104,
	0x46020003,
	0x3C0100C0,
	0xC4220108,
	0x46020002,
	0x3C01800F,
	0xC42269A8,
	0x46001000,
	0x3C01800F,
	0xE42069A8,
	0x03E00008,
	0x00000000,
	0x27BDFFE8,
	0xAFBF0014,
	0x0C300000,
	0x00000000,
	0x8FBF0014,
	0x03E00008,
	0x27BD0018,
	0x42C80000,
	0xC2FE0000,
	0x40400000,



	lw   $ra, 0x006c($sp)
	lw   $at, 0x0070($sp)
	jr    $ra
	addi   $sp, $sp, 0x80 //Load registers from stack

]
mk64rom.insert_code(codeblock_addr, func_deadhamster_test_code)
func_deadhamster_test_codeaddr_str = str(hex(codeblock_addr + dmaed_code_rom_to_ram))
codeblock_addr = codeblock_addr + len(func_deadhamster_test_code)*4




//This function decrements a timer (e.g. time score timer or hot potato battle countdown) based on the game tempo
// $A3 is both the input and output for the timer to decrement
function_decrement_timer = [
	lui   $a0, 0x8010 //Load game tempo menu option
	lbu   $a0, 0x210c($a0)
	bne   $a0, $zero, 0x3 //If game tempo is set by the menu option, default it to the menu option
	ori   $a2, $zero, 0x1
	lui   $a1, 0x8015 //Load game tempo to subtract from timer (to keep have timer keep seconds)
	lw   $a1, 0x0114($a1)
	bne   $a0, $a2, 0x2 //If game tempo is set by the menu option to 30 FPS
	ori   $a2, $zero, 0x2
	ori   $a1, $zero, 0x2
	//addi   $a3, $a3, 0xfffe //Subtract 2 from the timer (to keep timer in seconds)
	bne   $a0, $a2, 0x2 //If game tempo is set by the menu option to 60 FPS
	nop
	ori   $a1, $zero, 0x1
	//addi   $a3, $a3, 0xffff //Subtract 1 from the timer (to keep timer in seconds)
	sub   $a3, $a3, $a1 //Subtract game tempo

	jr    $ra
	nop
]
mk64rom.insert_code(codeblock_addr, function_decrement_timer)
function_decrement_timer_addr_str = str(hex(codeblock_addr + mk64rom.rom_to_ram))
codeblock_addr = codeblock_addr + len(function_decrement_timer)*4


//Function processes running the battle bot for a single player
//$A0 = Current player (0=P1, 1=P2, 2=P3, 3=P4)
function_run_battle_bot = [
	addi   $sp, $sp, 0xffd0 //Store registers
	sw   $ra, 0x20($sp)

	//Store current player in stack
	sw   $a0, 0x24($sp)

	//Set pointer for current player battle bot timer and state in $A3
	lui   $a3, 0x8010
	add   $a3, $a3, $a0
	sw   $a3, 0x28($sp) //Store pointer for current player in stack


	//Give bots auto items
	lui   $a0, 0x8010
	lbu   $a0, 0x2115($a0) //If inf. green shells are off, randomly assign items
 	bne   $a0, $zero, 0x16
 	lui   $a2, 0x802c //Load byte from RNG into $a2
	lbu   $a2, 0xa290($a2)
	sra   $a2, $a2, 0x1 //Divide RNG value by two to double the probabilitiy of getting an item
	lui   $a0, 0x8016 //Load base for player has an item memory loc.
	ori   $a0, $a0, 0x5f5f
	ori   $a1, $zero, 0xe0 //Calculate and add offset for current
	lw   $v0, 0x24($sp)
	mult   $a1, $v0
	mflo  $a1
	addu   $a0, $a0, $a1 //Store total offset for player for item memory location
	addi   $a1, $v0, 0x60 //Value to compare RNG to
	bne   $a1, $a2, 0xa //If RNG value == something
	lui   $v1, 0x800e //IF player count is 3 or 4, add 0x1C0 to their item mem loc. offset
	lbu   $v1, 0xc52f($v1)
	ori   $a2, $zero, 0x3
	bne   $v1, $a2, 0x2
	nop
	addiu   $a0, $a0, 0x1c0
	lbu   $a1, 0x0000($a0)
	bne   $a1, $zero, 0x2 //Check if player already has item, if not...
	ori   $v0, $zero, 0x1
	sb   $v0, 0x0000($a0) //Randomly give player item





	//Decrement player's counter by game's tempo and then if timer < 0, turn or go straight
	lw   $t2, 0x28($sp)
	lbu   $a3, 0x20d4($t2) //Load current bot's 1 byte timer
	'jal '+function_decrement_timer_addr_str, //Decrement timer
	nop
	sb   $a3, 0x20d4($t2) //Store decremented timer back to RAM
	//If current timer < 0
	slt   $a1, $a3, $zero
	beq   $a1, $zero, 0x15
	//And if currently moving straight, initiate turning
	lbu   $a0, 0x20d8($t2) //Load state of current player into $A0
	bne   $a0, $zero, 0xd //If player is currently traveling straight
	nop	//Iniate steering, call the RNG for a value between 1 and 2 and store in the player state
	jal    0x802b7e34 //Call RandomInt funciton to grab a number between 0 and 1
	ori   $a0, $zero, 0x02
	addi   $v0, $v0, 0x1 //Add 1 to result from RNG
	lw   $t2, 0x28($sp)
	sb   $v0, 0x20d8($t2) //Store player state back to ram
	jal    0x802b7e34 //Call RandomInt funciton to grab a new number for the timer
	ori   $a0, $zero, 0x18
	addi   $v0, $v0, 0x10 //Add constant to result from RNG
	lw   $t2, 0x28($sp)
	sb   $v0, 0x20d4($t2) //Store player timer back to ram
	beq   $zero, $zero, 0x6
	nop
	//Else if currently turning, initiate moving straight
	sb   $zero, 0x20d8($t2) //Store player state back to ram
	jal    0x802b7e34 //	//Call RNG to grab new time for going straight
	ori   $a0, $zero, 0x40
	addi   $v0, $v0, 0x28 //Add constant to result from RNG
	lw   $t2, 0x28($sp)
	sb   $v0, 0x20d4($t2) //Store player timer back to ram

	//Bot controller input
	lui   $a2, 0x8010
	ori   $a0, $zero, 0x4 //Offset per player in controller input
	lw   $v0, 0x0024($sp) //Load current player value from stack
	mult   $a0, $v0 //Multiply current player by offset per player
	mflo  $a0
	add   $a2, $a2, $a0 //Store total offset for player for controller input

	ori   $a0, $zero, 0x80 //Go foward by always pressing A
	sb   $a0, 0x20c0($a2)

	//Go foward, steer left, or steer right depending on the current player state
	lbu   $a0, 0x20d8($t2) //Load state of current player into $A0
	//Go straight if state is =0
	bne   $a0, $zero, 0x4
	nop
	sb   $zero, 0x20c2($a2)
	ori   $a0, $zero, 0x80 //Press gas (A) when going straight
	sb   $a0, 0x20c0($a2)
	//Go left if state is = 1
	ori   $a1, $zero, 0x1
	bne   $a0, $a1, 0x4
	ori   $a1, $zero, 0x50
	sb   $a1, 0x20c2($a2)
	ori   $a0, $zero, 0xc0 //Press gas and breaks (A+B) when turning
	sb   $a0, 0x20c0($a2)
	//Go right if state is = 2
	ori   $a1, $zero, 0x2
	bne   $a0, $a1, 0x4
	ori   $a1, $zero, 0xb0
	sb   $a1, 0x20c2($a2)
	ori   $a0, $zero, 0xc0 //Press gas and breaks (A+B) when turning
	sb   $a0, 0x20c0($a2)
	//Randomly press Z to fire items
	lui   $a0, 0x802c //Load byte of RNG value from 802BA290 into $k0
	lbu   $a0, 0xa290($a0)
	ori   $a1, $zero, 0x21 //If RNG == 21 + player number
	add   $a1, $a1, $v0
	beq   $a0, $k1, 0x0b
	nop
	ori   $a1, $zero, 0x32 //If RNG == 32 + player number
	add   $a1, $a1, $v0
	beq   $a0, $a1, 0x07
	nop
	ori   $a1, $zero, 0x43 //If RNG == 43 + player number
	add   $a1, $a1, $v0
	beq   $a0, $a1, 0x03
	nop
	beq   $zero, $zero, 0x03 //If RNG is != to any of the above
	nop
	ori   $a1, $zero, 0x20 //If RNG is one of the above, set button activator 1 to Z
	sb   $a1, 0x20c0($a2)



	lw   $ra, 0x20($sp)
	jr    $ra
	addi   $sp, $sp, 0x30
]
mk64rom.insert_code(codeblock_addr, function_run_battle_bot)
function_run_battle_bot_addr_str = str(hex(codeblock_addr + mk64rom.rom_to_ram))
codeblock_addr = codeblock_addr + len(function_run_battle_bot)*4





//This funciton resets HP back to max (or score to zero if game is timed)
function_reset_hp = [

	//If scoring is stock,
	lui   $v0, 0x8010
	lbu   $v0, 0x211b($v0)
	bne   $v0, $zero, 0x6
	lui   $a0, 0x8010
	//Reset HP back to max
	lhu   $a1, 0x2000($a0)
	sh   $a1, 0x2002($a0)
	sh   $a1, 0x2004($a0)
	sh   $a1, 0x2006($a0)
	sh   $a1, 0x2008($a0)
	//If scoring is timer, reset hits to zero
	beq   $v0, $zero, 0x5
	nop
	sh   $zero, 0x2002($a0)
	sh   $zero, 0x2004($a0)
	sh   $zero, 0x2006($a0)
	sh   $zero, 0x2008($a0)

	jr    $ra
	nop
]
mk64rom.insert_code(codeblock_addr, function_reset_hp)
function_reset_hp_addr_str = str(hex(codeblock_addr + mk64rom.rom_to_ram))
codeblock_addr = codeblock_addr + len(function_reset_hp)*4



//This function resets the timer when in time scoring
function_reset_timer = [
	lui   $v0, 0x8010
	lw   $v1, 0x2010($v0)
	sw   $v1, 0x2014($v0)

	jr    $ra
	nop
]
mk64rom.insert_code(codeblock_addr, function_reset_timer)
function_reset_timer_addr_str = str(hex(codeblock_addr + mk64rom.rom_to_ram))
codeblock_addr = codeblock_addr + len(function_reset_timer)*4



//This function checks if a player's HP is set to some value (normally zerozero and if it is, kills said player
//$A0 = player to decrement HP for, P1 = 0, P2 = 1, P3 =2, P4 = 4
////A3 = the value to check againt whichi sthe lowest number of hits
function_check_if_not_lowest_hits = [
	lui   $a1, 0x8010 //Load current player's hit score
	ori   $a1, $a1, 0x2002
	sll   $a2, $a0, 0x1 //Mutiply $A0 by 2
	addu   $a1, $a1, $a2
	lhu   $a2, 0x0000($a1)
	beq   $a2, $a3, 0x14 //kill player if their hit score is not the lowest
	//beq   $a2, $a3, 0x17 //kill player if their hit score is not the lowest
	//ori   $a2, $zero, 0xdd8 //Calculate offset between player structures and store offset in $a3
	//mult   $a0, $a2
	//mflo  $a3
	//lui   $a1, 0x800f //Check if player is already dead
	//addiu   $a1, $a1, 0x6990
	//addu   $a1, $a1, $a3
	//lbu   $a1, 0x0000($a1)
	//ori   $a2, $zero, 0xc0
	//bne   $a1, $a2, 0xe //If player is already dead, skip the rest of this code
	lui   $a1, 0x8019 //Set balloons to -1 to kill player
	addiu   $a1, $a1, 0xd8c0
	addu   $a1, $a1, $a0
	addu   $a1, $a1, $a0
	lhu   $t5, 0x0000($a1)
	ori   $a2, $zero, 0xffff
	beq   $a2, $t5, 0xd //If player is not yet dead
	nop
	sh   $a2, 0x0000($a1) //kill player


	ori   $a2, $zero, 0xdd8 //Calculate offset between player structures and store offset in $a3
	mult   $a0, $a2
	mflo  $t5
	lui   $a1, 0x800f
	addiu   $a1, $a1, 0x699c
	addu   $a1, $a1, $t5
	ori   $a2, $zero, 0x04 //Turn the player into a bomb/invisible
	sb   $a2, 0x0000($a1) //Store initially at 800F699C for P1
	addiu   $a1, $a1, 0x1
	ori   $a2, $zero, 0x40 //Explode the player
	sb   $a2, 0x0000($a1) //Store initially at 800F699D for P1

	jr    $ra
	nop
]
mk64rom.insert_code(codeblock_addr, function_check_if_not_lowest_hits)
function_check_if_not_lowest_hits_addr_str = str(hex(codeblock_addr + mk64rom.rom_to_ram))
codeblock_addr = codeblock_addr + len(function_check_if_not_lowest_hits)*4



//This function handles what happens when the timer reaches zero in time scoring mode
function_timer_reaches_zero = [
	//Display "SUDDEN DEATH" on screen
	lui   $a2, 0x800f //text pointer
	addiu   $a2, $a2, 0xba48
	ori   $a0, $zero, 0x3c //$A0 is the X pos
	jal    0x800577a4 //Run function to display int
	ori   $a1, $zero, 0x60 //$A1 is the Y pos

	//Load all player hit scores into memory
	lui   $v0, 0x8010
	lhu   $t1, 0x2002($v0) //P1
	lhu   $t2, 0x2004($v0) //P2
	lhu   $t3, 0x2006($v0) //P3
	lhu   $t4, 0x2008($v0) //P4

	//Find who has the least hits
	add   $a3, $t1, $zero //$v0 stores the lowest hit score found
	slt   $v1, $a3, $t2 //If P2's hits are less than $v0...
	bne   $v1, $zero, 0x2
	nop
	add   $a3, $t2, $zero //Set $v0 to P2's hit score
	slt   $v1, $a3, $t3 //If P3's hits are less than $v0...
	bne   $v1, $zero, 0x2
	nop
	add   $a3, $t3, $zero //Set $v0 to P3's hit score
	slt   $v1, $a3, $t4 //If P4's hits are less than $v0...
	bne   $v1, $zero, 0x2
	nop
	add   $a3, $t4, $zero //Set $v0 to P4's hit score

	//Kill all players who do not have the lowest score
	'jal '+function_check_if_not_lowest_hits_addr_str, //P1
	ori   $a0, $zero, 0x0
	'jal '+function_check_if_not_lowest_hits_addr_str, //P2
	ori   $a0, $zero, 0x1
	'jal '+function_check_if_not_lowest_hits_addr_str, //P3
	ori   $a0, $zero, 0x2
	'jal '+function_check_if_not_lowest_hits_addr_str, //P4
	ori   $a0, $zero, 0x3

	lw   $ra, 0x20($sp)
	jr    $ra
	addi   $sp, $sp, 0x30
	]
mk64rom.insert_code(codeblock_addr, function_timer_reaches_zero)
function_timer_reaches_zero_addr_str = str(hex(codeblock_addr + mk64rom.rom_to_ram))
codeblock_addr = codeblock_addr + len(function_timer_reaches_zero)*4

//This function displays the timer when in time scoring
function_process_time_scoring = [

	lui   $a0, 0x8010 //Check if score mode is time, if not just return
	lbu   $a1, 0x211b($a0)
	bne   $a1, $zero, 0x3
	nop
	jr    $ra
	nop

	addi   $sp, $sp, 0xffd0 //Store registers
	sw   $ra, 0x20($sp)

	lui   $t0, 0x8010 //Load timer
	lw   $a3, 0x2014($t0)
	slti  $a0, $a3, 0x0001 //If timer <= 0
	beq   $a0, $zero, 0x3
	nop
	'j '+function_timer_reaches_zero_addr_str, //Run function to kill all players but the one with the lowest number of hits
	nop


	//lui   $t0, 0x8010 //Load timer
	//lw   $a3, 0x2014($t0)
	'jal '+function_decrement_timer_addr_str, //Function to decrement timer
	nop
	sw    $a3, 0x2014($t0) //Store decremented timer
	ori   $a1, $zero, 0xe10 //Divide timer by 3600 (0xE10) to get minutes
	div   $a3, $a1
	mflo  $a3 //Grab timer minutes
	sw    $a3, 0x0024($sp) //Store minutes in the stack
	mfhi  $a3 //Get the modulus (e.g. remainder) of when the timer was divided by minutes above for later use in calculating seconds
	ori   $a1, $zero, 0x3c //Divide the remainder by 60 to convert it to seconds
	div   $a3, $a1
	mflo  $a3
	sw    $a3, 0x0028($sp) //Store seconds in the stack


	lw    $a3, 0x0024($sp) //Load timer minutes from the stack
	ori   $a0, $zero, 0x50 //X pos
	lui   $a2, 0x800f //text pointer
	addiu $a2, $a2, 0xba1c
	jal   0x800577d0 //Text print function
	ori   $a1, $zero, 0x60 //Y pos

	lw    $a3, 0x0024($sp) //Load timer minutes from the stack
	slti  $t1, $a3, 0xa
	bne   $t1, $zero, 0x2 //If minutes > 10, move colon over a bit
	ori   $a0, $zero, 0xb0 //X pos
	addi  $a0, $a0, 0x8
	lui   $a2, 0x800f //text pointer for semicolon
	lw    $a3, 0x0028($sp) //Load seconds from the stack
	slti  $t1, $a3, 0xa
	beq   $t1, $zero, 0x2 //If seconds < 10
	addiu $a2, $a2, 0xba40
	addi  $a2, $a2, 0x4 //Set text pointer to semicolon plus a zero
	jal   0x800577a4 //Text print function
	ori   $a1, $zero, 0x60 //Y pos

	lw    $a3, 0x0028($sp) //Load seconds from the stack
	slti  $t1, $a3, 0xa
	beq   $t1, $zero, 0x2 //If seconds > 10, move x position to the right a little
	ori   $a0, $zero, 0xb0 //X pos
	addi  $a0, $a0, 0x8
	lw    $t0, 0x0024($sp) //Load minutes from stack
	slti  $t0, $t0, 0xa
	bne   $t0, $zero, 0x2 //If minutes > 10, move seconds over a bit
	lui   $a2, 0x800f //text pointer (to nothing)
	addi  $a0, $a0, 0x8
	addiu $a2, $a2, 0xba43
	jal   0x800577d0 //Text + int print function
	ori   $a1, $zero, 0x60 //Y pos


	lw    $ra, 0x20($sp)
	jr    $ra
	addi  $sp, $sp, 0x30
]
mk64rom.insert_code(codeblock_addr, function_process_time_scoring)
function_process_time_scoring_addr_str = str(hex(codeblock_addr + mk64rom.rom_to_ram))
codeblock_addr = codeblock_addr + len(function_process_time_scoring)*4



//This function displays HP or "HITS" for some battle modes
function_display_hp = [
	addi  $sp, $sp, 0xffd0 //Store registers
	sw    $ra, 0x20($sp)

	lui   $v0, 0x8010 //If scoring is timer,
	lbu   $v0, 0x211b($v0)
	beq   $a0, $zero, 0x2
	lui   $a2, 0x800f //text pointer = 800EF810 for "HIT"
	addiu $a2, $a2, 0xba28

	bne   $v0, $zero, 0x6 //If scoring is stock,
	lui   $a0, 0x8010
	lhu   $a1, 0x2000($a0)
	lui   $a2, 0x800f //text pointer = 800EF810 for "HP"
	addiu $a2, $a2, 0xb810
	slti  $a1, $a1, 0x4
	bne   $a1, $zero, 0x27 //Only display HP if starting HP > 3

	sw    $a2, 0x28($sp) //Store text pointer in stack for later retrieval

	// //Display HP/HIT for P1
	ori   $a0, $zero, 0x0 //$A0 is the X pos
	ori   $a1, $zero, 0x0 //$A1 is the Y pos
	lui   $a3, 0x8010
	jal   0x800577d0 //Run function to display int
	lhu   $a3, 0x2002($a3)
	//lw   $a2, 0x0028($sp) //text pointer

	// //Display HP/HIT for P2
	ori   $a0, $zero, 0x0 //$A0 is the X pos
	ori   $a1, $zero, 0x72 //$A1 is the Y pos
	lui   $a3, 0x800e //If number of players is not 2 at 0x800DC538
	lbu   $a3, 0xc53b($a3)
	ori   $a2, $zero, 0x0002
	beq   $a3, $a2, 0x3
	nop
	ori   $a0, $zero, 0xe2 //$A0 is the X pos
	ori   $a1, $zero, 0x0 //$A1 is the Y pos
	lui   $a3, 0x8010
	lhu   $a3, 0x2004($a3)
	jal   0x800577d0 //Run function to display int
	lw    $a2, 0x0028($sp) //text pointer

	// //Display HP/HIT for P3
	lui   $a3, 0x800e //If number of players is not 2 at 0x800DC538
	lbu   $a3, 0xc53b($a3)
	ori   $a2, $zero, 0x0002
	beq   $a3, $a2, 0x6
	ori   $a0, $zero, 0x0 //$A0 is the X pos
	ori   $a1, $zero, 0x72 //$A1 is the Y pos
	lui   $a3, 0x8010
	lhu   $a3, 0x2006($a3)
	jal   0x800577d0 //Run function to display int
	lw    $a2, 0x0028($sp) //text pointer

	// //Display HP/HIT for P4
	lui   $a3, 0x800e //If number of players is 4 at 0x800DC538
	lbu   $a3, 0xc53b($a3)
	ori   $a2, $zero, 0x0004
	bne   $a3, $a2, 0x6
	ori   $a0, $zero, 0xe2 //$A0 is the X pos
	ori   $a1, $zero, 0x72 //$A1 is the Y pos
	lui   $a3, 0x8010
	lhu   $a3, 0x2008($a3)
	jal   0x800577d0 //Run function to display int
	lw    $a2, 0x0028($sp) //text pointer

	lw    $ra, 0x20($sp)
	jr    $ra
	addi  $sp, $sp, 0x30
]
mk64rom.insert_code(codeblock_addr, function_display_hp)
function_display_hp_addr_str = str(hex(codeblock_addr + mk64rom.rom_to_ram))
codeblock_addr = codeblock_addr + len(function_display_hp)*4



//This function displays and runs the universal countdown
function_display_countdown = [
	addi   $sp, $sp, 0xffd0 //Store registers
	sw   $ra, 0x20($sp)

	//Display Countdown
	lui   $t0, 0x8010 //Show custom timer at 0x80102104 (half)
	// lui   $a0, 0x8010 //Load game tempo menu option
	// lbu   $a0, 0x210c($a0)
	// bne   $a0, $zero, 0x3 //If game tempo is set by the menu option, default it to the menu option
	// ori   $a2, $zero, 0x1
	// lui   $a1, 0x8015 //Load game tempo to subtract from timer (to keep have timer keep seconds)
	// lw   $a1, 0x0114($a1)
	// bne   $a0, $a2, 0x2 //If game tempo is set by the menu option to 30 FPS
	// ori   $a2, $zero, 0x2
	// ori   $a1, $zero, 0x2
	// //addi   $a3, $a3, 0xfffe //Subtract 2 from the timer (to keep timer in seconds)
	// bne   $a0, $a2, 0x2 //If game tempo is set by the menu option to 60 FPS
	// nop
	// ori   $a1, $zero, 0x1
	// //addi   $a3, $a3, 0xffff //Subtract 1 from the timer (to keep timer in seconds)
	// sub   $a3, $a3, $a1 //Subtract game tempo
	'jal '+function_decrement_timer_addr_str, //Function to decrement timer
	lh   $a3, 0x2104($t0)
	sh   $a3, 0x2104($t0) //Store decremented timer back into ram slot

	// lui   $v0, 0x8010 //Load who is hot potato
	// lbu   $v0, 0x2100($v0)
	// //If nobody is the hot potato jump back
	// bne   $v0, $zero, 0x3
	// lw   $ra, 0x20($sp)
	// jr    $ra
	// addi   $sp, $sp, 0x30

	add   $a3, $a3, $a1 //Add tempo back before displaying so countdown when paused shows the correct value
	ori   $a1, $zero, 0x3c //Divide timer by 60 (0x3C) so output display is in secconds
	div   $a3, $a1
	mflo  $a3 //$A3 is the integer to display
	lui   $a2, 0x800f //text pointer (to nothing)
	addiu   $a2, $a2, 0xba41

	lui   $v1, 0x800e //Load number of players
	lbu   $v1, 0xc53b($v1)
	ori   $t1, $zero, 0x2
	bne   $v1, $t1, 0x8 //If number of players is 2
	ori   $t0, $zero, 0x1
	ori   $a0, $zero, 0x80 //Set x to middle of screen
	bne   $v0, $t0, 0x2 //If P1 is the hot potato
	ori   $t0, $zero, 0x2
	ori   $a1, $zero, 0x4c //Set y
	bne   $v0, $t0, 0x2 //If P2 is the hot potato
	nop
	ori   $a1, $zero, 0xc0 //Set y

	beq   $v1, $t1, 0x11 //If number of players is not 2 (ie. 3 or 4)
	ori   $t0, $zero, 0x1
	bne   $v0, $t0, 0x3 //If P1 is the hot potato
	ori   $t0, $zero, 0x2
	ori   $a0, $zero, 0x34 //Set x
	ori   $a1, $zero, 0x4c //Set y
	bne   $v0, $t0, 0x3 //If P2 is the hot potato
	ori   $t0, $zero, 0x3
	ori   $a0, $zero, 0xcc //Set x
	ori   $a1, $zero, 0x4c //Set y
	bne   $v0, $t0, 0x3 //If P3 is the hot potato
	ori   $t0, $zero, 0x4
	ori   $a0, $zero, 0x34 //Set x
	ori   $a1, $zero, 0xc0 //Set y
	bne   $v0, $t0, 0x3 //If P4 is the hot potato
	nop
	ori   $a0, $zero, 0xcc //Set x
	ori   $a1, $zero, 0xc0 //Set y

	jal    0x800577d0 //Run function to display text and int
	nop

	lw   $ra, 0x20($sp)
	jr    $ra
	addi   $sp, $sp, 0x30
	]
mk64rom.insert_code(codeblock_addr, function_display_countdown)
function_display_countdown_addr_str = str(hex(codeblock_addr + mk64rom.rom_to_ram))
codeblock_addr = codeblock_addr + len(function_display_countdown)*4


//This function handles hit detection for all battle modes
//Returns player who was hit as a byte at 0x80102100
function_hit_detection = [
	//Check each player's balloon count, if player has two balloons, set them back to three and make that player the hot potato
	ori   $a3, $zero, 0x1 //set counter to 1
	ori   $a1, $zero, 0x0001 //Load 2 balloons into $a1 for comparison
	lui   $a0, 0x8019 //Load player balloon memory location
	addiu   $a0, $a0, 0xd8c0
	lhu   $a2, 0x0000($a0) //DO
	bne   $a2, $a1, 0x4 //If ballons == 2, run the following code
	ori   $a2, $zero, 0x2 //Set balloons back to 3
	sh   $a2, 0x0000($a0)
	lui   $a2, 0x8010
	sb   $a3, 0x2100($a2) //Set player to be the hot potato (stored in RAM at 0x80102100 + $a3)
	addiu   $a0, $a0, 0x2 //add offset for next player's balloon count mem. location
	ori   $a2, $zero, 0x4
	bne   $a3, $a2, 0xfff7 //WHILE $A3 <= 0x4
	addiu   $a3, $a3, 0x1 //$A3 = A3 + 1

	jr    $ra
	nop
]
mk64rom.insert_code(codeblock_addr, function_hit_detection)
function_hit_detection_addr_str = str(hex(codeblock_addr + mk64rom.rom_to_ram))
codeblock_addr = codeblock_addr + len(function_hit_detection)*4


//This function processes hits and decrements 1 HP
//$A0 = player to decrement HP for, P1 = 0, P2 = 1, P3 =2, P4 = 4
function_process_hit = [
	addi   $sp, $sp, 0xffd0 //Store registers
	sw   $a0, 0x20($sp)
	sw   $a1, 0x24($sp)
	sw   $a2, 0x28($sp)
	sw   $a3, 0x2c($sp)


	lui   $a1, 0x8010 //Subtract or add 1 HP from player number stored in $a0
	ori   $a1, $a1, 0x2002
	sll   $a0, $a0, 0x1 //Mutiply $A0 by 2
	addu   $a1, $a1, $a0
	lhu   $a2, 0x0000($a1)
	lui   $v0, 0x8010
	lbu   $v0, 0x211b($v0)
	bne   $v0, $zero, 0x2 //If scoring is stock,
	nop
	addi   $a2, $a2, 0xffff //Subtract 1 HP
	beq   $v0, $zero, 0x2 //If scoring is timer
	nop
	addi   $a2, $a2, 0x1 //Add 1 hit
	sh   $a2, 0x0000($a1)
	lw   $a0, 0x20($sp)
	lw   $a1, 0x24($sp)
	lw   $a2, 0x28($sp)
	lw   $a3, 0x2c($sp)
	jr    $ra
	addi   $sp, $sp, 0x30
]
mk64rom.insert_code(codeblock_addr, function_process_hit)
function_process_hit_addr_str = str(hex(codeblock_addr + mk64rom.rom_to_ram))
codeblock_addr = codeblock_addr + len(function_process_hit)*4



//This function checks if a player's HP is set to some value (normally zerozero and if it is, kills said player
//$A0 = player to decrement HP for, P1 = 0, P2 = 1, P3 =2, P4 = 4
function_check_if_zero_hp = [
	addi   $sp, $sp, 0xffd0 //Store registers
	sw   $a0, 0x20($sp)
	sw   $a1, 0x24($sp)
	sw   $a2, 0x28($sp)
	sw   $a3, 0x2c($sp)

	lui   $a1, 0x8010 //Load current player's HP
	ori   $a1, $a1, 0x2002
	sll   $a2, $a0, 0x1 //Mutiply $A0 by 2
	addu   $a1, $a1, $a2
	lhu   $a2, 0x0000($a1)
	bne   $a2, $zero, 0x11 //kill player if their HP = 0
	ori   $a2, $zero, 0xdd8 //Calculate offset between player structures and store offset in $a3
	mult   $a0, $a2
	mflo  $a3
	lui   $a1, 0x8019
	addiu   $a1, $a1, 0xd8c0
	addu   $a1, $a1, $a0
	addu   $a1, $a1, $a0
	ori   $a2, $zero, 0xffff
	sh   $a2, 0x0000($a1)
	lui   $a1, 0x800f
	addiu   $a1, $a1, 0x699c
	addu   $a1, $a1, $a3
	ori   $a2, $zero, 0x04 //Turn the player into a bomb/invisible
	sb   $a2, 0x0000($a1) //Store initially at 800F699C for P1
	addiu   $a1, $a1, 0x1
	ori   $a2, $zero, 0x40 //Explode the player
	sb   $a2, 0x0000($a1) //Store initially at 800F699D for P1

	lw   $a0, 0x20($sp)
	lw   $a1, 0x24($sp)
	lw   $a2, 0x28($sp)
	lw   $a3, 0x2c($sp)
	jr    $ra
	addi   $sp, $sp, 0x30
]
mk64rom.insert_code(codeblock_addr, function_check_if_zero_hp)
function_check_if_zero_hp_addr_str = str(hex(codeblock_addr + mk64rom.rom_to_ram))
codeblock_addr = codeblock_addr + len(function_check_if_zero_hp)*4



//This function handles everything for team dath match mode
function_test_mode = [
	addi   $sp, $sp, 0xffd0 //Store registers
	sw   $ra, 0x20($sp)


	'jal '+func_deadhamster_test_codeaddr_str, //Test running DeadHamster's custom code
	nop

	// //Hit detection
	// 'jal '+function_hit_detection_addr_str,
	// nop
	// lui   $a1, 0x8010 //Load whoever might have been hit
	// lbu   $a0, 0x2100($a1)
	// beq   $a0, $zero, 0xa //If a player was hit
	// addi   $a0, $a0, 0xffff //Subtract 1 from $a0 to feed into the following
	// ori   $a1, $zero, 0xdd8 //Get player state mem address for forcing lakitu to respawn player
	// mult   $a0, $a1
	// mflo  $a2
	// lui   $a1, 0x800f
	// add   $a1, $a1, $a2
	// ori   $a3, $zero, 0x1 //Set bits for respawning
	// sb   $a3, 0x6a5b($a1) //Store byte to player state to force respawning
	// lui   $a1, 0x8010 //Reset whoever was hit previously to zero
	// sb   $zero, 0x2100($a1)



	lw   $ra, 0x20($sp)
	jr    $ra
	addi  $sp, $sp, 0x30
	]
mk64rom.insert_code(codeblock_addr, function_test_mode)
function_test_mode_addr_str = str(hex(codeblock_addr + mk64rom.rom_to_ram))
codeblock_addr = codeblock_addr + len(function_test_mode)*4




//This function handles everything for traditional battle mode
function_traditional_battle = [
	addi   $sp, $sp, 0xffd0 //Store registers
	sw   $ra, 0x20($sp)

	//Check if stock is off (not timed), and if it is on, then do a check on if HP < 3
	lui   $a2, 0x8010
	lbu   $a2, 0x211b($a2)
	bne   $a2, $zero, 0x5

	//If HP <= 3, and in stock (not timed), just use the game's built in ballons and skip all the custom HP code
	lui   $a0, 0x8010 //Load max hp
	lhu   $a0, 0x2000($a0)
	ori   $a1, $zero, 0x3
	slt   $a2, $a1, $a0
	beq   $a2, $zero, 0x1f

	//If game is starting or restarting, reset HP
	lui   $a0, 0x800f
	lbu   $a1, 0x6990($a0)
	ori   $a2, $zero, 0xe0
	bne   $a1, $a2, 0x5
	nop
	'jal '+function_reset_hp_addr_str,
	nop
	'jal '+function_reset_timer_addr_str,
	nop

	//Hit detection, HP, and killing player handling
	'jal '+function_hit_detection_addr_str,
	nop
	lui   $a1, 0x8010 //Load whoever might have been hit
	lbu   $a0, 0x2100($a1)
	beq   $a0, $zero, 0x7 //If a player was hit
	addi   $a0, $a0, 0xffff //Subtract 1 from $a0 to feed into the following functions
	'jal '+function_process_hit_addr_str, //Subtract 1 HP from player that is the hot potato
	nop
	lui   $a2, 0x8010 //Check if stock is on (not timed), and if it is on, check if player has HP=0
	lbu   $a2, 0x211b($a2)
	bne   $a2, $zero, 0x3
	nop
	'jal '+function_check_if_zero_hp_addr_str, //kill player if their HP = 0
	nop
	lui   $a1, 0x8010
	sb   $zero, 0x2100($a1) //Reset who was hit to zero

	//DISPLAY HP and run the time scoring (if it is selected as an option)
	lui   $a1, 0x800f //Only run counter and display HP and countdown when not paused (game tempo is zero or less)
	lbu   $a1, 0xa16c($a1)
	bne   $a1, $zero, 0x7
	nop
	jal    0x80057710 //Load font
	nop
	'jal '+function_display_hp_addr_str, //Display HP
	nop
	'jal '+function_process_time_scoring_addr_str, //Display timer (if in a time match)
	nop


	lw   $ra, 0x20($sp)
	jr    $ra
	addi  $sp, $sp, 0x30
	]
mk64rom.insert_code(codeblock_addr, function_traditional_battle)
function_traditional_battle_addr_str = str(hex(codeblock_addr + mk64rom.rom_to_ram))
codeblock_addr = codeblock_addr + len(function_traditional_battle)*4






//This function handles everything for hot potato battle mode
function_hot_potato = [
	addi  $sp, $sp, 0xffd0 //Store registers
	sw    $ra, 0x20($sp)


	// //Check each player's balloon count, if player has two balloons, set them back to three and make that player the hot potato
	'jal '+function_hit_detection_addr_str,
	nop
	//First turn off smoke for all players so that if a player is no longer the hot potato, the smoke will stop
	lui   $a0, 0x800f
	sb    $zero, 0x6a5a($a0)
	sb    $zero, 0x7832($a0)
	lui   $a0, 0x8010
	sb    $zero, 0x860a($a0)
	sb    $zero, 0x93e2($a0)
	//Make whoever is the hot potato smoke
	lui   $a0, 0x8010 //Load who is hot potato
	lbu   $a0, 0x2100($a0)
	beq   $a0, $zero, 0x8 //Run code only if someone actually is the hot potato
	ori   $a1, $zero, 0xdd8 //Set offset for player state storing if they smoke
	multu $a1, $a0 //Multiply offset by which player is smoking
	mflo  $a1
	lui   $a0, 0x800f
	ori   $a0, $a0, 0x5c82 //Would be 0x800F6A5A but have to subtract offset 0xDD8
	addu  $a0, $a0, $a1 //$a0 = memory address for player state storing if player is smoking
	ori   $a1, $zero, 0x10 //Set player who is hot potato to smoke
	sb    $a1, 0x0000($a0)

	//If timer less than zero, kill whoever is the hot potato and then reset the timer (note this sets the balloons to 0 and turns a person invisible/into a bomb)
	lui   $a1, 0x8010
	lh    $a1, 0x2104($a1)
	slt   $a1, $a1, $zero
	beq   $a1, $zero, 0x17 //If  custom timer is less than zero...
	lui   $a0, 0x8010 //Load who is the hot potato and store in $a0
	lbu   $a0, 0x2100($a0)
	addi  $a0, $a0, 0xffff
	ori   $a2, $zero, 0xdd8 //Calculate offset between player structures and store offset in $a3
	mult  $a0, $a2
	mflo  $a3
	'jal '+function_process_hit_addr_str, //Subtract 1 HP from player that is the hot potato
	nop
	// lui   $a1, 0x8010 //Subtract 1 HP from player that is the hot potato
	// ori   $a1, $a1, 0x2001
	// addu   $a1, $a1, $a0
	// lbu   $a2, 0x0000($a1)
	// addi   $a2, $a2, 0xffff
	// sb   $a2, 0x0000($a1)
	lui   $a2, 0x8010 //Check if stock is on (not timed), and if it is on, check if player has HP=0
	lbu   $a2, 0x211b($a2)
	bne   $a2, $zero, 0x3
	nop
	'jal '+function_check_if_zero_hp_addr_str, //kill player if their HP = 0
	nop
	// bne   $a2, $zero, 0xe //kill player if their HP = 0
	// lui   $a1, 0x8019
	// addiu   $a1, $a1, 0xd8c0
	// addu   $a1, $a1, $a0
	// addu   $a1, $a1, $a0
	// ori   $a2, $zero, 0xffff
	// sh   $a2, 0x0000($a1)
	// lui   $a1, 0x800f
	// addiu   $a1, $a1, 0x699c
	// addu   $a1, $a1, $a3
	// ori   $a2, $zero, 0x04 //Turn the player into a bomb/invisible
	// sb   $a2, 0x0000($a1) //Store initially at 800F699C for P1
	// addiu   $a1, $a1, 0x1
	// ori   $a2, $zero, 0x40 //Explode the player
	// sb   $a2, 0x0000($a1) //Store initially at 800F699D for P1
	lui   $a1, 0x800f //Make player who is hot potato lightning strink for a split second to indicate the hit
	ori   $a1, $a1, 0x6a4c
	addu  $a1, $a1, $a3
	ori   $a2, $zero, 0x40
	sb    $a2, 0x0000($a1)
	lui   $a0, 0x8010 //Set who his hot back to nothing
	sb    $zero, 0x2100($a0)
	lh    $a1, 0x2108($a0) //Reset timer to default value
	sh    $a1, 0x2104($a0)

	//If game is starting or restarting, force counter to starting value and ensure nobody is the hot potato
	lui   $a0, 0x800f
	lbu   $a1, 0x6990($a0)
	ori   $a2, $zero, 0xe0
	bne   $a1, $a2, 0x7
	nop
	'jal '+function_reset_hp_addr_str,
	nop
	'jal '+function_reset_timer_addr_str,
	nop
	lui   $a0, 0x8010 //Set who is the hot potato back to nothing
	sb    $zero, 0x2100($a0)

	lui   $a0, 0x8010 //If nobody is the hot potato, reset timer to default value
	lbu   $a1, 0x2100($a0)
	bne   $a1, $zero, 0x2
	lh    $a1, 0x2108($a0) //Reset timer to default
	sh    $a1, 0x2104($a0)

	//DISPLAY HP and run the time scoring (if it is selected as an option)
	lui   $a1, 0x800f //Only run counter and display HP and countdown when not paused (game tempo is zero or less)
	lbu   $a1, 0xa16c($a1)
	bne   $a1, $zero, 0xc
	nop

 	//Load font
	jal    0x80057710
	nop

	//Display HP
	'jal '+function_display_hp_addr_str,
	nop

	//Display Countdown
	lui   $v0, 0x8010 //Load who is hot potato
	lbu   $v0, 0x2100($v0)
	beq   $v0, $zero, 0x3 //If someone is the hot potato, display the counter
	nop
	'jal '+function_display_countdown_addr_str,
	nop

	//Display timer (if in a time match)
	'jal '+function_process_time_scoring_addr_str,
	nop

	lw    $ra, 0x20($sp)
	jr    $ra
	addi  $sp, $sp, 0x30
]
mk64rom.insert_code(codeblock_addr, function_hot_potato)
function_hot_potato_addr_str = str(hex(codeblock_addr + mk64rom.rom_to_ram))
codeblock_addr = codeblock_addr + len(function_hot_potato)*4








display_code = [
	addiu   $sp, $sp, 0xffdc //Store registers
	sw   $a0, 0x0010($sp)
	sw   $a1, 0x0014($sp)
	sw   $a2, 0x0018($sp)
	sw   $a3, 0x001c($sp)
	sw   $ra, 0x0020($sp)
	sw   $t0, 0x0024($sp)

	//If courses are set to flat, make all item boxes the same height off the ground
	lui   $a0, 0x8010
	lbu   $a0, 0x2116($a0)
	beq   $a0, $zero, 0x1a //If set to on
	lui   $a0, 0x8015 //Load beginning of item array
	ori   $a0, $a0, 0xf9b8
	lui   $a1, 0x8016 //Load end of item array
	ori   $a1, $a1, 0x2578
	lui   $a2, 0x800e //Check if course is Big donut or Skyscraper and set item box height accordingly, Grab current course from 0x800DC5A0
	lbu   $a2, 0xc5a1($a2)
	ori   $a3, $zero, 0x13
	bne   $a2, $a3, 0x2
	lui   $t0, 0x4120 //Force default item box height
	lui   $t0, 0x430d //Item box height for Big Donut
	ori   $a3, $zero, 0x10
	bne   $a2, $a3, 0x2
	nop
	lui   $t0, 0x41a0 //Item box height for Skyscraper
	lhu   $a2, 0x0000($a0) //Check if object is an item box, //DO (loop through entire simple item array)
	ori   $a3, $zero, 0xc
	bne   $a2, $a3, 0x5 //If object is an item box
	lhu   $a2, 0x0006($a0) //Load item box state to check if it is initialized
	ori   $a3, $zero, 0x2 //If item box is initialized
	bne   $a2, $a3, 0x2
	//ori   $a2, $zero, 0x0002 //Force item box to initialize (kill the respawn so it doesn't rise to its normal height)
	//sh   $a2, 0x0006($a0)
	nop
	sw   $t0, 0x001c($a0)
	addiu   $a0, $a0, 0x70
	slt   $a3, $a0, $a1
	bne   $a3, $zero, 0xfff5 //WHILE STILL IN ITME ARRAY
	nop

	//Auto item
	lui   $a0, 0x8010
	lb    $a1, 0x2117($a0)
	beq   $a1, $zero, 0x11 //If auto items are on
	lb    $a0, 0x2115($a0) //If inf. green shells are off, randomly assign items
 	bne   $a0, $zero, 0xf
 	lui   $a2, 0x802c //Load byte from RNG into $a2
	lbu   $a2, 0xa290($a2)
	sra   $a2, $a2, 0x1 //Divide RNG value by two to double the probabilitiy of getting an item
	lui   $a0, 0x8016 //Load base for player has an item memory loc.
	ori   $a0, $a0, 0x5f5f
	ori   $a1, $zero, 0x50
	//DO
	bne   $a1, $a2, 0x5 //If RNG value == something
	addi  $a1, $a1, 0x1
	lbu   $a1, 0x0000($a0)
	bne   $a1, $zero, 0x2 //Check if player already has item, if not...
	ori   $a3, $zero, 0x1
	sb    $a3, 0x0000($a0) //Randomly give player item
	lui   $a3, 0x8016
	ori   $a3, $a3, 0x63bf
	//WHILE $a0 < $a3
	bne   $a0, $a3, 0xfff7
	addi  $a0, $a0, 0xe0 //Increment Player has an item memory loc.


	//Run battle bots if they are set to on
	lui   $a1, 0x8010 //P1
	lbu   $a1, 0x20d0($a1)
	beq   $a1, $zero, 0x3
	ori   $a0, $zero, 0x0
	'jal '+function_run_battle_bot_addr_str,
	nop
	lui   $a1, 0x8010 //P2
	lbu   $a1, 0x20d1($a1)
	beq   $a1, $zero, 0x3
	ori   $a0, $zero, 0x1
	'jal '+function_run_battle_bot_addr_str,
	nop
	lui   $a1, 0x8010 //P3
	lbu   $a1, 0x20d2($a1)
	beq   $a1, $zero, 0x3
	ori   $a0, $zero, 0x2
	'jal '+function_run_battle_bot_addr_str,
	nop
	lui   $a1, 0x8010 //P4
	lbu   $a1, 0x20d3($a1)
	beq   $a1, $zero, 0x3
	ori   $a0, $zero, 0x3
	'jal '+function_run_battle_bot_addr_str,
	nop

	// //Activate music in 3P & 4P mode if it is set to on
	lui   $a0, 0x8010
	lb   $a0, 0x2113($a0)
	beq   $a0, $zero, 0x7 //If set to on
	lui   $a0, 0x8029
	lui   $a1, 0x240e
	ori   $a1, $a1, 0x0001
	sw   $a1, 0xec9c($a0)
	lui   $a1, 0x2409
	ori   $a1, $a1, 0x0001
	sw   $a1, 0xf9c4($a0)

	//Ludicrious speed (top speed is set to 0x45000000)
	lui   $a0, 0x8010
	lb    $a0, 0x211c($a0)
	beq   $a0, $zero, 0x7 //If set to on
	ori   $a2, $zero, 0x4500 //Set top speed
	lui   $a0, 0x800f //Update top speeds for four players
	sh    $a2, 0x6ba4($a0)
	sh    $a2, 0x797c($a0)
	lui   $a0, 0x8010
	sh    $a2, 0x8754($a0)
	sh    $a2, 0x952c($a0)

	//If any player has a blue shell, replace it with triple red shells, for those rare instances someone picks one up from a course item box
	lui   $a0, 0x8016
	ori   $a1, $zero, 0x7 //Blue shell value
	ori   $a2, $zero, 0x6 //Triple red shell value
	lbu   $a3, 0x5f5d($a0) //P1 1&2P modes
	bne   $a3, $a1, 0x3
	lbu   $a3, 0x603d($a0)
	sb    $a2, 0x5f5d($a0)
	sb    $a2, 0x5f8a($a0)
	bne   $a3, $a1, 0x3 //P2 1&2P modes
	lbu   $a3, 0x611d($a0)
	sb    $a2, 0x603d($a0)
	sb    $a2, 0x606a($a0)
	bne   $a3, $a1, 0x3 //P1 3&4P modes
	lbu   $a3, 0x61fd($a0)
	sb    $a2, 0x611d($a0)
	sb    $a2, 0x614a($a0)
	bne   $a3, $a1, 0x3 //P2 3&4P modes
	lbu   $a3, 0x62dd($a0)
	sb    $a2, 0x61fd($a0)
	sb    $a2, 0x622a($a0)
	bne   $a3, $a1, 0x3 //P3 3&4P modes
	lbu   $a3, 0x63bd($a0)
	sb    $a2, 0x622d($a0)
	sb    $a2, 0x630a($a0)
	bne   $a3, $a1, 0x3 //P4 3&4P modes
	nop
	sb    $a2, 0x63bd($a0)
	sb    $a2, 0x63ea($a0)


	//Run traditional battle mode if it is selected
	lui   $a0, 0x8010
	lbu   $a0, 0x211a($a0) //0x8010211A - 1 byte - Game mode (0=traditional, 1=hot potato, and so on and so forth...)
	ori   $a1, $zero, 0x0
	bne   $a0, $a1, 0x3
	nop
	'jal '+function_traditional_battle_addr_str,
	nop
	//Run hot potato mode if it is selected
	lui   $a0, 0x8010
	lbu   $a0, 0x211a($a0) //0x8010211A - 1 byte - Game mode (0=traditional, 1=hot potato, and so on and so forth...)
	ori   $a1, $zero, 0x1
	bne   $a0, $a1, 0x3
	nop
	'jal '+function_hot_potato_addr_str,
	nop
	//Run test mode mode if it is selected
	lui   $a0, 0x8010
	lbu   $a0, 0x211a($a0) //0x8010211A - 1 byte - Game mode (0=traditional, 1=hot potato, and so on and so forth...)
	ori   $a1, $zero, 0x2
	bne   $a0, $a1, 0x3
	nop
	'jal '+function_test_mode_addr_str,
	nop

	// //If a battle course, just use the default intializations, otherwise use the one for big donut
	// lui   $a1, 0x800e //Load current track from cup course index 0x8018EE0B
	// lbu   $a1, 0xc5a1($a1)
	// ori   $a0, $zero, 0x13 //Check if Big Donut, if it is, skip the rest of this
	// beq   $a1, $a0, 0xe
	// ori   $a0, $zero, 0x11 //check if double deck, if it is, skip the rest of this
	// beq   $a1, $k0, 0xc
	// ori   $a0, $zero, 0x10 //check if Skyscraper, if it is, skip the rest of this
	// beq   $a1, $a0, 0xa
	// ori   $a0, $zero, 0xf //check if block Fort, if it is, skip the rest of this
	// beq   $a1, $a0, 0x8
	// //Force mode to be battle mode
	// ori   $v1, $zero, 0x3
	// //If paused, force mode to be VS mode
	// lui   $a1, 0x800f
	// lbu   $a1, 0xa16c($a1)
	// beq   $a1, $zero, 0x4
	// nop
	// ori   $v1, $zero, 0x2
	// lui   $a0, 0x800e //Store byte for VS or battle mode
	// sh   $v1, 0xc53e($a0)

	lw    $a0, 0x0010($sp)
	lw    $a1, 0x0014($sp)
	lw    $ra, 0x0020($sp)
	lw    $t0, 0x0024($sp)
	lui   $a3, 0x800e //If number of players is 2 at 0x800DC538
	lbu   $a3, 0xc53b($a3)
	ori   $a2, $zero, 0x0002
	bne   $a2, $a3, 0x6
	lw    $a2, 0x0018($sp) //Shove a load register into the delay slot here just to be efficient
	lw    $a3, 0x001c($sp) //Ran last load register we need
	0x3C0B800E, //Replacement hook code
	0x8D6BC5E8,
	'J '+return_to_hook_address_2p,
	addiu $sp, $sp, 0x24 //Load registers no longer used
	0x3C02800E, //Replacement hook code
	0x8C42C5E8,
	'J '+return_to_hook_address_3p_4p,
	addiu $sp, $sp, 0x24 //Load registers no longer used
]


mk64rom.insert_code(codeblock_addr, display_code)


// hook_addr = 0x28E0 //Use Rena's hook for battle mode 3&4P
// replaced_hook_code = [0x3C0B800E, 0x956BC5B0]
hook_addr = 0x28F8
//Hook into 3&4P battle mode
code = ['j ' + hex(codeblock_addr+dmaed_code_rom_to_ram), 'nop']
mk64rom.insert_code(hook_addr, code)



//replaced_hook_code = [0x3C02800E, 0x8C42C5E8]

//mk64rom.insert_codeblock(hook_addr, codeblock_addr , display_code + replaced_hook_code)
hook_addr = 0x269C //Use Rena's hook for battle mode 2P
//Hook into 2P battle mode
code = ['j ' + hex(codeblock_addr+dmaed_code_rom_to_ram), 'nop']
mk64rom.insert_code(hook_addr, code)
//replaced_hook_code = [0x3C0B800E, 0x8D6BC5E8]
//mk64rom.insert_codeblock(hook_addr, codeblock_addr,  display_code + replaced_hook_code)

//codeblock_addr = codeblock_addr + len(display_code)*4 + 16
codeblock_addr = codeblock_addr + len(display_code)*4


//Function display menu option with ON/OFF
//$A1 = y position
//$A2 = text pointer
//$A3 = Status byte
func_disp_menu_onoff = [
	ori   $a0, $zero, 0x3c //$A0 is the X pos
	addi   $sp, $sp, 0xffe0 //Store registers in stack so I can save them while running disp text function
	sw   $a0, 0x0010($sp)
	sw   $a1, 0x0014($sp)
	sw   $ra, 0x001c($sp)
	jal    0x800577a4 //Display text [SOMETHING IS WRONG WITH RUNNING THIS FUNCTION HERE AND I DONT KNOW WHAT]
	sw   $a3, 0x0018($sp)
	lw   $a0, 0x0010($sp) //Load the registers back out of the stack
	lw   $a1, 0x0014($sp)
	lw   $a3, 0x0018($sp)
	lui   $a2, 0x800f //text pointer for "OFF"
	addiu   $a2, $a2, 0xb840
	beq   $a3, $zero, 0x2 //Move pointer to "ON if the item status = 1"
	nop
	addi   $a2, $a2, 0x4
	jal    0x800577a4 //Run function to display text
	addi   $a0, $a0, 0x88 //$A0 is the X pos (same as input + 0x84)
	lw   $ra, 0x001c($sp)
	jr    $ra
	// jr    $s2
	addi   $sp, $sp, 0x20
	]
mk64rom.insert_code(codeblock_addr, func_disp_menu_onoff)
func_disp_menu_onoff_addr_str = str(hex(codeblock_addr + dmaed_code_rom_to_ram))
// print('func_disp_menu_onoff_addr_str = ', func_disp_menu_onoff_addr_str)
// print('codeblock_addr = ', hex(codeblock_addr))
codeblock_addr = codeblock_addr + len(func_disp_menu_onoff)*4





//Function plays menu move curisor sound
func_play_menu_sound = [
	addi   $sp, $sp, 0xffdc //Store registers in stack
	sw   $a0, 0x0010($sp)
	sw   $a1, 0x0014($sp)
	sw   $a2, 0x0018($sp)
	sw   $a3, 0x001c($sp)
	sw   $ra, 0x0020($sp)
	lui   $a0, 0x4900 //Load sound ID for menu cursor move
	jal    0x800c8e10 //Run function soundPlay2
	ori   $a0, $a0, 0x8000
	lw   $a0, 0x0010($sp) //Load registers from stack
	lw   $a1, 0x0014($sp)
	lw   $a2, 0x0018($sp)
	lw   $a3, 0x001c($sp)
	lw   $ra, 0x0020($sp)
	jr    $ra
	addi   $sp, $sp, 0x24 //Load registers from stack
]
mk64rom.insert_code(codeblock_addr, func_play_menu_sound)
func_play_menu_sound_addr_str = str(hex(codeblock_addr + dmaed_code_rom_to_ram))
codeblock_addr = codeblock_addr + len(func_play_menu_sound)*4


//Function handles toggling the countdown up or down in the menu
//A0 = Menu item status pointer
//A1 = Joystick value
//A2 = Menu item index
//A3 = Current menu index selected
func_menu_toggle_countdown = [
	//If menu selection is Countdown
	bne   $a3, $a2, 0x12
	lui   $a2, 0x8010 //Load countdown timer default
	lh   $a0, 0x2108($a2)
	ori   $a2, $zero, 0x2 //If joystick was left
	bne   $a1, $a2, 0x3
	nop
	addi   $a0, $a0, 0xfed4 //Subtract 5 seconds
	ori   $a1, $zero, 0x4 //Set menu selection in progress byte to state indicating the selection has finished
	ori   $a2, $zero, 0x1 //If joystick was right
	bne   $a1, $a2, 0x3
	nop
	addi   $a0, $a0, 0x12c //Add 5 seconds
	ori   $a1, $zero, 0x4 //Set menu selection in progress byte to state indicating the selection has finished
	//if countdown default too low, reset to min
	slti  $a2, $a0, 0x0000
	beq   $a2, $zero, 0x2
	nop
	ori   $a0, $zero, 0x0
	lui   $a2, 0x8010 //Store updated countdown timer default
	sh   $a0, 0x2108($a2)

	jr    $ra
	nop
]
mk64rom.insert_code(codeblock_addr, func_menu_toggle_countdown)
func_menu_toggle_countdown_addr_str = str(hex(codeblock_addr + dmaed_code_rom_to_ram))
codeblock_addr = codeblock_addr + len(func_menu_toggle_countdown)*4



//Function handles toggling the timer up or down in the menu for deathmatch mode
//A0 = Menu item status pointer
//A1 = Joystick value
//A2 = Menu item index
//A3 = Current menu index selected
func_menu_toggle_timer = [
	//If menu selection is Countdown
	bne   $a3, $a2, 0x12
	lui   $a2, 0x8010 //Load timer default
	lw   $a0, 0x2010($a2)
	ori   $a2, $zero, 0x2 //If joystick was left
	bne   $a1, $a2, 0x3
	nop
	addi   $a0, $a0, 0xf1f0 //Subtract 60 seconds
	ori   $a1, $zero, 0x4 //Set menu selection in progress byte to state indicating the selection has finished
	ori   $a2, $zero, 0x1 //If joystick was right
	bne   $a1, $a2, 0x3
	nop
	addi   $a0, $a0, 0xe10 //Add 60 seconds
	ori   $a1, $zero, 0x4 //Set menu selection in progress byte to state indicating the selection has finished
	//if timer default too low, reset to min
	slti  $a2, $a0, 0xe10
	beq   $a2, $zero, 0x2
	nop
	ori   $a0, $zero, 0xe10
	lui   $a2, 0x8010 //Store updated countdown timer default
	sw   $a0, 0x2010($a2)

	jr    $ra
	nop
]
mk64rom.insert_code(codeblock_addr, func_menu_toggle_timer)
func_menu_toggle_timer_addr_str = str(hex(codeblock_addr + dmaed_code_rom_to_ram))
codeblock_addr = codeblock_addr + len(func_menu_toggle_timer)*4


//Function handles toggling HP up or down in the menu
//A0 = Menu item status pointer
//A1 = Joystick value
//A2 = Menu item index
//A3 = Current menu index selected
func_menu_toggle_hp = [
	// //If menu selection is HP
	bne   $a3, $a2, 0x16
	lui   $a2, 0x8010 //Load max HP
	lhu   $a0, 0x2000($a2)
	ori   $a2, $zero, 0x2 //If joystick was left
	bne   $a1, $a2, 0x3
	nop
	addi   $a0, $a0, 0xffff //Subtract 1 HP
	ori   $a1, $zero, 0x4 //Set menu selection in progress byte to state indicating the selection has finished
	ori   $a2, $zero, 0x1 //If joystick was right
	bne   $a1, $a2, 0x3
	nop
	addi   $a0, $a0, 0x1 //Add 1 HP
	ori   $a1, $zero, 0x4 //Set menu selection in progress byte to state indicating the selection has finished
	//if HP too low, reset to min
	addi   $a2, $zero, 0x0
	bne   $a0, $a2, 0x2
	nop
	ori   $a0, $zero, 0x3e7
	//If HPis too high, reset to max
	ori   $a2, $zero, 0x3e8
	bne   $a0, $a2, 0x2
	nop
	ori   $a0, $zero, 0x1
	lui   $a2, 0x8010 //Store updated max HP
	sh   $a0, 0x2000($a2)

	jr    $ra
	nop
]
mk64rom.insert_code(codeblock_addr, func_menu_toggle_hp)
func_menu_toggle_hp_addr_str = str(hex(codeblock_addr + dmaed_code_rom_to_ram))
codeblock_addr = codeblock_addr + len(func_menu_toggle_hp)*4




//Function handles toggling HP up or down in the menu
//A0 = Menu item status pointer
//A1 = Joystick value
//A2 = Menu item index
//A3 = Current menu index selected
func_menu_toggle_score = [
	// //If menu selection is score
	bne   $a3, $a2, 0x16
	lui   $a2, 0x8010 //Load max score
	lbu   $a0, 0x2005($a2)
	ori   $a2, $zero, 0x2 //If joystick was left
	bne   $a1, $a2, 0x3
	nop
	addi   $a0, $a0, 0xffff //Subtract a score
	ori   $a1, $zero, 0x4 //Set menu selection in progress byte to state indicating the selection has finished
	ori   $a2, $zero, 0x1 //If joystick was right
	bne   $a1, $a2, 0x3
	nop
	addi   $a0, $a0, 0x1 //Add a score
	ori   $a1, $zero, 0x4 //Set menu selection in progress byte to state indicating the selection has finished
	//if score too low, reset to min
	addi   $a2, $zero, 0x0
	bne   $a0, $a2, 0x2
	nop
	ori   $a0, $zero, 0x63
	//If score is too high, reset to max
	ori   $a2, $zero, 0x64
	bne   $a0, $a2, 0x2
	nop
	ori   $a0, $zero, 0x1
	lui   $a2, 0x8010 //Store updated max score
	sb   $a0, 0x2005($a2)

	jr    $ra
	nop
]
mk64rom.insert_code(codeblock_addr, func_menu_toggle_score)
func_menu_toggle_score_addr_str = str(hex(codeblock_addr + dmaed_code_rom_to_ram))
codeblock_addr = codeblock_addr + len(func_menu_toggle_score)*4






//Function handles toggling an option on/off in the menu
//A0 = Menu item status pointer
//A1 = Joystick value
//A2 = Menu item index
//A3 = Current menu index selected
func_menu_toggle_onoff = [
	bne   $a3, $a2, 0xb //If menu selection is this
	ori   $a2, $zero, 0x1 //If joystick was right
	beq   $a1, $a2, 0x5
	ori   $a2, $zero, 0x2 //If joystick was left
	beq   $a1, $a2, 0x3
	nop
	beq   $zero, $zero, 0x5 //If joystick was something else, just skip the rest of the code
	nop
	ori   $a1, $zero, 0x4 //Set menu selection in progress byte to state indicating the selection has finished
	lbu   $a2, 0x0000($a0) //Load item status
	nor   $a2, $a2, $zero //Not instruction to flip the bit in $A0
	sb   $a2, 0x0000($a0)
	jr    $ra
	nop
]
mk64rom.insert_code(codeblock_addr, func_menu_toggle_onoff)
func_menu_toggle_onoff_addr_str = str(hex(codeblock_addr + dmaed_code_rom_to_ram))
codeblock_addr = codeblock_addr + len(func_menu_toggle_onoff)*4



//Function display HP menu item
//$A1 = y position
func_menu_disp_score = [
	addi   $sp, $sp, 0xffdc //Store registers in stack
	sw   $ra, 0x0020($sp)

	lui   $a3, 0x8010 //Load max score
	lbu   $a3, 0x2005($a3)
	lui   $a2, 0x800f //text pointer for "MAX SCORE"
	addiu   $a2, $a2, 0xb9f8
	jal    0x800577d0 //Run function to display int
	ori   $a0, $zero, 0x50 //$A0 is the X pos

	lw   $ra, 0x0020($sp)
	jr    $ra
	addi   $sp, $sp, 0x24 //Load registers from stack
]
mk64rom.insert_code(codeblock_addr, func_menu_disp_score)
func_menu_disp_score_addr_str = str(hex(codeblock_addr + dmaed_code_rom_to_ram))
codeblock_addr = codeblock_addr + len(func_menu_disp_score)*4


//Function displays the scoring menu item
//$A1 = y position
func_menu_disp_scoring = [
	addi   $sp, $sp, 0xffdc //Store registers in stack
	sw   $ra, 0x0020($sp)
	sw   $a1, 0x0024($sp)

	//Display "SCORING"
	lui   $a2, 0x800f //text pointer = 800EF810 for "HP", //Display HP P1
	addiu   $a2, $a2, 0xba0c
	ori   $a0, $zero, 0x3c //$A0 is the X pos
	jal    0x800577a4 //Print text
	lw   $a1, 0x0024($sp) //$A1 is the Y pos
	//Display exactly what scoring mode (stored at 0x8010211A) is selected
	lui   $a0, 0x8010
	lbu   $a0, 0x211b($a0)
	//Set to Stock
	bne   $a0, $zero, 0x3
	nop
	lui   $a2, 0x800f //text pointer
	addiu   $a2, $a2, 0xba14
	//Set to Time
	beq   $a0, $zero, 0x3
	nop
	lui   $a2, 0x800f //text pointer
	addiu   $a2, $a2, 0xba1c
	//Actually show the selected option
	lw   $a1, 0x0024($sp)
	jal    0x800577a4 //Print text
	ori   $a0, $zero, 0x88 //$A0 is the X pos

	lw   $ra, 0x0020($sp)
	jr    $ra
	addi   $sp, $sp, 0x24 //Load registers from stack
]
mk64rom.insert_code(codeblock_addr, func_menu_disp_scoring)
func_menu_disp_scoring_addr_str = str(hex(codeblock_addr + dmaed_code_rom_to_ram))
codeblock_addr = codeblock_addr + len(func_menu_disp_scoring)*4


//Function display HP menu item
//$A1 = y position
func_menu_disp_menu_hp = [
	addi   $sp, $sp, 0xffdc //Store registers in stack
	sw   $ra, 0x0020($sp)

	lui   $a3, 0x8010 //Load max HP from 0x80102000
	lhu   $a3, 0x2000($a3)
	lui   $a2, 0x800f //text pointer = 800EF810 for "HP", //Display HP P1
	addiu   $a2, $a2, 0xb810
	// ori   $a1, $zero, 0x30 //$A1 is the Y pos
	jal    0x800577d0 //Run function to display int
	ori   $a0, $zero, 0x76 //$A0 is the X pos

	lw   $ra, 0x0020($sp)
	jr    $ra
	addi   $sp, $sp, 0x24 //Load registers from stack
]
mk64rom.insert_code(codeblock_addr, func_menu_disp_menu_hp)
func_menu_disp_menu_hp_addr_str = str(hex(codeblock_addr + dmaed_code_rom_to_ram))
codeblock_addr = codeblock_addr + len(func_menu_disp_menu_hp)*4


//Function display timer menu item
//$A1 = y position
func_menu_disp_menu_timer = [
	addi   $sp, $sp, 0xffdc //Store registers in stack
	sw   $ra, 0x0020($sp)

	lui   $a3, 0x8010 //Load default timer
	lw   $a3, 0x2010($a3)
	ori   $a2, $zero, 0xe10 //Divide timer by 3600 (0xE10) so output display is in minutes
	div   $a3, $a2
	mflo  $a3 //$A3 is the integer to display
	lui   $a2, 0x800f //text pointer
	addiu   $a2, $a2, 0xb9e8
	jal    0x800577d0 //Run function to display int
	ori   $a0, $zero, 0x40 //$A0 is the X pos

	lw   $ra, 0x0020($sp)
	jr    $ra
	addi   $sp, $sp, 0x24 //Load registers from stack
]
mk64rom.insert_code(codeblock_addr, func_menu_disp_menu_timer)
func_menu_disp_menu_timer_addr_str = str(hex(codeblock_addr + dmaed_code_rom_to_ram))
codeblock_addr = codeblock_addr + len(func_menu_disp_menu_timer)*4


//Function display countdown menu item
//$A1 = y position
func_menu_disp_menu_countdown = [
	addi  $sp, $sp, 0xffdc //Store registers in stack
	sw    $ra, 0x0020($sp)

	lui   $a3, 0x8010 //Load default countdown from 0x80102108
	lhu   $a3, 0x2108($a3)
	ori   $a2, $zero, 0x3c //Divide timer by 60 (0x3C) so output display is in secconds
	div   $a3, $a2
	mflo  $a3 //$A3 is the integer to display
	lui   $a2, 0x800f //text pointer = 800EF800 for "COUNTDOWN"
	addiu $a2, $a2, 0xb814
	jal    0x800577d0 //Run function to display int
	ori   $a0, $zero, 0x5d //$A0 is the X pos

	lw    $ra, 0x0020($sp)
	jr    $ra
	addi  $sp, $sp, 0x24 //Load registers from stack
]
mk64rom.insert_code(codeblock_addr, func_menu_disp_menu_countdown)
func_menu_disp_menu_countdown_addr_str = str(hex(codeblock_addr + dmaed_code_rom_to_ram))
codeblock_addr = codeblock_addr + len(func_menu_disp_menu_countdown)*4



//Function displays options for tradiational battle mode on the "GAME" page of menu
func_menu_disp_traditional_mode_on_game_page = [
	addi   $sp, $sp, 0xffdc //Store registers in stack
	sw   $ra, 0x0020($sp)

	//Display scoring menu option
	'jal '+func_menu_disp_scoring_addr_str,
	ori   $a1, $zero, 0x4c //Set y position

	//If SCORING is set to STOCK
	lui   $v0, 0x8010 //Load item status pointer
	lbu   $v0, 0x211b($v0)
	bne   $v0, $zero, 0x3 // //If menu selection is HP
	ori   $a1, $zero, 0x58 //Set y position
	'jal '+func_menu_disp_menu_hp_addr_str,
	nop
	//If SCORING is set to TIME
	beq   $v0, $zero, 0x3 // //If menu selection is timer
	ori   $a1, $zero, 0x58 //Set y position
	'jal '+func_menu_disp_menu_timer_addr_str,
	nop

	// //Display HP menu option
	// 'jal '+func_menu_disp_menu_hp_addr_str,
	// ori   $a1, $zero, 0x4c //Set y position


	//Set max distance you can scroll down in y direction on menu
	ori   $a1, $zero, 0x3
	lui   $a0, 0x8010
	sb   $a1, 0x210f($a0)

	lw   $ra, 0x0020($sp)
	jr    $ra
	addi   $sp, $sp, 0x24 //Load registers from stack
]
mk64rom.insert_code(codeblock_addr, func_menu_disp_traditional_mode_on_game_page)
func_menu_disp_traditional_mode_on_game_page_addr_str = str(hex(codeblock_addr + dmaed_code_rom_to_ram))
codeblock_addr = codeblock_addr + len(func_menu_disp_traditional_mode_on_game_page)*4




//Function displays options for hot potato battle mode on the "GAME" page of menu
func_menu_disp_hot_potato_mode_on_game_page = [
	addi   $sp, $sp, 0xffdc //Store registers in stack
	sw   $ra, 0x0020($sp)

	//Display scoring menu option
	'jal '+func_menu_disp_scoring_addr_str,
	ori   $a1, $zero, 0x4c //Set y position


	//If SCORING is set to STOCK
	lui   $v0, 0x8010 //Load item status pointer
	lbu   $v0, 0x211b($v0)
	bne   $v0, $zero, 0x3 // //If menu selection is HP
	ori   $a1, $zero, 0x58 //Set y position
	'jal '+func_menu_disp_menu_hp_addr_str,
	nop
	//If SCORING is set to TIME
	beq   $v0, $zero, 0x3 // //If menu selection is timer
	ori   $a1, $zero, 0x58 //Set y position
	'jal '+func_menu_disp_menu_timer_addr_str,
	nop


	//Display countdown menu option
	'jal '+func_menu_disp_menu_countdown_addr_str,
	ori   $a1, $zero, 0x64 //Set y position

	//Set max distance you can scroll down in y direction on menu
	ori   $a1, $zero, 0x4
	lui   $a0, 0x8010
	sb   $a1, 0x210f($a0)

	lw   $ra, 0x0020($sp)
	jr    $ra
	addi   $sp, $sp, 0x24 //Load registers from stack
]
mk64rom.insert_code(codeblock_addr, func_menu_disp_hot_potato_mode_on_game_page)
func_menu_disp_hot_potato_mode_on_game_page_addr_str = str(hex(codeblock_addr + dmaed_code_rom_to_ram))
codeblock_addr = codeblock_addr + len(func_menu_disp_hot_potato_mode_on_game_page)*4


//Function displays options for hot potato battle mode on the "GAME" page of menu
func_menu_disp_test_mode_on_game_page = [
	addi   $sp, $sp, 0xffdc //Store registers in stack
	sw   $ra, 0x0020($sp)

	//Display score menu option
	'jal '+func_menu_disp_score_addr_str,
	ori   $a1, $zero, 0x4c //Set y position


	//If SCORING is set to STOCK
	lui   $v0, 0x8010 //Load item status pointer
	lbu   $v0, 0x211b($v0)
	bne   $v0, $zero, 0x3 // //If menu selection is HP
	ori   $a1, $zero, 0x58 //Set y position
	'jal '+func_menu_disp_menu_hp_addr_str,
	nop
	//If SCORING is set to TIME
	beq   $v0, $zero, 0x3 // //If menu selection is timer
	ori   $a1, $zero, 0x58 //Set y position
	'jal '+func_menu_disp_menu_timer_addr_str,
	nop

	// //Display countdown menu option
	// 'jal '+func_menu_disp_menu_timer_addr_str,
	// ori   $a1, $zero, 0x58 //Set y position

	//Set max distance you can scroll down in y direction on menu
	ori   $a1, $zero, 0x3
	lui   $a0, 0x8010
	sb   $a1, 0x210f($a0)



	lw   $ra, 0x0020($sp)
	jr    $ra
	addi   $sp, $sp, 0x24 //Load registers from stack
]
mk64rom.insert_code(codeblock_addr, func_menu_disp_test_mode_on_game_page)
func_menu_disp_test_mode_on_game_page_addr_str = str(hex(codeblock_addr + dmaed_code_rom_to_ram))
codeblock_addr = codeblock_addr + len(func_menu_disp_test_mode_on_game_page)*4




//Function displays "GAME" page of menu
func_menu_disp_game_page = [
	addi   $sp, $sp, 0xffdc //Store registers in stack
	sw   $ra, 0x0020($sp)

	//Display MODE
	lui   $a2, 0x800f //text pointer = 800EF810 for "HP", //Display HP P1
	addiu   $a2, $a2, 0xb8e8
	ori   $a0, $zero, 0x3c //$A0 is the X pos
	jal    0x800577a4 //Print text
	ori   $a1, $zero, 0x40 //$A1 is the Y pos
	//Display exactly what game mode (stored at 0x8010211A) is selected
	lui   $a0, 0x8010
	lbu   $a0, 0x211a($a0)
	sw   $a0, 0x001c($sp) //Store current game mode in the stack for later use
	//Set to Traditional
	bne   $a0, $zero, 0x3
	nop
	lui   $a2, 0x800f //text pointer
	addiu   $a2, $a2, 0xb8dc
	//Set to Hot Potato
	ori   $a1, $zero, 0x1
	bne   $a0, $a1, 0x3
	nop
	lui   $a2, 0x800f //text pointer
	addiu   $a2, $a2, 0xb8d0
	//Set to Test Mode
	ori   $a1, $zero, 0x2
	bne   $a0, $a1, 0x3
	nop
	lui   $a2, 0x800f //text pointer
	addiu   $a2, $a2, 0xb9d8
	//Actually show the selected option
	ori   $a0, $zero, 0x70 //$A0 is the X pos
	jal    0x800577a4 //Print text
	ori   $a1, $zero, 0x40 //$A1 is the Y pos

	//If tradiational battle mode is selected, display only the options for that mode
	lw   $a0, 0x001c($sp) //Load current game mode from stack
	ori   $a1, $zero, 0x0
	bne   $a0, $a1, 0x3
	nop
	'jal '+func_menu_disp_traditional_mode_on_game_page_addr_str,
	nop

	//If hot potato battle mode is selected, display only the options for that mode
	lw   $a0, 0x001c($sp) //Load current game mode from stack
	ori   $a1, $zero, 0x1
	bne   $a0, $a1, 0x3
	nop
	'jal '+func_menu_disp_hot_potato_mode_on_game_page_addr_str,
	nop


	//If test mode battle mode is selected, display only the options for that mode
	lw   $a0, 0x001c($sp) //Load current game mode from stack
	ori   $a1, $zero, 0x2
	bne   $a0, $a1, 0x3
	nop
	'jal '+func_menu_disp_test_mode_on_game_page_addr_str,
	nop


	lw   $ra, 0x0020($sp)
	jr    $ra
	addi   $sp, $sp, 0x24 //Load registers from stack
]
mk64rom.insert_code(codeblock_addr, func_menu_disp_game_page)
func_menu_disp_game_page_addr_str = str(hex(codeblock_addr + dmaed_code_rom_to_ram))
codeblock_addr = codeblock_addr + len(func_menu_disp_game_page)*4


//Function displays "ITEM" page of menu
func_menu_disp_items_page = [
	addi   $sp, $sp, 0xffdc //Store registers in stack
	sw   $ra, 0x0020($sp)

	//Display "BANANA"
	lui   $a2, 0x800f //text pointer
	addiu   $a2, $a2, 0xb834
	lui   $a3, 0x8010 //Load status byte
	lb   $a3, 0x20f0($a3)
	'jal '+func_disp_menu_onoff_addr_str, //Run func_disp_menu_onoff
	ori   $a1, $zero, 0x40 //$A1 is the Y pos

	//Display "BANANA BUNCH"
	lui   $a2, 0x800f //text pointer
	addiu   $a2, $a2, 0xb934
	lui   $a3, 0x8010 //Load status byte
	lb   $a3, 0x20f1($a3)
	'jal '+func_disp_menu_onoff_addr_str, //Run func_disp_menu_onoff
	ori   $a1, $zero, 0x4c //$A1 is the Y pos

	//Display "GREEN SHELL"
	lui   $a2, 0x800f //text pointer
	addiu   $a2, $a2, 0xb944
	lui   $a3, 0x8010 //Load status byte
	lb   $a3, 0x20f2($a3)
	'jal '+func_disp_menu_onoff_addr_str, //Run func_disp_menu_onoff
	ori   $a1, $zero, 0x58 //$A1 is the Y pos

	//Display "3 GREEN SHELLS"
	lui   $a2, 0x800f //text pointer
	addiu   $a2, $a2, 0xb954
	lui   $a3, 0x8010 //Load status byte
	lb   $a3, 0x20f3($a3)
	'jal '+func_disp_menu_onoff_addr_str, //Run func_disp_menu_onoff
	ori   $a1, $zero, 0x64 //$A1 is the Y pos

	//Display "RED SHELL"
	lui   $a2, 0x800f //text pointer
	addiu   $a2, $a2, 0xb960
	lui   $a3, 0x8010 //Load status byte
	lb   $a3, 0x20f4($a3)
	'jal '+func_disp_menu_onoff_addr_str, //Run func_disp_menu_onoff
	ori   $a1, $zero, 0x70 //$A1 is the Y pos

	//Display "FAKE ITEM BOX"
	lui   $a2, 0x800f //text pointer
	addiu   $a2, $a2, 0xb96c
	lui   $a3, 0x8010 //Load status byte
	lb   $a3, 0x20f5($a3)
	'jal '+func_disp_menu_onoff_addr_str, //Run func_disp_menu_onoff
	ori   $a1, $zero, 0x7c //$A1 is the Y pos

	//Display "STAR"
	lui   $a2, 0x800f //text pointer
	addiu   $a2, $a2, 0xb824
	lui   $a3, 0x8010 //Load status byte
	lb   $a3, 0x20f6($a3)
	'jal '+func_disp_menu_onoff_addr_str, //Run func_disp_menu_onoff
	ori   $a1, $zero, 0x88 //$A1 is the Y pos

	//Display "GHOST"
	lui   $a2, 0x800f //text pointer
	addiu   $a2, $a2, 0xb82c
	lui   $a3, 0x8010 //Load status byte
	lb   $a3, 0x20f7($a3)
	'jal '+func_disp_menu_onoff_addr_str, //Run func_disp_menu_onoff
	ori   $a1, $zero, 0x94 //$A1 is the Y pos

	//DISPLAY "AUTO-ITEMS"
	lui   $a2, 0x800f //text pointer
	addiu   $a2, $a2, 0xb8c4
	lui   $a3, 0x8010 //Load status bytes
	lb   $a3, 0x2117($a3)
	'jal '+func_disp_menu_onoff_addr_str, //Run func_disp_menu_onoff
	ori   $a1, $zero, 0xa0 //$A1 is the Y pos

	//DISPLAY "INF. G. SHELLS"
	lui   $a2, 0x800f //text pointer
	addiu   $a2, $a2, 0xb8a4
	lui   $a3, 0x8010 //Load status byte
	lb   $a3, 0x2115($a3)
	'jal '+func_disp_menu_onoff_addr_str, //Run func_disp_menu_onoff
	ori   $a1, $zero, 0xac //$A1 is the Y pos

	//Set shell hit height if infinite green shells are turned back off, otherwise set hit height to default
	lui   $a2, 0x8010 //Load status
	lb   $a2, 0x2115($a2)
	bne   $a2, $zero, 0x2 //if infinite green shells are turned back off
	lui   $a1, 0x3c01 //Restore greenshell hit height
	ori   $a1, $a1, 0x3fb9 //Here is where the actual height is set (Default 3FB9, 0x3DCC about 0.1)'
	beq   $a2, $zero, 0x2 //if infinite green shells are turned on
	lui   $a0, 0x8019
	ori   $a1, $a1, 0x3dcc //Here is where the actual height is set (Default 3FB9, 0x3DCC about 0.1)'
	sw   $a1, 0xc56c($a0)
	lui   $a1, 0x4481
	ori   $a1, $a1, 0x4000
	sw   $a1, 0xc578($a0)

	//Set max distance you can scroll down in y direction on menu
	ori   $a1, $zero, 0xa
	lui   $a0, 0x8010
	sb   $a1, 0x210f($a0)


	lw   $ra, 0x0020($sp)
	jr    $ra
	addi   $sp, $sp, 0x24 //Load registers from stack
]
mk64rom.insert_code(codeblock_addr, func_menu_disp_items_page)
func_menu_disp_items_page_addr_str = str(hex(codeblock_addr + dmaed_code_rom_to_ram))
codeblock_addr = codeblock_addr + len(func_menu_disp_items_page)*4


//Function displays "OPTIONS" page of menu
func_menu_disp_options_page = [
	addi   $sp, $sp, 0xffdc //Store registers in stack
	sw   $ra, 0x0020($sp)

	//DISPLAY "FLAT COURSES"
	lui   $a2, 0x800f //text pointer
	addiu   $a2, $a2, 0xb8b4
	lui   $a3, 0x8010 //Load status byte
	lbu   $a3, 0x2116($a3)
	'jal '+func_disp_menu_onoff_addr_str, //Run func_disp_menu_onoff
	ori   $a1, $zero, 0x40 //$A1 is the Y pos

	//Restore regular course scaling if flat courses are turned back off
	lui   $a0, 0x8010 //Load status
	lbu   $a0, 0x2116($a0)
	bne   $a0, $zero, 0x3 //if turned off
	lui   $a1, 0x800e //Flatten the battle field 810DC608 C0A0
	lui   $a0, 0x3f80 //Default = 3F80
	sw   $a0, 0xc608($a1)


	// //Display "WIDESCREEN"
	lui   $a2, 0x800f //text pointer for  "WIDESCREEN"
	addiu   $a2, $a2, 0xb86c
	lui   $a3, 0x8010 //Load status byte
	lbu   $a3, 0x2111($a3)
	'jal '+func_disp_menu_onoff_addr_str, //Run func_disp_menu_onoff
	ori   $a1, $zero, 0x4c //$A1 is the Y pos

	// //Display "ANTIALIASING"
	lui   $a2, 0x800f //text pointer for  "ANTIALIASING"
	addiu   $a2, $a2, 0xb878
	lui   $a3, 0x8010 //Load status byte
	lbu   $a3, 0x2112($a3)
	'jal '+func_disp_menu_onoff_addr_str, //Run func_disp_menu_onoff
	ori   $a1, $zero, 0x58 //$A1 is the Y pos

	//Display "3P/4P MUSIC"
	lui   $a2, 0x800f //text pointer for  "3P/4P MUSIC"
	addiu   $a2, $a2, 0xb888
	lui   $a3, 0x8010 //Load status byte
	lbu   $a3, 0x2113($a3)
	'jal '+func_disp_menu_onoff_addr_str, //Run func_disp_menu_onoff
	ori   $a1, $zero, 0x64 //$A1 is the Y pos

	//Display "SAME CHARS"
	lui   $a2, 0x800f //text pointer for  "SAME CHARS"
	addiu   $a2, $a2, 0xb894
	lui   $a3, 0x8010 //Load status byte
	lbu   $a3, 0x2114($a3)
	'jal '+func_disp_menu_onoff_addr_str, //Run func_disp_menu_onoff
	ori   $a1, $zero, 0x70 //$A1 is the Y pos


	//Display GAME TEMPO
	lui   $a2, 0x800f //text pointer for GAME TEMPO
	addiu   $a2, $a2, 0xb97c
	ori   $a0, $zero, 0x3c //$A0 is the X pos
	jal    0x800577a4 //Print text
	ori   $a1, $zero, 0x7c //$A1 is the Y pos
	//Display selected option
	lui   $a0, 0x8010
	lbu   $a0, 0x210c($a0)
	//Set to DEFAULT
	bne   $a0, $zero, 0x3
	nop
	lui   $a2, 0x800f //text pointer
	addiu   $a2, $a2, 0xb988
	//Set to 30 FPS
	ori   $a1, $zero, 0x1
	bne   $a0, $a1, 0x3
	nop
	lui   $a2, 0x800f //text pointer
	addiu   $a2, $a2, 0xb990
	//Set to 60 FPS
	ori   $a1, $zero, 0x2
	bne   $a0, $a1, 0x3
	nop
	lui   $a2, 0x800f //text pointer
	addiu   $a2, $a2, 0xb998
	//Actually show the selected option
	ori   $a0, $zero, 0xa4 //$A0 is the X pos
	jal    0x800577a4 //Print text
	ori   $a1, $zero, 0x7c //$A1 is the Y pos

	//Display "MINIMAP"
	lui   $a2, 0x800f //text pointer for
	addiu   $a2, $a2, 0xba04
	lui   $a3, 0x8010 //Load status byte
	lbu   $a3, 0x2110($a3)
	'jal '+func_disp_menu_onoff_addr_str, //Run func_disp_menu_onoff
	ori   $a1, $zero, 0x88 //$A1 is the Y pos

	//Display "LUDICROUS SPEED"
	lui   $a2, 0x800f //text pointer
	addiu   $a2, $a2, 0xba30
	lui   $a3, 0x8010 //Load status byte
	lbu   $a3, 0x211c($a3)
	'jal '+func_disp_menu_onoff_addr_str, //Run func_disp_menu_onoff
	ori   $a1, $zero, 0x94 //$A1 is the Y pos


	//Set max distance you can scroll down in y direction on menu
	ori   $a1, $zero, 0x8
	lui   $a0, 0x8010
	sb   $a1, 0x210f($a0)

	lw   $ra, 0x0020($sp)
	jr    $ra
	addi   $sp, $sp, 0x24 //Load registers from stack
]
mk64rom.insert_code(codeblock_addr, func_menu_disp_options_page)
func_menu_disp_options_page_addr_str = str(hex(codeblock_addr + dmaed_code_rom_to_ram))
codeblock_addr = codeblock_addr + len(func_menu_disp_options_page)*4



//Function displays "BOTS" page of menu
func_menu_disp_bots_page = [
	addi   $sp, $sp, 0xffdc //Store registers in stack
	sw   $ra, 0x0020($sp)


	//DISPLAY "PLAYER 1"
	lui   $a2, 0x800f //text pointer
	addiu   $a2, $a2, 0xb9a8
	lui   $a3, 0x8010 //Load status byte
	lb   $a3, 0x20d0($a3)
	'jal '+func_disp_menu_onoff_addr_str, //Run func_disp_menu_onoff
	ori   $a1, $zero, 0x40 //$A1 is the Y pos

	//DISPLAY "PLAYER 2"
	lui   $a2, 0x800f //text pointer
	addiu   $a2, $a2, 0xb9b4
	lui   $a3, 0x8010 //Load status byte
	lb   $a3, 0x20d1($a3)
	'jal '+func_disp_menu_onoff_addr_str, //Run func_disp_menu_onoff
	ori   $a1, $zero, 0x4c //$A1 is the Y pos

	//DISPLAY "PLAYER 3"
	lui   $a2, 0x800f //text pointer
	addiu   $a2, $a2, 0xb9c0
	lui   $a3, 0x8010 //Load status byte
	lb   $a3, 0x20d2($a3)
	'jal '+func_disp_menu_onoff_addr_str, //Run func_disp_menu_onoff
	ori   $a1, $zero, 0x58 //$A1 is the Y pos

	//DISPLAY "PLAYER 4"
	lui   $a2, 0x800f //text pointer
	addiu   $a2, $a2, 0xb9cc
	lui   $a3, 0x8010 //Load status byte
	lb   $a3, 0x20d3($a3)
	'jal '+func_disp_menu_onoff_addr_str, //Run func_disp_menu_onoff
	ori   $a1, $zero, 0x64 //$A1 is the Y pos


	//Set max distance you can scroll down in y direction on menu
	ori   $a1, $zero, 0x4
	lui   $a0, 0x8010
	sb   $a1, 0x210f($a0)

	lw   $ra, 0x0020($sp)
	jr    $ra
	addi   $sp, $sp, 0x24 //Load registers from stack
]
mk64rom.insert_code(codeblock_addr, func_menu_disp_bots_page)
func_menu_disp_bots_page_addr_str = str(hex(codeblock_addr + dmaed_code_rom_to_ram))
codeblock_addr = codeblock_addr + len(func_menu_disp_bots_page)*4


func_menu_items_page_toggle = [
	addi   $sp, $sp, 0xffdc //Store registers in stack
	sw   $ra, 0x001c($sp)


	// //If menu selection is banana items on/off
	lui   $a0, 0x8010 //Load item status pointer
	addiu   $a0, $a0, 0x20f0
	'jal '+func_menu_toggle_onoff_addr_str,
	ori   $a2, $zero, 0x0 //Load menu index for this item

	// //If menu selection is banana bunch items on/off
	lui   $a0, 0x8010 //Load item status pointer
	addiu   $a0, $a0, 0x20f1
	'jal '+func_menu_toggle_onoff_addr_str,
	ori   $a2, $zero, 0x1 //Load menu index for this item

	// //If menu selection is single green shells items on/off
	lui   $a0, 0x8010 //Load item status pointer
	addiu   $a0, $a0, 0x20f2
	'jal '+func_menu_toggle_onoff_addr_str,
	ori   $a2, $zero, 0x2 //Load menu index for this item

	// //If menu selection is triple green shells items on/off
	lui   $a0, 0x8010 //Load item status pointer
	addiu   $a0, $a0, 0x20f3
	'jal '+func_menu_toggle_onoff_addr_str,
	ori   $a2, $zero, 0x3 //Load menu index for this item

	// //If menu selection is single red shells items on/off
	lui   $a0, 0x8010 //Load item status pointer
	addiu   $a0, $a0, 0x20f4
	'jal '+func_menu_toggle_onoff_addr_str,
	ori   $a2, $zero, 0x4 //Load menu index for this item

	// //If menu selection is fake item box items on/off
	lui   $a0, 0x8010 //Load item status pointer
	addiu   $a0, $a0, 0x20f5
	'jal '+func_menu_toggle_onoff_addr_str,
	ori   $a2, $zero, 0x5 //Load menu index for this item

	// //If menu selection is star items on/off
	lui   $a0, 0x8010 //Load item status pointer
	addiu   $a0, $a0, 0x20f6
	'jal '+func_menu_toggle_onoff_addr_str,
	ori   $a2, $zero, 0x6 //Load menu index for this item

	// //If menu selection is star items on/off
	lui   $a0, 0x8010 //Load item status pointer
	addiu   $a0, $a0, 0x20f7
	'jal '+func_menu_toggle_onoff_addr_str,
	ori   $a2, $zero, 0x7 //Load menu index for this item

	// //If menu selection is auto items
	lui   $a0, 0x8010 //Load item status pointer
	addiu   $a0, $a0, 0x2117
	'jal '+func_menu_toggle_onoff_addr_str,
	ori   $a2, $zero, 0x8 //Load menu index for this item

	//If menu selection is Infinite green shells
	lui   $a0, 0x8010 //Load item status pointer
	addiu   $a0, $a0, 0x2115
	'jal '+func_menu_toggle_onoff_addr_str,
	ori   $a2, $zero, 0x9 //Load menu index for this item


	lw   $ra, 0x001c($sp)
	jr    $ra
	addi   $sp, $sp, 0x24 //Load registers from stack

]
mk64rom.insert_code(codeblock_addr, func_menu_items_page_toggle)
func_menu_items_page_toggle_addr_str = str(hex(codeblock_addr + dmaed_code_rom_to_ram))
codeblock_addr = codeblock_addr + len(func_menu_items_page_toggle)*4




func_menu_bots_page_toggle = [
	addi   $sp, $sp, 0xffdc //Store registers in stack
	sw   $ra, 0x001c($sp)

	// //If menu selection is Player 1 on/off
	lui   $a0, 0x8010 //Load item status pointer
	addiu   $a0, $a0, 0x20d0
	'jal '+func_menu_toggle_onoff_addr_str,
	ori   $a2, $zero, 0x0 //Load menu index for this item

	// //If menu selection is Player 2 on/off
	lui   $a0, 0x8010 //Load item status pointer
	addiu   $a0, $a0, 0x20d1
	'jal '+func_menu_toggle_onoff_addr_str,
	ori   $a2, $zero, 0x1 //Load menu index for this item

	// //If menu selection is Player 3 on/off
	lui   $a0, 0x8010 //Load item status pointer
	addiu   $a0, $a0, 0x20d2
	'jal '+func_menu_toggle_onoff_addr_str,
	ori   $a2, $zero, 0x2 //Load menu index for this item

	// //If menu selection is Player 4 on/off
	lui   $a0, 0x8010 //Load item status pointer
	addiu   $a0, $a0, 0x20d3
	'jal '+func_menu_toggle_onoff_addr_str,
	ori   $a2, $zero, 0x3 //Load menu index for this item

	lw   $ra, 0x001c($sp)
	jr    $ra
	addi   $sp, $sp, 0x24 //Load registers from stack

]
mk64rom.insert_code(codeblock_addr, func_menu_bots_page_toggle)
func_menu_bots_page_toggle_addr_str = str(hex(codeblock_addr + dmaed_code_rom_to_ram))
codeblock_addr = codeblock_addr + len(func_menu_bots_page_toggle)*4





func_menu_tradiational_battle_on_game_page_toggle = [
	addi   $sp, $sp, 0xffdc //Store registers in stack
	sw   $ra, 0x001c($sp)

	//If menu selection is SCORING
	lui   $a0, 0x8010 //Load item status pointer
	addiu   $a0, $a0, 0x211b
	'jal '+func_menu_toggle_onoff_addr_str,
	ori   $a2, $zero, 0x1 //Load menu index for this item


	//If SCORING is set to STOCK
	lui   $v0, 0x8010
	lbu   $v0, 0x211b($v0)
	ori   $a2, $zero, 0x2 //Load menu index for this item
	bne   $v0, $zero, 0x3 // //If menu selection is HP
	nop
	'jal '+func_menu_toggle_hp_addr_str,
	nop
	//If SCORING is set to TIME
	beq   $v0, $zero, 0x3 // //If menu selection is timer
	nop
	'jal '+func_menu_toggle_timer_addr_str,
	nop


	lw   $ra, 0x001c($sp)
	jr    $ra
	addi   $sp, $sp, 0x24 //Load registers from stack

]
mk64rom.insert_code(codeblock_addr, func_menu_tradiational_battle_on_game_page_toggle)
func_menu_tradiational_battle_on_game_page_toggle_addr_str = str(hex(codeblock_addr + dmaed_code_rom_to_ram))
codeblock_addr = codeblock_addr + len(func_menu_tradiational_battle_on_game_page_toggle)*4


func_menu_hot_potato_battle_on_game_page_toggle = [
	addi   $sp, $sp, 0xffdc //Store registers in stack
	sw   $ra, 0x001c($sp)



	//If menu selection is SCORING
	lui   $a0, 0x8010 //Load item status pointer
	addiu   $a0, $a0, 0x211b
	'jal '+func_menu_toggle_onoff_addr_str,
	ori   $a2, $zero, 0x1 //Load menu index for this item


	//If SCORING is set to STOCK
	lui   $v0, 0x8010
	lbu   $v0, 0x211b($v0)
	ori   $a2, $zero, 0x2 //Load menu index for this item
	bne   $v0, $zero, 0x3 // //If menu selection is HP
	nop
	'jal '+func_menu_toggle_hp_addr_str,
	nop
	//If SCORING is set to TIME
	beq   $v0, $zero, 0x3 // //If menu selection is timer
	nop
	'jal '+func_menu_toggle_timer_addr_str,
	nop



	// //If menu selection is countdown
	'jal '+func_menu_toggle_countdown_addr_str,
	ori   $a2, $zero, 0x3 //Load menu index for this item


	lw   $ra, 0x001c($sp)
	jr    $ra
	addi   $sp, $sp, 0x24 //Load registers from stack

]
mk64rom.insert_code(codeblock_addr, func_menu_hot_potato_battle_on_game_page_toggle)
func_menu_hot_potato_battle_on_game_page_toggle_addr_str = str(hex(codeblock_addr + dmaed_code_rom_to_ram))
codeblock_addr = codeblock_addr + len(func_menu_hot_potato_battle_on_game_page_toggle)*4



func_menu_test_mode_on_game_page_toggle = [
	addi   $sp, $sp, 0xffdc //Store registers in stack
	sw   $ra, 0x001c($sp)


	// //If menu selection is max score
	lui   $a0, 0x8010 //Load item status pointer
	addiu   $a0, $a0, 0x20f0
	'jal '+func_menu_toggle_score_addr_str,
	ori   $a2, $zero, 0x1 //Load menu index for this item


	// //If menu selection is timer
	lui   $a0, 0x8010 //Load item status pointer
	addiu   $a0, $a0, 0x20f0
	'jal '+func_menu_toggle_timer_addr_str,
	ori   $a2, $zero, 0x2 //Load menu index for this item


	lw   $ra, 0x001c($sp)
	jr    $ra
	addi   $sp, $sp, 0x24 //Load registers from stack

]
mk64rom.insert_code(codeblock_addr, func_menu_test_mode_on_game_page_toggle)
func_menu_test_mode_on_game_page_toggle_addr_str = str(hex(codeblock_addr + dmaed_code_rom_to_ram))
codeblock_addr = codeblock_addr + len(func_menu_test_mode_on_game_page_toggle)*4




func_menu_game_page_toggle = [
	addi   $sp, $sp, 0xffdc //Store registers in stack
	sw   $ra, 0x001c($sp)


	// //If menu selection is mode
	bne   $a3, $zero, 0x16
	lui   $a2, 0x8010 //Load game mode
	lbu   $a0, 0x211a($a2)
	ori   $a2, $zero, 0x2 //If joystick was left
	bne   $a1, $a2, 0x3
	nop
	addi   $a0, $a0, 0xffff //Subtract 1 from game mode variable
	ori   $a1, $zero, 0x4 //Set menu selection in progress byte to state indicating the selection has finished
	ori   $a2, $zero, 0x1 //If joystick was right
	bne   $a1, $a2, 0x3
	nop
	addi   $a0, $a0, 0x1 //Add 1 to game mode variable
	ori   $a1, $zero, 0x4 //Set menu selection in progress byte to state indicating the selection has finished
	//if game mode is too low, loop to max
	addi   $a2, $zero, 0xffff
	bne   $a0, $a2, 0x2
	nop
	ori   $a0, $zero, 0x2
	//If gme mode is too high, loop to min
	ori   $a2, $zero, 0x3
	bne   $a0, $a2, 0x2
	nop
	ori   $a0, $zero, 0x00
	lui   $a2, 0x8010 //Store updated game mode
	sb   $a0, 0x211a($a2)

	//If mode is tradiational battle
	lui   $a2, 0x8010 //Load game mode
	lbu   $a0, 0x211a($a2)
	bne   $a0, $zero, 0x3
	nop
	'jal '+func_menu_tradiational_battle_on_game_page_toggle_addr_str,
	nop


	//If mode is hot potato battle
	lui   $a2, 0x8010 //Load game mode
	lbu   $a0, 0x211a($a2)
	ori   $a2, $zero, 0x1
	bne   $a0, $a2, 0x3
	nop
	'jal '+func_menu_hot_potato_battle_on_game_page_toggle_addr_str,
	nop


	//If game mode is test mode
	lui   $a2, 0x8010 //Load game mode
	lbu   $a0, 0x211a($a2)
	ori   $a2, $zero, 0x2
	bne   $a0, $a2, 0x3
	nop
	'jal '+func_menu_test_mode_on_game_page_toggle_addr_str,
	nop

	lw   $ra, 0x001c($sp)
	jr    $ra
	addi   $sp, $sp, 0x24 //Load registers from stack

]
mk64rom.insert_code(codeblock_addr, func_menu_game_page_toggle)
func_menu_game_page_toggle_addr_str = str(hex(codeblock_addr + dmaed_code_rom_to_ram))
codeblock_addr = codeblock_addr + len(func_menu_game_page_toggle)*4




func_menu_options_page_toggle = [
	addi   $sp, $sp, 0xffdc //Store registers in stack
	sw   $ra, 0x001c($sp)


	// //If menu selection is flat coureses
	lui   $a0, 0x8010 //Load item status pointer
	addiu   $a0, $a0, 0x2116
	'jal '+func_menu_toggle_onoff_addr_str,
	ori   $a2, $zero, 0x0 //Load menu index for this item


	//If menu selection is Widescreen on/off
	lui   $a0, 0x8010 //Load item status pointer
	addiu   $a0, $a0, 0x2111
	'jal '+func_menu_toggle_onoff_addr_str,
	ori   $a2, $zero, 0x1 //Load menu index for this item

	// //If menu selection is antialiasing on/off
	lui   $a0, 0x8010 //Load item status pointer
	addiu   $a0, $a0, 0x2112
	'jal '+func_menu_toggle_onoff_addr_str,
	ori   $a2, $zero, 0x2 //Load menu index for this item

	// //If menu selection is 3P/4P music on/off
	lui   $a0, 0x8010 //Load item status pointer
	addiu   $a0, $a0, 0x2113
	'jal '+func_menu_toggle_onoff_addr_str,
	ori   $a2, $zero, 0x3 //Load menu index for this item

	//If menu selection is all chars select on/off
	lui   $a0, 0x8010 //Load item status pointer
	addiu   $a0, $a0, 0x2114
	'jal '+func_menu_toggle_onoff_addr_str,
	ori   $a2, $zero, 0x4 //Load menu index for this item


	// //If menu selection is GAME TEMPO
	ori   $a2, $zero, 0x5
	bne   $a3, $a2, 0x16
	lui   $a2, 0x8010 //Load game tempo variable
	lbu   $a0, 0x210c($a2)
	ori   $a2, $zero, 0x2 //If joystick was left
	bne   $a1, $a2, 0x3
	nop
	addi   $a0, $a0, 0xffff //Subtract 1 from variable
	ori   $a1, $zero, 0x4 //Set menu selection in progress byte to state indicating the selection has finished
	ori   $a2, $zero, 0x1 //If joystick was right
	bne   $a1, $a2, 0x3
	nop
	addi   $a0, $a0, 0x1 //Add 1 to variable
	ori   $a1, $zero, 0x4 //Set menu selection in progress byte to state indicating the selection has finished
	//if game mode is too low, loop to max
	addi   $a2, $zero, 0xffff
	bne   $a0, $a2, 0x2
	nop
	ori   $a0, $zero, 0x2
	//If gme mode is too high, loop to min
	ori   $a2, $zero, 0x3
	bne   $a0, $a2, 0x2
	nop
	ori   $a0, $zero, 0x00
	lui   $a2, 0x8010 //Store updated game mode
	sb   $a0, 0x210c($a2)

	//If menu selection is minimap on/off
	lui   $a0, 0x8010 //Load item status pointer
	addiu   $a0, $a0, 0x2110
	'jal '+func_menu_toggle_onoff_addr_str,
	ori   $a2, $zero, 0x6 //Load menu index for this item


	//Control if mimimap is on or off
	lui   $v0, 0x8010 //Load item status pointer
	lb   $v0, 0x2110($v0)
	bne   $v0, $zero, 0x2
	ori   $v1, $zero, 0x0c01
	ori   $v1, $zero, 0x2400
	lui   $v0, 0x8006
	sh   $v1, 0x9d08($v0)

	//If menu selection is ludicrious speed on/off
	lui   $a0, 0x8010 //Load item status pointer
	addiu   $a0, $a0, 0x211c
	'jal '+func_menu_toggle_onoff_addr_str,
	ori   $a2, $zero, 0x7 //Load menu index for this item



	lw   $ra, 0x001c($sp)
	jr    $ra
	addi   $sp, $sp, 0x24 //Load registers from stack
]
mk64rom.insert_code(codeblock_addr, func_menu_options_page_toggle)
func_menu_options_page_toggle_addr_str = str(hex(codeblock_addr + dmaed_code_rom_to_ram))
codeblock_addr = codeblock_addr + len(func_menu_options_page_toggle)*4






menu_code = [
	0x0C02555D,	//Run lines that were replaced by hook first, COMMENTING OUT DISABLES TITLE SCREEN LOGO AND BACKGROUND which is what I want
	0x00000000,


	addi   $sp, $sp, 0xffb8 //Store registers
	sw   $a0, 0x0028($sp)
	sw   $a1, 0x002c($sp)
	sw   $a2, 0x0030($sp)
	sw   $a3, 0x0034($sp)
	sw   $ra, 0x0038($sp)
	sw   $t6, 0x003c($sp) //Free up $T6 for use
	//sw   $t7, 0x0040($sp)



	//Display a semi-transparent background for the menu
	lui   $a0, 0x8015 //Load dlistBuffer from to 0x80150298 to $a0
	lw   $a0, 0x0298($a0)
	ori   $a1, $zero, 0x1c //x1
	ori   $a2, $zero, 0xc //y1
	ori   $a3, $zero, 0x11c //x2
	ori   $t6, $zero, 0xdc //y2
	sw   $t6, 0x0010($sp) //(argument passing starts at offset of 0x10 in stack)
	sw   $zero, 0x0014($sp) //u32 r
	sw   $zero, 0x0018($sp) //u32 g
	sw   $zero, 0x001c($sp) //u32 b
	ori   $t6, $zero, 0xc8 //transparency
	sw   $t6, 0x0020($sp)
	jal    0x80098df8 //Call drawBox function 0x80098DF8
	nop
	lui   $a0, 0x8015 //Store dlistBuffer back to 0x80150298
	sw   $v0, 0x0298($a0)



	//Display menu border left
	lui   $a0, 0x8015 //Load dlistBuffer from to 0x80150298 to $a0
	lw   $a0, 0x0298($a0)
	ori   $a1, $zero, 0x1c //x1
	ori   $a2, $zero, 0xc //y1
	ori   $a3, $zero, 0x1e //x2
	ori   $t6, $zero, 0xdc //y2
	sw   $t6, 0x0010($sp) //(argument passing starts at offset of 0x10 in stack)
	ori   $t6, $zero, 0x80 //color
	sw   $t6, 0x0014($sp) //u32 r
	sw   $t6, 0x0018($sp) //u32 g
	sw   $t6, 0x001c($sp) //u32 b
	ori   $t6, $zero, 0xff
	sw   $t6, 0x0020($sp) //transparency
	jal    0x80098df8 //Call drawBox function 0x80098DF8
	nop
	lui   $a0, 0x8015 //Store dlistBuffer back to 0x80150298
	sw   $v0, 0x0298($a0)

	//Display menu border right
	lui   $a0, 0x8015 //Load dlistBuffer from to 0x80150298 to $a0
	lw   $a0, 0x0298($a0)
	ori   $a1, $zero, 0x11c //x1
	ori   $a2, $zero, 0xc //y1
	ori   $a3, $zero, 0x11e //x2
	ori   $t6, $zero, 0xdc //y2
	sw   $t6, 0x0010($sp) //(argument passing starts at offset of 0x10 in stack)
	ori   $t6, $zero, 0x80 //color
	sw   $t6, 0x0014($sp) //u32 r
	sw   $t6, 0x0018($sp) //u32 g
	sw   $t6, 0x001c($sp) //u32 b
	ori   $t6, $zero, 0xff
	sw   $t6, 0x0020($sp) //transparency
	jal    0x80098df8 //Call drawBox function 0x80098DF8
	nop
	lui   $a0, 0x8015 //Store dlistBuffer back to 0x80150298
	sw   $v0, 0x0298($a0)

	//Display  menu border bottom
	lui   $a0, 0x8015 //Load dlistBuffer from to 0x80150298 to $a0
	lw   $a0, 0x0298($a0)
	ori   $a1, $zero, 0x1c //x1
	ori   $a2, $zero, 0xda //y1
	ori   $a3, $zero, 0x11c //x2
	ori   $t6, $zero, 0xdc //y2
	sw   $t6, 0x0010($sp) //(argument passing starts at offset of 0x10 in stack)
	ori   $t6, $zero, 0x80 //color
	sw   $t6, 0x0014($sp) //u32 r
	sw   $t6, 0x0018($sp) //u32 g
	sw   $t6, 0x001c($sp) //u32 b
	ori   $t6, $zero, 0xff
	sw   $t6, 0x0020($sp) //transparency
	jal    0x80098df8 //Call drawBox function 0x80098DF8
	nop
	lui   $a0, 0x8015 //Store dlistBuffer back to 0x80150298
	sw   $v0, 0x0298($a0)


	//Display menu border top
	lui   $a0, 0x8015 //Load dlistBuffer from to 0x80150298 to $a0
	lw   $a0, 0x0298($a0)
	ori   $a1, $zero, 0x1c //x1
	ori   $a2, $zero, 0xc //y1
	ori   $a3, $zero, 0x11c //x2
	ori   $t6, $zero, 0xe //y2
	sw   $t6, 0x0010($sp) //(argument passing starts at offset of 0x10 in stack)
	ori   $t6, $zero, 0x80 //color
	sw   $t6, 0x0014($sp) //u32 r
	sw   $t6, 0x0018($sp) //u32 g
	sw   $t6, 0x001c($sp) //u32 b
	ori   $t6, $zero, 0xff
	sw   $t6, 0x0020($sp) //transparency
	jal    0x80098df8 //Call drawBox function 0x80098DF8
	nop
	lui   $a0, 0x8015 //Store dlistBuffer back to 0x80150298
	sw   $v0, 0x0298($a0)



	//Display menu seperator between battle kart and credit title and tabs
	lui   $a0, 0x8015 //Load dlistBuffer from to 0x80150298 to $a0
	lw   $a0, 0x0298($a0)
	ori   $a1, $zero, 0x1c //x1
	ori   $a2, $zero, 0x2a //y1
	ori   $a3, $zero, 0x11c //x2
	ori   $t6, $zero, 0x2c //y2
	sw   $t6, 0x0010($sp) //(argument passing starts at offset of 0x10 in stack)
	ori   $t6, $zero, 0x80 //color
	sw   $t6, 0x0014($sp) //u32 r
	sw   $t6, 0x0018($sp) //u32 g
	sw   $t6, 0x001c($sp) //u32 b
	ori   $t6, $zero, 0xff
	sw   $t6, 0x0020($sp) //transparency
	jal    0x80098df8 //Call drawBox function 0x80098DF8
	nop
	lui   $a0, 0x8015 //Store dlistBuffer back to 0x80150298
	sw   $v0, 0x0298($a0)

	//Display menu seperator between tabs and rest of menu
	lui   $a0, 0x8015 //Load dlistBuffer from to 0x80150298 to $a0
	lw   $a0, 0x0298($a0)
	ori   $a1, $zero, 0x1c //x1
	ori   $a2, $zero, 0x40 //y1
	ori   $a3, $zero, 0x11c //x2
	ori   $t6, $zero, 0x42 //y2
	sw   $t6, 0x0010($sp) //(argument passing starts at offset of 0x10 in stack)
	ori   $t6, $zero, 0x80 //color
	sw   $t6, 0x0014($sp) //u32 r
	sw   $t6, 0x0018($sp) //u32 g
	sw   $t6, 0x001c($sp) //u32 b
	ori   $t6, $zero, 0xff
	sw   $t6, 0x0020($sp) //transparency
	jal    0x80098df8 //Call drawBox function 0x80098DF8
	nop
	lui   $a0, 0x8015 //Store dlistBuffer back to 0x80150298
	sw   $v0, 0x0298($a0)




	// // //Display menu page tabs
	//Grab x position based on current page
	lui   $a0, 0x8010 //Load current page
	lbu   $a3, 0x2118($a0)
	bne   $a3, $zero, 0x2 //If page == 0, set x position in $t7
	ori   $a1, $zero, 0x1
	ori   $t7, $zero, 0x22
	bne   $a3, $a1, 0x2 //If page == 1, set x position in $t7
	ori   $a1, $zero, 0x2
	ori   $t7, $zero, 0x5e
	bne   $a3, $a1, 0x2 //If page == 2, set x position in $t7
	ori   $a1, $zero, 0x3
	ori   $t7, $zero, 0x9a
	bne   $a3, $a1, 0x2 //If page == 3, set x position in $t7
	nop
	ori   $t7, $zero, 0xd6
	sw   $t7, 0x0040($sp) //Store result in stack so it can be accessed even after running jal 0x80098DF8


	//Display tab background
	lui   $a0, 0x8015 //Load dlistBuffer from to 0x80150298 to $a0
	lw   $a0, 0x0298($a0)
	addi   $a1, $t7, 0x00 //x1
	ori   $a2, $zero, 0x30 //y1
	addi   $a3, $t7, 0x3e //x2
	ori   $t6, $zero, 0x40 //y2
	sw   $t6, 0x0010($sp) //(argument passing starts at offset of 0x10 in stack)
	ori   $t6, $zero, 0x50 //color
	sw   $t6, 0x0014($sp) //u32 r
	sw   $t6, 0x0018($sp) //u32 g
	sw   $t6, 0x001c($sp) //u32 b
	ori   $t6, $zero, 0xb0
	sw   $t6, 0x0020($sp) //transparency
	jal    0x80098df8 //Call drawBox function 0x80098DF8
	nop
	lui   $a0, 0x8015 //Store dlistBuffer back to 0x80150298
	sw   $v0, 0x0298($a0)


	//Display left side of tab
	lw   $t7, 0x0040($sp)
	lui   $a0, 0x8015 //Load dlistBuffer from to 0x80150298 to $a0
	lw   $a0, 0x0298($a0)
	addi   $a1, $t7, 0x00 //x1
	ori   $a2, $zero, 0x32 //y1
	addi   $a3, $t7, 0x02 //x2
	ori   $t6, $zero, 0x40 //y2
	sw   $t6, 0x0010($sp) //(argument passing starts at offset of 0x10 in stack)
	ori   $t6, $zero, 0x80 //color
	sw   $t6, 0x0014($sp) //u32 r
	sw   $t6, 0x0018($sp) //u32 g
	sw   $t6, 0x001c($sp) //u32 b
	ori   $t6, $zero, 0xff
	sw   $t6, 0x0020($sp) //transparency
	jal    0x80098df8 //Call drawBox function 0x80098DF8
	nop
	lui   $a0, 0x8015 //Store dlistBuffer back to 0x80150298
	sw   $v0, 0x0298($a0)


	//Display right side of tab
	lw   $t7, 0x0040($sp)
	lui   $a0, 0x8015 //Load dlistBuffer from to 0x80150298 to $a0
	lw   $a0, 0x0298($a0)
	addi   $a1, $t7, 0x3c //x1
	ori   $a2, $zero, 0x32 //y1
	addi   $a3, $t7, 0x3e //x2
	ori   $t6, $zero, 0x40 //y2
	sw   $t6, 0x0010($sp) //(argument passing starts at offset of 0x10 in stack)
	ori   $t6, $zero, 0x80 //color
	sw   $t6, 0x0014($sp) //u32 r
	sw   $t6, 0x0018($sp) //u32 g
	sw   $t6, 0x001c($sp) //u32 b
	ori   $t6, $zero, 0xff
	sw   $t6, 0x0020($sp) //transparency
	jal    0x80098df8 //Call drawBox function 0x80098DF8
	nop
	lui   $a0, 0x8015 //Store dlistBuffer back to 0x80150298
	sw   $v0, 0x0298($a0)


	//Display top of tab
	lw   $t7, 0x0040($sp)
	lui   $a0, 0x8015 //Load dlistBuffer from to 0x80150298 to $a0
	lw   $a0, 0x0298($a0)
	addi   $a1, $t7, 0x00 //x1
	ori   $a2, $zero, 0x30 //y1
	addi   $a3, $t7, 0x3e //x2
	ori   $t6, $zero, 0x32 //y2
	sw   $t6, 0x0010($sp) //(argument passing starts at offset of 0x10 in stack)
	ori   $t6, $zero, 0x80 //color
	sw   $t6, 0x0014($sp) //u32 r
	sw   $t6, 0x0018($sp) //u32 g
	sw   $t6, 0x001c($sp) //u32 b
	ori   $t6, $zero, 0xff
	sw   $t6, 0x0020($sp) //transparency
	jal    0x80098df8 //Call drawBox function 0x80098DF8
	nop
	lui   $a0, 0x8015 //Store dlistBuffer back to 0x80150298
	sw   $v0, 0x0298($a0)





	//Display currently selected item as a long skinny rectangle
	lui   $a1, 0x8010 //Load current menu selection and set the Y position based on that, $A1 is the y position
	lb    $a3, 0x2118($a1)
	addu  $a3, $a1, $a3 //Load current menu selection, which will vary based on page
	lb    $a1, 0x20e0($a3)
	ori   $a2, $zero, 0xc //Multiply $A1 by 12
	mult  $a1, $a2
	mflo  $a1
	addi  $a2, $a1, 0x51 //A1 is the y pos
	lui   $a0, 0x8015 //Load dlistBuffer from to 0x80150298 to $a0
	lw    $a0, 0x0298($a0)
	ori   $a1, $zero, 0x34 //x1
	ori   $a3, $zero, 0x106 //x2
	addi  $t6, $a2, 0xe //y2
	sw    $t6, 0x0010($sp) //(argument passing starts at offset of 0x10 in stack)
	sw    $zero, 0x0014($sp) //u32 r
	sw    $zero, 0x0018($sp) //u32 g
	ori   $t6, $zero, 0xff //u32 b
	sw    $t6, 0x001c($sp)
	ori   $t6, $zero, 0xb0 //transparency
	sw    $t6, 0x0020($sp)
	jal   0x80098df8 //Call drawBox function 0x80098DF8
	nop
	lui   $a0, 0x8015 //Store dlistBuffer back to 0x80150298
	sw    $v0, 0x0298($a0)

	//Use Z and R buttons to move through menu pages
	lui   $a0, 0x800f //Load P1 buttons pressed
	lhu   $a0, 0x6914($a0)
	lui   $a2, 0x8010
	lbu   $a3, 0x2118($a2) //Load current menu page
	lbu   $a1, 0x2119($a2) //Load value of menu page movmement in progress byte
	//If menu page movement in progress, skip moving the menu page since it is already in the process of moving
	bne   $a1, $zero, 0xc
	//If Z or L bittom is pessed, move menu page left
	//andi  $a2, $a0, 0x2000
	andi  $a2, $a0, 0x2020
	beq   $a2, $zero, 0x4
	nop
	'jal '+func_play_menu_sound_addr_str, //Play menu sound
	addi   $a3, $a3, 0xffff
	ori   $a1, $zero, 0x1 //Menu selection in progress byte set
	//If R button is pressed, move menu page right
	andi  $a2, $a0, 0x0010
	beq   $a2, $zero, 0x4
	nop
	'jal '+func_play_menu_sound_addr_str, //Play menu sound
	addi   $a3, $a3, 0x1
	ori   $a1, $zero, 0x1 //Menu selection in progress byte set
	//Reset menu page move in progress byte if no buttons are pressed
	bne   $a0, $zero, 0x2
	nop
	ori   $a1, $zero, 0x0 //Menu selection in progress byte reset to zero
	//if menu page is too low, reset to min
	addi   $a2, $zero, 0xffff
	bne   $a3, $a2, 0x2
	nop
	ori   $a3, $zero, 0x3
	//If menu page is too high, reset to max
	ori   $a2, $zero, 0x4
	bne   $a3, $a2, 0x2
	nop
	ori   $a3, $zero, 0x0
	//Store menu selection in progress and menu selection bytes back to ram
	lui   $a0, 0x8010
	sb   $a3, 0x2118($a0)
	sb   $a1, 0x2119($a0)




	//Move menu selection y-axis or option based on P1 C-stick y-axis (Using c-stick activator //2 D014F0F3 00??)
	//0x801020E0 - 1 byte - Item menu selection (0, 1, 2, ect. as you go down the menu)
	//0x801020E1 - 1 byte - Game menu selection (0, 1, 2, ect. as you go down the menu)
	//0x801020E2 - 1 byte - Options menu selection (0, 1, 2, ect. as you go down the menu)
	lui   $a0, 0x8010
	lb   $a1, 0x210d($a0) //Load value of menu selection movmement in progress byte
	lbu   $a3, 0x2118($a0) //Load current menu page
	addu   $a3, $a0, $a3 //Load current menu selection, which will vary based on page
	lb   $a3, 0x20e0($a3)
	lui   $a0, 0x8015 //Load value of P1's joystick y-axis into $A0
	lbu   $a0, 0xf0f3($a0)
	srl   $a0, $a0, 0x6 //Divide joystick value by 32
	//Add d-pad support
	lui   $v0, 0x800f //Load button activator
	lbu   $v0, 0x6914($v0)
	ori   $v1, $zero, 0x08 //If D-up is held, set joystick value to what it would be if it was up
	bne   $v0, $v1, 0x2
	nop
	ori   $a0, $zero, 0x1
	ori   $v1, $zero, 0x4 //If D-down is held, set joystick value to what it would be if it was down
	bne   $v0, $v1, 0x2
	nop
	ori   $a0, $zero, 0x2
	//If menu selection in progress, skip moving the menu selection since it is already in the process of moving
	//bne   $a1, $zero, 0xa
	bne   $a1, $zero, 0xc
	//If c-stick is up and the value is high enough, move menu selection up
	ori   $a2, $zero, 0x1
	bne   $a0, $a2, 0x4
	nop
	'jal '+func_play_menu_sound_addr_str, //Play menu sound
	addi   $a3, $a3, 0xffff
	ori   $a1, $zero, 0x1 //Menu selection in progress byte set
	//if c-stick is down and the value is high enough, move menu selection down
	ori   $a2, $zero, 0x2
	bne   $a0, $a2, 0x4
	nop
	'jal '+func_play_menu_sound_addr_str, //Play menu sound
	addi   $a3, $a3, 0x1
	ori   $a1, $zero, 0x1 //Menu selection in progress byte set
	//Rest menu selection in progress byte if joystick is not moved far enough
	beq   $a0, $zero, 0x3 //If joystick is up a little or...
	ori   $a2, $zero, 0x3 //If joystick is down a little
	bne   $a0, $a2, 0x2
	nop
	ori   $a1, $zero, 0x0
	//if menu selection is too low, reset to min
	addi   $a2, $zero, 0xffff
	bne   $a3, $a2, 0x2
	nop
	ori   $a3, $zero, 0x0
	//If menu selection is too high, reset to max
	lui   $a2, 0x8010 //Grab max menu scroll down distance from 0x8010210F
	lbu   $a2, 0x210f($a2)
	bne   $a3, $a2, 0x2 //If scrolling > value stored in 0x8010210F
	addi   $a2, $a2, 0xffff
	ori   $a3, $a2, 0x0 //Subtract 1 and put value back to max possible scroll down distance
	//Store menu selection in progress and menu selection bytes back to ram
	lui   $a0, 0x8010
	lbu   $a2, 0x2118($a0) //Load current menu page
	addu   $a2, $a0, $a2 //Load current menu selection, which will vary based on page
	sb   $a1, 0x210d($a0)
	sb   $a3, 0x20e0($a2)


	//Move menu selection x-axis or option based on P1 C-stick x-axis (Using c-stick activator //2 D014F0F2 00??)
	lb   $a1, 0x210e($a0) //Load value of menu selection movmement in progress byte
	//lb   $a3, 0x210c($a0) //Load current menu selection
	lui   $a0, 0x8015 //Load value of P1's joystick x-axis into $A0
	lbu   $a0, 0xf0f2($a0)
	srl   $a0, $a0, 0x6 //Divide joystick value by 32
	//Add d-pad support
	lui   $v0, 0x800f //Load button activator
	lbu   $v0, 0x6914($v0)
	ori   $v1, $zero, 0x02 //If D-left is held, set joystick value to what it would be if it was left
	bne   $v0, $v1, 0x2
	nop
	ori   $a0, $zero, 0x2
	ori   $v1, $zero, 0x1 //If D-right is held, set joystick value to what it would be if it was right
	bne   $v0, $v1, 0x2
	nop
	ori   $a0, $zero, 0x1
	//If menu selection in progress, skip moving the menu selection since it is already in the process of moving
	ori   $a2, $zero, 0x4
	beq   $a1, $a2, 0xa
	//If c-stick is left and the value is high enough, move menu selection left
	ori   $a2, $zero, 0x1
	bne   $a0, $a2, 0x3
	nop
	'jal '+func_play_menu_sound_addr_str, //Play menu sound
	ori   $a1, $zero, 0x1 //Menu selection in progress byte set
	//if c-stick is right and the value is high enough, move menu selection right
	ori   $a2, $zero, 0x2
	bne   $a0, $a2, 0x3
	nop
	'jal '+func_play_menu_sound_addr_str, //Play menu sound
	ori   $a1, $zero, 0x2 //Menu selection in progress byte set
	//Rest menu selection in progress byte if joystick is not moved far enough
	beq   $a0, $zero, 0x5 //If joystick is up a little or...
	ori   $a2, $zero, 0x3 //If joystick is down a little
	beq   $a0, $a2, 0x3
	nop
	beq   $zero, $zero, 0x2
	nop
	ori   $a1, $zero, 0x0








	//Menu toggling only for page 0 GAME:
	lui   $a2, 0x8010 //Load current page
	lbu   $a2, 0x2118($a2)
	ori   $a0, $zero, 0x0
	bne   $a2, $a0, 0x3
	nop
	'jal '+func_menu_game_page_toggle_addr_str,
	nop




	//Menu toggling only for page 1 ITEMS:
	lui   $a2, 0x8010 //Load current page
	lbu   $a2, 0x2118($a2)
	ori   $a0, $zero, 0x1
	bne   $a2, $a0, 0x3
	nop
	'jal '+func_menu_items_page_toggle_addr_str,
	nop


	//Menu toggling only for page 2 BOTS:
	lui   $a2, 0x8010 //Load current page
	lbu   $a2, 0x2118($a2)
	ori   $a0, $zero, 0x2
	bne   $a2, $a0, 0x3
	nop
	'jal '+func_menu_bots_page_toggle_addr_str,
	nop



	//Menu toggling only for page 3 OPTOINS:
	lui   $a2, 0x8010 //Load current page
	lbu   $a2, 0x2118($a2)
	ori   $a0, $zero, 0x3
	bne   $a2, $a0, 0x3
	nop
	'jal '+func_menu_options_page_toggle_addr_str,
	nop




	lui   $a2, 0x8010
	sb   $a1, 0x210e($a2) //Store menu selection in progress byte back to ram



	lui   $a1, 0x8019 //Stop title demo counter at 8018EE00 from counting anything
	sw   $zero, 0xee00($a1)


	jal    0x80057710 //Load font
	nop

	//jal    0x800930d8 //Set text color
	//ori   $a0, $zero, 0x00 // A0=color (00=blue 01=green 02=red 03=yellow 04=cool transition through them, 05=same transition, 06+=glitches)'

	// Display hack title "BATTLE KART 64"
	ori   $a0, $zero, 0x54 //$A0 is the X pos
	ori   $a1, $zero, 0x00 //A1 is the y pos
	lui   $a2, 0x800f //text pointer
	jal    0x800577a4 //Print text
	addiu   $a2, $a2, 0xb848

	//Display hack title info "VX.X BY TRICLON"
	ori   $a0, $zero, 0x50 //$A0 is the X pos
	ori   $a1, $zero, 0xc //A1 is the y pos
	lui   $a2, 0x800f //text pointer
	jal    0x800577a4 //Print text
	addiu   $a2, $a2, 0xb85a


	//Display "Z", "L", and "R" for menu pages
	//Display "L"
	ori   $a0, $zero, 0x00 //$A0 is the X pos
	ori   $a1, $zero, 0x19 //A1 is the y pos
	lui   $a2, 0x800f //text pointer
	jal    0x800577a4 //Print text
	addiu   $a2, $a2, 0xb820
	//Display "Z"
	ori   $a0, $zero, 0x00 //$A0 is the X pos
	ori   $a1, $zero, 0x25 //A1 is the y pos
	lui   $a2, 0x800f //text pointer
	jal    0x800577a4 //Print text
	addiu   $a2, $a2, 0xb8f8
	//Display "R"
	ori   $a0, $zero, 0x10b //$A0 is the X pos
	ori   $a1, $zero, 0x20 //A1 is the y pos
	lui   $a2, 0x800f //text pointer
	jal    0x800577a4 //Print text
	addiu   $a2, $a2, 0xb8fc








	//Display page tab names
	//Game
	lui   $a2, 0x800f
	addiu   $a2, $a2, 0xb900
	ori   $a0, $zero, 0x1e //x position $a0
	jal    0x800577a4 //Display text function
	ori   $a1, $zero, 0x21 // y postion  $a1
	//Items
	lui   $a2, 0x800f
	addiu   $a2, $a2, 0xb8c9
	ori   $a0, $zero, 0x54 //x position $a0
	jal    0x800577a4 //Display text function
	ori   $a1, $zero, 0x21 // y postion  $a1
	//Bots
	lui   $a2, 0x800f //Text pointer $a2
	addiu   $a2, $a2, 0xb9a0
	ori   $a0, $zero, 0x97 //x position $a0
	jal    0x800577a4 //Display text function
	ori   $a1, $zero, 0x21 // y postion  $a1
	//Options
	lui   $a2, 0x800f //Text pointer $a2
	addiu   $a2, $a2, 0xb8f0
	ori   $a0, $zero, 0xc6 //x position $a0
	jal    0x800577a4 //Display text function
	ori   $a1, $zero, 0x21 // y postion  $a1




	//Display only for page 0 GAME:
	lui   $a0, 0x8010 //Load current page
	lbu   $a3, 0x2118($a0)
	ori   $a0, $zero, 0x0
	bne   $a3, $a0, 0x3
	nop
	'jal '+func_menu_disp_game_page_addr_str,
	nop



	//Display only for page 1 ITEMS:
	lui   $a0, 0x8010 //Load current page
	lbu   $a3, 0x2118($a0)
	ori   $a0, $zero, 0x1
	bne   $a3, $a0, 0x3
	nop
	'jal '+func_menu_disp_items_page_addr_str,
	nop



	//Display only for page 2 BOTS:
	lui   $a0, 0x8010 //Load current page
	lbu   $a3, 0x2118($a0)
	ori   $a0, $zero, 0x2
	bne   $a3, $a0, 0x3
	nop
	'jal '+func_menu_disp_bots_page_addr_str,
	nop



	//Display only for page 3 OPTIONS:
	lui   $a0, 0x8010 //Load current page
	lbu   $a3, 0x2118($a0)
	ori   $a0, $zero, 0x3
	bne   $a3, $a0, 0x3
	nop
	'jal '+func_menu_disp_options_page_addr_str,
	nop








	lw   $a0, 0x0028($sp)
	lw   $a1, 0x002c($sp)
	lw   $a2, 0x0030($sp)
	lw   $a3, 0x0034($sp)
	lw   $ra, 0x0038($sp)
	lw   $t6, 0x003c($sp) //Free up $T6 for use
	//lw   $t7, 0x0040($sp)
	addi   $sp, $sp, 0x48 //Load registers

	'j '+hex(0x957D0 + 0x80000000 - 0xC00 + 0x8),
	nop
	// lw   $s0, 0x0014($sp)
	// lw   $s1, 0x0018($sp)
	// lw   $s2, 0x0020($sp)
	]




//hook_addr = 0x957D0 //Title screen hook
mk64rom.insert_code(0x957D0, ['j '+hex(codeblock_addr + mk64rom.rom_to_ram), 'nop']) //Title screen hook
replaced_hook_code = []
//mk64rom.insert_codeblock(hook_addr, codeblock_addr,  menu_code + replaced_hook_code)
mk64rom.insert_code(codeblock_addr, menu_code)

codeblock_addr = codeblock_addr + len(menu_code)*4


print(hex(codeblock_addr + mk64rom.rom_to_ram))

//Write a bit of custom code to ensure the item function rerolls if an item is zeroed out (ie. turned off)
reroll_items_if_zero_code = [
	lui   $a0, 0x8010



	//If all items are off, get ready for a suprise!
	lw   $v0, 0x20f0($a0)
	bne   $v0, $zero, 0x5
	lw   $v0, 0x20f4($a0)
	bne   $v0, $zero, 0x3
	nop
	ori   $v1, $zero, 0x8 //Give this item, muhahahaha >:)
	j    0x8007af2c //Jump back


	//If a single banana is rolled and this item is disabled, reroll
	ori   $v0, $zero, 0x01
	bne   $v1, $v0, 0x4 //If item is rolled
	lbu   $a1, 0x20f0($a0)
	bne   $a1, $zero, 0x2 //And if item is disabled
	nop
	j    0x8007adb8 //Reroll items

	//If a banana bunch is rolled and this item is disabled, reroll
	ori   $v0, $zero, 0x02
	bne   $v1, $v0, 0x4 //If item is rolled
	lbu   $a1, 0x20f1($a0)
	bne   $a1, $zero, 0x2 //And if item is disabled
	nop
	j    0x8007adb8 //Reroll items

	//If a green shell is rolled and this item is disabled, reroll
	ori   $v0, $zero, 0x03
	bne   $v1, $v0, 0x4 //If item is rolled
	lbu   $a1, 0x20f2($a0)
	bne   $a1, $zero, 0x2 //And if item is disabled
	nop
	j    0x8007adb8 //Reroll items

	//If 3 green shells is rolled and this item is disabled, reroll
	ori   $v0, $zero, 0x04
	bne   $v1, $v0, 0x4 //If item is rolled
	lbu   $a1, 0x20f3($a0)
	bne   $a1, $zero, 0x2 //And if item is disabled
	nop
	j    0x8007adb8 //Reroll items

	//If a red shell is rolled and this item is disabled, reroll
	ori   $v0, $zero, 0x05
	bne   $v1, $v0, 0x4 //If item is rolled
	lbu   $a1, 0x20f4($a0)
	bne   $a1, $zero, 0x2 //And if item is disabled
	nop
	j    0x8007adb8 //Reroll items

	//If a fake item box is rolled and this item is disabled, reroll
	ori   $v0, $zero, 0x09
	bne   $v1, $v0, 0x4 //If item is rolled
	lbu   $a1, 0x20f5($a0)
	bne   $a1, $zero, 0x2 //And if item is disabled
	nop
	j    0x8007adb8 //Reroll items

	//If a star is rolled and this item is disabled, reroll
	ori   $v0, $zero, 0x0a
	bne   $v1, $v0, 0x4 //If item is rolled
	lbu   $a1, 0x20f6($a0)
	bne   $a1, $zero, 0x2 //And if item is disabled
	nop
	j    0x8007adb8 //Reroll items

	//If a ghost is rolled and this item is disabled, reroll
	ori   $v0, $zero, 0x0b
	bne   $v1, $v0, 0x5 //If item is rolled
	lbu   $a1, 0x20f7($a0)
	bne   $a1, $zero, 0x3 //And if item is disabled
	nop
	j    0x8007adb8 //Reroll items
	nop






	//Otherwise resume code
	j    0x8007af2c
	nop
]

mk64rom.insert_code(0x7BAD4, ['J '+hex(codeblock_addr+mk64rom.rom_to_ram)]) //Insert hook to custom asm
mk64rom.insert_code(codeblock_addr, reroll_items_if_zero_code)
codeblock_addr = codeblock_addr + len(reroll_items_if_zero_code)*4 //+ 8



//Load endlessly looping codeblock (aka The Engine
codeblock = [


	// //Default lose HP/baloons when falling off course, certain game modes might overwrite this
	// lui   $k0, 0x0c01
	// ori   $k0, $k0, 0xae2d
	// lui   $k1, 0x8009
	// sw   $k1, 0x0f78($k0)


	// //If game mode is team deathmatch, turn off losing balloons when falling off course
	// lui   $k0, 0x8010 //Load game mode
	// lbu   $k0, 0x211a($k0)
	// ori   $k1, $zero, 0x2
	// bne   $k0, $k1, 0x2 //If game mode is team deathmatch
	// lui   $k0, 0x8009 //Don't lose balloons when falling off course
	// sw   $zero, 0x0f78($k0)



	//If a battle course, just use the default intializations, otherwise use the one for big donut
	lui   $k0, 0x8004 //By default, do not force battle mode initialization for big donut
	lui   $k1, 0x0160
	ori   $k1, $k1, 0x0008
	sw   $k1, 0xc1e8($k0)
	lui   $k1, 0x800e //Load current track from cup course index 0x8018EE0B
	lbu   $k1, 0xc5a1($k1)
	ori   $k0, $zero, 0x13 //Check if Big Donut, if it is, skip the rest of this
	beq   $k1, $k0, 0x11
	ori   $k0, $zero, 0x11 //check if double deck, if it is, skip the rest of this
	beq   $k1, $k0, 0xf
	ori   $k0, $zero, 0x10 //check if Skyscraper, if it is, skip the rest of this
	beq   $k1, $k0, 0xd
	ori   $k0, $zero, 0xf //check if block Fort, if it is, skip the rest of this
	beq   $k1, $k0, 0xb
	// //Force battle mode if trying to load a race course map in VS mode
	// lui   $k1, 0x8019 //If menu selection is ok
	// lbu   $k1, 0xedec($k1)
	// ori   $k0, $zero, 0x3
	// bne   $k1, $k0, 0xf
	// lui   $k1, 0x800e //And if mode is VS
	// lhu   $k1, 0xc53e($k1)
	// ori   $k0, $zero, 0x2
	// bne   $k1, $k0, 0xb
	// // //If cup selection is not battle  8018EE09 != 4
	// // ori   $k0, $zero, 0x4
	// // lui   $k1, 0x8019
	// // lbu   $k1, 0xee09($k1)
	// // bne   $k1, $k0, 0xb
	lui   $k0, 0x8004 //Force battle mode initialization for Big Donut
	lui   $k1, 0x0800
	ori   $k1, $k1, 0xf263
	sw   $k1, 0xc1e8($k0)
	// lui   $k0, 0x8019 //Force vs mode if deselecting okay in course selection menu, this is a bug catch
	// lbu   $k0, 0xedec($k0)
	// ori   $k1, $zero, 0x4
	// bne   $k0, $k1, 0x3
	// // ori   $k1, $zero, 0x2
	// // lui   $k0, 0x800e
	// // sh   $k1, 0xc53e($k0)
	// ori   $k1, $zero, 0x2
	// lui   $k0, 0x8019
	// sh   $k1, 0xedec($k0)
	lui   $k0, 0x8019 //Force battle mode after selecting okay in course selection menu
	lbu   $k0, 0xedec($k0)
	ori   $k1, $zero, 0x3
	bne   $k0, $k1, 0x3
	ori   $k1, $zero, 0x3
	lui   $k0, 0x800e
	sh   $k1, 0xc53e($k0)
	// lui   $k0, 0x8009 //Don't lose balloons when falling off course
	// sw   $zero, 0x0f78($k0)




	// ori   $k1, $zero, 0x00
	// lui   $k0, 0x800f
	// sh   $k1, 0x6a5a($k0)
	// sh   $k1, 0x7832($k0)
	// lui   $k0, 0x8010
	// sh   $k1, 0x860a($k0)
	// sh   $k1, 0x93e2($k0)

	// //And also force players x to something
	// lui   $k0, 0x800f
	// lui   $k1, 0xc100
	// sw   $k1, 0x69ac($k0)
	// lui   $k1, 0xc200
	// sw   $k1, 0x774($k0)
	// lui   $k0, 0x8010
	// lui   $k1, 0xc220
	// sw   $k1, 0x855c($k0)
	// lui   $k1, 0xc240
	// sw   $k1, 0x9334($k0)



	// //If game mode is traditional, and HP is <= 4, set the number of ballons displayed to be this and set the max balloons so that the game's own code can take care of that
	lui   $k0, 0x8007 //Default zero out left and right baloons
	sw   $zero, 0xb82c($k0)
	sw   $zero, 0xb850($k0)
	lui   $k0, 0x8007 //Default max balloon count to three
	ori   $k1, $zero, 0x2
	sh   $k1, 0xb86e($k0)
	lui   $k0, 0x8010 //Check if stock is on (not timed), and if it is on run the following code below
	lbu   $k0, 0x211b($k0)
	bne   $k0, $zero, 0x1d
	lui   $k0, 0x8010 //Load game mode
	lbu   $k0, 0x211a($k0)
	bne   $k0, $zero, 0x1a //If game mode is traditional battle
	//HP = 1
	lui   $k0, 0x8010 //Load max HP from 0x80102000
	lhu   $k0, 0x2000($k0)
	ori   $k1, $zero, 0x1
	bne   $k0, $k1, 0x2 //If HP = 1
	lui   $k0, 0x8007 //Set max balloon count to one
	sh   $zero, 0xb86e($k0)
	//HP = 2
	lui   $k0, 0x8010 //Load max HP from 0x80102000
	lhu   $k0, 0x2000($k0)
	ori   $k1, $zero, 0x2
	bne   $k0, $k1, 0x7 //If HP = 2
	lui   $k0, 0x0c01 //Load instruction that causes balloons to load "JAL 0x8006A50C" into $a2
	ori   $k0, $k0, 0xa943
	lui   $k1, 0x8007
	sw   $k0, 0xb82c($k1) //Diaplay left baloon
	lui   $k0, 0x8007 //Set max balloon count to two
	ori   $k1, $zero, 0x1
	sh   $k1, 0xb86e($k0)
	//HP = 3
	lui   $k0, 0x8010 //Load max HP from 0x80102000
	lhu   $k0, 0x2000($k0)
	ori   $k1, $zero, 0x3
	bne   $k0, $k1, 0x5 //If HP = 3
	lui   $k0, 0x0c01 //Load instruction that causes balloons to load "JAL 0x8006A50C" into $a2
	ori   $k0, $k0, 0xa943
	lui   $k1, 0x8007
	sw   $k0, 0xb82c($k1) //Diaplay left balloon
	sw   $k0, 0xb850($k1) //Diaplay right balloon







	//Set widescreen mode if it is on
	lui   $k0, 0x8010
	lb   $k1, 0x2111($k0)
	beq   $k1, $zero, 0xb //If widescreen is on...
	lui   $k0, 0x800e
	lb   $k1, 0xc533($k0) //Load number of players
	ori   $k0, $zero, 0x1
	bne   $k1, $k0, 0x4 //Run code for if player count is 2
	lui   $k0, 0x8015
	ori   $k1, $zero, 0x4060
	sh   $k1, 0x0148($k0)
	beq   $zero, $zero, 0x3
	lui   $k0, 0x8015 //Run this code if players are 1P, 3P or 4P
	ori   $k1, $zero, 0x3fdf
	sh   $k1, 0x0148($k0)


	//Disable anti-aliasing if set to on
	//0x80102112 - 1 byte - Disable AA (0=OFF, 1=ON)
	lui   $k0, 0x8010
	lb   $k0, 0x2112($k0)
	beq   $k0, $zero, 0x4 //If disable AA set to on
	ori   $k0, $zero, 0x3216 //Disable anti-aliasing
	lui   $k1, 0x800f
	sw   $k0, 0xb3dc($k1)
	sw   $k0, 0xb40c($k1)

	//Add same character selection if set to on
	lui   $k0, 0x8010
	lb   $k0, 0x2114($k0)
	beq   $k0, $zero, 0x8 //If set to on
	lui   $k0, 0x800b
	ori   $k1, $zero, 0x7fff
	sw   $zero, 0x3924($k0)
	sh   $k1, 0x3936($k0)
	sw   $zero, 0x39a4($k0)
	sh   $k1, 0x39b6($k0)
	sw   $zero, 0x3a38($k0)
	sh   $k1, 0x3a4e($k0)

	//Infinite green shells if set to on
	lui   $k0, 0x8010
	lbu   $k0, 0x2115($k0)
	//beq   $k0, $zero, 0x1b //If set to on
	beq   $k0, $zero, 0xf //If set to on
	lui   $k0, 0x8016
	sb   $zero, 0xf6ff($k0) //Allow players to fire infinite green shells
	ori   $k1, $zero, 0x3 //Give all players green shell items that are always on
	sb   $k1, 0x5f5d($k0)
	sb   $k1, 0x5f8a($k0)
	sb   $k1, 0x603d($k0)
	sb   $k1, 0x606a($k0)
	sb   $k1, 0x611d($k0)
	sb   $k1, 0x614a($k0)
	sb   $k1, 0x61fd($k0)
	sb   $k1, 0x622a($k0)
	sb   $k1, 0x62dd($k0)
	sb   $k1, 0x630a($k0)
	sb   $k1, 0x63bd($k0)
	sb   $k1, 0x63ea($k0)
	//lui   $k0, 0x8019 //Reduce greenshell hit height
	//lui   $k1, 0x3c01
	//ori   $k1, $k1, 0x3dcc //Here is where the actual height is set (Default 3FB9, 0x3DCC about 0.1)'
	//sw   $k1, 0xc56c($k0)
	// lui   $k1, 0x4481
	// ori   $k1, $k1, 0x4000
	// sw   $k1, 0xc578($k0)
	// DOESN'T WORK, WIERD EFFECTS
	// lui   $k0, 0x802a //Turn off item boxes, (credit hyperhacker: https://www.kodewerx.org/forum/viewtopic.php?f=18&t=2763//p46017)
	// lui   $k1, 0x080a
	// addiu   $k1, $k1, 0x7561
	// sw   $k1, 0xd830($k0)
	// sw   $zero, 0xd834($k0)


	// DOESN'T WORK, WIERD EFFECTS
	// //If auto-items is on, turn off item boxes
	// lui   $k0, 0x8010
	// lb   $k1, 0x2117($k0)
	// beq   $k1, $zero, 0x5 //If set to on
	// lui   $k0, 0x802a //Turn off item boxes, (credit hyperhacker: https://www.kodewerx.org/forum/viewtopic.php?f=18&t=2763//p46017)
	// lui   $k1, 0x080a
	// addiu   $k1, $k1, 0x7561
	// sw   $k1, 0xd830($k0)
	// sw   $zero, 0xd834($k0)


	//Flat battle courses
	lui   $k0, 0x8010
	lb   $k1, 0x2116($k0)
	beq   $k1, $zero, 0x3 //If set to on
	lui   $k1, 0x800e //Flatten the battle field 810DC608 C0A0
	lui   $k0, 0x3ccc //Default = 3F80
	sw   $k0, 0xc608($k1)
	// lui   $k0, 0x802a //Turn off item boxes, (credit hyperhacker: https://www.kodewerx.org/forum/viewtopic.php?f=18&t=2763//p46017)
	// lui   $k1, 0x080a
	// addiu   $k1, $k1, 0x7561
	// sw   $k1, 0xd830($k0)
	// sw   $zero, 0xd834($k0)

	// //30 FPS Tempo fix
	lui   $k0, 0x8010
	lbu   $k0, 0x210c($k0)
	ori   $k1, $zero, 0x1
	lui   $k1, 0x8000
	lui   $k0, 0x240a //3/4 player tempo fix
	ori   $k0, $k0, 0x0002
	sw   $k0, 0x1c90($k1)
	sw   $k0, 0x1c94($k1)
	lui   $k0, 0x2409 //2 player tempo fix
	ori   $k0, $k0, 0x0002
	sw   $k0, 0x1a38($k1)
	sw   $k0, 0x1a3c($k1)

	//60 FPS Tempo fix
	lui   $k0, 0x8010
	lbu   $k0, 0x210c($k0)
	ori   $k1, $zero, 0x2
	bne   $k0, $k1, 0xd //If set to on
	lui   $k1, 0x8000
	lui   $k0, 0x240f //1 player tempo fix
	ori   $k0, $k0, 0x0001
	sw   $k0, 0x15c4($k1)
	sw   $k0, 0x15c8($k1)
	lui   $k0, 0x2409 //2 player tempo fix
	ori   $k0, $k0, 0x0001
	sw   $k0, 0x1a38($k1)
	sw   $k0, 0x1a3c($k1)
	lui   $k0, 0x240a //3/4 player tempo fix
	ori   $k0, $k0, 0x0001
	sw   $k0, 0x1c90($k1)
	sw   $k0, 0x1c94($k1)


	//Copy battle bot controller input generated by the battle bot function to the correct button activators (because we need to use the exeption handler hook)
	//P1
	lui   $k0, 0x8010 //Check if bot is on
	lb   $k0, 0x20d0($k0)
	beq   $k0, $zero, 0xe
	lui   $k0, 0x8019 //Auto select character for bot
	ori   $k1, $zero, 0x1
	sb   $k1, 0xede8($k0)
	lui   $k0, 0x800f //Check if in game and player is not starting or dead
	lbu   $k0, 0x6990($k0)
	ori   $k1, $zero, 0xc0
	bne   $k0, $k1, 0x7
	lui   $k0, 0x8010
	lw   $k1, 0x20c0($k0) //Copy controller input into correct button activator
	lui   $k0, 0x8019
	sw   $k1, 0x6504($k0)
	lui   $k1, 0xff01 //Trick console/emulator into thinking controller is plugged in
	ori   $k1, $k1, 0x0401
	sw   $k1, 0x6500($k0)
	 //P2
	lui   $k0, 0x8010 //Check if bot is on
	lb   $k1, 0x20d1($k0)
	beq   $k1, $zero, 0xe
	lui   $k0, 0x8019 //Auto select character for bot
	ori   $k1, $zero, 0x1
	sb   $k1, 0xede9($k0)
	lui   $k0, 0x800f //Check if in game and player is not starting or dead
	lbu   $k0, 0x7768($k0)
	ori   $k1, $zero, 0xc0
	bne   $k0, $k1, 0x7
	lui   $k0, 0x8010
	lw   $k1, 0x20c4($k0) //Copy controller input into correct button activator
	lui   $k0, 0x8019
	sw   $k1, 0x650c($k0)
	lui   $k1, 0xff01 //Trick console/emulator into thinking controller is plugged in
	ori   $k1, $k1, 0x0401
	sw   $k1, 0x6508($k0)
	 //P3
	lui   $k0, 0x8010 //Check if bot is on
	lb   $k1, 0x20d2($k0)
	beq   $k1, $zero, 0xe
	lui   $k0, 0x8019 //Auto select character for bot
	ori   $k1, $zero, 0x1
	sb   $k1, 0xedea($k0)
	lui   $k0, 0x8010 //Check if in game and player is not starting or dead
	lbu   $k0, 0x8540($k0)
	ori   $k1, $zero, 0xc0
	bne   $k0, $k1, 0x7
	lui   $k0, 0x8010
	lw   $k1, 0x20c8($k0)
	lui   $k0, 0x8019 //Copy controller input into correct button activator
	sw   $k1, 0x6514($k0)
	lui   $k1, 0xff01 //Trick console/emulator into thinking controller is plugged in
	ori   $k1, $k1, 0x0401
	sw   $k1, 0x6510($k0)
	//P4
	lui   $k0, 0x8010 //Check if bot is on
	lb   $k1, 0x20d3($k0)
	beq   $k1, $zero, 0xe
	lui   $k0, 0x8019 //Auto select character for bot
	ori   $k1, $zero, 0x1
	sb   $k1, 0xedeb($k0)
	lui   $k0, 0x8010 //Check if in game and player is not starting or dead
	lbu   $k0, 0x9318($k0)
	ori   $k1, $zero, 0xc0
	bne   $k0, $k1, 0x7
	lui   $k0, 0x8010
	lw   $k1, 0x20cc($k0) //Copy controller input into correct button activator
	lui   $k0, 0x8019
	sw   $k1, 0x651c($k0)
	lui   $k1, 0xff01 //Trick console/emulator into thinking controller is plugged in
	ori   $k1, $k1, 0x0401
	sw   $k1, 0x6518($k0)


	//Enable mirror mode ("8118ED12 FF00")
	lui   $k0, 0x8019
	ori   $k1, $zero, 0xff00
	sh   $k1, 0xed12($k0)




	// //Test two playre vertical split screen
	// lui   $k0, 0x800e
	// lbu   $k1, 0xc533($k0)
	// ori   $k0, $zero, 0x1
	// bne   $k0, $k1, 0x3
	// lui   $k0, 0x800e
	// ori   $k1, $zero, 0x2
	// sb   $k1, 0xc533($k0)


	// //Test first person for player 1
	// //Load player 1 x position
	// lui   $k0, 0x800f
	// lw   $k1, 0x69a4($k0) //Load player x position
	// lui   $k0, 0x8016
	// sw   $k1, 0x46fc($k0) //Save camera x position
	// lui   $k0, 0x800f
	// lw   $k1, 0x69a8($k0) //Load player y position
	// lui   $k0, 0x8016
	// sw   $k1, 0x4700($k0) //Save camera y position
	// lui   $k0, 0x800f
	// lw   $k1, 0x69ac($k0) //Load player z position
	// lui   $k0, 0x8016
	// sw   $k1, 0x4704($k0) //Save camera z position
	// lui   $k0, 0x8000
	// sw   $zero, 0x158c($k0) //Nop camera function in all places
	// sw   $zero, 0x1838($k0) //Nop camera function in all places
	// sw   $zero, 0x1858($k0) //Nop camera function in all places
	// sw   $zero, 0x19e0($k0) //Nop camera function in all places
	// sw   $zero, 0x1a00($k0) //Nop camera function in all places
	// sw   $zero, 0x1bf8($k0) //Nop camera function in all places
	// sw   $zero, 0x1c18($k0) //Nop camera function in all places
	// sw   $zero, 0x1c38($k0) //Nop camera function in all places
	// sw   $zero, 0x1c58($k0) //Nop camera function in all places
	// // lui   $k0, 0x8010
	// // sw   $zero, 0x9578($k0) //Nop camera function in all places
	// // sw   $zero, 0x9594($k0) //Nop camera function in all places
	// // sw   $zero, 0x95ac($k0) //Nop camera function in all places
	// // sw   $zero, 0x95c8($k0) //Nop camera function in all places
	// // sw   $zero, 0x95e0($k0) //Nop camera function in all places
	// // sw   $zero, 0x95f8($k0) //Nop camera function in all places
	// // sw   $zero, 0x9610($k0) //Nop camera function in all places


]




crash_screen_gscode  = [
  '810045F0 0800', //Turn on build in crash screen to make debugging easier
  '810045F2 1192']
codeblock = codeblock + mk64_lib.gameshark_to_hex(crash_screen_gscode)

//Insert jump back to exception handler
code = [
	'j '+exceptionhadlerjumpbackaddr_hex_str, //Otherwise jump back to exception handler
    nop
	]
codeblock = codeblock + code

//Insert code block into rom
//hook_addr = 0xD1DB8 //Hook into exception handler preamble
//insert_code_here_addr = 0xE9E80 //PAL VI stuff?
//codeblock_addr = 0x58084  //somewhere in the debug
//mk64rom.insert_codeblock(hook_addr, codeblock_addr, codeblock)
//mk64rom.insert_codeblock(hook_addr, insert_code_here_addr, codeblock)
mk64rom.insert_code(codeblock_addr, codeblock)


exception_handler_code_addr_hex_str = format(codeblock_addr + mk64rom.rom_to_ram, '08x')

codeblock_addr = codeblock_addr + len(codeblock)*4 //+ 8




//Set big donut to be higher when flat courses are on so we are above the water level in order to avoid the terrible camera issues

//Set up the hook inside scale height multiplier code
mk64rom.insert_code(0x111D4C, ['j '+hex(codeblock_addr+mk64rom.rom_to_ram)])
//Set up code to check if big donut is loaded and then artificially raise it's height if it is
code = [
	lui   $a0, 0x8010 //Check if flat courses are set to on at 0x80102116
	lbu   $a0, 0x2116($a0)
	beq   $a0, $zero, 0x6
	lui   $a0, 0x800e //Check if course is Big donut, Grab current course from 0x800DC5A0
	lbu   $a0, 0xc5a1($a0)
	ori   $a3, $zero, 0x13
	bne   $a0, $a3, 0x2
	nop
	addi   $t3, $t3, 0x80 //Set course height to be higher to get it above the water level
	j    0x802a8740
	nop
]
mk64rom.insert_code(codeblock_addr, code)
codeblock_addr = codeblock_addr + len(code)*4 //+ 16






//Test setting positions for luigi's raceway when it loads into battle mode
//Set up hook inside player initializaiotn code for battle mode
mk64rom.insert_code(0x3D970, ['j '+hex(codeblock_addr+mk64rom.rom_to_ram), 'nop'])
//Set up code to set the player positions after the players are initialized
code = [
	// addi   $sp, $sp, 0xfe00
	// sw   $v0, 0x0010($sp)
	// sw   $v1, 0x0014($sp)
	// sw   $a0, 0x0018($sp)



	//Load current track from cup course index 0x8018EE0B
	lui   $v1, 0x800e
	lbu   $v1, 0xc5a1($v1)


	//Jump back if a battle course
	// //If course is
	ori   $v0, $zero, 0x13 //Big Donut
	beq   $v1, $v0, 0x9
	ori   $v0, $zero, 0x11 //double deck
	beq   $v1, $v0, 0x7
	ori   $v0, $zero, 0x10 //Skyscraper
	beq   $v1, $v0, 0x5
	ori   $v0, $zero, 0xf //Black Fort
	beq   $v1, $v0, 0x3
	nop
	beq   $zero, $zero, 0x3
	nop
	0x03E00008,//Run lines that were after the hook to jump back
	0x27BD0060,


	//Positions for Luigi's Raceway
	ori   $v0, $zero, 0x08
	bne   $v1, $v0, 0x7
	nop
	lui   $t1, 0xc2da
	lui   $t2, 0xc301
	lui   $t3, 0xc315
	lui   $t4, 0xc329
	lui   $a2, 0xc232
	lui   $a3, 0xc334
	//Positions for Moo Moo Farm
	ori   $v0, $zero, 0x09
	bne   $v1, $v0, 0x7
	nop
	lui   $t1, 0x4220
	lui   $t2, 0x41a0
	lui   $t3, 0x0000
	lui   $t4, 0xc1a0
	lui   $a2, 0x41bc
	lui   $a3, 0x427c
	//Positions for Koopa Troopa Beach
	ori   $v0, $zero, 0x06
	bne   $v1, $v0, 0x7
	nop
	lui   $t1, 0xc080
	lui   $t2, 0xc1c0
	lui   $t3, 0xc230
	lui   $t4, 0xc280
	lui   $a2, 0x40c7
	lui   $a3, 0x42de
	//Positions for Kalamari Desert
	ori   $v0, $zero, 0x0b
	bne   $v1, $v0, 0x7
	nop
	lui   $t1, 0x41f8
	lui   $t2, 0x4130
	lui   $t3, 0xc110
	lui   $t4, 0xc1e8
	lui   $a2, 0x40b0
	lui   $a3, 0x4403
	//Positions for Toad's Turnpike
	ori   $v0, $zero, 0x0a
	bne   $v1, $v0, 0x7
	nop
	lui   $t1, 0x41f0
	lui   $t2, 0x4120
	lui   $t3, 0xc120
	lui   $t4, 0xc1f0
	lui   $a2, 0x40b0
	lui   $a3, 0x4238
	//Positions for Frappe Snowland
	ori   $v0, $zero, 0x05
	bne   $v1, $v0, 0x7
	nop
	lui   $t1, 0x41d0
	lui   $t2, 0x40c0
	lui   $t3, 0xc160
	lui   $t4, 0xc208
	lui   $a2, 0x40b0
	lui   $a3, 0xc370
	//Positions for Choco Mountain
	ori   $v0, $zero, 0x01
	bne   $v1, $v0, 0x7
	nop
	lui   $t1, 0x41c0
	lui   $t2, 0x4080
	lui   $t3, 0xc180
	lui   $t4, 0xc210
	lui   $a2, 0x423c
	lui   $a3, 0xc428
	//Positions for Mario Raceway
	ori   $v0, $zero, 0x00
	bne   $v1, $v0, 0x7
	nop
	lui   $t1, 0x41f0
	lui   $t2, 0x4120
	lui   $t3, 0xc120
	lui   $t4, 0xc1f0
	lui   $a2, 0x40b0
	lui   $a3, 0xc34a
	//Positions for Wario Stadium
	ori   $v0, $zero, 0x0e
	bne   $v1, $v0, 0x7
	nop
	lui   $t1, 0x422c
	lui   $t2, 0x41b8
	lui   $t3, 0x4040
	lui   $t4, 0xc188
	lui   $a2, 0x40b0
	lui   $a3, 0x41a8
	//Positions for Sherbert Land
	ori   $v0, $zero, 0x0c
	bne   $v1, $v0, 0x7
	nop
	lui   $t1, 0x41a0
	lui   $t2, 0x0000
	lui   $t3, 0xc1a0
	lui   $t4, 0xc220
	lui   $a2, 0x40b0
	lui   $a3, 0x41f8
	//Positions for Royal Raceway
	ori   $v0, $zero, 0x07
	bne   $v1, $v0, 0x7
	nop
	lui   $t1, 0xc200
	lui   $t2, 0xc250
	lui   $t3, 0xc290
	lui   $t4, 0xc2b8
	lui   $a2, 0x40b0
	lui   $a3, 0xc396
	//Positions for Bowser's Castle
	ori   $v0, $zero, 0x02
	bne   $v1, $v0, 0x7
	nop
	lui   $t1, 0x4200
	lui   $t2, 0x4140
	lui   $t3, 0xc100
	lui   $t4, 0xc1e0
	lui   $a2, 0x40b0
	lui   $a3, 0xc31a
	//Positions for DK's Jungle Parkway
	ori   $v0, $zero, 0x12
	bne   $v1, $v0, 0x7
	nop
	lui   $t1, 0x4204
	lui   $t2, 0x4150
	lui   $t3, 0xc0e0
	lui   $t4, 0xc1d8
	lui   $a2, 0x40aa
	lui   $a3, 0x4204
	//Positions for Yoshi Valley
	ori   $v0, $zero, 0x04
	bne   $v1, $v0, 0x7
	nop
	lui   $t1, 0x41d8
	lui   $t2, 0x40e0
	lui   $t3, 0xc150
	lui   $t4, 0xc204
	lui   $a2, 0x4339
	lui   $a3, 0x4190
	//Positions for Banshee Boardwalk
	ori   $v0, $zero, 0x03
	bne   $v1, $v0, 0x7
	nop
	lui   $t1, 0x420c
	lui   $t2, 0x4170
	lui   $t3, 0xc0a0
	lui   $t4, 0xc1c8
	lui   $a2, 0x418c
	lui   $a3, 0xc23c
	//Positions for Rainbow Road
	ori   $v0, $zero, 0x0d
	bne   $v1, $v0, 0x8
	nop
	lui   $t1, 0x4210
	lui   $t2, 0x4180
	lui   $t3, 0xc080
	lui   $t4, 0xc1c0
	lui   $a2, 0x44bd
	ori   $a2, $a2, 0x8000
	lui   $a3, 0x4198


	//If in extra mode...(mirroed) mode, use the x starting positoins must be flipped from positive to negative
	lui   $a0, 0x800e //Load current CCs
	lbu   $t5, 0xc54b($a0)
	ori   $a0, $zero, 0x3
	bne   $t5, $a0, 0x54
	//Positions for Luigi's Raceway
	ori   $v0, $zero, 0x08
	bne   $v1, $v0, 0x5
	nop
	lui   $t1, 0x4329
	lui   $t2, 0x4315
	lui   $t3, 0x4301
	lui   $t4, 0x42da
	//Positions for Moo Moo Farm
	ori   $v0, $zero, 0x09
	bne   $v1, $v0, 0x5
	nop
	lui   $t1, 0x41a0
	lui   $t2, 0x0000
	lui   $t3, 0xc1a0
	lui   $t4, 0xc220
	//Positions for Koopa Troopa Beach
	ori   $v0, $zero, 0x06
	bne   $v1, $v0, 0x5
	nop
	lui   $t1, 0x4280
	lui   $t2, 0x4230
	lui   $t3, 0x41c0
	lui   $t4, 0x4080
	//Positions for Kalamari Desert
	ori   $v0, $zero, 0x0b
	bne   $v1, $v0, 0x5
	nop
	lui   $t1, 0x4118
	lui   $t2, 0x4110
	lui   $t3, 0xc130
	lui   $t4, 0xc1f8
	//Positions for Toad's Turnpike
	ori   $v0, $zero, 0x0a
	bne   $v1, $v0, 0x5
	nop
	lui   $t1, 0x41f0
	lui   $t2, 0x4120
	lui   $t3, 0xc120
	lui   $t4, 0xc1f0
	//Positions for Frappe Snowland
	ori   $v0, $zero, 0x05
	bne   $v1, $v0, 0x5
	nop
	lui   $t1, 0x4208
	lui   $t2, 0x4160
	lui   $t3, 0xc0c0
	lui   $t4, 0xc1d0
	//Positions for Choco Mountain
	ori   $v0, $zero, 0x01
	bne   $v1, $v0, 0x5
	nop
	lui   $t1, 0x4210
	lui   $t2, 0x4180
	lui   $t3, 0xc080
	lui   $t4, 0xc1c0
	//Positions for Mario Raceway
	ori   $v0, $zero, 0x00
	bne   $v1, $v0, 0x5
	nop
	lui   $t1, 0x41f0
	lui   $t2, 0x4120
	lui   $t3, 0xc120
	lui   $t4, 0xc1f0
	//Positions for Wario Stadium
	ori   $v0, $zero, 0x0e
	bne   $v1, $v0, 0x5
	nop
	lui   $t1, 0x4188
	lui   $t2, 0xc040
	lui   $t3, 0xc1b8
	lui   $t4, 0xc22c
	//Positions for Sherbert Land
	ori   $v0, $zero, 0x0c
	bne   $v1, $v0, 0x5
	nop
	lui   $t1, 0x4220
	lui   $t2, 0x41a0
	lui   $t3, 0x0000
	lui   $t4, 0xc1a0
	//Positions for Royal Raceway
	ori   $v0, $zero, 0x07
	bne   $v1, $v0, 0x5
	nop
	lui   $t1, 0x42b8
	lui   $t2, 0x4290
	lui   $t3, 0x4250
	lui   $t4, 0x4200
	//Positions for Bowser's Castle
	ori   $v0, $zero, 0x02
	bne   $v1, $v0, 0x5
	nop
	lui   $t1, 0x41e0
	lui   $t2, 0x4100
	lui   $t3, 0xc140
	lui   $t4, 0xc200
	//Positions for DK's Jungle Parkway
	ori   $v0, $zero, 0x12
	bne   $v1, $v0, 0x5
	nop
	lui   $t1, 0x41d8
	lui   $t2, 0x40e0
	lui   $t3, 0xc150
	lui   $t4, 0xc204
	//Positions for Yoshi Valley
	ori   $v0, $zero, 0x04
	bne   $v1, $v0, 0x5
	nop
	lui   $t1, 0x4204
	lui   $t2, 0x4150
	lui   $t3, 0xc0e0
	lui   $t4, 0xc1d8
	//Positions for Banshee Boardwalk
	ori   $v0, $zero, 0x03
	bne   $v1, $v0, 0x5
	nop
	lui   $t1, 0x41c8
	lui   $t2, 0x40a0
	lui   $t3, 0xc170
	lui   $t4, 0xc20c
	//Positions for Rainbow Road
	ori   $v0, $zero, 0x0d
	bne   $v1, $v0, 0x5
	nop
	lui   $t1, 0x41c0
	lui   $t2, 0x4080
	lui   $t3, 0xc180
	lui   $t4, 0xc210


	//General code for setting positions
	lui   $v0, 0x800f
	lui   $v1, 0x8010
	//x
	sw   $t1, 0x69a4($v0) //P1 x
	sw   $t2, 0x777c($v0) //P2 x
	sw   $t3, 0x8554($v1) //P3 x
	sw   $t4, 0x932c($v1) //P4 x
	//y
	sw   $a2, 0x69a8($v0) //P1 y
	sw   $a2, 0x7780($v0) //P2 y
	sw   $a2, 0x8558($v1) //P3 y
	sw   $a2, 0x9330($v1) //P4 y
	//z
	sw   $a3, 0x69ac($v0) //P1 z
	sw   $a3, 0x7784($v0) //P2 z
	sw   $a3, 0x855c($v1) //P3 z
	sw   $a3, 0x9334($v1) //P4 z
	//Set rotation
	ori   $a0, $zero, 0x8000
	sh   $a0, 0x69be($v0) //P1 rotation
	sh   $a0, 0x7796($v0) //P2 rotation
	sh   $a0, 0x856e($v1) //P3 rotation
	sh   $a0, 0x9346($v1) //P4 rotation

	//Set top speed for 50, 100, and 150 CC, since the battle mode top speed is a snail's pace
	lui   $a0, 0x800e //Load current CCs
	lbu   $a1, 0xc54b($a0)
	bne   $a1, $zero, 0x2 //If 50 CC, set top speed to 43910000 - 290
	nop
	ori   $a2, $zero, 0x4391
	ori   $a3, $zero, 0x1
	bne   $a1, $a3, 0x2 //If 100 CC, set top speed to 439B0000 - 310
	nop
	ori   $a2, $zero, 0x439b
	ori   $a3, $zero, 0x2
	bne   $a1, $a3, 0x2 //If 150 CC, set top speed to 43A00000 - 320
	nop
	ori   $a2, $zero, 0x43a0
	ori   $a3, $zero, 0x3
	bne   $a1, $a3, 0x2 //If extra mode, top speed is same as 100 CC, so set top speed to 439B0000 - 310
	nop
	ori   $a2, $zero, 0x439b
	lui   $a0, 0x800f //Update top speeds for four players
	sh   $a2, 0x6ba4($a0)
	sh   $a2, 0x797c($a0)
	lui   $a0, 0x8010
	sh   $a2, 0x8754($a0)
	sh   $a2, 0x952c($a0)


	//Disable lakitu reverse
	lui   $a0, 0x8008
	sw   $zero, 0xaa10($a0)

	0x03E00008,//Run lines that were after the hook to jump back (This copies the JR overwritten for the hook)
	0x27BD0060,
]
mk64rom.insert_code(codeblock_addr, code)
codeblock_addr = codeblock_addr + len(code)*4


// //Hide balloons in battle mode
// nop = ['nop']
// //mk64rom.insert_code(0x0006C408, nop) //Show one ballooon to make it easy to see each player
// mk64rom.insert_code(0x0006C42C, nop) //But hide the left and right balloons
// mk64rom.insert_code(0x0006C450, nop)

//Set lighting effect time to very short because lighting effect is used to indicate HP loss, and we don't actually want to shrink anyone
mk64rom.insert_code(0x8EF00, [0x28410040])




//Disable "Mario Raceway" time on title screen
mk64rom.insert_code(0x957D8, [0x00000000])


//Insert code into rom to force always battle on race courses (see https://sites.google.com/view/triclons-mario-kart-64-page/gameshark-codes/battle-mode-on-any-course)
//mk64rom.insert_code(0x3CDE8, [0x0800F263]) //Force battle mode initialization no matter what
//mk64rom.insert_code(0x7B510, nop) //Disable lakitu reverse
//mk64rom.insert_code(0x12A98, nop) //Crash fix by NOPing offending JAL instruction

//mk64rom.insert_code(0xF37D4, [0x00000000, 0x00000000]) //Test battle courses on mario raceway


// // //Nop function call causing Skyscraper to crash when you have 1 balloon
// // mk64rom.insert_code(0x2EDAC, [0x00000000])
// mk64rom.insert_code(0x1154A4, [jr    $ra'nop'])













//Recalculate the original ram/rom offsets since for the code below since this custom code is not loaded into the expansion pak memory
mk64rom.reload_ramrom_offsets()

//This code runs from a hook into the exception handler, if the main battle kart code has been DMAed, then the custom code that hooks into the exception handler is jumped to and allowed to run
boot_check_code = [
    lui   $k0, 0x8019 //Check if boot has finished and GS code has been copied from rom to ram by waiting for controllers to be set up
    lhu   $k0, 0x6500($k0)
    ori   $k1, $zero, 0xff01
    bne   $k0, $k1, 0x03 //If boot is finished...
    nop
    'j 0x'+exception_handler_code_addr_hex_str, //Jump to custom code
    nop
    'j '+exceptionhadlerjumpbackaddr_hex_str, //Otherwise jump back to exception handler
    nop
]

mk64rom.insert_code(custom_code_address + mk64rom.ram_to_rom, boot_check_code)

code = ['j '+hex(custom_code_address), 'nop'] //Jump to somewhere in the PAL VI code
mk64rom.insert_code(exception_handler_preamble_hook_address + mk64rom.ram_to_rom, code)

custom_code_address = custom_code_address + len(boot_check_code)*4

//Insert code that runs DMA copy
size_hex_str = format(int(codeblock_addr - end_of_rom_address), '08x')
run_dma_copy_code = [
    addi   $sp, $sp, 0xffe0
    sw   $a0, 0x0010($sp)
    sw   $a1, 0x0014($sp)
    sw   $a2, 0x0018($sp)
    sw   $ra, 0x001c($sp)


    'lui $a0 0x'+ramaddr_hex_str[0:4],  //Load RAM destination
    'ori $a0 $a0 0x'+ramaddr_hex_str[4:8],
    'lui $a1 0x'+romaddr_hex_str[0:4], //Load ROM source
    'ori $a1 $a1 0x'+romaddr_hex_str[4:8],
    'lui $a2 0x'+size_hex_str[0:4], //Load size
    'ori $a2 $a2 0x'+size_hex_str[4:8],
    'jal '+format(dma_copy_function_address, '08x'), //JAL DmaCopy
    nop

	lui   $a0, 0x8010 //Set default max HP
	ori   $a1, $zero, 0x3
	sh   $a1, 0x2000($a0)

	lui   $a0, 0x8010 //Set default countdown for hot potato (0xE10 is 1 minute, 0x708 is 30 seconds)
	ori   $a1, $zero, 0x708
	sh   $a1, 0x2108($a0)


	//Set default team deathmatch settings
	ori   $a1, $zero, 0x8cbc //Set default time limit to 10 minutes
	sw   $a1, 0x2010($a0)
	// ori   $a1, $zero, 0xa //Set default deathmatch max score to
	// sb   $a1, 0x2005($a0)


	//Set default game settings
	ori   $a2, $zero, 0x0
	sb   $a2, 0x2118($a0) //Default menu page is GAME
	nor   $a2, $zero, $zero //Sets boolean to compare to ON
	sb   $a2, 0x20f0($a0) //Items all on
	sb   $a2, 0x20f1($a0)
	sb   $a2, 0x20f2($a0)
	sb   $a2, 0x20f3($a0)
	sb   $a2, 0x20f4($a0)
	sb   $a2, 0x20f5($a0)
	sb   $a2, 0x20f6($a0)
	sb   $a2, 0x20f7($a0)

	sb   $zero, 0x2111($a0) //Widescreen default = 0 (off)
	//nor   $a2, $zero, $zero //Sets boolean to compare to ON
	sb   $zero, 0x2112($a0) //disable antialising default = 0 (0ff)
	sb   $zero, 0x2113($a0) //3P/4P music default = 0 (off)
	sb   $zero, 0x2114($a0) //Select same chars = 0 (off)
	sb   $zero, 0x2115($a0) //Inf. green shells = 0 (off)
	sb   $a2, 0x2110($a0) //Minimap display on
	sb   $zero, 0x211c($a0) //Ludicrous speed off



    lw   $a0, 0x0010($sp) //Load registers from stack
    lw   $a1, 0x0014($sp)
    lw   $a2, 0x0018($sp)
    lw   $ra, 0x001c($sp)
    addi   $sp, $sp, 0x20
    lui   $t6, 0x8030 //Run these two lines the hook replaced
    lui   $at, 0x1fff
    j    0x80000bf4 //Jump back to boot code after hook
    nop
]

mk64rom.insert_code(custom_code_address + mk64rom.ram_to_rom, run_dma_copy_code)


//Hook in boot for code that runs DMA copy
code = ['j ' + hex(custom_code_address), 'nop']
mk64rom.insert_code(0x17EC, code)


//Test zeroing out stuff

// mk64rom.insert_code(0x3CD24, ['nop']) //Try skipping the player position initis and see what happens
// mk64rom.insert_code(0x3CDE8, ['nop']) //Try skipping the player position initis and see what happens
// mk64rom.insert_code(0xEEAA4, [0x8003C12C]) //Try skipping the player position initis and see what happens


//mk64rom.insert_code(0x3D578, ['nop'])
// mk64rom.insert_code(0x3D4A8, ['lui $at 0xC220']) //shrink starting position distance for double deck
// mk64rom.insert_code(0x3D4B4, ['lui $at 0x4220'])
// mk64rom.insert_code(0x3D4E8, ['lui $at 0xC220'])
// mk64rom.insert_code(0x3D4F4, ['lui $at 0x4220'])

// mk64rom.insert_code(0x3D268, ['lui $at 0xC220']) //shrink starting position distance for block fort
// mk64rom.insert_code(0x3D274, ['lui $at 0x4220'])
// mk64rom.insert_code(0x3D2A8, ['lui $at 0xC220'])
// mk64rom.insert_code(0x3D2B4, ['lui $at 0x4220'])


//mk64rom.insert_code(0xEEB00, [0x42200000, 0xC2200000, 0x42200000, 0xC2200000]) //shrink starting position distance for big donut
//mk64rom.insert_code(0x3D4F4, [ori   $s0, $zero, 0x0 ].)

// //Test nopping functions and see what happens
// mk64rom.insert_code(0x3D95C, ['nop'])
