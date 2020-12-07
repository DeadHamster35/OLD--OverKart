#include <sys/types.h>
#include <math.h>
// These are new custom RAM values
// 0x80400000 - 0x804FFFFF is restricted for OverKart64 functions and data.
// 0x80500000 - 0x805FFFFF is reserved for Custom Course Assembly and data.
// 0X80600000 - 0X80780000 should be safe for any other custom code.
// The end of RAM is course data, from 0x80800000 backwards.
// This varies based on the size of data for the current course. Be cautious!


#define RedCoin_RSP 0x08001028;

extern long ok_HeaderOffsets; //0x80450000
extern long ok_MenuOffsets; //0x80451400
extern uint ok_CourseHeader; //0x80453C00

extern long ok_HeaderROM; //0xBE9178

extern long ok_Target; //0x80454D04
extern long ok_Source; //0x80454D08
extern long ok_Pointer; //0x80454D0C
extern short ok_TKMChar; //0x80454D10
extern long ok_Credits;


extern long ok_ItemChance1; //0x80454D24
extern long ok_ItemChance2; //0x80454D28
extern long ok_ItemChance3; //0x80454D2C
extern long ok_ItemChance4; //0x80454D30
extern long ok_ItemChance5; //0x80454D34
extern long ok_ItemChance6; //0x80454D38
extern long ok_ItemChance7; //0x80454D3C
extern long ok_ItemChance8; //0x80454D40


extern long ok_CourseTable; //0x80454D50  //0x28 bytes

extern long ok_FreePointer;
extern long ok_RedCoinList;
//0x80454D78
extern long ok_MapTextureData; //0x80455000 //

extern long ok_FreeSpace; //0x80453D00; //0x1000 bytes free RAM for temp storage.
extern long ok_Logo;
extern long ok_RedCoin;
extern long ok_RedCoinSprite;

extern void ok_ASMJump(); //






//


extern long bannerN;
extern long bannerU;
extern long previewN;
extern long previewU;
extern long set0;
extern long set1;
extern long set2;
extern long set3;
extern long set4;
extern long LogoROM;
extern long CoinROM;
extern long RCSpriteROM;

extern long DisplayHopTable;
extern long CollisionJumpTable;
extern long AddObjectTable;
