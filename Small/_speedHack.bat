mips64-elf-gcc -Wall -O1 -mtune=vr4300 -march=vr4300 -mabi=32 -fomit-frame-pointer -G0 -c "speedhack\fastswap.c"
armips speedhack\main.asm
n64crc "speedhack\!SpeedHack.z64"