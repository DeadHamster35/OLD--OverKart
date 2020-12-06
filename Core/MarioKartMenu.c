#include <math.h>
#include "library/MarioKart.h"
#include "library/OKHeader.h"
#include "MarioKartMenu.h"
#include "Core.h"

char *menuNames[] = {"Game Options", "Cup Editor"};

int gameMode[5] = {0,0,0,0,0};

static int menuChar[] = {12,10};

char *gameOptions[] = {"Option A", "Option B", "Option C", "Option D", "Option E"};
char *gameParameters[][9] = {{"ABC1", "ABC2","ABC3"}, {"ABCDEF1", "ABCDEF2"}, {"GHI1", "GHI2","GHI3","GHI4"},{"JKL1", "JKL2","JKL3"}, {"MNO1", "MNO2","MNO3"}};


static int gameLimits[] = {2,1,3,2,2};  //how many parameters for each option.


static int gameChar[][4] = {{4,4,4}, {7,7}, {4,4,4,4}, {4,4,4},{4,4,4}};  //how many letters in each parameter
// the X parameter of gameChar[][X] needs to be equal to the largest number of parameters.
// gameChar[2] has 4 parameters, "GHI1", "GHI2","GHI3", and "GHI4" so the number is 4.
// if you had a option with 7 parameters, it would need to be 7.

static int pageLimit[] = {5,5};  //how many total options on each page
//duplicate gameOptions - gameChar for new pages, add additional elements to pageLimit and menuNames for corresponding pages.
//add new xxxMode array for tracking options, see below for parameter function

//check below for adding more pages to swapping functions.


char *cupNames[] = {"Mushroom Cup","Flower Cup","Star Cup","Special Cup"};
static int cupChar[] = {12,10,8,11};

char *courseNames[] = {"Mario Raceway", "Choco Mountain", "Bowser Castle", "Banshee Boardwalk","Yoshi Valley", "Frappe Snowland", "Koopa Troopa Beach", "Royal Raceway",
"Luigi Raceway", "Moo Moo Farm", "Toad Turnpike","Kalimari Desert","Sherbet Land","Rainbow Road","Wario Stadium", "Block Fort", "Skyscraper", "Double Deck", "DK Jungle Parkway","Big Donut"};
static int courseChar[] = {13,14,13,17,12,15,18,13,13,12,13,15,11,12,13,10,10,11,17,9};





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
               }  //duplicate this case for additional pages. Add new xxxMode variables.
               case 1:
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



     //the Cup Editor menu is treated different from the others.
     if (currentPage == 1)
     {
          if (currentParameter == 0)
          {
               menuX = 157 - ((menuChar[currentPage]) * 4);
               GraphPtr = drawBox(GraphPtr, menuX, 17, menuX + (menuChar[currentPage] * 8), 27, 200, 0, 0, 200);
          }
          else if (currentParameter == 1)
          {
               menuX = 157 - ((cupChar[cupSelection]) * 4);
               GraphPtr = drawBox(GraphPtr, menuX, 40, menuX + (cupChar[cupSelection] * 8), 50, 200, 0, 0, 200);
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
               menuY = ((currentParameter - 1) * 14) + 43;
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
     if (currentPage != 1)
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
                              if (currentPage < 1) //increase this to allow more pages
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
                              if (currentPage == 1)
                              {
                                   currentParameter++;

                              }
                              else
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
                              if (currentPage == 1)
                              {
                                   currentParameter--;

                              }
                              else
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

                         }
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




}
