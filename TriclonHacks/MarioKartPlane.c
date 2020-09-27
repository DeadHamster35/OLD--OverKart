#include "library/MarioKart.h"
#include "library/OverKart.h"


void planeGame()
{
  gravity_1 = 100;
  gravity_2 = 100;
  gravity_3 = 100;
  gravity_4 = 100;
  gravity_5 = 100;
  gravity_6 = 100;
  gravity_7 = 100;
  gravity_8 = 100;
  surface_p0 = 0x0000;



  if ((player1SpeedA != 0) | (player1SpeedB != 0))
  {
    player1Y = player1Y + ((player1inputY / -127.0f) * 3);
  }
}
