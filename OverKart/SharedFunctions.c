#include <sys/types.h>
#include <math.h>
#include <stdbool.h>
#include "library/SubProgram.h"
#include "library/MarioKart.h"
#include "library/OKHeader.h"
#include "library/OKassembly.h"
#include "MarioKartMenu.h"
#include "MarioKartStats.h"
#include "MarioKartPractice.h"
#include "MarioKartAI.h"
#include "CustomLevels.h"
#include "OverKart.h"


int GetRealAddress(int RSPAddress)
{
	int number = SegmentNumber(RSPAddress);
	int offset = SegmentOffset(RSPAddress);

	return(PhysToK0(SegmentTable[number] + offset));
}

static const char *hex = "0123456789ABCDEF";
char* printHex(char *buf, uint num, int nDigits) {
    //print hex number into buffer.
    //will zero-pad to specified number of digits.
    //will truncate numbers larger than specified length.
    //returns pointer to null terminator.
    char *bufEnd = &buf[nDigits];
    *bufEnd = 0;
    while(nDigits--) {
        buf[nDigits] = hex[num & 0xF];
        num >>= 4;
    }
    return bufEnd;
}
