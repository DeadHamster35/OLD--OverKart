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



void draw_kart()
{
    DMABuffer(mykart1,gCamera1,0,0);
    DMABuffer(kart2,gCamera1,1,0);
    DMABuffer(kart3,gCamera1,2,0);
    DMABuffer(kart4,gCamera1,3,0);
    DMABuffer(kart5,gCamera1,4,0);
    DMABuffer(kart6,gCamera1,5,0);
    DMABuffer(kart7,gCamera1,6,0);
    DMABuffer(kart8,gCamera1,7,0);

    DrawBuffer(kart1,0,0);
    DrawBuffer(kart2,1,0);
    DrawBuffer(kart3,2,0);
    DrawBuffer(kart4,3,0);
    DrawBuffer(kart5,4,0);
    DrawBuffer(kart6,5,0);
    DrawBuffer(kart7,6,0);
    DrawBuffer(kart8,7,0);

   if(DMAKartCount!=0)
   {
       CheckDMA();
   }
   else
   {
	  SmokeDisp(mykart1,0,0);
	  SmokeDisp(kart2,1,0);
	  SmokeDisp(kart3,2,0);
	  SmokeDisp(kart4,3,0);
	  SmokeDisp(kart5,4,0);
	  SmokeDisp(kart6,5,0);
	  SmokeDisp(kart7,6,0);
	  SmokeDisp(kart8,7,0);
   }
   DMAKartCount = 0;


}


void draw_kart2P()
{
    DMABuffer(mykart1,gCamera2,0,1);
    DMABuffer(kart2,gCamera2,1,1);
    DMABuffer(kart3,gCamera2,2,1);
    DMABuffer(kart4,gCamera2,3,1);
    DMABuffer(kart5,gCamera2,4,1);
    DMABuffer(kart6,gCamera2,5,1);
    DMABuffer(kart7,gCamera2,6,1);
    DMABuffer(kart8,gCamera2,7,1);

    DrawBuffer(kart1,0,1);
    DrawBuffer(kart2,1,1);
    DrawBuffer(kart3,2,1);
    DrawBuffer(kart4,3,1);
    DrawBuffer(kart5,4,1);
    DrawBuffer(kart6,5,1);
    DrawBuffer(kart7,6,1);
    DrawBuffer(kart8,7,1);

   if(DMAKartCount!=0)
   {
       CheckDMA2P();
   }
   else
   {
	  SmokeDisp2P(mykart1,0,1);
	  SmokeDisp2P(kart2,1,1);
	  SmokeDisp2P(kart3,2,1);
	  SmokeDisp2P(kart4,3,1);
	  SmokeDisp2P(kart5,4,1);
	  SmokeDisp2P(kart6,5,1);
	  SmokeDisp2P(kart7,6,1);
	  SmokeDisp2P(kart8,7,1);
   }
   DMAKartCount = 0;


}


void draw_kart3P()
{
    DMABuffer(mykart1,gCamera3,0,2);
    DMABuffer(kart2,gCamera3,1,2);
    DMABuffer(kart3,gCamera3,2,2);
    DMABuffer(kart4,gCamera3,3,2);
    DMABuffer(kart5,gCamera3,4,2);
    DMABuffer(kart6,gCamera3,5,2);
    DMABuffer(kart7,gCamera3,6,2);
    DMABuffer(kart8,gCamera3,7,2);

    DrawBuffer(kart1,0,2);
    DrawBuffer(kart2,1,2);
    DrawBuffer(kart3,2,2);
    DrawBuffer(kart4,3,2);
    DrawBuffer(kart5,4,2);
    DrawBuffer(kart6,5,2);
    DrawBuffer(kart7,6,2);
    DrawBuffer(kart8,7,2);

   if(DMAKartCount!=0)
   {
       CheckDMA3P();
   }
   else
   {
	  SmokeDisp3P(mykart1,0,2);
	  SmokeDisp3P(kart2,1,2);
	  SmokeDisp3P(kart3,2,2);
	  SmokeDisp3P(kart4,3,2);
	  SmokeDisp3P(kart5,4,2);
	  SmokeDisp3P(kart6,5,2);
	  SmokeDisp3P(kart7,6,2);
	  SmokeDisp3P(kart8,7,2);
   }
   DMAKartCount = 0;


}

void draw_kart4P()
{
	DMABuffer(mykart1,gCamera4,0,3);
     DMABuffer(kart2,gCamera4,1,3);
     DMABuffer(kart3,gCamera4,2,3);
     DMABuffer(kart4,gCamera4,3,3);
     DMABuffer(kart5,gCamera4,4,3);
     DMABuffer(kart6,gCamera4,5,3);
     DMABuffer(kart7,gCamera4,6,3);
     DMABuffer(kart8,gCamera4,7,3);

     DrawBuffer(kart1,0,3);
     DrawBuffer(kart2,1,3);
     DrawBuffer(kart3,2,3);
     DrawBuffer(kart4,3,3);
     DrawBuffer(kart5,4,3);
     DrawBuffer(kart6,5,3);
     DrawBuffer(kart7,6,3);
     DrawBuffer(kart8,7,3);

    if(DMAKartCount!=0)
    {
        CheckDMA4P();
    }
    else
    {
 	  SmokeDisp4P(mykart1,0,3);
 	  SmokeDisp4P(kart2,1,3);
 	  SmokeDisp4P(kart3,2,3);
 	  SmokeDisp4P(kart4,3,3);
 	  SmokeDisp4P(kart5,4,3);
 	  SmokeDisp4P(kart6,5,3);
 	  SmokeDisp4P(kart7,6,3);
 	  SmokeDisp4P(kart8,7,3);
    }
    DMAKartCount = 0;


}

void draw_kartAfter()
{
	SmokeDispAfter(mykart1,0,0);
	SmokeDispAfter(kart2,1,0);
	SmokeDispAfter(kart3,2,0);
	SmokeDispAfter(kart4,3,0);
	SmokeDispAfter(kart5,4,0);
	SmokeDispAfter(kart6,5,0);
	SmokeDispAfter(kart7,6,0);
	SmokeDispAfter(kart8,7,0);
}

void draw_kart2PAfter()
{
	SmokeDisp2PAfter(mykart1,0,1);
	SmokeDisp2PAfter(kart2,1,1);
	SmokeDisp2PAfter(kart3,2,1);
	SmokeDisp2PAfter(kart4,3,1);
	SmokeDisp2PAfter(kart5,4,1);
	SmokeDisp2PAfter(kart6,5,1);
	SmokeDisp2PAfter(kart7,6,1);
	SmokeDisp2PAfter(kart8,7,1);
}

void draw_kart3PAfter()
{
	SmokeDisp3PAfter(mykart1,0,2);
	SmokeDisp3PAfter(kart2,1,2);
	SmokeDisp3PAfter(kart3,2,2);
	SmokeDisp3PAfter(kart4,3,2);
	SmokeDisp3PAfter(kart5,4,2);
	SmokeDisp3PAfter(kart6,5,2);
	SmokeDisp3PAfter(kart7,6,2);
	SmokeDisp3PAfter(kart8,7,2);
}

void draw_kart4PAfter()
{
	SmokeDisp4PAfter(mykart1,0,3);
	SmokeDisp4PAfter(kart2,1,3);
	SmokeDisp4PAfter(kart3,2,3);
	SmokeDisp4PAfter(kart4,3,3);
	SmokeDisp4PAfter(kart5,4,3);
	SmokeDisp4PAfter(kart6,5,3);
	SmokeDisp4PAfter(kart7,6,3);
	SmokeDisp4PAfter(kart8,7,3);
}



void checkDMAHelp()
{
	SmokeDisp(kart4,3,0);
	SmokeDisp(kart5,4,0);
	SmokeDisp(kart6,5,0);
	SmokeDisp(kart7,6,0);
	SmokeDisp(kart8,7,0);
}

void checkDMA2PHelp()
{
	SmokeDisp2P(kart4,3,1);
	SmokeDisp2P(kart5,4,1);
	SmokeDisp2P(kart6,5,1);
	SmokeDisp2P(kart7,6,1);
	SmokeDisp2P(kart8,7,1);
}

void checkDMA3PHelp()
{
	SmokeDisp3P(kart4,3,2);
	SmokeDisp3P(kart5,4,2);
	SmokeDisp3P(kart6,5,2);
	SmokeDisp3P(kart7,6,2);
	SmokeDisp3P(kart8,7,2);
}

void checkDMA4PHelp()
{
	SmokeDisp4P(kart4,3,3);
	SmokeDisp4P(kart5,4,3);
	SmokeDisp4P(kart6,5,3);
	SmokeDisp4P(kart7,6,3);
	SmokeDisp4P(kart8,7,3);
}
