#include <sys/types.h>
#include <math.h>
#include "library/MarioKart.h"
#include "library/OKHeader.h"
#include "MarioKartMenu.h"
#include "MarioKartStats.h"
#include "OverKart.h"
#include "SharedFunctions.h"

char *menuNames[] = {"Game Options", "Mod Options","Render Options","Cup Editor"};
static int menuChar[] = {12,11,14,10};
char *cupNames[] = {"Mushroom Cup","Flower Cup","Star Cup","Special Cup"};
static int cupChar[] = {12,10,8,11};

char *courseNames[] = {"Mario Raceway", "Choco Mountain", "Bowser Castle", "Banshee Boardwalk","Yoshi Valley", "Frappe Snowland", "Koopa Troopa Beach", "Royal Raceway",
"Luigi Raceway", "Moo Moo Farm", "Toad Turnpike","Kalimari Desert","Sherbet Land","Rainbow Road","Wario Stadium", "Block Fort", "Skyscraper", "Double Deck", "DK Jungle Parkway","Big Donut"};
static int courseChar[] = {13,14,13,17,12,15,18,13,13,12,13,15,11,12,13,10,10,11,17,9};

char *gameOptions[] = {"CC Mode", "Mirror Mode", "All Cup", "AI State", "Racer Stats"};
char *gameParameters[][9] = {{"Default", "50cc","100cc","150cc"}, {"Off" , "On"}, {"Off" , "On"}, {"Regular","Force VS", "Debug"}, {"Default","Mario","Luigi","Yoshi","Toad","D.K.","Wario","Peach","Bowser"}};

static int gameLimits[] = {3,1,1,2,8};
static int gameChar[][9] = {{7,4,5,5}, {3,2}, {3,2},{7,8,5},{7,5,5,5,4,4,5,5,6}};

char *modOptions[] = {"Practice Mode", "Flycam", "Input Display", "Details", "Force Items"};
char *modParameters[][14] = {{"Off" , "On", "Map", "Dev"}, {"Off" , "On"}, {"Off" , "On"}, {"Off","On","Shortcut"},

{"Default","8th","7th","6th","5th","4th","3rd","2nd","1st","Banana","3 G. Shell", "3 R. Shell", "Star", "3 Shroom"}

};

static int modLimits[] = {3,1,1,2,8};
static int modChar[][14] = {{3,2,3,3}, {3,2},{3,2},{3,2,8},{7,3,3,3,3,3,3,3,3,6,10,10,4,8}};


char *renderOptions[] = {"Widescreen", "Anti-Alias", "Screen Split", "Draw Dist.", "Game Tempo"};
char *renderParameters[][2] = { {"Off" , "On"}, {"On" , "Off"}, {"Default", "2P Vertical"}, {"Default","Extended"}, {"Console","Emulator"}};
static int renderLimits[] = {1,1,1,1,1};
static int renderChar[][2] = { {3,2}, {2,3}, {7,8}, {7,8}, {7,8}};

static int pageLimit[] = {5,5,5,5};



int cupSelection = 0;
int cupOffset = 0;


int menuButton = 0;
static int menuX;
static int menuY;
int menuIndex = 0;
int menuBlink = 0;

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



void PrintMenuTest()
{
     char HeaderText[18];
     char textA[54];
     char textB[54];
     char *bufH = HeaderText;
     char *bufA = textA;
     char *bufB = textB;
     GraphPtr = drawBox(GraphPtr, 0, 0, 400, 75, 0, 0, 0, 200);
     loadFont();
     uint HeaderOffset = (uint)&ok_CourseHeader;

     bufH = printHex(bufH, HeaderOffset, 8); *bufH++ = 0;
     printString(15,10,HeaderText);


     bufA = printHex(bufA, (HeaderOffset + 0x34), 8); *bufA++ = ' ';
     bufA = printHex(bufA, (HeaderOffset + 0x50), 8); *bufA++ = ' ';
     bufA = printHex(bufA, (HeaderOffset + 0x40), 8); *bufA++ = 0;
     printString(15, 30, textA);


     bufB = printHex(bufB, *(uint*)(HeaderOffset + 0x34), 8); *bufB++ = ' ';
     bufB = printHex(bufB, *(uint*)(HeaderOffset + 0x50), 8); *bufB++ = ' ';
     bufB = printHex(bufB, *(uint*)(HeaderOffset + 0x40), 8); *bufB++ = 0;
     printString(15, 40, textB);


}

void printGPTime(float printTime)
{

     int wholeNumber = 0;
     int decimalNumber = 0;
     int printOffsetA, printOffsetB = 0;


     wholeNumber = (int) printTime;
     decimalNumber = (int) ((printTime - wholeNumber) * 100);

     int minutes = 0;
     int seconds = 0;

     if (decimalNumber < 0)
     {
          decimalNumber = decimalNumber * -1;
     }

     if (wholeNumber > 60)
     {
          minutes = (long)(floor)(wholeNumber/60);
          seconds = wholeNumber - (minutes * 60);
     }
     else
     {
          seconds = wholeNumber;
     }

     if (minutes >= 10)
     {
          if (minutes >= 100)
          {
               if (minutes >= 1000)
               {

                    printOffsetA = 40;
               }
               else
               {
                    printOffsetA = 32;
               }
          }
          else
          {
               printOffsetA = 24;
          }
     }
     else
     {
          printOffsetA = 16;
     }

     if (seconds >= 10)
     {
          if (seconds >= 100)
          {
               if (seconds >= 1000)
               {

                    printOffsetB = 40;
               }
               else
               {
                    printOffsetB = 32;
               }
          }
          else
          {
               printOffsetB = 24;
          }
     }
     else
     {
          printOffsetB = 16;
     }



     printOffsetB = printOffsetB + printOffsetA;


     loadFont();
     menuY = 210;
     menuX = 55;

     printString(menuX,menuY,"Total Time:");

     menuX = 145;


     printString(menuX + printOffsetA, menuY, "'");
     if (seconds < 10)
     {
          printStringNumber(menuX + printOffsetA,menuY,"",0);
          printOffsetA = printOffsetA + 8;
          printOffsetB = printOffsetB + 8;
     }

     printString(menuX + printOffsetB, menuY, "\"");
     if (decimalNumber < 10)
     {
          printStringNumber(menuX+printOffsetB,menuY,"",0);
          printOffsetB = printOffsetB + 8;
     }




     printStringNumber(menuX,menuY,"",minutes);
     printStringNumber(menuX + printOffsetA,menuY,"",seconds);
     printStringNumber(menuX+printOffsetB,menuY,"",decimalNumber);



}


void printMap(int devParameter)
{
          if (g_playerCount == 1)
          {
               menuX = 25;
               menuY = 150;
               GraphPtr = drawBox(GraphPtr, menuX + 18, menuY + 18, menuX + 185, menuY + 68, 0, 0, 0, 175);
               GraphPtr = drawBox(GraphPtr, menuX + 18, menuY + 18 + (devParameter * 20), menuX + 74, menuY + 28 + (devParameter * 20), 200, 0, 0, 175);
               loadFont();

               int wholeNumber = 0;
               int decimalNumber = 0;
               int printOffsetA, printOffsetB, printOffsetC = 0;

               printStringNumber(menuX,menuY,"  Map X:",g_mapX);
               printStringNumber(menuX,menuY+10,"  Map Y:",g_mapY);
               printStringNumber(menuX,menuY+20,"Start X:",g_startX);
               printStringNumber(menuX,menuY+30,"Start Y:",g_startY);
               printString(menuX,menuY+40,"  Scale:");

               wholeNumber = (int) (g_mapScale * 100);
               decimalNumber = (int) (((g_mapScale * 100) - wholeNumber) * 1000);

               if (decimalNumber < 0)
               {
                    decimalNumber = decimalNumber * -1;
               }
               if (wholeNumber >= 10)
               {
                    if (wholeNumber >= 100)
                    {
                         if (wholeNumber >= 1000)
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
                    printStringNumber(menuX+printOffsetA-4,menuY+ 40,"",0);
                    printOffsetC = 8;
               }
               else
               {
                    printOffsetC = 0;
               }
               menuX = 50;

               printStringNumber(menuX+printOffsetB,menuY + 40,"",wholeNumber);
               printString(menuX+printOffsetA,menuY + 40,".");
               printStringNumber(menuX+printOffsetA-4+printOffsetC,menuY + 40,"",decimalNumber);


     }

}


void printDetails()
{
     if (g_playerCount == 1)
     {
          menuX = 58;
          menuY = 170;
          GraphPtr = drawBox(GraphPtr, menuX + 18, menuY + 18, menuX + 185, menuY + 58, 0, 0, 0, 175);
          loadFont();

          int wholeNumber = 0;
          int decimalNumber = 0;
          int offsetValue, printOffsetA, printOffsetB, printOffsetC = 0;

          printString(menuX,menuY,"X:");
          printString(menuX,menuY+10,"Y:");
          printString(menuX,menuY+20,"Z:");
          printString(menuX,menuY+30,"A:");

          if (modMode[3] == 1)
          {
               printString(menuX+87,menuY," SX:");
               printString(menuX+87,menuY+10," SY:");
               printString(menuX+87,menuY+20," SZ:");
          }
          else
          {
               printString(menuX+87,menuY," LA:");
               printString(menuX+87,menuY+10," LS:");
               printString(menuX+87,menuY+20," PG:");
          }


          printString(menuX+87,menuY+30," SA:");


          for(int loop = 0; loop < 4; loop++)
          {
               switch  (loop)
               {
                    case 0x00:
                    {
                         wholeNumber = (int) g_player1LocationX;
                         decimalNumber = (int) ((g_player1LocationX - wholeNumber) * 1000);
                         break;
                    }
                    case 0x01:
                    {
                         wholeNumber = (int) g_player1LocationY;
                         decimalNumber = (int) ((g_player1LocationY - wholeNumber) * 1000);
                         break;
                    }
                    case 0x02:
                    {
                         wholeNumber = (int) g_player1LocationZ;
                         decimalNumber = (int) ((g_player1LocationZ - wholeNumber) * 1000);
                         break;
                    }
                    case 0x03:
                    {
                         float playerAngle = (((float)g_player1LocationA / 65536) * 360);
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
                         if (modMode[3] == 1)
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
                         if (modMode[3] == 1)
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
                         if (modMode[3] == 1)
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
               if ((loop == 2) & (modMode[3] == 2))
               {
                    printOffsetB = printOffsetB + 8;
               }
               printOffsetA = 48;

               if ((modMode[3] == 1) | (loop == 3))
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
               if ((modMode[3] == 1) | (loop == 3))
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

     if (modMode[0] == 0x01)
     {
          GraphPtr = drawBox(GraphPtr, menuX + 18, menuY + 18, menuX + (12 * 8) + 19, menuY + 28, 0, 0,0, 175);
          loadFont();

          printString(menuX,menuY, "Practice  ON");

     }
     else if (modMode[4] > 0)
     {
          GraphPtr = drawBox(GraphPtr, menuX + 18, menuY + 18, menuX + (11 * 8) + 19, menuY + 28, 0, 0,0, 175);
          loadFont();

          printString(menuX,menuY, "Force Items");
     }
     else if (gameMode[3] > 0x00)
     {

          switch (gameMode[3])
          {
               // PRACTICE BUILD overlay text.
               case 0x01 :
               {
                    GraphPtr = drawBox(GraphPtr, menuX + 18, menuY + 18, menuX + (10 * 8) + 19, menuY + 28, 0, 0,0, 175);
                    loadFont();
                    printString(menuX,menuY, "Versus CPU");
                    break;
               }
               case 0x02 :
               {
                    GraphPtr = drawBox(GraphPtr, menuX + 18, menuY + 18, menuX + (9 * 8) + 19, menuY + 28, 0, 0,0, 175);
                    loadFont();
                    printString(menuX,menuY, "Debug CPU");
                    break;
               }
          }
     }
     else if (gameMode[4] > 0x00)
     {
          GraphPtr = drawBox(GraphPtr, menuX + 18, menuY + 18, menuX + (11 * 8) + 19, menuY + 28, 0, 0,0, 175);
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
                    if (gameMode[currentParameter-1 + menuIndex] > 0)
                    {
                         gameMode[currentParameter-1 + menuIndex]--;
                    }
                    break;
               }
               case 1:
               {
                    if (modMode[currentParameter-1 + menuIndex] > 0)
                    {
                         modMode[currentParameter-1 + menuIndex]--;
                    }
                    break;
               }
               case 2:
               {
                    if (renderMode[currentParameter-1 + menuIndex] > 0)
                    {
                         renderMode[currentParameter-1 + menuIndex]--;
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
                    if (gameMode[currentParameter-1 + menuIndex] < gameLimits[currentParameter-1 + menuIndex])
                    {
                         gameMode[currentParameter-1 + menuIndex]++;
                    }
                    break;
               }
               case 1:
               {
                    if (modMode[currentParameter-1 + menuIndex] < modLimits[currentParameter-1 + menuIndex])
                    {
                         modMode[currentParameter-1 + menuIndex]++;
                    }
                    break;
               }
               case 2:
               {
                    if (renderMode[currentParameter-1 + menuIndex] < renderLimits[currentParameter-1 + menuIndex])
                    {
                         renderMode[currentParameter-1 + menuIndex]++;
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
     GraphPtr = drawBox(GraphPtr, 50, 10, 270, 127, 0, 0,0, 175);
     GraphPtr = drawBox(GraphPtr, 48, 8, 50, 127, 0, 0,0, 255);
     GraphPtr = drawBox(GraphPtr, 270, 8, 272, 127, 0, 0,0, 255);
     GraphPtr = drawBox(GraphPtr, 50, 8, 270, 10, 0, 0,0, 255);
     GraphPtr = drawBox(GraphPtr, 50, 125, 270, 127, 0, 0,0, 255);

     GraphPtr = drawBox(GraphPtr, 60, 32, 260, 33, 0, 0,0, 255);




     if (currentPage == 3)
     {
          if (currentParameter == 0)
          {
               menuX = 157 - ((menuChar[currentPage]) * 4);
               GraphPtr = drawBox(GraphPtr, menuX, 17, menuX + (menuChar[currentPage] * 8), 27, 200, 0, 0, 200);
          }
          else if (currentParameter == 1)
          {
               menuX = 157 - ((cupChar[cupSelection]) * 4);
               GraphPtr = drawBox(GraphPtr, menuX, 45, menuX + (cupChar[cupSelection] * 8), 55, 200, 0, 0, 200);
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
               menuY = ((currentParameter - 1) * 14) + 38;
               GraphPtr = drawBox(GraphPtr, menuX, menuY, menuX + (courseChar[(long)*l_courseID] * 8), menuY+11, 200, 0, 0, 200);
          }
     }
     else
     {
          if (currentParameter == 0)
          {
               menuX = 157 - ((menuChar[currentPage]) * 4);
               GraphPtr = drawBox(GraphPtr, menuX, 19, menuX + (menuChar[currentPage] * 8), 29, 200, 0, 0, 200);
          }
          else
          {
               menuY = currentParameter * 18 + 33;
               GraphPtr = drawBox(GraphPtr, 55, menuY, 60, menuY+5, 200, 0, 0, 200);
          }


          if (pageLimit[currentPage] > 4)
          {
               if (menuIndex == 0)
               {
                    if (menuBlink < 15)
                    {
                         GraphPtr = drawBox(GraphPtr, 157, 113, 165, 121, 0, 0, 0, 240);
                         GraphPtr = drawBox(GraphPtr, 158, 114, 164, 120, 200, 0, 0, 240);
                    }

               }
               else
               {
                    if (menuBlink < 15)
                    {
                         GraphPtr = drawBox(GraphPtr, 157, 37, 165, 45, 0, 0, 0, 240);
                         GraphPtr = drawBox(GraphPtr, 158, 38, 164, 44, 200, 0, 0, 240);
                    }
               }
          }
     }


     loadFont();


     if (SYSTEM_Region == 0x00)
     {
          printString(18,195,"PAL");
     }
     else
     {
          printString(18,195,"NTSC");
     }

     printString(0,205,"BUILD 4.0");
     printString(200,195,"OverKart");
     printString(216,205,"Team");

     int menuLoop = 0;


     menuX = 138 - (menuChar[currentPage] * 4);
     printString(menuX,0,menuNames[currentPage]);
     menuY = 30;

     switch(currentPage)
     {
          case 0:
          {
               do{
                    printString(45,menuY,gameOptions[menuLoop + menuIndex]);
                    menuX = 200 - (gameChar[menuLoop+ menuIndex][gameMode[menuLoop + menuIndex]] * 4);
                    printString(menuX,menuY,gameParameters[menuLoop+ menuIndex][gameMode[menuLoop + menuIndex]]);
                    menuY = menuY + 18;
                    menuLoop++;
               } while (menuLoop < 4);
               break;
          }
          case 1:
          {
               do{
                    printString(45,menuY,modOptions[menuLoop + menuIndex]);
                    menuX = 200 - (modChar[menuLoop + menuIndex][modMode[menuLoop + menuIndex]] * 4);
                    printString(menuX,menuY,modParameters[menuLoop + menuIndex][modMode[menuLoop + menuIndex]]);
                    menuY = menuY + 18;
                    menuLoop++;
               } while (menuLoop < 4);
               break;
          }
          case 2:
          {
               do{
                    printString(45,menuY,renderOptions[menuLoop + menuIndex]);
                    menuX = 200 - (renderChar[menuLoop + menuIndex][renderMode[menuLoop + menuIndex]] * 4);
                    printString(menuX,menuY,renderParameters[menuLoop + menuIndex][renderMode[menuLoop + menuIndex]]);
                    menuY = menuY + 18;
                    menuLoop++;
               } while (menuLoop < 4);
               break;
          }
          case 3:
          {
               menuX = 135 - (cupChar[cupSelection] * 4);
               printString(menuX,22,cupNames[cupSelection]);
               menuY = 40;
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
     if (currentPage != 3)
     {
          if (pageLimit[currentPage] > 4)
          {
               if (menuIndex == 0)
               {
                    if (menuBlink < 15)
                    {
                         printString(137,93,"+");
                    }

               }
               else
               {
                    if (menuBlink < 15)
                    {
                         printString(137,17,"+");
                    }
               }
          }
     }



     g_mlogoY = 0x00000075;
     g_mflagID = 0;
     g_mpressstartID = 0;
     g_mracewayTime = 0;


}



void titleMenu(void)
{
     if (menuBlink > 30)
     {
          menuBlink = 0;
     }
     else
     {
          menuBlink++;
     }


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

     if ((titleDemo > 3) && (menuScreenB <= 0x03))
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
                                   menuIndex = 0;
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
                                   menuIndex = 0;
                                   playSound(0x4900801A);
                              }
                         }
                         break;

                    }
                    //Move forward to next option
                    case 0x04 :
                    {
                         menuButton = 0x01;
                         if (currentParameter + menuIndex < pageLimit[currentPage])
                         {
                              if ((currentParameter == 4) & (currentPage < 3))
                              {
                                   menuIndex++;
                              }
                              else
                              {
                                   currentParameter++;
                              }

                         }
                         break;

                         //
                    }
                    //Move backward to previous option
                    case 0x08 :
                    {
                         menuButton = 0x01;
                         if (currentParameter + menuIndex > 0)
                         {
                              if ((currentParameter == 1) & (currentPage < 3) & (menuIndex > 0))
                              {
                                   menuIndex--;
                              }
                              else
                              {
                                   currentParameter--;
                              }

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

     // This handles the FASTRESET hack in the Dpad Menu g_InGame




}
