#include <stdbool.h>
#include "library/MarioKart.h"
#include "library/OKHeader.h"
#include "library/OKassembly.h"
#include "MarioKartMenu.h"
#include "MarioKartPractice.h"
#include "MarioKart3D.h"
#include "SharedFunctions.h"
#include "MarioKartObjects.h"


short *TKMChar = &ok_TKMChar;
short hsLabel = 99;
short asmBool = 0;
short courseSwapped = 0;
short startupSwitch = 0;
int courseValue = 3000;
int raceStatus = 0; //used to mirror g_startingIndicator to ensure code runs once.

//genericInput;

long dataLength = 0; //
long *targetAddress = &ok_Target;
long *sourceAddress = &ok_Source;
long *tempPointer = &ok_Pointer;
long *graphPointer = &GraphPtrOffset;
long currentHeaderAddress = 0;




int gpCourseIndex = 0;

short genericInput = 0;
short buttonPressed = 0; //
int hsID = 0;
int hsGP = 0;
short gpTimeCheck = 0;

float gpTotalTime = 0;

int previewBuffer = 0x98D65D0;



void runDMA()
{
	DMA(*targetAddress, *sourceAddress, dataLength);
}
void runRAM()
{
	ramCopy(*targetAddress, *sourceAddress, dataLength);
}
void runMIO()
{
	decodeMIO0(*sourceAddress, *targetAddress);
}
void runTKM()
{
	decodeTKMK(*sourceAddress, tempPointer, *targetAddress, 0xBE);
}


void loadLogo()
{
	//left as example
	/*
	SetSegment(8,(int)(&ok_Logo));
	ok_Source = (int)(&LogoROM);
	ok_Target = (int)(&ok_FreeSpace);
	dataLength = 0x3888;
	runDMA();
	ok_Source = (int)(&ok_FreeSpace);
	ok_Target = (int)(&ok_Logo);
	runMIO();
	g_NintendoLogoOffset = 0x080059E8;
	g_NintendoLogoBorder = 0x256B9478;
	*/

}


void okSetup(void)
{
	//runs once at startup
	loadLogo();
	startupSwitch = 35;
	nopASM = 0;
	DisplayNOPA = 0;
	DisplayNOPB = 0;
	CollisionNOPA = 0;
	CollisionNOPB = 0;


	DisplayJumpA = (0x3C010000 | ((((long)&DisplayHopTable >> 16) + 1) & 0x0000FFFF));
	DisplayJumpB = (0x8C2D0000 | ((long)&DisplayHopTable & 0x0000FFFF));

	CollisionJumpA = (0x3C010000 | ((((long)&CollisionJumpTable >> 16) + 1) & 0x0000FFFF));
	CollisionJumpB = (0x8C2B0000 | ((long)&CollisionJumpTable & 0x0000FFFF));
}

bool CheckRaceResults()
{
	//returns true if the GP mode should advance (did the players win?)
	if (g_playerCount == 0x01)
	{
		if (g_playerPosition1 <= 3)
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	else
	{
		if ((g_playerPosition1 <= 3) || (g_playerPosition2 <= 3))
		{
			return true;
		}
		else
		{
			return false;
		}
	}
}



void startRace()
{
	//runs at start of race
}

void endRace()
{
	//runs at end of race
}




void gameCode(void)
{
	//this code runs once every frame while rendering gameplay.



	if (g_startingIndicator == 0x03)
	{
		raceStatus = 0x03;
	}
	if (g_startingIndicator == 0x02)
	{
		if (raceStatus != 0x02)
		{
			raceStatus = 0x02;
			startRace();
		}

	}
	if (g_startingIndicator == 0x05)
	{
		if (raceStatus != 0x05)
		{
			raceStatus = 0x05;
			endRace();
		}
	}



}



//
//
//
void allRun(void)
{
	//this code runs once every frame all game.
	if (startupSwitch != 35)
	{
		okSetup();
	}

}
