extern void decodeMIO0(int input, int output);
extern void DMA(int output, int input, int Length);
extern void decodeTKMK(int input, int output);
extern void loadCourse(int courseID);
extern void ramCopy(int output, int input, int Length);
extern void InitControllers();
extern void readControllers();



extern void printString(int xPosition, int yPosition, const char *printText);
extern unsigned long* drawBox(unsigned long *buf, int x1, int y1, int x2, int y2, int r, int g, int b, int a);
extern unsigned long* boxOffset;

extern void initializePlayer(int playerStructure, int characterID, float deltaX, float deltaZ, int characterID2, int unknown0xB000);

extern void playSound(int soundID);

extern void colorFont(int color);
extern void loadFont();


//
//

extern long nopASM; //0x80002714
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

extern short asm_selectA; //0x800B3924
extern short asm_selectB; //0x800B3924
extern short asm_selectC; //0x800B3924
extern short asm_selectD; //0x800B3924
extern short asm_selectE; //0x800B3924
extern short asm_selectF; //0x800B3924

extern char g_resetToggle; //
extern char g_startingIndicator;
extern char g_playerCount; //
extern char g_gameType;
extern char g_ccSelection;
extern float g_gameTimer;
extern char g_CourseID;
extern char g_loadedcourseFlag;
extern char g_gameMode; //0 = gp 1 = time trials 2 = vs 3 =battle
extern short g_mirrorMode;

extern long antialiasToggle;
extern long antialiasToggleB;

extern short player1inputX;
extern short player1inputY;
extern short p1Button;


extern char p_Input; //
extern char d_Input; //
extern char c_Input;

extern float player1X;
extern float player1Y;
extern float player1Z;
extern float player1ROT;
extern float player1SpeedA;
extern float player1SpeedB;
extern float player1SpeedC;
extern float player1SpeedD;
extern float player1SpeedE;

extern float player2X;
extern float player2Y;
extern float player2Z;
extern float player3X;
extern float player3Y;
extern float player3Z;
extern float player4X;
extern float player4Y;
extern float player4Z;

extern long cpu2Speed;
extern long cpu3Speed;
extern long cpu4Speed;

extern char boost2;
extern char boost3;
extern char boost4;

extern char g_player1State; //
extern char g_player2State; //
extern char g_player3State; //
extern char g_player4State; //
extern char g_player5State; //
extern char g_player6State; //
extern char g_player7State; //

extern float aspectRatio;
extern float farClip;

extern float g_lap1Time;
extern float g_lap2Time;
extern float g_lap3Time;

extern long g_progressValue;

extern float gravity_1;
extern float gravity_2;
extern float gravity_3;
extern float gravity_4;
extern float gravity_5;
extern float gravity_6;
extern float gravity_7;
extern float gravity_8;

extern short surface_p0;

extern long g_gameLap; //80164394
extern char itemBoolean; //0x80165F5F
extern char itemA;
extern char itemB;
extern char itemC;

extern char g_lapCheckA; //
extern char g_lapCheckB; //
extern char backButton;  //
extern char menuScreenA; //
extern char menuScreenB; //
extern char menuScreenC; //

extern long titleDemo; //

extern char cupSelect; //8018EE09
extern char courseSelect; //8018EE0B
extern char inGame; //0x8018EDFC

extern char songID; //

extern char player2OK; //
extern char player3OK; //
extern char player4OK; //




// the following all deal with ASM instructions in the game.
// we edit them in the customASM and stockASM routines.

extern long highpolypipeA; //0x802911E8   ;;3C190700
extern long highpolypipeB; //0x802911EC   ;;373908E8

extern long lowpolypipeA; //0x8029120C   ;;3C0A0700
extern long lowpolypipeB; //0x80291210   ;;354A2D68


extern long bigmushroomA; //0x802911A4   ;;3C180700
extern long bigmushroomB; //0x802911A8   ;;37181140

extern long bigmushroomsurfaceA; //0x80295E3C   ;;3C040700
extern long bigmushroomsurfaceB; //0x80295E44   ;;34841140

extern long audienceA; //0x802927EC   ;;3C0F0700
extern long audienceB; //0x802927F0   ;;35EF14A0

extern long audienceflagsA; //0x802928F0   ;;3C0D0700
extern long audienceflagsB; //0x802928F4   ;;35AD0160

extern long billboard1A; //0x802927CC   ;;
extern long billboard1B; //0x802927D0   ;;

extern long billboard2A; //0x802927AC   ;;
extern long billboard2B; //0x802927B0   ;;

extern long billboardpost1A; //0x80292898   ;;
extern long billboardpost1B; //0x8029289C   ;;

extern long billboardpost2A; //0x80292878   ;;
extern long billboardpost2B; //0x8029287C   ;;



extern long fencesA; //0x802928BC   ;;3C180700
extern long fencesB; //0x802928D4   ;;371800E0

extern long bigsignA; //0x802A2AA4   ;;3C0A0601
extern long bigsignB; //0x802A2AA8   ;;254A9330


extern short pathLength; //800DD9D0  - DE5D0
extern long pathOffset; //0x800DC8D0  -  DD4D0
extern long pathOffsetB; //0x800DC780


// these are offsets to POP data inside segment 6.

extern long itemboxesA; //0x8029DBD4   ;;3C040601
extern long itemboxesB; //0x8029DBDC   ;;24849498

extern long treeslistA; //0x8029DBBC   ;;3C040601
extern long treeslistB; //0x8029DBC4   ;;24849570

extern long treesdisplayA; //0x802992C8   ;;3C180600
extern long treesdisplayB; //0x802992E0   ;;27186A68

extern long piranhalistA; //0x8029DBC8   ;;3C040601
extern long piranhalistB; //0x8029DBD0   ;;24849518

extern long piranhadisplayA; //0x80298668   ;;3C0F0600
extern long piranhadisplayB; //0x8029866C   ;;25EF6990


// offsets for course data


extern long sectionviewA; //0x802927FC   ;;3C040900
extern long sectionviewB; //0x80292810   ;;248401F0

extern long surfacemapA; //0x80295E74   ;;3C040601
extern long surfacemapB; //0x80295E7C   ;;24849650
