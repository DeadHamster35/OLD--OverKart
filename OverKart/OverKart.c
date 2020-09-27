#include <stdbool.h>
#include "library/MarioKart.h"
#include "library/OKHeader.h"
#include "MarioKartMenu.h"
#include "MarioKartStats.h"
#include "MarioKartPractice.h"
#include "MarioKartAI.h"
#include "CustomLevels.h"

extern long bannerN;
extern long bannerU;
extern long previewN;
extern long previewU;
extern long set0;
extern long set1;
extern long set2;
extern long set3;
extern long set4;

char hsLabel = 99;
char asmBool = 0;
char courseSwapped = 0;
char startupSwitch = 0;
short courseValue = 99;

//genericInput;

long dmaLength = 0; //
long *dmaTarget = &ok_dmaTarget;
long *dmaSource = &ok_dmaSource;
long *mioTarget = &ok_mioTarget;
long *mioSource = &ok_mioSource;


int gameMode[4] = {0,0,0,0};
int modMode[4] = {0,0,0,0};
int renderMode[4] = {0,0,0,0};

char genericInput = 0;
char buttonPressed = 0; //
char hsID = 0;
char hsGP = 0;
char gpTimeCheck = 0;

float gpTotalTime = 0;

int previewBuffer = 0x98D65D0;



void runDMA()
{
	DMA(*dmaTarget, *dmaSource, dmaLength);
}

void setSongSpeed(void)
{
	if (hsID > 0)
	{
		songID = ok_Song;
		if (renderMode[3] == 0x00)
		{
			tempo1A = 0x240F0000;
			tempo1B = 0x240F0000;
			tempo1AS = ok_SpeedA;
			tempo1BS = ok_SpeedA;

			tempo2A = 0x24090000;
			tempo2B = 0x24090000;
			tempo2AS = ok_SpeedB;
			tempo2BS = ok_SpeedB;

			tempo3A = 0x240A0000;
			tempo3B = 0x240A0000;
			tempo3AS = ok_SpeedC;
			tempo3BS = ok_SpeedC;
		}
	}
	else
	{
		tempo1A = 0x3C0F8015;
		tempo1B = 0x8DEF0114;

		tempo2A = 0x3C098015;
		tempo2B = 0x8D290114;

		tempo3A = 0x3C0A8015;
		tempo3B = 0x8D4A0114;
	}

}
void setASM(void)
{
	if (ok_ASMOffset == 0)
	{
		asmBool = 0x00;
	}
	else
	{
		asmBool = 0x01;
		dmaLength = ok_ASMEnd - ok_ASMOffset;
		*dmaTarget = 0x80500000;
		*dmaSource = (long)&ok_ASMOffset;
		DMA(*dmaTarget, *dmaSource, dmaLength);
	}
}
void setSky(void)
{
	if (hsID > 0)
	{
		*dmaTarget = (long)&g_skyColorTop;
		*dmaSource = (long)&ok_SkyOffset;
		dmaLength = 0x0C;
		DMA(*dmaTarget, *dmaSource, dmaLength);
	}
	else
	{
		*dmaTarget = (long)&g_skyColorTop;
		*dmaSource = 0x1220E0;
		dmaLength = 0x0C;
		DMA(*dmaTarget, *dmaSource, dmaLength);
	}
}






void loadCourseHeader(void)
{
		*dmaTarget = 0x802B8D80;
		*dmaSource = (0xBFDA80 + (courseValue * 0x64) + ((hsID-1) * 0x7D0) + 0x34);
		dmaLength = 0x30;
		DMA(*dmaTarget, *dmaSource, dmaLength);
}


void loadOKHeader()
{

	//first load the OK64 header into expansion RAM
	*dmaTarget = 0x80417000;
	*dmaSource = (0xBFDA80 + ((hsID-1) * 0x7D0) + (courseValue * 0x64));
	dmaLength = 0x34;
	DMA(*dmaTarget, *dmaSource, dmaLength);


}

void loadHotSwap(void)
{
	if (hsID > 0)
	{

		loadOKHeader();
		//now load the Mario Kart 64 header into it's location in RAM.
		*dmaTarget = 0x802B8D80;
		*dmaSource = (0xBFDA80 + 0x34 + ((hsID-1) * 0x7D0) + (courseValue * 0x64));
		dmaLength = 0x30;
		DMA(*dmaTarget, *dmaSource, dmaLength);

		courseSwapped = 1;
	}
	else
	{
		*dmaSource = 0x122390;
		*dmaTarget = 0x802B8D80;
		dmaLength = 0x30;
		DMA(*dmaTarget, *dmaSource, dmaLength);
		courseSwapped = 1;
		ok_ASMOffset = 0x00;
	}

	setSky();
	setSongSpeed();
	setASM();
}

void setLabel(void)
{
	*mioTarget = (long)&g_bannerTexture;

	switch (hsID)
	{
		case 0x00:
		{

			*mioSource = (long)&set0;
			decodeMIO0(*mioSource, *mioTarget);
			break;
		}
		case 0x01:
		{
			*mioSource = (long)&set1;
			decodeMIO0(*mioSource, *mioTarget);
			break;
		}
		case 0x02:
		{
			*mioSource = (long)&set2;
			decodeMIO0(*mioSource, *mioTarget);
			break;
		}
		case 0x03:
		{
			*mioSource = (long)&set3;
			decodeMIO0(*mioSource, *mioTarget);
			break;
		}
		case 0x04:
		{
			*mioSource = (long)&set4;
			decodeMIO0(*mioSource, *mioTarget);
			break;
		}

	}
	hsLabel = hsID;
}

/*
void setPreviews()
{

	//1F40

	//2F80
	if (hsID > 0)
	{
		*dmaTarget = (long)&ok_previewOffset;

		*dmaSource = (0xBFF9C0 + ((hsID-1) * 0x100));
		dmaLength = 0x100;
		DMA(*dmaTarget, *dmaSource, dmaLength);

		*dmaTarget = (long)&ok_previewTemp;

		dmaLength = 0x4E10;
		for(int currentCourse = 0; currentCourse < 4; currentCourse++)
		{
			*dmaSource = *(&ok_previewOffset + (g_cupSelect * 16) + (currentCourse * 4));
			if (*dmaSource != 0xFFFFFFFF)
			{
				if (*dmaSource != 0x00000000)
				{
					*mioSource = (long)&ok_previewTemp;
					DMA(*dmaTarget,*dmaSource,dmaLength);
					*mioTarget = (long)(&g_previewTexture + (currentCourse * 0x2708));
					decodeMIO0(*mioSource,*mioTarget);
					*mioTarget = (*mioTarget + 0x4E10);
					decodeMIO0(*mioSource,*mioTarget);
				}
				else
				{
					*mioSource = (long)&previewU;
					*mioTarget = (long)(&g_previewTexture + (currentCourse * 0x2708));
					decodeMIO0(*mioSource,*mioTarget);
					*mioTarget = (*mioTarget + 0x4E10);
					decodeMIO0(*mioSource,*mioTarget);
				}
			}
			else
			{
				*mioSource = (long)&previewN;
				*mioTarget = (long)(&g_previewTexture + (currentCourse * 0x2708));
				decodeMIO0(*mioSource,*mioTarget);
				*mioTarget = (*mioTarget + 0x4E10);
				decodeMIO0(*mioSource,*mioTarget);
			}
		}
	}
	else
	{
		//0x98D65D0

		*dmaTarget = (long)&ok_previewTemp;

		dmaLength = 0x4E10;
		for(int currentCourse = 0; currentCourse < 4; currentCourse++)
		{
			*dmaSource = *(&g_cup0preview0 + (g_cupSelect * 16) + (currentCourse * 4));

					*mioSource = (long)&ok_previewTemp;
					DMA(*dmaTarget,*dmaSource,dmaLength);
					*mioTarget = (long)(&g_previewTexture + (currentCourse * 0x2708));
					decodeMIO0(*mioSource,*mioTarget);
					*mioTarget = (*mioTarget + 0x4E10);
					decodeMIO0(*mioSource,*mioTarget);

	}
}
*/
void swapHS(int direction)
{
	if (direction == 0)
	{
		if  (hsID > 0)
		{
			if (hsID == 1)
			{
				stockASM();
			}
			hsID = hsID - 1;
			playSound(0x4900801A);
			buttonPressed = 1;
		}
	}
	else
	{
		if  (hsID < 4)
		{
			if (hsID == 0)
			{
				customASM();
			}
			hsID = hsID + 1;
			playSound(0x4900801A);
			buttonPressed = 1;
		}
	}
}



void okSetup(void)
{
	startupSwitch = 35;
	nopASM = 0x00000000;
	hsID = 0;

	// Set startup flag to 1. Ensures setup is only run 1 time.



	g_farClip = 20000;

	asm_SongA = 0x240E0001;
	asm_SongB = 0x240E0001;
	asm_selectA = 0x2400;
	asm_selectC = 0x2400;
	asm_selectE = 0x2400;
	asm_selectB = 0x7FFF;
	asm_selectD = 0x7FFF;
	asm_selectF = 0x7FFF;

	hsGP = 0;
}




void gameCode(void)
{


	printAnticheat();

	if (modMode[0] > 0x00)
	{
		practiceHack();
	}
	if (modMode[1] > 0x00)
	{
		drawInputDisplay();
	}

	if (modMode[2] > 0x00)
	{
		printDetails();
	}

	if (asmBool > 0x00)
	{
		//ok_ASMJump();
	}



	g_farClip = 20000;

}



//
//
//
bool checkEndGame()
{
	if (g_playerCount == 0x01)
	{
		if (g_gameLapPlayer1 == 3)
		{
			if (g_playerCount == 0x01)
			{
				if (g_playerPosition1 <= 4)
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
				if ((g_playerPosition1 <= 4) | (g_playerPosition2 <= 4))
				{
					return true;
				}
				else
				{
					return false;
				}
			}
		}
		else
		{
			return false;
		}
	}
	else
	{
		if ((g_gameLapPlayer1 == 3) | (g_gameLapPlayer2 == 3))
		{
			if (g_playerCount == 0x01)
			{
				if (g_playerPosition1 <= 4)
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
				if ((g_playerPosition1 <= 4) | (g_playerPosition2 <= 4))
				{
					return true;
				}
				else
				{
					return false;
				}
			}
		}
		else
		{
			return false;
		}
	}

}


void allRun(void)
{

	if ((hsID > 0) & (g_gameMode == 0x00) & (checkEndGame()))
	{
		menuScreenA = 0x00;
		g_loadedcourseFlag = 0xF0;
		gpTimeCheck = 0x00;
		courseValue++;
		loadCourseHeader();
		loadOKHeader();
	}
	if ((hsID > 0) & (g_gameLapPlayer1 == 0x03) & (gpTimeCheck == 0x00))
	{
		gpTimeCheck = 0x01;
		gpTotalTime += g_raceTime;
	}
	if (startupSwitch != 35)
	{
		okSetup();
	}

	modCheck();






	if (SYSTEM_Region == 0x01)
	{
		if (inGame == 0x00)
		{

			if (p_Input > 0)
			{
				genericInput = p_Input;
			}
			else
			{
				genericInput = d_Input;
			}
			if (genericInput == 0x00)
			{
				buttonPressed = 0;   //set the boolean that tells the game a button is held down to false
			}




			if (((menuScreenA >= 0x02) & (menuScreenB == 0x01)) & (buttonPressed == 0))
			{
				if (genericInput == 0x20)  // L and Z, how convenient!
				{
					swapHS(0);
				}
				if (genericInput == 0x10)  // R!
				{
					swapHS(1);

				}
				if (hsLabel != hsID)
				{
					setLabel();
					if (hsID > 0)
					{
						//setPreviews();
					}
				}

			}
			//

			//delete this soon
			// need more info on course tables and jumps
			if (hsID > 0x00)
			{
				g_courseID = 0x00;
			}


			switch(g_gameMode)
			{
				//GRAND PRIX
				/*
				case 0x00:
				{

					if ((menuScreenA >= 2) & (hsID > 0))
					{
						if (courseValue != (g_cupSelect * 10))
						{
							courseValue = (g_cupSelect * 10);
							loadCourseHeader();
							loadOKHeader();
							//setPreviews();
						}
					}

					break;
				}
				*/
				//TT
				case 0x01:
				{
					if ((menuScreenA >= 2) & (hsID > 0))
					{
						if (courseValue != (g_cupSelect * 10) + (g_courseSelect))
						{

							if ((courseValue + 6 <  (g_cupSelect * 10) + (g_courseSelect)) | ((courseValue - 6 >  (g_cupSelect * 10) + (g_courseSelect))))
							{
								//setPreviews();
							}
							courseValue = (g_cupSelect * 10) + (g_courseSelect);
							loadHotSwap();
						}
					}
					break;
				}

				//VS
				case 0x02:
				{
					if ((menuScreenA >= 2) & (hsID > 0))
					{
						if (courseValue != (g_cupSelect * 10) + (g_courseSelect))
						{
							courseValue = (g_cupSelect * 10) + (g_courseSelect);
							loadHotSwap();
						}
					}
					break;
				}

			}

		}
	}
}
