
/*
Here we create declarations for a few functions and variables in MK64 so they can be referenced from our C code.
Later we will tell armips their addresses by defining labels for them in hotswap.asm.
*/

extern void decodeMIO0(int input, int output);
extern void DMA(int RAM, int ROM, int Length);
extern void decodeTKMK(int input, int output);
extern void printString(int xPosition, int yPosition, const char *printText);
extern void colorFont(int color);
extern void loadFont();


extern char g_CourseID; //0x800DC5A0
extern char loadedCourse; //0x800DC5A5
extern char startingIndicator;
extern char p_Input; //800F6915
extern char d_Input; //800F6914

extern char songID; //0x8028ECE7



extern char gameOn;

extern long titleDemo; //0x8018EE00

extern char backButton;  //0x8018EDE3 == 0x01 backing out of a window
extern char courseScreenA; //8018EDEE  >= 0x02
extern char courseScreenB; //8018EDEC;  == 0x01
extern char courseScreenC; //8018EDEC;  == 0x01

extern char gameMode; //0x800DC53F   0 = gp 1 = time trials 2 = vs 3 =battle

extern char cupSelect; //8018EE09
extern char courseSelect; //8018EE0B

extern char inGame; //0x8018EDFB


extern long tempo1A; //0x800015C4  ;;3C0F8015
extern char tempo1AS; //0x800015C7  ;;speed value
extern long tempo1B; //0x800015C8  ;;8DEF0114
extern char tempo1BS; //0x800015CB  ;; speed value

extern long tempo2A; //0x80001A38  ;;3C098015
extern char tempo2AS; //0x80001A3B  ;;speed value
extern long tempo2B; //0x80001A3C  ;;8D290114
extern char tempo2BS; //0x80001A3F  ;; speed value

extern long tempo3A; //0x80001C90  ;;3C0A8015
extern char tempo3AS; //0x80001C93  ;;speed value
extern long tempo3B; //0x80001C94  ;;8D4A0114
extern char tempo3BS; //0x80001C97  ;; speed value


extern char resetButton; //0x800DC50F



extern char playerCount; //800DC53B
extern char p2AI; //800DC53B
extern char p3AI; //800DC53B
extern char p4AI; //800DC53B
extern char p5AI; //800DC53B
extern char p6AI; //800DC53B
extern char p7AI; //800DC53B
extern char p8AI; //800DC53B





extern short selectA; //0x800B3924
extern short selectB; //0x800B3924
extern short selectC; //0x800B3924
extern short selectD; //0x800B3924
extern short selectE; //0x800B3924
extern short selectF; //0x800B3924


extern char player2OK; //800DC53B
extern char player3OK; //800DC53B
extern char player4OK; //800DC53B


extern char itemBoolean; //0x80165F5F
extern char gameLap; //80164394
extern char lapA; //
extern char lapB; //
extern long timerA;
extern char itemA;
extern char itemB;
extern char itemC;

extern long ingameX;
extern long ingameY;
extern long ingameZ;
extern long ingameX2;
extern long ingameY2;
extern long ingameZ2;
extern long ingameROT;

extern long ingameSpeedA;
extern long ingameSpeedB;
extern long ingameSpeedC;
extern long ingameSpeedD;
extern long ingameSpeedE;

extern long internalX;
extern long internalY;
extern long internalZ;
extern long internalROT;


extern char internalBool; //0x80600000
extern char startupBool;
extern char forceCPU;

extern char menuFlag;
extern char cpuFlag;

extern char parameterFlag;
extern char parameterFlagB;
extern char parameterFlagC;
extern char buttonPressed;
