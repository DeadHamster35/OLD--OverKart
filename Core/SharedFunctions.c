#include <stdbool.h>
#include "library/SubProgram.h"
#include "library/MarioKart.h"
#include "library/OKHeader.h"
#include "library/OKassembly.h"
#include "MarioKartMenu.h"
#include "MarioKartPractice.h"
#include "Core.h"


int GetRealAddress(int RSPAddress)
{
	int number = SegmentNumber(RSPAddress);
	int offset = SegmentOffset(RSPAddress);

	return(PhysToK0(SegmentTable[number] + offset));
}
