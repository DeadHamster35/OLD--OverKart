#include "library/MarioKart.h"
#include "library/OKHeader.h"
#include "MarioKartMenu.h"
#include "OverKart.h"
#include "MarioKartAI.h"
#include "MarioKart3D.h"
#include "SharedFunctions.h"
#include <stdbool.h>







float LocalY = 10;
int moveDistance = 5;
int lastX = 0;
int lastY = 0;
int lastZ = 0;
int devParameter;
int devOption;

char savestateSplit = 0x00;
float savestateTimeA = 0;
float savestateTimeB = 0;
float savestateTimeC = 0;
long savestateLapA = 0;
char savestateLapB = 0x00;
char savestateLapC = 0x00;
float saveTimer = 0;
bool cruiseControl = false;


static int savestateToggle = 0x00;
static char itemSwap = 0x00;
static char resetToggle = 0x00;
char splitBool = 0x00;
long splitStart = 0;
long splitEnd = 0;
float splitTimer = 0;


void splitFunc()
{
	if (splitBool == 0x01)
	{
		if (g_progressValue < splitStart)
		{
			g_gameTimer = 0;
		}
		if (g_progressValue >= splitStart)
		{
			splitBool = 0x02;
		}
	}
	if (splitBool == 0x02)
	{
		if (g_progressValue >= splitEnd)
		{
			splitTimer = g_gameTimer;
			splitBool = 0x03;
		}
	}
	if (splitBool == 0x03)
	{
		g_gameTimer = splitTimer;
	}

}




void modCheck()
{

	if (gameMode[0] > 0x00)
	{
		g_raceClass = gameMode[0] - 1;
	}
	if (gameMode[1] > 0x00)
	{
			g_mirrorMode = 0x0001;
	}
	if (gameMode[2] > 0x00)
	{

	}
	else
	{

	}
	if (gameMode[3] > 0x00)
	{
		aiSetup();
	}
	//gameMode[4] handled in Menu

	if (renderMode[0] > 0x00)
	{
		if ((g_playerCount == 0x02) & (renderMode[2] == 0x00))
		{
			g_aspectRatio = 3.5;
		}
		else
		{
			g_aspectRatio = 1.77778;
		}
	}
	else
	{
		if (g_playerCount == 0x02)
		{
			g_aspectRatio = 2.6666667;
		}
		else
		{
			g_aspectRatio = 1.333334;
		}
	}
	if (renderMode[1] > 0x00)
	{
		antialiasToggle = 0x00013016;
		antialiasToggleB = 0x00013016;
	}
	if (renderMode[2] > 0x00)
	{
		if (g_playerCount == 0x02)
		{
			g_screenSplitA = 2;
			g_ScreenSplitB = 2;
		}
	}
	if (renderMode[4] > 0x00)
	{
		asm_tempo1A = 0x240F0000;
		asm_tempo1B = 0x240F0000;
		asm_tempo1ASpeed = 2;
		asm_tempo1BSpeed = 2;

		asm_tempo2A = 0x24090000;
		asm_tempo2B = 0x24090000;
		asm_tempo2ASpeed = 2;
		asm_tempo2BSpeed = 2;

		asm_tempo3A = 0x240A0000;
		asm_tempo3B = 0x240A0000;
		asm_tempo3ASpeed = 2;
		asm_tempo3BSpeed = 2;
	}




	//modMode[0] and modMode[2] handled in gameCode function.
	if (modMode[4] > 0x00)
	{
		if (modMode[4] < 0x09)
		{
			asm_itemJump1B = 0x84A55002;
			asm_itemJump2B = 0x84A55002;
			asm_itemJump1A = 0x3C058041;
			asm_itemJump2A = 0x3C058041;

			ok_ItemChance1 = g_playerPosition1;
			ok_ItemChance2 = g_playerPosition2;
			ok_ItemChance3 = g_playerPosition3;
			ok_ItemChance4 = g_playerPosition4;
			ok_ItemChance5 = g_playerPosition5;
			ok_ItemChance6 = g_playerPosition6;
			ok_ItemChance7 = g_playerPosition7;
			ok_ItemChance8 = g_playerPosition8;
			switch(g_playerCount)
			{

				case 0x04:
				{
					ok_ItemChance1 = 8 - modMode[4];
					ok_ItemChance2 = 8 - modMode[4];
					ok_ItemChance3 = 8 - modMode[4];
					ok_ItemChance4 = 8 - modMode[4];
					break;
				}
				case 0x03:
				{
					ok_ItemChance1 = 8 - modMode[4];
					ok_ItemChance2 = 8 - modMode[4];
					ok_ItemChance3 = 8 - modMode[4];
					break;
				}
				case 0x02:
				{
					ok_ItemChance1 = 8 - modMode[4];
					ok_ItemChance2 = 8- modMode[4];
					break;
				}
				case 0x01:
				{
					ok_ItemChance1 = 8 - modMode[4];
					break;
				}
			}
		}
	}
	else
	{
		asm_itemJump1B = 0x84A543BA;
		asm_itemJump2B = 0x84A543BA;
		asm_itemJump1A = 0x3C058016;
		asm_itemJump2A = 0x3C058016;
	}
}

void saveState()
{
	//simpleObjects
	dataLength = 0x2BC0;
	*targetAddress = 0x80420000;
	*sourceAddress = 0x8015F9B8;
	ramCopy(*targetAddress, *sourceAddress, dataLength);

	//dynamicObjects
	dataLength = 0x1E140;
	*targetAddress = 0x80422BC4;
	*sourceAddress = 0x80165C18;
	ramCopy(*targetAddress, *sourceAddress, dataLength);

	//playerData
	dataLength = 0x6EC0;
	*targetAddress = 0x80440D08;
	*sourceAddress = 0x800F6990;
	ramCopy(*targetAddress, *sourceAddress, dataLength);


	//courseOBJ
	dataLength = 0x840;
	*targetAddress = 0x80447BCC;
	*sourceAddress = 0x8016359C;
	ramCopy(*targetAddress, *sourceAddress, dataLength);

	//camera data
	dataLength = 0x2E0;
	*targetAddress = 0x80448410;
	*sourceAddress = 0x801646F0;
	ramCopy(*targetAddress, *sourceAddress, dataLength);

	//lap timers
	dataLength = 0x90;
	*targetAddress = 0x804486F0;
	*sourceAddress = 0x8018CA70;
	ramCopy(*targetAddress, *sourceAddress, dataLength);

	saveTimer = g_gameTimer;
	savestateLapA = g_gameLapPlayer1;
	savestateLapB = g_lapCheckA;
	savestateLapC = g_lapCheckB;
	savestateTimeA = g_raceTime;
	savestateTimeB = g_lap2Time;
	savestateTimeC = g_lap3Time;
	savestateSplit = splitBool;
}

void loadState()
{
	dataLength =0x2BC0;
	*targetAddress = 0x8015F9B8;
	*sourceAddress = 0x80420000;
	ramCopy(*targetAddress, *sourceAddress, dataLength);

	dataLength = 0x1E140;
	*targetAddress = 0x80165C18;
	*sourceAddress = 0x80422BC4;
	ramCopy(*targetAddress, *sourceAddress, dataLength);

	//playerData
	dataLength = 0x6EC0;
	*targetAddress = 0x800F6990;
	*sourceAddress = 0x80440D08;
	ramCopy(*targetAddress, *sourceAddress, dataLength);

	//courseOBJ
	dataLength = 0x840;
	*targetAddress = 0x8016359C;
	*sourceAddress = 0x80447BCC;
	ramCopy(*targetAddress, *sourceAddress, dataLength);

	//camera data
	dataLength = 0x2E0;
	*targetAddress = 0x801646F0;
	*sourceAddress = 0x80448410;
	ramCopy(*targetAddress, *sourceAddress, dataLength);

	//lap timers
	dataLength = 0x90;
	*targetAddress = 0x8018CA70;
	*sourceAddress = 0x804486F0;
	ramCopy(*targetAddress, *sourceAddress, dataLength);

	g_gameTimer = saveTimer;
	g_gameLapPlayer1 = savestateLapA;
	g_lapCheckA = savestateLapB;
	g_lapCheckB = savestateLapC;
	g_raceTime = savestateTimeA;
	g_lap2Time = savestateTimeB;
	g_lap3Time = savestateTimeC;
	splitBool = savestateSplit;
}

void drawInputDisplay()
{
	//static int xpos = 66, ypos = 32, w = 6, h = 6; //below lap counter
	static int xpos = 260, ypos = 215, w = 8, h = 6; //above top 4
	static const char *names[] = {
		"A", "B", "Z", "S",
		"U", "D", "L", "R", // draw d-pad
		"", "", //unused bits
		"L", "R",
		"U", "D", "L", "R" //C buttons
	};
	static const char colors[][3] = {
		{  0, 192, 255}, //A: blue
		{  0, 255,   0}, //B: green
		{255, 255, 255}, //Z: white
		{255,   0,   0}, //Start: red
		{192, 192, 192}, {192, 192, 192}, //up, down
		{192, 192, 192}, {192, 192, 192}, //left, right
		{  0,   0,   0}, {  0,   0,   0}, //unused
		{255, 255, 255}, {255, 255, 255}, //L, R
		{255, 255,   0}, {255, 255,   0}, //C up, down
		{255, 255,   0}, {255, 255,   0}  //C left, right
	};
	static const char coords[][2] = {
		{3, 1}, //A
		{3, 2}, //B
		{5, 1}, //Z
		{3, 0}, //start
		{5, 0}, {5, 2}, {4, 1}, {6, 1}, //d-pad
		{0, 0}, {0, 0}, //unused
		{4, 0}, //L
		{6, 0}, //R
		{5, 0}, //C up
		{5, 2}, //C down
		{4, 1}, //C left
		{6, 1}  //C right
	};
	static const char *stickNames[] = {
		"U", "D", "L", "R","S"
	};
	static const char stickColor[][3] = {
		{192, 192, 192},
		{192, 192, 192},
		{192, 192, 192},
		{192, 192, 192},
		{255, 255, 255}
	};
	static const char stickCoord[][2] = {
		{1, 0}, //U
		{1, 2}, //D
		{0, 1}, //L
		{2, 1}, //R
		{1, 1} //stick
	};

	GraphPtr = drawBox(GraphPtr,
	xpos, ypos, xpos+w*7 +1, ypos+h*3 +1, //x1, y1, x2, y2
	0, 0, 0, 128); //r, g, b, a


	unsigned short flag = 0x8000;
	for(int i=0; i<16; i++)
	{
		if(names[i][0])
		{
			int r = colors[i][0], g = colors[i][1], b = colors[i][2];
			int a = 0;
			if (p1Button & flag)
			{
				a = 255;
			}
			else
			{
				a = 32;
			}
			int x = xpos + (coords[i][0] * w);
			int y = ypos + (coords[i][1] * h);

			GraphPtr = drawBox(GraphPtr,
				x + 1 , y + 1, x+w, y+h, //x1, y1, x2, y2
				r, g, b, a); //r, g, b, a

		}
			flag >>= 1;
	}
	for(int i=0; i<4; i++)
	{
		if(stickNames[i][0])
		{
			int r = stickColor[i][0], g = stickColor[i][1], b = stickColor[i][2];
			int a = 0;
			if (p1Button & flag)
			{
				a = 255;
			}
			else
			{
				a = 32;
			}
			int x = xpos + (stickCoord[i][0] * w);
			int y = ypos + (stickCoord[i][1] * h);

			GraphPtr = drawBox(GraphPtr,
			x + 1 , y + 1, x+w, y+h, //x1, y1, x2, y2
			r, g, b, a); //r, g, b, a



		}
		flag >>= 1;
	}


	float deltaX = player1inputX / 127.0f * w;
	float deltaY = player1inputY / -127.0f * h;

	int r = stickColor[4][0], g = stickColor[4][1], b = stickColor[4][2];
	int a = 255;
	int x = xpos + ((stickCoord[4][0] * w) + deltaX);
	int y = ypos + ((stickCoord[4][1] * h) + deltaY);

	GraphPtr = drawBox(GraphPtr,
		x + 1 , y + 1, x+w, y+h, //x1, y1, x2, y2
		r, g, b, a); //r, g, b, a



					//XXX analog stick
}




void rotateCamera(int inputAngle)
{

	float playerAngle = ((float)inputAngle / 360.0) * 65535.0;
	short angleValue = (short)playerAngle;
	float x1 = g_player1LocationX - g_player1CameraX;
	float y1 = g_player1LocationZ - g_player1CameraZ;

	float x2 = x1 * cosF(playerAngle) - y1 * sinF(playerAngle);
	float y2 = x1 * sinF(playerAngle) + y1 * cosF(playerAngle);

	g_player1LocationX = x2 + g_player1CameraX;
	g_player1LocationZ = y2 + g_player1CameraZ;
	g_player1LocationA = g_player1LocationA + angleValue;
}


void moveCamera(int inputDistance)
{
	float playerAngle = (((float)g_player1LocationA / 65535) * 360);
	float angleRadian = (int)playerAngle * -0.0174533;
	g_player1LocationX = (float)(g_player1LocationX + inputDistance * sinF(angleRadian));
	g_player1LocationZ = (float)(g_player1LocationZ + inputDistance * cosF(angleRadian));
}

void moveCameraTilt(int inputDistance, int tilt)
{
	float playerAngle = (((float)g_player1LocationA / 65535) * 360) + tilt;
	if (tilt > 0)
	{
		if (playerAngle > 360)
		playerAngle -= 360;
	}
	else
	{
		if (playerAngle < 0)
		playerAngle += 360;
	}


	float angleRadian = (int)playerAngle * -0.0174533;
	g_player1LocationX = (float)(g_player1LocationX + inputDistance * sinF(angleRadian));
	g_player1LocationZ = (float)(g_player1LocationZ + inputDistance * cosF(angleRadian));
}


//modmode[0] is > 0 then
void practiceHack()
{
	char dpadInput = ((d_Input >> 8) & 0x0F);
	short cpadInput = (d_Input & 0x000F);
	char LRToggle = (p_Input & 0xF0);
	char ABToggle = ((d_Input >> 12) & 0x0F);
	if (modMode[0] == 1)
	{
		if ((resetToggle == 0x01) && (g_gameTimer != 0x00000000))
		{
			g_InGame = 0x01;
			resetToggle = 0x00;
		}
		if ((itemSwap == 0x01) && (itemBoolean < 0x08) && (itemBoolean > 0x03))
		{
			itemA = 0x08;
			itemB = 0x08;
			itemC = 0x08;

		}
		if (splitBool > 0x00)
		{
			splitFunc();

		}
		if (itemBoolean == 0x07)
		{
			itemSwap = 0x00;
		}
		if (dpadInput == 0x00)
		{
			buttonPressed = 0x00;
		}
		// D-Pad Hacks.
		if (cpadInput == 0x02)
		{
			g_player1LocationY = g_player1LocationY + 3;
			g_player1SpeedY = 0;
			GraphPtr = drawBox(GraphPtr, 23, 43, 120, 53, 0, 0,0, 175);
	          loadFont();
	          printString(5,25, "FLYING");
		}
		if (buttonPressed == 0x00)
		{
			if (LRToggle == 0x20)
			{
				switch(dpadInput)
				{

					// End Split hack.
					case 0x01 :
					{

						buttonPressed = 1;
						splitEnd = g_progressValue;

						break;
					}

					//Start Split hack.
					case 0x02 :
					{

						buttonPressed = 1;
						splitStart = g_progressValue;
						break;
					}

					// Turn Off Split Timer
					case 0x04 :
					{
						splitBool = 0x00;

						buttonPressed = 1;
						break;
					}

					// Turn on Split Timer
					case 0x08 :
					{
						splitBool = 0x01;

						break;
					}
				}
			}
			else
			{
				switch(dpadInput)
				{

					// Load Position hack.
					case 0x01 :
					{
						if (savestateToggle == ((hsID * 0x10) + g_courseID + 1))
						{
							buttonPressed = 1;
							loadState();
						}
						break;
					}

					// Save Position hack.

					case 0x02 :
					{

						buttonPressed = 1;
						savestateToggle = ((hsID * 0x10) + g_courseID + 1);
						saveState();
						break;
					}

					// Reset Timer and Lap Hack
					case 0x04 :
					{
						g_gameLapPlayer1 = 0x00;
						g_lapCheckA = 0x00;
						g_lapCheckB = 0x00;

						g_gameTimer = 90;
						itemSwap = 0x01;
						itemBoolean = 0x01;

						buttonPressed = 1;
						break;
					}

					//FASTRESET Hack
					case 0x08 :
					{
						g_resetToggle = 0x00;
						resetToggle = 0x01;
						buttonPressed = 1;

						break;
					}
				}
			}
		}
	}


	if (modMode[1] == 1)
	{
		disableEngine = 0x0100;
		disableHUD = 0x2400;
		disableGhostHUD = 0;
		g_playerSpriteSize = 0;
		g_playerStatus = 0;
		if ((lastX == 0) && (lastY == 0))
		{
			lastX = g_player1LocationX;
			lastY = g_player1LocationY;
			lastZ = g_player1LocationZ;
		}
		else
		{
			g_player1LocationX = lastX;
			g_player1LocationY = lastY;
			g_player1LocationZ = lastZ;
		}


		if ((c_Input == 0) && (ABToggle == 0) && (cpadInput == 0) && (dpadInput == 0))
		{
			buttonPressed = 0x00;
		}


		if (buttonPressed == 0x00)
		{
			if (cruiseControl)
			{
				moveCamera(moveDistance);
			}
			else
			{
				switch(ABToggle)
				{
					case 0x04:
					{
						moveCamera((int)(-1 * moveDistance));
						break;
					}
					case 0x08:
					{
						moveCamera(moveDistance);
						break;
					}
				}
			}

			if (LRToggle == 0x10)
			{
				GraphPtr = drawBox(GraphPtr, 23, 43, 120, 63, 0, 0,0, 175);
				loadFont();
				printStringNumber(5,25, "SECTION-", g_player1Section);
				printStringNumber(5,35, "SPEED-", moveDistance);

				if ((c_Input & 0x01) == 0x01)
				{
					moveCameraTilt(moveDistance,90);
				}
				if ((c_Input & 0x02) == 0x02)
				{
					moveCameraTilt(moveDistance,-90);
				}
				if ((c_Input & 0x04) == 0x04)
				{
					g_player1LocationY = g_player1LocationY - moveDistance * .6;
				}
				if ((c_Input & 0x08) == 0x08)
				{
					g_player1LocationY = g_player1LocationY + moveDistance * .6;
				}
				switch(dpadInput)
				{

					case 0x01:
					{
						g_player1Section = g_player1Section + 1;
						buttonPressed = 1;
						break;
					}
					case 0x02:
					{
						if (g_player1Section > 1)
						{
							g_player1Section = g_player1Section - 1;
						}
						buttonPressed = 1;
						break;
					}
					case 0x04 :
					{
						if (moveDistance > 5)
						{
							moveDistance = moveDistance - 5;
						}
						buttonPressed = 1;
						break;
					}

					// Turn on Split Timer
					case 0x08 :
					{
						moveDistance = moveDistance + 5;
						buttonPressed = 1;
						break;
					}
				}
			}
			else
			{
				switch(cpadInput)
				{
					case 0x01:
					{
						moveCameraTilt(moveDistance,90);
						break;
					}
					case 0x02:
					{
						moveCameraTilt(moveDistance,-90);
						break;
					}
					case 0x04:
					{
						cruiseControl = !cruiseControl;
						buttonPressed = 1;
						break;
					}
				}
				if ((c_Input & 0x01) == 0x01)
				{
					rotateCamera(5);
				}
				if ((c_Input & 0x02) == 0x02)
				{
					rotateCamera(-5);
				}
				if ((c_Input & 0x04) == 0x04)
				{
					g_player1LocationY = g_player1LocationY - moveDistance * .6;
				}
				if ((c_Input & 0x08) == 0x08)
				{
					g_player1LocationY = g_player1LocationY + moveDistance * .6;
				}
			}

		}


		lastX = g_player1LocationX;
		lastY = g_player1LocationY;
		lastZ = g_player1LocationZ;

	}






	//devmode

	if (modMode[0] == 2)
	{
		printMap(devParameter);
		if (dpadInput == 0x00)
		{
			buttonPressed = 0x00;
		}
		if (LRToggle == 0x10)
		{

			switch(dpadInput)
			{
				case 0x08 :
				{
					if (devParameter > 0 && buttonPressed == 0)
					{
						devParameter--;
						buttonPressed = 1;
					}
					break;
				}

				case 0x04 :
				{
					if (devParameter < 3 && buttonPressed == 0)
					{
						devParameter++;
						buttonPressed = 1;
					}
					break;
				}
			}
		}
		else
		{
			buttonPressed = 0;
			switch(devParameter)
			{
				case 0:
				{
					//map

					switch(dpadInput)
					{

						case 0x01 :
						{
							g_mapX++;
							break;
						}


						case 0x02 :
						{

							g_mapX--;
							break;
						}

						case 0x04 :
						{
							g_mapY++;
							break;
						}

						case 0x08 :
						{
							g_mapY--;
							break;
						}
					}
					break;
				}



				case 1:
				{
					//map
					switch(dpadInput)
					{

						case 0x01 :
						{
							g_startX++;
							break;
						}


						case 0x02 :
						{

							g_startX--;
							break;
						}

						case 0x04 :
						{
							g_startY++;
							break;
						}

						case 0x08 :
						{
							g_startY--;
							break;
						}
					}
					break;
				}



				case 2:
				{
					//map
					switch(dpadInput)
					{

						case 0x01 :
						{
							g_mapScale = g_mapScale + .0001;
							break;
						}


						case 0x02 :
						{

							g_mapScale = g_mapScale - .0001;
							break;
						}
					}
					break;
				}

			}
		}
	}


	if (modMode[0] == 3)
	{

		if (dpadInput == 0x00)
		{
			buttonPressed = 0x00;
		}
		if (LRToggle == 0x10)
		{

			switch(dpadInput)
			{
				case 0x08 :
				{
					break;
				}

				case 0x04 :
				{
					break;
				}
			}
		}
		else
		{
			buttonPressed = 0;
			switch(dpadInput)
			{

				case 0x01 :
				{
					void* Car = &g_PlayerStateTable;
					int playerID = ((long)&Car - (long)&g_PlayerStateTable) / 0xDD8;
					SetThunder(Car,playerID);
					break;
				}


				case 0x02 :
				{
					void* Car = &g_PlayerStateTable;
					int playerID = ((long)&Car - (long)&g_PlayerStateTable) / 0xDD8;
					SetStorm(Car,playerID);
					break;
				}

				case 0x04 :
				{
					void* Car = &g_PlayerStateTable;
					int playerID = ((long)&Car - (long)&g_PlayerStateTable) / 0xDD8;
					SetStar(Car,playerID);
					break;
				}

				case 0x08 :
				{
					void* Car = &g_PlayerStateTable;
					int playerID = ((long)&Car - (long)&g_PlayerStateTable) / 0xDD8;
					SetStar(Car,playerID);
					break;
				}
			}
		}
	}
}
