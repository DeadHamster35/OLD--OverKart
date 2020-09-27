#include "library/MarioKart.h"
#include "library/OKHeader.h"
#include "MarioKartMenu.h"
#include "MarioKartStats.h"
#include "OverKart.h"


static const char *menuNames[] = {"Game Options", "Mod Options","Render Options","Cup Editor"};
static int menuChar[] = {12,11,14,10};

static const char *cupNames[] = {"Mushroom Cup","Flower Cup","Star Cup","Special Cup"};
static int cupChar[] = {12,10,8,11};

static const char *courseNames[] = {"Mario Raceway", "Choco Mountain", "Bowser Castle", "Banshee Boardwalk","Yoshi Valley", "Frappe Snowland", "Koopa Troopa Beach", "Royal Raceway",
"Luigi Raceway", "Moo Moo Farm", "Toad Turnpike","Kalimari Desert","Sherbet Land","Rainbow Road","Wario Stadium", "Block Fort", "Skyscraper", "Double Deck", "DK Jungle Parkway","Big Donut"};
static int courseChar[] = {13,14,13,17,12,15,18,13,13,12,13,15,11,12,13,10,10,11,17,9};

static const char *gameOptions[] = {"CC Mode", "Mirror Mode", "AI State", "Racer Stats"};
static const char *gameParameters[][9] = {{"Default", "50cc","100cc","150cc"}, {"Off" , "On"}, {"Regular","Force VS", "Debug"}, {"Default","Mario","Luigi","Yoshi","Toad","D.K.","Wario","Peach","Bowser"}};

static int gameLimits[] = {3,1,2,8};
static int gameChar[][9] = {{7,4,5,5}, {3,2},{7,8,5},{7,5,5,5,4,4,5,5,6}};

static const char *modOptions[] = {"Practice Mode", "Input Display", "Details", "Force Items"};
static const char *modParameters[][14] = {{"Off" , "On"}, {"Off" , "On"}, {"Off","On","Shortcut"},

{"Default","8th","7th","6th","5th","4th","3rd","2nd","1st","Banana","3 G. Shell", "3 R. Shell", "Star", "3 Shroom"}

};

static int modLimits[] = {1,1,2,8};
static int modChar[][14] = {{3,2}, {3,2},{3,2,8},{7,3,3,3,3,3,3,3,3,6,10,10,4,8}};


static const char *renderOptions[] = {"Widescreen", "Anti-Alias", "Screen Split", "Game Tempo"};
static const char *renderParameters[][2] = { {"Off" , "On"}, {"Off" , "On"}, {"Default", "2P Vertical"}, {"Console","Emulator"}};
static int renderLimits[] = {2,1,1,8};
static int renderChar[][2] = { {3,2}, {3,2}, {7,11}, {7,8}};

static int pageLimit[] = {4,4,4,5};



int cupSelection = 0;
int cupOffset = 0;


int menuButton = 0;
static int menuX;
static int menuY;

static int currentPage = 0;
static int currentParameter = 0;
static int buttonHeld = 0;






int cup_NTSC = 0x800F2BB4;
int cup_PAL = 0x800F2C14;











void loadPosition()
{
     switch(g_playerCount)
     {
          case 0x01 :
          {
               menuX = 5;
               menuY = 15;
               break;
          }
          case 0x02 :
          {
               menuX = 90;
               menuY = 97;
               break;
          }
          case 0x03 :
          {
               menuX = 170;
               menuY = 200;
               break;
          }
          case 0x04 :
          {
               menuX = 90;
               menuY = 97;
               break;
          }
     }
}



void printDetails()
{
     if (g_playerCount == 1)
     {
          menuX = 58;
          menuY = 170;
          boxOffset = drawBox(boxOffset, menuX + 18, menuY + 18, menuX + 185, menuY + 58, 0, 0, 0, 175);
          loadFont();

          int wholeNumber = 0;
          int decimalNumber = 0;
          int printOffsetA = 0;
          int printOffsetB = 0;
          int printOffsetC = 0;
          int offsetValue = 0;

          printString(menuX,menuY,"X:");
          printString(menuX,menuY+10,"Y:");
          printString(menuX,menuY+20,"Z:");
          printString(menuX,menuY+30,"A:");

          if (modMode[2] == 1)
          {
               printString(menuX+87,menuY," SX:");
          }
          else
          {
               printString(menuX+87,menuY," LA:");
          }
          if (modMode[2] == 1)
          {
               printString(menuX+87,menuY+10," SY:");
          }
          else
          {
               printString(menuX+87,menuY+10," LS:");
          }
          if (modMode[2] == 1)
          {
               printString(menuX+87,menuY+20," SZ:");
          }
          else
          {
               printString(menuX+87,menuY+20," PG:");
          }


          printString(menuX+87,menuY+30," SA:");


          for(int loop = 0; loop < 4; loop++)
          {
               switch  (loop)
               {
                    case 0x00:
                    {
                         wholeNumber = (int) g_playerLocation1X;
                         decimalNumber = (int) ((g_playerLocation1X - wholeNumber) * 1000);
                         break;
                    }
                    case 0x01:
                    {
                         wholeNumber = (int) g_playerLocation1Y;
                         decimalNumber = (int) ((g_playerLocation1Y - wholeNumber) * 1000);
                         break;
                    }
                    case 0x02:
                    {
                         wholeNumber = (int) g_playerLocation1Z;
                         decimalNumber = (int) ((g_playerLocation1Z - wholeNumber) * 1000);
                         break;
                    }
                    case 0x03:
                    {
                         float playerAngle = (((float)g_playerLocation1A / 65535) * 360);
                         wholeNumber = playerAngle;
                         decimalNumber = (int) ((playerAngle - wholeNumber) * 1000);
                         break;
                    }

               }
               if (decimalNumber < 0)
               {
                    decimalNumber = decimalNumber * -1;
               }

               if (wholeNumber > 0)
               {
                    offsetValue = wholeNumber;
               }
               else
               {
                    offsetValue = wholeNumber * -1;
               }
               if (offsetValue >= 10)
               {
                    if (offsetValue >= 100)
                    {
                         if (offsetValue >= 1000)
                         {

                              printOffsetB = 8;
                         }
                         else
                         {
                         printOffsetB = 16;
                         }
                    }
                    else
                    {
                    printOffsetB = 24;
                    }
               }
               else
               {
                    printOffsetB = 32;
               }
               if (wholeNumber >= 0)
               {
                    printOffsetB = printOffsetB + 8;
               }

               printOffsetA = 56;

               if (decimalNumber < 100)
               {
                    printStringNumber(menuX+printOffsetA-4,menuY,"",0);
                    printOffsetC = 8;
               }
               else
               {
                    printOffsetC = 0;
               }



               printStringNumber(menuX+printOffsetB,menuY,"",wholeNumber);
               printString(menuX+printOffsetA,menuY,".");
               printStringNumber(menuX+printOffsetA-4+printOffsetC,menuY,"",decimalNumber);
               menuY = menuY + 10;
               //
               //
          }


          menuX = menuX + 87;
          menuY = 170;
          for(int loop = 0; loop < 4; loop++)
          {
               switch  (loop)
               {
                    case 0x00:
                    {
                         if (modMode[2] == 1)
                         {
                              wholeNumber = (int) g_player1SpeedX;
                              decimalNumber = (int) ((g_player1SpeedX - wholeNumber) * 1000);
                         }
                         else
                         {
                              wholeNumber = (int) g_lakituSurface;
                         }

                         break;
                    }
                    case 0x01:
                    {
                         if (modMode[2] == 1)
                         {
                              wholeNumber = (int) g_player1SpeedY;
                              decimalNumber = (int) ((g_player1SpeedY - wholeNumber) * 1000);
                         }
                         else
                         {
                              wholeNumber = (int) g_lakituStatus;
                         }

                         break;
                    }
                    case 0x02:
                    {
                         if (modMode[2] == 1)
                         {
                              wholeNumber = (int) g_player1SpeedZ;
                              decimalNumber = (int) ((g_player1SpeedZ - wholeNumber) * 1000);
                         }
                         else
                         {
                              wholeNumber = (int) g_progressValue;
                         }

                         break;
                    }
                    case 0x03:
                    {
                         wholeNumber = (int) g_player1SpeedA;
                         decimalNumber = (int) ((g_player1SpeedA - wholeNumber) * 1000);
                         break;
                    }
               }
               if (decimalNumber < 0)
               {
                    decimalNumber = decimalNumber * -1;
               }


               if (wholeNumber > 0)
               {
                    offsetValue = wholeNumber;
               }
               else
               {
                    offsetValue = wholeNumber * -1;
               }
               if (offsetValue >= 10)
               {
                    if (offsetValue >= 100)
                    {
                         printOffsetB = 8;
                    }
                    else
                    {
                    printOffsetB = 16;
                    }
               }
               else
               {
                    printOffsetB = 24;
               }
               if (wholeNumber >= 0)
               {
                    printOffsetB = printOffsetB + 8;
               }
               if ((loop == 2) & (modMode[2] == 2))
               {
                    printOffsetB = printOffsetB + 8;
               }
               printOffsetA = 48;

               if ((modMode[2] == 1) | (loop == 3))
               {
                    if (decimalNumber < 100)
                    {
                         printStringNumber(menuX+printOffsetA-4,menuY,"",0);
                         printOffsetC = 8;
                    }
                    else
                    {
                         printOffsetC = 0;
                    }
               }

               printStringNumber(menuX+printOffsetB,menuY,"",wholeNumber);
               if ((modMode[2] == 1) | (loop == 3))
               {
                    printString(menuX+printOffsetA,menuY,".");
                    printStringNumber(menuX+printOffsetA-4+printOffsetC,menuY,"",decimalNumber);
               }
               menuY = menuY + 10;
               //
               //
          }


     }

}

void printAnticheat()
{
     loadPosition();

     if (modMode[0] > 0x00)
     {
          boxOffset = drawBox(boxOffset, menuX + 18, menuY + 18, menuX + (12 * 8) + 19, menuY + 28, 0, 0,0, 175);
          loadFont();

          printString(menuX,menuY, "Practice  ON");

     }
     else if (modMode[3] > 0)
     {
          boxOffset = drawBox(boxOffset, menuX + 18, menuY + 18, menuX + (11 * 8) + 19, menuY + 28, 0, 0,0, 175);
          loadFont();

          printString(menuX,menuY, "Force Items");
     }
     else if (gameMode[2] > 0x00)
     {

          switch (gameMode[2])
          {
               // PRACTICE BUILD overlay text.
               case 0x01 :
               {
                    boxOffset = drawBox(boxOffset, menuX + 18, menuY + 18, menuX + (10 * 8) + 19, menuY + 28, 0, 0,0, 175);
                    loadFont();
                    printString(menuX,menuY, "Versus CPU");
                    break;
               }
               case 0x02 :
               {
                    boxOffset = drawBox(boxOffset, menuX + 18, menuY + 18, menuX + (9 * 8) + 19, menuY + 28, 0, 0,0, 175);
                    loadFont();
                    printString(menuX,menuY, "Debug CPU");
                    break;
               }
          }
     }
     else if (gameMode[3] > 0x00)
     {
          boxOffset = drawBox(boxOffset, menuX + 18, menuY + 18, menuX + (11 * 8) + 19, menuY + 28, 0, 0,0, 175);
          loadFont();

          printString(menuX,menuY, "Force Stats");
     }



}


void swapParameter(int directionIndex)
{
     //if directionIndex == 0, swap down;
     //if directionIndex == 1, swap up;
     if (directionIndex == 0)
     {
          switch(currentPage)
          {
               case 0:
               {
                    if (gameMode[currentParameter-1] > 0)
                    {
                         gameMode[currentParameter-1]--;
                    }
                    break;
               }
               case 1:
               {
                    if (modMode[currentParameter-1] > 0)
                    {
                         modMode[currentParameter-1]--;
                    }
                    break;
               }
               case 2:
               {
                    if (renderMode[currentParameter-1] > 0)
                    {
                         renderMode[currentParameter-1]--;
                    }
                    break;
               }
               case 3:
               {
                    if (currentParameter == 1)
                    {
                         if (cupSelection > 0)
                         {
                              cupSelection--;
                         }
                    }
                    if (currentParameter > 1)
                    {
                         if (SYSTEM_Region == 0x00)
                         {
                              cupOffset = (cup_PAL + (cupSelection * 8) + ((currentParameter - 2) * 2));
                         }
                         else
                         {
                              cupOffset = (cup_NTSC + (cupSelection * 8) + ((currentParameter - 2) * 2));
                         }
                         short *l_courseID = (short *)cupOffset;
                         if (*l_courseID > 0)
                         {
                              *l_courseID = *l_courseID - 1;
                         }
                    }
                    break;
               }
               default:
               {
                    break;
               }


          }


     }
     else
     {
          switch(currentPage)
          {
               case 0:
               {
                    if (gameMode[currentParameter-1] < gameLimits[currentParameter-1])
                    {
                         gameMode[currentParameter-1]++;
                    }
                    break;
               }
               case 1:
               {
                    if (modMode[currentParameter-1] < modLimits[currentParameter-1])
                    {
                         modMode[currentParameter-1]++;
                    }
                    break;
               }
               case 2:
               {
                    if (renderMode[currentParameter-1] < renderLimits[currentParameter-1])
                    {
                         renderMode[currentParameter-1]++;
                    }
                    break;
               }
               case 3:
               {
                    if (currentParameter == 1)
                    {
                         if (cupSelection < 3)
                         {
                              cupSelection++;
                         }
                    }
                    if (currentParameter > 1)
                    {
                         if (SYSTEM_Region == 0x00)
                         {
                              cupOffset = (cup_PAL + (cupSelection * 8) + ((currentParameter - 2) * 2));
                         }
                         else
                         {
                              cupOffset = (cup_NTSC + (cupSelection * 8) + ((currentParameter - 2) * 2));
                         }

                         short *l_courseID = (short *)cupOffset;

                         if (*l_courseID < 19)
                         {
                              *l_courseID = *l_courseID + 1;
                         }
                    }
                    break;
               }
               default:
               {
                    break;
               }
          }
     }




}



void printMenu()
{
     boxOffset = drawBox(boxOffset, 55, 20, 265, 120, 0, 0,0, 175);
     boxOffset = drawBox(boxOffset, 53, 18, 55, 122, 0, 0,0, 255);
     boxOffset = drawBox(boxOffset, 265, 18, 267, 122, 0, 0,0, 255);
     boxOffset = drawBox(boxOffset, 55, 18, 265, 20, 0, 0,0, 255);
     boxOffset = drawBox(boxOffset, 55, 120, 265, 122, 0, 0,0, 255);

     boxOffset = drawBox(boxOffset, 77, 40, 243, 42, 0, 0,0, 255);




     if (currentPage == 3)
     {
          if (currentParameter == 0)
          {
               menuX = 157 - ((menuChar[currentPage]) * 4);
               boxOffset = drawBox(boxOffset, menuX, 27, menuX + (menuChar[currentPage] * 8), 38, 200, 0, 0, 200);
          }
          else if (currentParameter == 1)
          {
               menuX = 157 - ((cupChar[cupSelection]) * 4);
               boxOffset = drawBox(boxOffset, menuX, 45, menuX + (cupChar[cupSelection] * 8), 55, 200, 0, 0, 200);
          }
          else
          {
               if (SYSTEM_Region == 0x00)
               {
                    cupOffset = (cup_PAL + (cupSelection * 8) + ((currentParameter - 2) * 2));
               }
               else
               {
                    cupOffset = (cup_NTSC + (cupSelection * 8) + ((currentParameter - 2) * 2));
               }
               short *l_courseID = (short *)cupOffset;
               menuX = 157 - ((courseChar[(long)*l_courseID]) * 4);
               menuY = ((currentParameter - 1) * 14) + 48;
               boxOffset = drawBox(boxOffset, menuX, menuY, menuX + (courseChar[(long)*l_courseID] * 8), menuY+11, 200, 0, 0, 200);
          }
     }
     else
     {
          if (currentParameter == 0)
          {
               menuX = 157 - ((menuChar[currentPage]) * 4);
               boxOffset = drawBox(boxOffset, menuX, 27, menuX + (menuChar[currentPage] * 8), 38, 200, 0, 0, 200);
          }
          else
          {
               menuY = currentParameter * 18 + 33;
               boxOffset = drawBox(boxOffset, 60, menuY, 65, menuY+5, 200, 0, 0, 200);
          }
     }


     loadFont();
     printString(18,195,"NTSC");
     printString(0,205,"BUILD 3.2");
     printString(200,195,"OverKart");
     printString(216,205,"Team");
     int menuLoop = 0;


     menuX = 138 - (menuChar[currentPage] * 4);
     printString(menuX,10,menuNames[currentPage]);
     menuY = 30;

     switch(currentPage)
     {
          case 0:
          {
               do{
                    printString(50,menuY,gameOptions[menuLoop]);
                    menuX = 200 - (gameChar[menuLoop][gameMode[menuLoop]] * 4);
                    printString(menuX,menuY,gameParameters[menuLoop][gameMode[menuLoop]]);
                    menuY = menuY + 18;
                    menuLoop++;
               } while (menuLoop < 4);
               break;
          }
          case 1:
          {
               do{
                    printString(50,menuY,modOptions[menuLoop]);
                    menuX = 200 - (modChar[menuLoop][modMode[menuLoop]] * 4);
                    printString(menuX,menuY,modParameters[menuLoop][modMode[menuLoop]]);
                    menuY = menuY + 18;
                    menuLoop++;
               } while (menuLoop < 4);
               break;
          }
          case 2:
          {
               do{
                    printString(50,menuY,renderOptions[menuLoop]);
                    menuX = 200 - (renderChar[menuLoop][renderMode[menuLoop]] * 4);
                    printString(menuX,menuY,renderParameters[menuLoop][renderMode[menuLoop]]);
                    menuY = menuY + 18;
                    menuLoop++;
               } while (menuLoop < 4);
               break;
          }
          case 3:
          {
               menuX = 138 - (cupChar[cupSelection] * 4);
               printString(menuX,27,cupNames[cupSelection]);
               menuY = 45;
               do{
                    if (SYSTEM_Region == 0x00)
                    {
                         cupOffset = (cup_PAL + (cupSelection * 8) + menuLoop * 2);
                    }
                    else
                    {
                         cupOffset = (cup_NTSC + (cupSelection * 8) + menuLoop * 2);
                    }
                    short *l_courseID = (short *)cupOffset;
                    menuX = 138 - (courseChar[(long)*l_courseID] * 4);
                    printString(menuX,menuY,courseNames[(long)*l_courseID]);
                    menuY = menuY + 14;
                    menuLoop++;
               } while (menuLoop < 4);
               break;
          }
          default:
          {
               break;
          }


     }


     g_mlogoY = 0x00000075;
     g_mflagID = 0;
     g_mpressstartID = 0;
     g_mracewayTime = 0;


}



void titleMenu(void)
{
     if(titleDemo > 4)
     {
          titleDemo = 4;   //This is a timer that runs at the title screen. Locking at 4 Prevents the demo courses from being displayed.
     }
     char dpadInput = d_Input >> 8;

     // Reset the menuButton timer. This is set to 0x01 when a button is held down.

     if ( (dpadInput == 0x00) & (c_Input == 0x00))
     {
          menuButton = 0x00;
          buttonHeld = 0;
     }

     if (menuButton == 0x01)
     {
          buttonHeld++;
          if (buttonHeld == 10)
          {
               menuButton = 0;
               buttonHeld = 0;
          }
     }

     if ((titleDemo > 3) && (menuScreenC <= 0x03))
     {

          //printString(200,150,"TEXT");
          //menuButton is set to 0x01 when a button is held down.
          if  (menuButton == 0x00)
          {

               if (c_Input > 0x00)
               {
                    genericInput = c_Input;
               }
               else
               {
                    genericInput = dpadInput;
               }
               // Uses the Control Stick or Dpad to switch through the menu.
               switch(genericInput)
               {
                    //Increase the current menu Parameter by 1
                    case 0x01 :
                    {
                         menuButton = 0x01;
                         if (currentParameter > 0)
                         {
                              swapParameter(1);
                         }
                         else
                         {
                              if (currentPage < 3)
                              {
                                   currentPage++;
                                   playSound(0x4900801A);
                              }
                         }
                         break;

                    }
                    //Decrease the current menu Parameter by 1
                    case 0x02 :
                    {
                         menuButton = 0x01;
                         if (currentParameter > 0)
                         {
                              swapParameter(0);
                         }
                         else
                         {
                              if (currentPage > 0)
                              {
                                   currentPage--;
                                   playSound(0x4900801A);
                              }
                         }
                         break;

                    }
                    //Move forward to next option
                    case 0x04 :
                    {
                         menuButton = 0x01;
                         if (currentParameter < pageLimit[currentPage])
                         {
                              currentParameter++;
                         }
                         break;

                         //
                    }
                    //Move backward to previous option
                    case 0x08 :
                    {
                         menuButton = 0x01;
                         if (currentParameter > 0)
                         {
                              currentParameter--;
                         }
                         break;
                    }


               }
               // End of menu Dpad code.


          }


          // Now print the menu using the menuFlag and parameterFlag options above.
          checkStats();
          printMenu();

     }
     //
     //
     //
     // End of TITLE MENU code

     // This handles the FASTRESET hack in the Dpad Menu INGAME




}
