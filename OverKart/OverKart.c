#include <stdbool.h>
#include "library/MarioKart.h"
#include "library/OKHeader.h"
#include "library/OKassembly.h"
#include "MarioKartMenu.h"
#include "MarioKartStats.h"
#include "MarioKartPractice.h"
#include "MarioKartAI.h"
#include "CustomLevels.h"
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


int gameMode[5] = {0,0,0,0,0};
int modMode[5] = {0,0,0,0,0};
int renderMode[4] = {0,0,0,0};

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

}


void okSetup(void)
{
	loadHeaderOffsets();
	loadLogo();
	startupSwitch = 35;
	nopASM = 0;
	DisplayNOPA = 0;
	DisplayNOPB = 0;
	CollisionNOPA = 0;
	CollisionNOPB = 0;
	//SetObjectNOPA = 0;
	//SetObjectNOPB = 0;
	hsID = 0;
	asm_SongA = 0x240E0001;
	asm_SongB = 0x240E0001;
	asm_selectA = 0x2400;
	asm_selectC = 0x2400;
	asm_selectE = 0x2400;
	asm_selectB = 0x7FFF;
	asm_selectD = 0x7FFF;
	asm_selectF = 0x7FFF;
	hsGP = 0;


	DisplayHopA = (0x3C010000 | ((((long)&DisplayHopTable >> 16) + 1) & 0x0000FFFF));
	DisplayHopB = (0x8C2D0000 | ((long)&DisplayHopTable & 0x0000FFFF));

	CollisionJumpA = (0x3C010000 | ((((long)&CollisionJumpTable >> 16) + 1) & 0x0000FFFF));
	CollisionJumpB = (0x8C2B0000 | ((long)&CollisionJumpTable & 0x0000FFFF));

	SetObjectTableA = (0x3C010000 | ((((long)&AddObjectTable >> 16) + 1) & 0x0000FFFF));
	SetObjectTableB = (0x8C390000 | ((long)&AddObjectTable & 0x0000FFFF));
}

bool checkEndGame()
{
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
	loadCoin();
	if (hsID > 0)
	{
		loadMinimap();
		setWater();
		long PathAddress = GetRealAddress(ok_RedCoinList);
		RedCoinChallenge(PathAddress);

	}
}

void endRace()
{
	if (g_gameMode == 0x00)
	{
		if (checkEndGame())
		{
			g_loadedcourseFlag = 0xF0;
			gpTotalTime += g_raceTime;
			gpCourseIndex++;
			if (hsID > 0)
			{
				loadHotSwap(gpCourseIndex);
				*tempPointer = courseValue;
			}
		}
	}
}




void gameCode(void)
{


	printAnticheat();


	if (modMode[0] > 0 || modMode[1] > 0)
	{
		practiceHack();
	}
	if (modMode[2] > 0x00)
	{
		drawInputDisplay();
	}

	if (modMode[3] > 0x00)
	{
		printDetails();
	}

	if (asmBool > 0x00)
	{
		ok_ASMJump();
	}



	if ((hsID > 0) || (renderMode[3] == 1))
	{
		g_farClip = 20000;
	}
	else
	{
		g_farClip = 6800;
	}

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
		if (g_gameMode == 0x00)
		{
			printGPTime(gpTotalTime);
			hsTableSet();
		}
		/*
		*sourceAddress = *(long*)(&ok_CourseHeader + 0xE);
		*targetAddress = (long)&ok_Credits;
		dataLength = 36;

		if ((hsID > 0) && (*sourceAddress != 0x00000000))
		{
    		 	runDMA();
			int stringLength = *(long*)(&ok_Credits);
			loadFont();
			printString( (140 - (stringLength * 4)), 150, (char*)(&ok_Credits + 1));
		}
		*/

	}
	if (g_startingIndicator == 0x05)
	{
		if (raceStatus != 0x05)
		{
			raceStatus = 0x05;
			endRace();
		}
		if (g_gameMode == 0x00)
		{
			printGPTime(gpTotalTime);
		}
	}



}
void resetMap()
{
	gpTotalTime = 0;
	gpCourseIndex = 0;
}



//
//
//
void allRun(void)
{

	if (startupSwitch != 35)
	{
		okSetup();
	}

	modCheck();


	if (gameMode[2] > 0x00)
	{
		asm_CupCount = 15;
	}
	else
	{
		asm_CupCount = 3;
	}






	if (SYSTEM_Region == 0x01)
	{

		if (g_InGame == 0x00)
		{

			if (p_Input > 0)
			{
				genericInput = (short)p_Input;
			}
			else
			{
				genericInput = (short)d_Input;
			}
			if (genericInput == 0x00)
			{
				buttonPressed = 0;   //set the boolean that tells the game a button is held down to false
			}


			if (menuScreenC < 2)
			{
				hsID = 0;

			}

			if ((menuScreenC >= 0x02) && (menuScreenA == 0x01) && (buttonPressed == 0))
			{

				if (genericInput == 0x20)  // L and Z, how convenient!
				{
					swapHS(0);
					buttonPressed = 1;
				}
				if (genericInput == 0x10)  // R!
				{
					swapHS(1);
					buttonPressed = 1;
				}
				resetMap();

			}


			//

			//delete this soon
			// need more info on course tables and jumps

			if (hsID > 0)
			{
				g_courseID = 0x00;

			}


			switch(g_gameMode)
			{
				//GRAND PRIX

				case 0x00:
				{

					if ((menuScreenC >= 2))
					{
						if (courseValue != (g_cupSelect * 4) + ((hsID-1) * 0x10))
						{
							courseValue = (g_cupSelect * 4) + ((hsID-1) * 0x10);
							loadHotSwap(0);
						}
					}

					break;
				}

				//TT
				case 0x01:
				{
					if ((menuScreenC >= 2))
					{
						if (courseValue != (g_cupSelect * 4) + g_courseSelect + ((hsID-1) * 0x10))
						{

							courseValue = (g_cupSelect * 4) + g_courseSelect + ((hsID-1) * 0x10);
							loadHotSwap(0);
						}
					}

					break;
				}

				//VS
				case 0x02:
				{
					if ((menuScreenC >= 2))
					{
						if (courseValue != (g_cupSelect * 4) + g_courseSelect + ((hsID-1) * 0x10))
						{

							courseValue = (g_cupSelect * 4) + g_courseSelect + ((hsID-1) * 0x10);
							loadHotSwap(0);
						}
					}
					break;
				}

			}


		}
	}

}


void MenuPrint()
{
	PrintMenuTest();
}
