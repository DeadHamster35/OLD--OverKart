#include <stdbool.h>
#include "library/MarioKart.h"
#include "library/OKHeader.h"
#include "library/OKassembly.h"
#include "MarioKartMenu.h"
#include "MarioKartPractice.h"
#include "MarioKart3D.h"
#include "SharedFunctions.h"
#include "MarioKartObjects.h"



short hsLabel = 99;
short asmBool = 0;
short courseSwapped = 0;
short startupSwitch = 0;
int courseValue = 3000;
int raceStatus = 0; //used to mirror g_startingIndicator to ensure code runs once.

//genericInput;





int gpCourseIndex = 0;

short genericInput = 0;
short buttonPressed = 0; //
int hsID = 0;
int hsGP = 0;
short gpTimeCheck = 0;

float gpTotalTime = 0;

int previewBuffer = 0x98D65D0;




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
	// it does NOT allow printing graphics or text.
	if (startupSwitch != 35)
	{
		okSetup();
	}

}

void MenuPrint()
{
	// this code will run during non-gameplay and allow for printing graphics/text.
}


void draw_kart3P()
{
    for(int kart_num = 0; kart_num < 8; kart_num++)
    {
        if (kart_num == 0)
        {
            DMABuffer(mykart1, gCamera3, kart_num, 2);
        }
        else
        {
            DMABuffer(kart1+(kart_num*0x4), gCamera3, kart_num, 2);
        }
        DrawBuffer(kart1+(kart_num*0x4), kart_num, 2);
        if(DMAKartCount!=0)
        {
            CheckDMA3P();
        }
        else{
            if (kart_num == 0)
            {
                SmokeDisp3P(kart1+(kart_num*0x4), kart_num, 2);
            }
            else
            {
                SmokeDisp3P(kart1+(kart_num*0x4), kart_num, 2);
            }
        }
        DMAKartCount = 0;

    }
}

void draw_kart4P()
{
    for (int kart_num=0; kart_num < 8; kart_num++)
    {
        if (kart_num == 0)
        {
            DMABuffer(mykart1, gCamera4, kart_num, 3);
        }
        else
        {
            DMABuffer(kart1+(kart_num*0x4), gCamera4, kart_num, 3);
        }
        DrawBuffer(kart1+(kart_num*0x4), kart_num, 3);
        if(DMAKartCount!=0)
        {
            CheckDMA4P();
        }
        else{
            if (kart_num == 0)
            {
                SmokeDisp4P(kart1+(kart_num*0x4), kart_num, 3);
            }
            else
            {
                SmokeDisp4P(kart1+(kart_num*0x4), kart_num, 3);
            }
        }
        DMAKartCount = 0;

    }
}
