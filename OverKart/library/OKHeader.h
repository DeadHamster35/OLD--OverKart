// These are new custom RAM values
// 0x80400000 - 0x804FFFFF is restricted for OverKart64 functions and data.
// 0x80500000 - 0x805FFFFF is reserved for Custom Course Assembly and data.
// 0X80600000 - 0X80780000 should be safe for any other custom code.
// The end of RAM is course data, from 0x80800000 backwards.
// This varies based on the size of data for the current course. Be cautious!

extern long ok_ItemChance1;
extern long ok_ItemChance2;
extern long ok_ItemChance3;
extern long ok_ItemChance4;
extern long ok_ItemChance5;
extern long ok_ItemChance6;
extern long ok_ItemChance7;
extern long ok_ItemChance8;

extern long ok_NameOffset;
extern long ok_NameEnd;
extern long ok_GhostOffset;
extern long ok_GhostEnd;

extern char ok_Song;
extern char ok_SpeedA;
extern char ok_SpeedB;
extern char ok_SpeedC;

extern long ok_MapOffset;
extern long ok_MapEnd;
extern long ok_CoordOffset;
extern long ok_CoordEnd;
extern long ok_SkyOffset;
extern long ok_SkyEnd;
extern long ok_ASMOffset;
extern long ok_ASMEnd;

extern long ok_dmaTarget;
extern long ok_dmaSource;
extern long ok_mioTarget;
extern long ok_mioSource;

extern long ok_previewOffset;
extern long ok_previewTemp;




extern void ok_ASMJump(); //
