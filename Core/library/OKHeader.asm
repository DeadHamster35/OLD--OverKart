;;These are new custom RAM values
;;0x80400000 - 0x804FFFFF is restricted for OverKart64 functions and data.
;;0x80500000 - 0x805FFFFF is reserved for Custom Course Assembly and data.
;;0X80600000 - 0X80780000 should be safe for any other custom code.
;;The end of RAM is course data, from 0x80800000 backwards.
;;This varies based on the size of data for the current course. Be cautious!




// 80420000 - 80450000 for save states

.definelabel ok_HeaderOffsets, 0x80450000
.definelabel ok_MenuOffsets, 0x80451400
.definelabel ok_CourseHeader, 0x80453C00

.definelabel ok_HeaderROM, 0xBE9178



//80403344 courseValue;


.definelabel ok_ItemChance1, 0x80454D24
.definelabel ok_ItemChance2, 0x80454D28
.definelabel ok_ItemChance3, 0x80454D2C
.definelabel ok_ItemChance4, 0x80454D30
.definelabel ok_ItemChance5, 0x80454D34
.definelabel ok_ItemChance6, 0x80454D38
.definelabel ok_ItemChance7, 0x80454D3C
.definelabel ok_ItemChance8, 0x80454D40


.definelabel ok_CourseTable, 0x80454D50  //0x28 bytes
//0x80454D78
.definelabel ok_FreePointer, 0x80454D78  //set value after loading data.
.definelabel ok_RedCoinList, 0x80454D7C
.definelabel ok_Credits, 0x80455F00
.definelabel ok_MapTextureData, 0x80456000 // up to 0x3000 bytes
.definelabel ok_FreeSpace, 0x80458000; //free RAM for temp storage.
.definelabel ok_Logo, 0x80462000;  //logo for intro, can be overwritten after.
.definelabel ok_RedCoin, 0x80462000; // overwrites logo after. 0x1058 length
.definelabel ok_RedCoinSprite, 0x8046305C;


.definelabel ok_ASMJump, 0x80490000
