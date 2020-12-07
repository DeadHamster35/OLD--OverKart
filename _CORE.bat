cls
ARMIPS\bin\mips64-elf-gcc -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "Core\Core.c" -o "Core\Core.o"
ARMIPS\bin\mips64-elf-gcc -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "Core\MarioKartMenu.c" -o "Core\MarioKartMenu.o"
ARMIPS\bin\mips64-elf-gcc -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "Core\MarioKartPractice.c" -o "Core\MarioKartPractice.o"
ARMIPS\bin\mips64-elf-gcc -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "Core\MarioKart3D.c" -o "Core\MarioKart3D.o"
ARMIPS\bin\mips64-elf-gcc -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "Core\MarioKartObjects.c" -o "Core\MarioKartObjects.o"
ARMIPS\bin\mips64-elf-gcc -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "Core\SharedFunctions.c" -o "Core\SharedFunctions.o" 
ARMIPS\bin\armips "Core\MAKE.asm"
ARMIPS\bin\n64crc "Core\ROM\mod.z64"
