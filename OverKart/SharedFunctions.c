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
