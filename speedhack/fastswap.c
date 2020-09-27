#include "fastswap.h"

static const char *menuOptions[] = {"CPU Override", "Option 2", "Option 3"};
static const char *cpuParameters[] = {"Default","Force 0x90","Force 0xD0"};
static const char *genericParameters[] = {"Parameter 1","Parameter 2","Parameter 3"};

void printMenu()
{
	loadFont();
	printString(100,100,menuOptions[menuFlag]);
	switch(menuFlag)
	{
		case 0x00 :
		{
			printString(110,110,cpuParameters[cpuFlag]);
			break;
		}
		case 0x01 :
		{
			printString(90,110,genericParameters[parameterFlagB]);;
			break;
		}
		case 0x02 :
		{
			printString(90,110,genericParameters[parameterFlagC]);
			break;
		}
	}




}


void voidMenu()
{


	switch(menuFlag)
	{
		case 0x00 :
		{
			printString(110,110,cpuParameters[cpuFlag]);
			break;
		}
		case 0x01 :
		{
			printString(90,110,genericParameters[parameterFlagB]);;
			break;
		}
		case 0x02 :
		{
			printString(90,110,genericParameters[parameterFlagC]);
			break;
		}
	}




}




void loadParameters()
{
	switch(menuFlag)
	{
		case 0x00 :
		{
			parameterFlag = cpuFlag;
			break;
		}
		case 0x01 :
		{
			parameterFlag = parameterFlagB;
			break;
		}
		case 0x02 :
		{
			parameterFlag = parameterFlagC;
			break;
		}

	}
}

void saveParameters()
{
	switch(menuFlag)
	{
		case 0x00 :
		{
			cpuFlag = parameterFlag;
			break;
		}
		case 0x01 :
		{
			parameterFlagB = parameterFlag;
			break;
		}
		case 0x02 :
		{
			parameterFlagC = parameterFlag;
			break;
		}
	}
}


void speedHack(void)
{





	if (gameOn > 0x00)
	{

		if (startupBool != 0x35)
		{

			startupBool = 0x35;
			selectA = 0x2400;
			selectC = 0x2400;
			selectE = 0x2400;
			selectB = 0x7FFF;
			selectD = 0x7FFF;
			selectF = 0x7FFF;
			menuFlag = 0x00;
			cpuFlag = 0x00;
			parameterFlag = 0x00;
			parameterFlagB = 0x00;
			parameterFlagC = 0x00;

		}

		if(titleDemo > 4)
		{
			titleDemo = 4;   //This is a timer that runs at the title screen. Locking at 4 Prevents the demo courses from being displayed.
		}



		// Reset the buttonPressed timer. This is set to 0x01 when a button is held down.
		if (d_Input == 0x00)
		{
			buttonPressed = 0x00;
		}



		// Start of TITLE MENU code below
		// This code only runs in the TITLE MENU
		//
		//

		if ((titleDemo > 3) && (courseScreenC <= 0x03))
		{

			//printString(200,150,"TEXT");
			//buttonPressed is set to 0x01 when a button is held down.
			if  (buttonPressed == 0x00)
			{

				// Uses the Dpad to switch through the menu.
				switch(d_Input)
				{
					//Increase the current menu Parameter by 1
					case 0x01 :
					{
						loadParameters();
						if (parameterFlag < 2)
						{
							parameterFlag++;
							
						}
						saveParameters();
						buttonPressed = 0x01;
						break;
					}
					//Decrease the current menu Parameter by 1
					case 0x02 :
					{
						loadParameters();
						if (parameterFlag > 0)
						{
							parameterFlag = parameterFlag - 1;
						}
						saveParameters();
						buttonPressed = 0x01;
						break;
					}
					//Move forward to next option
					case 0x04 :
					{
						if (menuFlag < 2)
						{
							menuFlag++;
						}
						buttonPressed = 0x01;
						break;
					}
					//Move backward to previous option
					case 0x08 :
					{
						if (menuFlag > 0)
						{
							menuFlag = menuFlag - 1;
						}
						buttonPressed = 0x01;
						break;
					}


				}
				// End of menu Dpad code.


			}

			// Now print the menu using the menuFlag and parameterFlag options above.

			printMenu();

		}
		//
		//
		//
		// End of TITLE MENU code

		// This handles the FASTRESET hack in the Dpad Menu INGAME
		if ((internalBool == 0x01) && (timerA != 0x00000000))
		{
			inGame = 0x01;
			internalBool = 0x00;
		}







		// Start of INGAME code below
		// Code will run when race has started.
		//
		//
	if (inGame >= 0x01)
	{
		// PRACTICE BUILD overlay text.
		loadFont();
		printString(5,20, "Practice");
		printString(10,30, "Build 1");
		if ((itemBoolean < 0x08) && (itemBoolean > 0x03))
		{
			itemA = 0x0E;
			itemB = 0x0E;
			itemC = 0x0E;

		}
		// End PRACTICE BUILD overlay text.


		// D-Pad Hacks.
		if (buttonPressed == 0x00)
		{
			switch(d_Input)
			{

				// Load Position hack.
				case 0x01 :
				{
					ingameX = internalX;
					ingameY = internalY;
					ingameZ = internalZ;
					ingameROT = internalROT;
					ingameSpeedA = 0x00000000;
					ingameSpeedB = 0x00000000;
					ingameSpeedC = 0x00000000;
					ingameSpeedD = 0x00000000;
					ingameSpeedE = 0x00000000;
					break;
				}

				// Save Position hack.
				case 0x02 :
				{
					internalX = ingameX;
					internalY = ingameY;
					internalZ = ingameZ;
					internalROT = ingameROT;
					break;
				}

				// Reset Timer and Lap Hack
				case 0x04 :
				{
					gameLap = 0x00;
					lapA = 0x00;
					lapB = 0x00;

					timerA = 0x42B41380;

					itemBoolean = 0x01;
					break;
				}

				//FASTRESET Hack
				case 0x08 :
				{
					resetButton = 0x00;
					internalBool = 0x01;
					break;
				}
			}

		}
		//  End of D-Pad Hacks.

		//
		//
		//
		//End of INGAME code
	}
	}









	// AI Menu Hack
	//
	//
	//


	//set the controller to Press A for the player select
	if (cpuFlag > 0x00)
	{
		player2OK = 0X01;
		player3OK = 0x01;
		player4OK = 0x01;
	}
	else
	{
		player2OK = 0X00;
		player3OK = 0x00;
		player4OK = 0x00;
	}
	// end player selectA


	// Set AI states based on parameter.
	// If Parameter is 1, AI is default.
	if (cpuFlag == 0x01)
	{
		p2AI = 0x90;
		p3AI = 0x90;
		p4AI = 0x90;
	}
	//end Default AI


	// If Parameter is 2, AI uses Debug AI
	if ((cpuFlag == 0x02) && (startingIndicator >= 0x02))
	{
		forceCPU = 0x01;
	}
	if ((loadedCourse == 0xFF) || (startingIndicator != 0x03))
	{
		forceCPU = 0x00;
	}

	if (forceCPU == 0x01)
	{
		p2AI = 0xD0;
		p3AI = 0xD0;
		p4AI = 0xD0;

	}
	//end Debug AI

	//
	//
	//
	// End AI Menu Hack


}
