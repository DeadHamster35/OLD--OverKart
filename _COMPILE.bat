cls
ARMIPS\bin\mips64-elf-gcc -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "OverKart\OverKart.c" -o "OverKart\OverKart.o"
ARMIPS\bin\mips64-elf-gcc -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "OverKart\CustomLevels.c" -o "OverKart\CustomLevels.o"
ARMIPS\bin\mips64-elf-gcc -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "OverKart\MarioKartMenu.c" -o "OverKart\MarioKartMenu.o"
ARMIPS\bin\mips64-elf-gcc -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "OverKart\MarioKartPractice.c" -o "OverKart\MarioKartPractice.o"
ARMIPS\bin\mips64-elf-gcc -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "OverKart\MarioKartStats.c" -o "OverKart\MarioKartStats.o"
ARMIPS\bin\mips64-elf-gcc -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "OverKart\MarioKartAI.c" -o "OverKart\MarioKartAI.o"
ARMIPS\bin\mips64-elf-gcc -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "OverKart\MarioKart3D.c" -o "OverKart\MarioKart3D.o"
ARMIPS\bin\mips64-elf-gcc -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "OverKart\MarioKartObjects.c" -o "OverKart\MarioKartObjects.o"
ARMIPS\bin\mips64-elf-gcc -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "OverKart\SharedFunctions.c" -o "OverKart\SharedFunctions.o" 
ARMIPS\bin\armips "OverKart\OverKart3.asm"
ARMIPS\bin\n64crc "OverKart\ROM\BASE.z64"
