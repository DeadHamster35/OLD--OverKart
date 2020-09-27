// These are new custom RAM values
// 0x80400000 - 0x804FFFFF is restricted for OverKart64 functions and data.
// 0x80500000 - 0x805FFFFF is reserved for Custom Course Assembly and data.
// 0X80600000 - 0X80780000 should be safe for any other custom code.
// The end of RAM is course data, from 0x80800000 backwards.
// This varies based on the size of data for the current course. Be cautious!

extern long nameOffset;
extern long nameEnd;
extern long ghostOffset;
extern long ghostEnd;

extern char okSong;
extern char speedA;
extern char speedB;
extern char speedC;

extern long mapOffset;
extern long mapEnd;
extern long coordOffset;
extern long coordEnd;
extern long skyOffset;
extern long skyEnd;
extern long asmOffset;
extern long asmEnd;

extern long dmaLength; //
extern long dmaTarget; //
extern long dmaSource; //
extern long mioTarget; //
extern long mioSource; //

extern char buttonPressed; //

extern char parameterFlag;
extern char cpuFlag;
extern char practiceFlag;
extern char fastFlag;
extern char widescreenFlag;
extern char statsFlag;
extern char menuFlag;
extern char aliasFlag;
extern char arduinoFlag;
extern char mirrorFlag;

extern char hsID;


extern char splitBool;
extern long splitStart;
extern long splitEnd;
extern float splitTimer;

extern char savestateSplit;
extern float savestateTimeA;
extern float savestateTimeB;
extern float savestateTimeC;
extern long savestateLapA;
extern char savestateLapB;
extern char savestateLapC;
extern float saveTimer;

extern float planeYP1;
extern float planeYP2;
extern float planeYP3;
extern float planeYP4;

extern void asmJump(); //
