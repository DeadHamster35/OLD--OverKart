extern long SYSTEM_Region;

extern void decodeMIO0(const long input, long output);
extern void DMA(long output, const long input, long Length);
extern void decodeTKMK(int input, int output);
extern void loadCourse(int courseID);
extern void ramCopy(int output, int input, int Length);

extern void printNumber(int *xPosition, int *yPosition, int num, int base);
extern void printString(int xPosition, int yPosition, const char *printText);
extern void printStringNumber(int xPosition, int yPosition, const char *printText, int printValue);
extern unsigned long* drawBox(unsigned long *buf, int x1, int y1, int x2, int y2, int r, int g, int b, int a);
extern unsigned long* boxOffset;

extern void initializePlayer(int playerStructure, int characterID, float deltaX, float deltaZ, int characterID2, int unknown0xB000);

extern long asm_itemJump1A;// 0x8007B084  //3C058016
extern long asm_itemJump1B;// 0x8007B098  //84A543BA

extern long asm_itemJump2A;// 0x8007AFC0  //3C058016
extern long asm_itemJump2B;// 0x8007AFD4  //84A543BA

extern void playSound(int soundID);

extern void colorFont(int color);
extern void loadFont();

extern long g_SegmentA;
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

extern long g_resetToggle; //
extern long g_startingIndicator;
extern long g_screenSplitA;
extern long g_ScreenSplitB;
extern long g_playerCount; //
extern long g_gameType;
extern long g_raceClass;
extern float g_gameTimer;
extern short g_courseID;
extern short g_loadedcourseFlag;
extern long g_gameMode; //0 = gp 1 = time trials 2 = vs 3 =battle
extern short g_mirrorMode;

extern long antialiasToggle;
extern long antialiasToggleB;



extern short g_cup0Array0;
extern short g_cup0Array1;
extern short g_cup0Array2;
extern short g_cup0Array3;
extern short g_cup1Array0;
extern short g_cup1Array1;
extern short g_cup1Array2;
extern short g_cup1Array3;
extern short g_cup2Array0;
extern short g_cup2Array1;
extern short g_cup2Array2;
extern short g_cup2Array3;
extern short g_cup3Array0;
extern short g_cup3Array1;
extern short g_cup3Array2;
extern short g_cup3Array3;
extern short g_cupBArray0;
extern short g_cupBArray1;
extern short g_cupBArray2;
extern short g_cupBArray3;

extern long g_bannerTexture;
extern long g_previewTexture;
extern long g_DEBUG;

extern long g_cup0preview0; // 0x80199540
extern long g_cup0preview1; // 0x80199568
extern long g_cup0preview2; // 0x801994F0
extern long g_cup0preview3; // 0x801995B8


extern long g_cup1preview0; // 0x80199590
extern long g_cup1preview1; // 0x801994C8
extern long g_cup1preview2; // 0x80199428
extern long g_cup1preview3; // 0x80199400


extern long g_cup2preview0; // 0x80199630
extern long g_cup2preview1; // 0x801995E0
extern long g_cup2preview2; // 0x80199518
extern long g_cup2preview3; // 0x80199450


extern long g_cup3preview0; // 0x801996D0
extern long g_cup3preview1; // 0x801994A0
extern long g_cup3preview2; // 0x80199478
extern long g_cup3preview3; // 0x80199608


extern char g_lakituStatus; // 0x80165DCE
extern short g_lakituSurface; // 0x80163316



extern char p_Input; //
extern short d_Input; //
extern char c_Input;

extern float g_playerLocation1X;
extern float g_playerLocation1Y;
extern float g_playerLocation1Z;
extern long g_playerLocation1A;
extern float g_player1SpeedX;
extern float g_player1SpeedY;
extern float g_player1SpeedZ;
extern float g_player1SpeedA;
extern float g_player1SpeedU1;
extern float g_player1SpeedU2;

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

extern float g_aspectRatio;
extern float g_farClip;

extern float g_raceTime;
extern float g_lap2Time;
extern float g_lap3Time;

extern short g_progressValue;

extern long g_playerPosition1;// 801643B8
extern long g_playerPosition2;//, 801643BC
extern long g_playerPosition3;//, 801643C0
extern long g_playerPosition4;//, 801643C4
extern long g_playerPosition5;//, 801643C8
extern long g_playerPosition6;//, 801643CC
extern long g_playerPosition7;//, 801643D0
extern long g_playerPosition8;//, 801643D4

extern float gravity_1;
extern float gravity_2;
extern float gravity_3;
extern float gravity_4;
extern float gravity_5;
extern float gravity_6;
extern float gravity_7;
extern float gravity_8;

extern short surface_p0;

extern long g_gameLapPlayer1;    // 0x8  0164390
extern long g_gameLapPlayer2;    // 0x8  0164394
extern long g_gameLapPlayer3;    // 0x8  0164398
extern long g_gameLapPlayer4;    // 0x8  016439C
extern long g_gameLapPlayer5;    // 0x8  01643A0
extern long g_gameLapPlayer6;    // 0x8  01643A4
extern long g_gameLapPlayer7;    // 0x8  01643A8
extern long g_gameLapPlayer8;    // 0x8  01643AC


extern char itemBoolean; //0x80165F5F
extern char itemA;
extern char itemB;
extern char itemC;

extern char g_lapCheckA; //
extern char g_lapCheckB; //

extern long g_mlogoY;// 0x8018D9F0
extern long g_mflagID;// 0x8018DA30
extern long g_mpressstartID;// 0x8018DA58
extern long g_mracewayTime;// 0x8018DA80

extern char backButton;  //
extern char menuScreenA; //
extern char menuScreenB; //
extern char menuScreenC; //

extern long titleDemo; //

extern char g_cupSelect; //8018EE09
extern char g_courseSelect; //8018EE0B
extern char inGame; //0x8018EDFC

extern short asm_CupCount;
extern char songID; //
extern long asm_SongA;// 0x8028EC9C
extern long asm_SongB;// 0x8028F9C4

extern long g_skyColorTop;

extern char player2OK; //
extern char player3OK; //
extern char player4OK; //
