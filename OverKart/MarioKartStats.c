#include "library/MarioKart.h"
#include "library/MarioKartStats.h"
#include "library/OKHeader.h"
#include "MarioKartMenu.h"
#include "OverKart.h"

int statsCheck = 0;
static float statData;



void dmaLoop(int loopCount)
{
     int currentPass = 0;
     do{
          runDMA();
          *targetAddress = *targetAddress + dataLength;
          currentPass++;
     } while (currentPass < loopCount);
}

void unknown33()
{
     //Unknown33 - 40
     if (gameMode[4]== 0)
     {
          *sourceAddress = 0xE36D0;
          *targetAddress = 0x800E2AD0;
          dataLength = 0x1E0;
          runDMA();
     }
     else
     {
          switch(gameMode[4])
          {

               case 0x01:
               {
                    *sourceAddress = 0xE36D0;
                    break;
               }
               case 0x02:
               {
                    *sourceAddress = 0xE370C;
                    break;
               }
               case 0x03:
               {
                    *sourceAddress = 0xE3748;
                    break;
               }
               case 0x04:
               {
                    *sourceAddress = 0xE3784;
                    break;
               }
               case 0x05:
               {
                    *sourceAddress = 0xE37C0;
                    break;
               }
               case 0x06:
               {
                    *sourceAddress = 0xE37FC;
                    break;
               }
               case 0x07:
               {
                    *sourceAddress = 0xE3838;
                    break;
               }
               case 0x08:
               {
                    *sourceAddress = 0xE3874;
                    break;
               }
          }
          dataLength = 0x3C;
          *targetAddress = 0x800E2AD0;
          dmaLoop(8);
     }
}



void unknown41()
{

     if (gameMode[4] == 0)
     {
          *sourceAddress = 0xE38B0;
          *targetAddress = 0x800E2CB0;
          dataLength = 0x1E0;
          runDMA();
     }
     else
          {
          switch(gameMode[4])
          {

               case 0x01:
               {
                    *sourceAddress = 0xE38B0;
                    break;
               }
               case 0x02:
               {
                    *sourceAddress = 0xE38EC;
                    break;
               }
               case 0x03:
               {
                    *sourceAddress = 0xE3928;
                    break;
               }
               case 0x04:
               {
                    *sourceAddress = 0xE3964;
                    break;
               }
               case 0x05:
               {
                    *sourceAddress = 0xE39A0;
                    break;
               }
               case 0x06:
               {
                    *sourceAddress = 0xE39DC;
                    break;
               }
               case 0x07:
               {
                    *sourceAddress = 0xE3A18;
                    break;
               }
               case 0x08:
               {
                    *sourceAddress = 0xE3A54;
                    break;
               }
          }
          *targetAddress = 0x800E2CB0;
          dataLength = 0x3C;
          dmaLoop(8);
     }



}


void accelTable()
{
     if (gameMode[4] == 0)
     {
          *sourceAddress = 0xE3AD0;
          *targetAddress = 0x800E2ED0 ;
          dataLength = 0x140;
          runDMA();
     }
     else
     {
          switch(gameMode[4])
          {
               case 0x01:
               {
                    *sourceAddress = 0xE3AD0;
                    break;
               }
               case 0x02:
               {
                    *sourceAddress = 0xE3AF8;
               }
               case 0x03:
               {
                    *sourceAddress = 0xE3B20;
               }
               case 0x04:
               {
                    *sourceAddress = 0xE3B48;
               }
               case 0x05:
               {
                    *sourceAddress = 0xE3B70;
                    break;
               }
               case 0x06:
               {
                    *sourceAddress = 0xE3B98;
                    break;
               }
               case 0x07:
               {
                    *sourceAddress = 0xE3BC0;
                    break;
               }
               case 0x08:
               {
                    *sourceAddress = 0xE3BE8;
                    break;
               }
          }
          dataLength = 0x28;
          *targetAddress = 0x800E2ED0;
          dmaLoop(8);
     }


}



void equalStats()
{
     //unknown11
     switch(gameMode[4])
     {
          case 0x00:
          {
               u11_Mario = 3364;
               u11_Luigi = 3364;
               u11_Yoshi = 3457;
               u11_Toad = 3457;
               u11_DK = 3364;
               u11_Wario = 3364;
               u11_Peach = 3457;
               u11_Bowser = 3364;
               break;
          }
          case 0x01:
          {
               statData = 3364;
               break;
          }
          case 0x02:
          {
               statData = 3364;
               break;
          }
          case 0x03:
          {
               statData = 3457;
               break;
          }
          case 0x04:
          {
               statData = 3457;
               break;
          }
          case 0x05:
          {
               statData = 3364;
               break;
          }
          case 0x06:
          {
               statData = 3364;
               break;
          }
          case 0x07:
          {
               statData = 3457;
               break;
          }
          case 0x08:
          {
               statData = 3364;
               break;
          }



     }
     if (gameMode[4] > 0x00)
     {
          u11_Mario = statData;
          u11_Luigi = statData;
          u11_Yoshi = statData;
          u11_Toad = statData;
          u11_DK = statData;
          u11_Wario = statData;
          u11_Peach = statData;
          u11_Bowser = statData;
     }
     //
     //
     //





     //unknown12
     switch(gameMode[4])
     {
          case 0x00:
          {
               u12_Mario = 3844;
               u12_Luigi = 3844;
               u12_Yoshi = 3943;
               u12_Toad = 3943;
               u12_DK = 3844;
               u12_Wario = 3844;
               u12_Peach = 3943;
               u12_Bowser = 3844;
               break;
          }
          case 0x01:
          {
               statData = 3844;
               break;
          }
          case 0x02:
          {
               statData = 3844;
               break;
          }
          case 0x03:
          {
               statData = 3943;
               break;
          }
          case 0x04:
          {
               statData = 3943;
               break;
          }
          case 0x05:
          {
               statData = 3844;
               break;
          }
          case 0x06:
          {
               statData = 3844;
               break;
          }
          case 0x07:
          {
               statData = 3943;
               break;
          }
          case 0x08:
          {
               statData = 3844;
               break;
          }



     }
     if (gameMode[4] > 0x00)
     {
          u12_Mario = statData;
          u12_Luigi = statData;
          u12_Yoshi = statData;
          u12_Toad = statData;
          u12_DK = statData;
          u12_Wario = statData;
          u12_Peach = statData;
          u12_Bowser = statData;
     }
     //
     //
     //









     //unknown13
     switch(gameMode[4])
     {
          case 0x00:
          {
               u13_Mario = 4096;
               u13_Luigi = 4096;
               u13_Yoshi = 4199;
               u13_Toad = 4199;
               u13_DK = 4096;
               u13_Wario = 4096;
               u13_Peach = 4199;
               u13_Bowser = 4096;
               break;
          }
          case 0x01:
          {
               statData = 4096;
               break;
          }
          case 0x02:
          {
               statData = 4096;
               break;
          }
          case 0x03:
          {
               statData = 4199;
               break;
          }
          case 0x04:
          {
               statData = 4199;
               break;
          }
          case 0x05:
          {
               statData = 4096;
               break;
          }
          case 0x06:
          {
               statData = 4096;
               break;
          }
          case 0x07:
          {
               statData = 4199;
               break;
          }
          case 0x08:
          {
               statData = 4096;
               break;
          }



     }
     if (gameMode[4] > 0x00)
     {
          u13_Mario = statData;
          u13_Luigi = statData;
          u13_Yoshi = statData;
          u13_Toad = statData;
          u13_DK = statData;
          u13_Wario = statData;
          u13_Peach = statData;
          u13_Bowser = statData;
     }
     //
     //
     //









     //unknown14
     switch(gameMode[4])
     {
          case 0x00:
          {
               u14_Mario = 3844;
               u14_Luigi = 3844;
               u14_Yoshi = 3943;
               u14_Toad = 3943;
               u14_DK = 3844;
               u14_Wario = 3844;
               u14_Peach = 3943;
               u14_Bowser = 3844;
               break;
          }
          case 0x01:
          {
               statData = 3844;
               break;
          }
          case 0x02:
          {
               statData = 3844;
               break;
          }
          case 0x03:
          {
               statData = 3943;
               break;
          }
          case 0x04:
          {
               statData = 3943;
               break;
          }
          case 0x05:
          {
               statData = 3844;
               break;
          }
          case 0x06:
          {
               statData = 3844;
               break;
          }
          case 0x07:
          {
               statData = 3943;
               break;
          }
          case 0x08:
          {
               statData = 3844;
               break;
          }



     }

     if (gameMode[4] > 0x00)
     {
          u14_Mario = statData;
          u14_Luigi = statData;
          u14_Yoshi = statData;
          u14_Toad = statData;
          u14_DK = statData;
          u14_Wario = statData;
          u14_Peach = statData;
          u14_Bowser = statData;
     }
     //
     //
     //










     //cc50
     switch(gameMode[4])
     {
          case 0x00:
          {
               cc50_Mario = 290;
               cc50_Luigi = 290;
               cc50_Yoshi = 294;
               cc50_Toad = 294;
               cc50_DK = 290;
               cc50_Wario = 290;
               cc50_Peach = 294;
               cc50_Bowser = 290;
               break;
          }
          case 0x01:
          {
               statData = 290;
               break;
          }
          case 0x02:
          {
               statData = 290;
               break;
          }
          case 0x03:
          {
               statData = 294;
               break;
          }
          case 0x04:
          {
               statData = 294;
               break;
          }
          case 0x05:
          {
               statData = 290;
               break;
          }
          case 0x06:
          {
               statData = 290;
               break;
          }
          case 0x07:
          {
               statData = 294;
               break;
          }
          case 0x08:
          {
               statData = 290;
               break;
          }



     }
     if (gameMode[4] > 0x00)
     {
          cc50_Mario = statData;
          cc50_Luigi = statData;
          cc50_Yoshi = statData;
          cc50_Toad = statData;
          cc50_DK = statData;
          cc50_Wario = statData;
          cc50_Peach = statData;
          cc50_Bowser = statData;
     }
     //
     //
     //









     //cc100
     switch(gameMode[4])
     {
          case 0x00:
          {
               cc100_Mario = 310;
               cc100_Luigi = 310;
               cc100_Yoshi = 314;
               cc100_Toad = 314;
               cc100_DK = 310;
               cc100_Wario = 310;
               cc100_Peach = 314;
               cc100_Bowser = 310;
               break;
          }
          case 0x01:
          {
               statData = 310;
               break;
          }
          case 0x02:
          {
               statData = 310;
               break;
          }
          case 0x03:
          {
               statData = 314;
               break;
          }
          case 0x04:
          {
               statData = 314;
               break;
          }
          case 0x05:
          {
               statData = 310;
               break;
          }
          case 0x06:
          {
               statData = 310;
               break;
          }
          case 0x07:
          {
               statData = 314;
               break;
          }
          case 0x08:
          {
               statData = 310;
               break;
          }



     }
     if (gameMode[4] > 0x00)
     {
          cc100_Mario = statData;
          cc100_Luigi = statData;
          cc100_Yoshi = statData;
          cc100_Toad = statData;
          cc100_DK = statData;
          cc100_Wario = statData;
          cc100_Peach = statData;
          cc100_Bowser = statData;
     }
     //
     //
     //










     //cc150
     switch(gameMode[4])
     {
          case 0x00:
          {
               cc150_Mario = 320;
               cc150_Luigi = 320;
               cc150_Yoshi = 324;
               cc150_Toad = 324;
               cc150_DK = 320;
               cc150_Wario = 320;
               cc150_Peach = 324;
               cc150_Bowser = 320;
               break;
          }
          case 0x01:
          {
               statData = 320;
               break;
          }
          case 0x02:
          {
               statData = 320;
               break;
          }
          case 0x03:
          {
               statData = 324;
               break;
          }
          case 0x04:
          {
               statData = 324;
               break;
          }
          case 0x05:
          {
               statData = 320;
               break;
          }
          case 0x06:
          {
               statData = 320;
               break;
          }
          case 0x07:
          {
               statData = 324;
               break;
          }
          case 0x08:
          {
               statData = 320;
               break;
          }



     }
     if (gameMode[4] > 0x00)
     {
          cc150_Mario = statData;
          cc150_Luigi = statData;
          cc150_Yoshi = statData;
          cc150_Toad = statData;
          cc150_DK = statData;
          cc150_Wario = statData;
          cc150_Peach = statData;
          cc150_Bowser = statData;
     }
     //
     //
     //










     //ccextra
     switch(gameMode[4])
     {
          case 0x00:
          {
               ccextra_Mario = 310;
               ccextra_Luigi = 310;
               ccextra_Yoshi = 314;
               ccextra_Toad = 314;
               ccextra_DK = 310;
               ccextra_Wario = 310;
               ccextra_Peach = 314;
               ccextra_Bowser = 310;
               break;
          }
          case 0x01:
          {
               statData = 310;
               break;
          }
          case 0x02:
          {
               statData = 310;
               break;
          }
          case 0x03:
          {
               statData = 314;
               break;
          }
          case 0x04:
          {
               statData = 314;
               break;
          }
          case 0x05:
          {
               statData = 310;
               break;
          }
          case 0x06:
          {
               statData = 310;
               break;
          }
          case 0x07:
          {
               statData = 314;
               break;
          }
          case 0x08:
          {
               statData = 310;
               break;
          }



     }
     if (gameMode[4] > 0x00)
     {
          ccextra_Mario = statData;
          ccextra_Luigi = statData;
          ccextra_Yoshi = statData;
          ccextra_Toad = statData;
          ccextra_DK = statData;
          ccextra_Wario = statData;
          ccextra_Peach = statData;
          ccextra_Bowser = statData;
     }
     //
     //
     //







     switch(gameMode[4])
     {
          case 0x00:
          {
               turncoA_Mario = 0;
               turncoA_Luigi = 0;
               turncoA_Yoshi = 0.002;
               turncoA_Toad = 0.002;
               turncoA_DK = -0.002;
               turncoA_Wario = -0.002;
               turncoA_Peach = 0.002;
               turncoA_Bowser = -0.002;
               turncoB_Mario = 0;
               turncoB_Luigi = 0;
               turncoB_Yoshi = 0.002;
               turncoB_Toad = 0.002;
               turncoB_DK = -0.002;
               turncoB_Wario = -0.002;
               turncoB_Peach = 0.002;
               turncoB_Bowser = -0.002;
               break;
          }
          case 0x01:
          {
               statData = 0;
               break;
          }
          case 0x02:
          {
               statData = 0;
               break;
          }
          case 0x03:
          {
               statData = 0.002;
               break;
          }
          case 0x04:
          {
               statData = 0.002;
               break;
          }
          case 0x05:
          {
               statData = -0.002;
               break;
          }
          case 0x06:
          {
               statData = -0.002;
               break;
          }
          case 0x07:
          {
               statData = 0.002;
               break;
          }
          case 0x08:
          {
               statData = -0.002;
               break;
          }



     }
     if (gameMode[4] > 0x00)
     {
          turncoA_Mario = statData;
          turncoA_Luigi = statData;
          turncoA_Yoshi = statData;
          turncoA_Toad = statData;
          turncoA_DK = statData;
          turncoA_Wario = statData;
          turncoA_Peach = statData;
          turncoA_Bowser = statData;
          turncoB_Mario = statData;
          turncoB_Luigi = statData;
          turncoB_Yoshi = statData;
          turncoB_Toad = statData;
          turncoB_DK = statData;
          turncoB_Wario = statData;
          turncoB_Peach = statData;
          turncoB_Bowser = statData;
     }




     switch(gameMode[4])
     {
          case 0x00:
          {
               tripleTap_Mario = 2;

               tripleTap_Luigi = 2;

               tripleTap_Yoshi = 3;

               tripleTap_Toad = 3;

               tripleTap_DK = 1.5;

               tripleTap_Wario = 1.5;

               tripleTap_Peach = 3;

               tripleTap_Bowser = 3;

               break;
          }
          case 0x01:
          {
               statData = 2;
               break;
          }
          case 0x02:
          {
               statData = 2;
               break;
          }
          case 0x03:
          {
               statData = 3;
               break;
          }
          case 0x04:
          {
               statData = 3;
               break;
          }
          case 0x05:
          {
               statData = 1.5;
               break;
          }
          case 0x06:
          {
               statData = 1.5;
               break;
          }
          case 0x07:
          {
               statData = 3;
               break;
          }
          case 0x08:
          {
               statData = 3;
               break;
          }



     }
     if (gameMode[4] > 0x00)
     {
          tripleTap_Mario = statData;
          tripleTap_Luigi = statData;
          tripleTap_Yoshi = statData;
          tripleTap_Toad = statData;
          tripleTap_DK = statData;
          tripleTap_Wario = statData;
          tripleTap_Peach = statData;
          tripleTap_Bowser = statData;
     }

     switch(gameMode[4])
     {
          case 0x00:
          {
               turnangle_Mario = 1.25;

               turnangle_Luigi = 1.25;

               turnangle_Yoshi = 1.28;

               turnangle_Toad = 1.28;

               turnangle_DK = 1.15;

               turnangle_Wario = 1.15;

               turnangle_Peach = 1.28;

               turnangle_Bowser = 1.28;

               break;
          }
          case 0x01:
          {
               statData = 1.25;
               break;
          }
          case 0x02:
          {
               statData = 1.25;
               break;
          }
          case 0x03:
          {
               statData = 1.28;
               break;
          }
          case 0x04:
          {
               statData = 1.28;
               break;
          }
          case 0x05:
          {
               statData = 1.15;
               break;
          }
          case 0x06:
          {
               statData = 1.15;
               break;
          }
          case 0x07:
          {
               statData = 1.28;
               break;
          }
          case 0x08:
          {
               statData = 1.28;
               break;
          }



     }
     if (gameMode[4] > 0x00)
     {
          turnangle_Mario = statData;
          turnangle_Luigi = statData;
          turnangle_Yoshi = statData;
          turnangle_Toad = statData;
          turnangle_DK = statData;
          turnangle_Wario = statData;
          turnangle_Peach = statData;
          turnangle_Bowser = statData;

     }






     accelTable(gameMode[4]);

     unknown33(gameMode[4]);
     unknown41(gameMode[4]);



}


void checkStats()
{
     if (gameMode[4] != statsCheck)
     {
          equalStats();
          statsCheck = gameMode[4];
     }
}
