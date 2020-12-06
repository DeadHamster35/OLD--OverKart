#include "library/MarioKart.h"
#include "MarioKartMenu.h"
#include "OverKart.h"


static char computerState;
static char forceCPU;
static char startBoost;
static float ccSpeed;

void fastAI()
{
     switch(g_raceClass)
     {
          case 0x00:
          {
               ccSpeed = 0x43F90000;
               break;
          }
          case 0x01:
          {
               ccSpeed = 0x44018000;
               break;
          }
          case 0x02:
          {
               ccSpeed = 0x44048000;
               break;
          }
     }

     if ((g_startingIndicator < 0x03) && (startBoost == 0x00))
     {
          startBoost = 0x01;
     }
     if ((g_startingIndicator == 0x03) && (startBoost == 0x01))
     {
          startBoost = 0x00;
          switch(g_playerCount)
          {
               case 0x01 :
               {
                    boost2 = 0x02;
                    boost3 = 0x02;
                    boost4 = 0x02;
                    break;
               }
               case 0x02 :
               {
                    boost2 = 0x02;
                    break;
               }
               case 0x03 :
               {
                    boost2 = 0x02;
                    boost3 = 0x02;
                    break;
               }
               case 0x04 :
               {
                    boost2 = 0x02;
                    boost3 = 0x02;
                    boost4 = 0x02;
                    break;
               }
          }
     }
     if (g_gameTimer > 5.0)
     {
          switch(g_playerCount)
          {
               case 0x01 :
               {
                    cpu2Speed = ccSpeed;
                    cpu3Speed = ccSpeed;
                    cpu4Speed = ccSpeed;

                    break;
               }
               case 0x02 :
               {
                    cpu2Speed = ccSpeed;

                    break;
               }
               case 0x03 :
               {
                    cpu2Speed = ccSpeed;
                    cpu3Speed = ccSpeed;

                    break;
               }
               case 0x04 :
               {
                    cpu2Speed = ccSpeed;
                    cpu3Speed = ccSpeed;
                    cpu4Speed = ccSpeed;

                    break;
               }
          }

     }
}




void checkAI()
{
     if (forceCPU > 0x00)
	{
		switch (gameMode[3])
		{
			case 0x01 :
			{
				computerState = 0x91;
				break;
			}
			case 0x02 :
			{
				computerState = 0xD1;
				break;
			}
		}


		switch(g_playerCount)
		{
			case 0x01 :
			{
				g_player1State = computerState;
				g_player2State = computerState;
				g_player3State = computerState;

				break;
			}
			case 0x02 :
			{
				g_player1State = computerState;

				break;
			}
			case 0x03 :
			{
				g_player1State = computerState;
				g_player2State = computerState;

				break;
			}
			case 0x04 :
			{
				g_player1State = computerState;
				g_player2State = computerState;
				g_player3State = computerState;

				break;
			}
		}

	}




}



void aiSetup()
{
     if (gameMode[3] > 0x00)
	{
		player2OK = 0X01;
		player3OK = 0x01;
		player4OK = 0x01;
	}
	else
	{

	}



	if ((gameMode[3] > 0x00) && (g_startingIndicator >= 0x02))
	{
		forceCPU = 0x01;
	}
	if ((g_loadedcourseFlag == 0xFF) || (g_startingIndicator < 0x02))
	{
		forceCPU = 0x00;
	}

     if (gameMode[3] == 0x02)
     {
          fastAI();
     }

     checkAI();

     //
}
