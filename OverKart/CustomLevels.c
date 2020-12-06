#include "library/OKAssembly.h"
#include "library/OKHeader.h"
#include "library/MarioKart.h"
#include "OverKart.h"





void copyCourseTable(int copyMode)
{
	//0 to save 1 to load.
	dataLength = 0x28;
	if (copyMode == 0)
	{
		*sourceAddress = (long)&ok_CourseTable;
		*targetAddress = (long)&g_CupArray;
	}
	else
	{
		*sourceAddress = (long)&g_CupArray;
		*targetAddress = (long)&ok_CourseTable;
	}
	runRAM();
}

void hsTableSet()
{
	g_cup0Array0 = 0;
	g_cup0Array1 = 0;
	g_cup0Array2 = 0;
	g_cup0Array3 = 0;
	g_cup1Array0 = 0;
	g_cup1Array1 = 0;
	g_cup1Array2 = 0;
	g_cup1Array3 = 0;
	g_cup2Array0 = 0;
	g_cup2Array1 = 0;
	g_cup2Array2 = 0;
	g_cup2Array3 = 0;
	g_cup3Array0 = 0;
	g_cup3Array1 = 0;
	g_cup3Array2 = 0;
	g_cup3Array3 = 0;
}






void stockASM(void)
{
	//these functions will swap the ASM routines that load Mario's Raceway.
	//they will point to the custom setup we've implemented for HotSwap courses.
	//this does not swap in the course header table, only the ASM instructions.


	highpolypipeA= 0x3C190700;   //3C190700
	highpolypipeB= 0x373908E8;   //373908E8

	lowpolypipeA= 0x3C0A0700;   //3C0A0700
	lowpolypipeB= 0x354A2D68;   //354A2D68

	uraGrpA = 0x3C0E0700;
	uraGrpB = 0x35CE3050;

	bigmushroomA= 0x3C180700;   //3C180700
	bigmushroomB= 0x37181140;   //37181140

	bigmushroomsurfaceA= 0x3C040700;   //3C040700
	bigmushroomsurfaceB= 0x34841140;   //34841140

	audienceA= 0x3C0F0700;   //3C0F0700
	audienceB= 0x35EF14A0;   //35EF14A0

	audienceflagsA= 0x3C0D0700;   //3C0D0700
	audienceflagsB= 0x35AD0160;   //35AD0160

	billboard1A= 0x3C0C0700;   //3C0C0700
	billboard1B= 0x358C3240;   //358C3240

	billboard2A= 0x3C0F0700;   //3C0E0700
	billboard2B= 0x35EF3508;   //35CE0450

	billboardpost1A= 0x3C190700;   //3C190700
	billboardpost1B= 0x37390240;   //37390240

	billboardpost2A= 0x3C0E0700;   //3C190700
	billboardpost2B= 0x35CE0450;   //37390240

	fencesA= 0x3C180700;   //3C180700
	fencesB= 0x371800E0;   //371800E0

	bigsignA= 0x3C0A0601;   //3C0A0601
	bigsignB= 0x254A9330;   //254A9330

	itemboxesA = 0x3C040601; //8029DBD4
	itemboxesB = 0x24849498; //8029DBDC

	treeslistA = 0x3C040601; //8029DBBC
	treeslistB = 0x24849570; //8029DBC4

	treesdisplayA = 0x3C180600; //802992C8
	treesdisplayB = 0x27186A68; //802992E0

	piranhalistA = 0x3C040601; //8029DBC8
	piranhalistB = 0x24849518; //8029DBD0

	piranhadisplayA = 0x3C0F0600; //80298668
	piranhadisplayB = 0x25EF6990; //8029866C

	sectionviewA = 0x3C040900;   //3C040900
	sectionviewB = 0x248401F0;   //248401F0

	surfacemapA = 0x3C040601;   //3C040601
	surfacemapB = 0x24849650;   //24849650

	unknownA1 = 0x3C190601; //0x802927FC   ;;3C190601 -> 3C190600
	unknownB1 = 0x3C040700; //0x802927FC   ;;3C190601 -> 3C190600
	unknownC1 = 0x3C040700; //0x802927FC   ;;3C190601 -> 3C190600
	unknownD1 = 0x3C040700; //0x802927FC   ;;3C190601 -> 3C190600

	unknownA2 = 0x27399348; //0x80292810   ;;24849348 -> 24840000

	unknownB = 0x34841140; //0x802927FC   ;;34841140 -> 34840000
	unknownC = 0x348408E8; //0x80292810   ;;348408E8 -> 34840000
	unknownD = 0x34842D68; //0x80295E70   ;;34842D68 -> 34840000

	g_pathLength = 0x0258;
	pathOffset = 0x060057B0;
	pathOffsetB = 0x06005568;

	g_mapStartToggle = 0x0C0132B4;

	copyCourseTable(0);
}
void customASM(void)
{
	//these functions will swap the ASM routines that load Mario's Raceway.
	//they will point to the custom setup we've implemented for custom courses.
	//this does not swap in the course header table, only the ASM instructions.

	highpolypipeA= 0x3C190600;  //3C190700
	highpolypipeB= 0x37390000;   //373908E8

	lowpolypipeA= 0x3C0A0600;   //3C0A0700
	lowpolypipeB= 0x354A0000;   //354A2D68

	uraGrpA = 0x3C0E0600;
	uraGrpB = 0x35CE0000;


	bigmushroomA= 0x3C180600;   //3C180700
	bigmushroomB= 0x37180000;   //37181140

	bigmushroomsurfaceA= 0x3C040600;   //3C040700
	bigmushroomsurfaceB= 0x34840000;   //34841140

	audienceA= 0x3C0F0600;   //3C0F0700
	audienceB= 0x35EF0000;   //35EF14A0

	audienceflagsA= 0x3C0D0600;   //3C0D0700
	audienceflagsB= 0x35AD0000;   //35AD0160

	billboard1A= 0x3C0C0600;   //
	billboard1B= 0x358C0000;   //

	billboard2A= 0x3C0F0600;   //
	billboard2B= 0x35EF0000;   //

	billboardpost1A= 0x3C190600;   //
	billboardpost1B= 0x37390000;   //

	billboardpost2A= 0x3C0E0600;   //
	billboardpost2B= 0x35CE0000;   //

	fencesA= 0x3C180600;   //3C180700
	fencesB= 0x37180000;   //371800E0

	bigsignA= 0x3C0A0600;   //3C0A0601
	bigsignB= 0x254A0000;   //254A9330

	itemboxesA = 0x3C040600; //8029DBD4
	itemboxesB = 0x24841910; //8029DBDC

	treeslistA = 0x3C040600; //8029DBBC
	treeslistB = 0x24841B18; //8029DBC4

	treesdisplayA = 0x3C180600; //802992C8
	treesdisplayB = 0x27182288; //802992E0

	piranhalistA = 0x3C040600; //8029DBC8
	piranhalistB = 0x24841D20; //8029DBD0

	piranhadisplayA = 0x3C0F0600; //80298668
	piranhadisplayB = 0x25EF21B0; //8029866C


	sectionviewA = 0x3C040600;   //3C040900
	sectionviewB = 0x24842328;   //248401F0

	surfacemapA = 0x3C040600;   //3C040601
	surfacemapB = 0x24842538;  //24849650


	unknownA1 = 0x3C190600; //0x802927FC   ;;3C190601 -> 3C190600
	unknownB1 = 0x3C040600; //0x802927FC   ;;3C190601 -> 3C190600
	unknownC1 = 0x3C040600; //0x802927FC   ;;3C190601 -> 3C190600
	unknownD1 = 0x3C040600; //0x802927FC   ;;3C190601 -> 3C190600

	unknownA2 = 0x27390000; //0x80292810   ;;27399348 -> 27390000

	unknownB = 0x34840000; //0x802927FC   ;;34841140 -> 34840000
	unknownC = 0x34840000; //0x80292810   ;;348408E8 -> 34840000
	unknownD = 0x34840000; //0x80295E70   ;;34842D68 -> 34840000

	g_pathLength = 0x320;
	pathOffset = 0x06000008;
	pathOffsetB = 0x06000008;


	g_mapStartToggle = 0x00000000;

	ok_RedCoinList = 0x06001F28;



	copyCourseTable(1);
	g_cup0Array0 = 0;
	g_cup0Array1 = 1;
	g_cup0Array2 = 2;
	g_cup0Array3 = 3;
	g_cup1Array0 = 4;
	g_cup1Array1 = 5;
	g_cup1Array2 = 6;
	g_cup1Array3 = 7;
	g_cup2Array0 = 8;
	g_cup2Array1 = 9;
	g_cup2Array2 = 10;
	g_cup2Array3 = 11;
	g_cup3Array0 = 12;
	g_cup3Array1 = 13;
	g_cup3Array2 = 14;
	g_cup3Array3 = 15;

}


void setSong()
{
	songID = (short)*(long*)(&ok_CourseHeader + 0x16);
}
void setTempo(void)
{

	if ((hsID > 0) & (renderMode[4] == 0x00))
	{

		int tempoValues = *(long*)(&ok_CourseHeader + 0x15);
		int tempoSpeed = 0;
		dataLength = 0xC;
		switch(g_playerCount)
		{
			case 1:
			asm_tempo1A = 0x240F0000;
			asm_tempo1B = 0x240F0000;
			tempoSpeed = tempoValues >> 24;
			asm_tempo1ASpeed = (short)tempoSpeed;
			asm_tempo1BSpeed = (short)tempoSpeed;
			break;
			case 2:
			asm_tempo2A = 0x24090000;
			asm_tempo2B = 0x24090000;
			tempoSpeed = (tempoValues >> 16) & (0x00FF);
			asm_tempo2ASpeed = (short)tempoSpeed;
			asm_tempo2BSpeed = (short)tempoSpeed;
			break;
			case 3:
			asm_tempo3A = 0x240A0000;
			asm_tempo3B = 0x240A0000;
			tempoSpeed = (tempoValues >> 8) & (0x00FF);
			asm_tempo3ASpeed = (short)tempoSpeed;
			asm_tempo3BSpeed = (short)tempoSpeed;
			break;
			case 4:
			asm_tempo3A = 0x240A0000;
			asm_tempo3B = 0x240A0000;
			tempoSpeed = tempoValues & 0x00FF;
			asm_tempo3ASpeed = (short)tempoSpeed;
			asm_tempo3BSpeed = (short)tempoSpeed;
			break;
		}
	}
	else
	{
		asm_tempo1A = 0x3C0F8015;
		asm_tempo1B = 0x8DEF0114;

		asm_tempo2A = 0x3C098015;
		asm_tempo2B = 0x8D290114;

		asm_tempo3A = 0x3C0A8015;
		asm_tempo3B = 0x8D4A0114;
	}


}
void setASM(void)
{
	if (hsID == 0)
	{
		asmBool = 0x00;
	}
	else
	{
		*sourceAddress = *(long*)(&ok_CourseHeader + 0x10);
		if (*sourceAddress == 0x00000000)
		{
			asmBool = 0x00;
		}
		else
		{
			asmBool = 0x01;
			dataLength = (*(long*)(&ok_CourseHeader + 0x11)) - *sourceAddress;
			*targetAddress = 0x80500000;
			runDMA();
		}
	}

}

void setPath()
{

	if (hsID > 0)
	{
		g_pathLength =(short)(*(long*)(&ok_CourseHeader + 0x18) & 0xFFFF0000);

	}
	else
	{
		g_pathLength = 0x0258;
	}
}

void setWater()
{

	if (hsID > 0)
	{
		g_waterHeight = *(float*)(&ok_CourseHeader + 0x18);
	}
}

void setEcho()
{
	if (hsID > 0)
	{
		int echoValues = *(long*)(&ok_CourseHeader + 0x14);
		echoStart = (echoValues >> 16) & (0xFFFF);
		echoStop = echoValues & 0xFFFF;
	}
	else
	{
		echoStart = 0x19B;
		echoStop = 0x1B9;
	}


}
void setSky()
{

	if (hsID > 0)
	{

		*targetAddress = (long)&g_skyColorTop;
		*sourceAddress = *(long*)(&ok_CourseHeader + 0xD);
		dataLength = 0xC;
		runDMA();
		*targetAddress = (long)&g_skyColorBot;
		*sourceAddress = *sourceAddress + 0xC;
		runDMA();
	}
	else
	{
		*targetAddress = (long)&g_skyColorTop;
		*sourceAddress = 0x1220E0;
		dataLength = 0x0C;
		runDMA();
		*targetAddress = (long)&g_skyColorBot;
		*sourceAddress = 0x1221DC;
		runDMA();
	}

}




void loadHeaderOffsets()
{
	*targetAddress = (long)&ok_HeaderOffsets;
	*sourceAddress = 0xBE9178;
	dataLength = 0x3C00;
	runDMA();
}


void loadHotSwap(int gpOffset)
{

	//version 4
	if (hsID > 0)
	{

		//version 4
		//first load the entire OverKart header into expansion RAM
		*targetAddress = (long)&ok_CourseHeader;
		*sourceAddress = *(long*)(&ok_HeaderOffsets + ((courseValue + gpOffset) * 1) + ((hsID-1) * 0x14));
		dataLength = 0x64;
		if (*sourceAddress != 0xFFFFFFFF)
		{
			runDMA();

			//load the standard course loadHeaderOffsets
			*targetAddress = 0x802B8D80;
			*sourceAddress = (long)(&ok_CourseHeader + 1);
			dataLength = 0x30;
			runRAM();
		}


		courseSwapped = 1;

	}
	else
	{
		*sourceAddress = 0x122390;
		*targetAddress = 0x802B8D80;
		dataLength = 0x30;
		runDMA();
		courseSwapped = 1;
		asmBool = 0;
	}

	setSky();

	setTempo();

	//setASM();
	setEcho();
	//setPath();
	setSong();
	setWater();

}

void setLabel(void)
{
	*targetAddress = (long)&g_bannerTexture;

	switch (hsID)
	{
		case 0:
		{
			*sourceAddress = (long)&set0;
			break;
		}
		case 1:
		{
			*sourceAddress = (long)&set1;
			break;
		}
		case 2:
		{
			*sourceAddress = (long)&set2;
			break;
		}
		case 3:
		{
			*sourceAddress = (long)&set3;
			break;
		}
		case 4:
		{
			*sourceAddress = (long)&set4;
			break;
		}
	}
	decodeMIO0(*sourceAddress, *targetAddress);
}


void setBanners()
{

	//1F40

	//2F80
	if (hsID > 0)
	{
		for(int currentCourse = 0; currentCourse < 16; currentCourse++)
		{


			*sourceAddress = *(long*)(&ok_MenuOffsets + (currentCourse * 2) + ((hsID-1) * 0x28));
			if ((*sourceAddress != 0x00000000) && (*sourceAddress != 0xFFFFFFFF))
			{
				*targetAddress = (long)&ok_FreeSpace;
				dataLength = (*(long*)(&ok_MenuOffsets + (currentCourse * 2) + ((hsID-1) * 0x28) + 1) - *sourceAddress);
				runDMA();
				*sourceAddress = (long)&ok_FreeSpace;

			}
			if (*sourceAddress == 0x00000000)
			{
				*sourceAddress = (long)&bannerU;
			}
			if (*sourceAddress == 0xFFFFFFFF)
			{
				*sourceAddress = (long)&bannerN;
			}

			*targetAddress = (long)(&g_CourseBannerOffsets + (currentCourse * 0x4F0));
			runMIO();

		}
	}
	else
	{
		/*
		7FEFC0
		7FF3C0
		7fe6c0
		7ffcc0

		7ff7c0
		7fe1c0
		7fcdc0
		7fc8c0

		8008c0
		8000c0
		7febc0
		7fd2c0

		8018c0
		7fddc0
		7fd7c0
		8004c0
		*/
		dataLength = 0x1000;
		int currentOffset = (long)&g_CourseBannerOffsets;

		*targetAddress = (long)&ok_FreeSpace;
		*sourceAddress = 0x7FEFC0;
		runDMA();
		*targetAddress =  currentOffset;
		*sourceAddress = (long)&ok_FreeSpace;
		runTKM();
		currentOffset= currentOffset + 0x13C0;

		*targetAddress = (long)&ok_FreeSpace;
		*sourceAddress = 0x7FF3C0;
		runDMA();
		*targetAddress =  currentOffset;
		*sourceAddress = (long)&ok_FreeSpace;
		runTKM();
		currentOffset= currentOffset + 0x13C0;

		*targetAddress = (long)&ok_FreeSpace;
		*sourceAddress = 0x7fe6c0;
		runDMA();
		*targetAddress =  currentOffset;
		*sourceAddress = (long)&ok_FreeSpace;
		runTKM();
		currentOffset= currentOffset + 0x13C0;

		*targetAddress = (long)&ok_FreeSpace;
		*sourceAddress = 0x7ffcc0;
		runDMA();
		*targetAddress =  currentOffset;
		*sourceAddress = (long)&ok_FreeSpace;
		runTKM();
		currentOffset= currentOffset + 0x13C0;
		//
		//
		*targetAddress = (long)&ok_FreeSpace;
		*sourceAddress = 0x7ff7c0;
		runDMA();
		*targetAddress =  currentOffset;
		*sourceAddress = (long)&ok_FreeSpace;
		runTKM();
		currentOffset= currentOffset + 0x13C0;

		*targetAddress = (long)&ok_FreeSpace;
		*sourceAddress = 0x7fe1c0;
		runDMA();
		*targetAddress =  currentOffset;
		*sourceAddress = (long)&ok_FreeSpace;
		runTKM();
		currentOffset= currentOffset + 0x13C0;

		*targetAddress = (long)&ok_FreeSpace;
		*sourceAddress = 0x7fcdc0;
		runDMA();
		*targetAddress =  currentOffset;
		*sourceAddress = (long)&ok_FreeSpace;
		runTKM();
		currentOffset= currentOffset + 0x13C0;

		*targetAddress = (long)&ok_FreeSpace;
		*sourceAddress = 0x7fc8c0;
		runDMA();
		*targetAddress =  currentOffset;
		*sourceAddress = (long)&ok_FreeSpace;
		runTKM();
		currentOffset= currentOffset + 0x13C0;
		//
		//
		*targetAddress = (long)&ok_FreeSpace;
		*sourceAddress = 0x8008c0;
		runDMA();
		*targetAddress =  currentOffset;
		*sourceAddress = (long)&ok_FreeSpace;
		runTKM();
		currentOffset= currentOffset + 0x13C0;

		*targetAddress = (long)&ok_FreeSpace;
		*sourceAddress = 0x8000c0;
		runDMA();
		*targetAddress =  currentOffset;
		*sourceAddress = (long)&ok_FreeSpace;
		runTKM();
		currentOffset= currentOffset + 0x13C0;

		*targetAddress = (long)&ok_FreeSpace;
		*sourceAddress = 0x7febc0;
		runDMA();
		*targetAddress =  currentOffset;
		*sourceAddress = (long)&ok_FreeSpace;
		runTKM();
		currentOffset= currentOffset + 0x13C0;

		*targetAddress = (long)&ok_FreeSpace;
		*sourceAddress = 0x7fd2c0;
		runDMA();
		*targetAddress =  currentOffset;
		*sourceAddress = (long)&ok_FreeSpace;
		runTKM();
		currentOffset= currentOffset + 0x13C0;
		//
		//
		*targetAddress = (long)&ok_FreeSpace;
		*sourceAddress = 0x8018c0;
		runDMA();
		*targetAddress =  currentOffset;
		*sourceAddress = (long)&ok_FreeSpace;
		runTKM();
		currentOffset= currentOffset + 0x13C0;

		*targetAddress = (long)&ok_FreeSpace;
		*sourceAddress = 0x7fddc0;
		runDMA();
		*targetAddress =  currentOffset;
		*sourceAddress = (long)&ok_FreeSpace;
		runTKM();
		currentOffset= currentOffset + 0x13C0;

		*targetAddress = (long)&ok_FreeSpace;
		*sourceAddress = 0x7fd7c0;
		runDMA();
		*targetAddress =  currentOffset;
		*sourceAddress = (long)&ok_FreeSpace;
		runTKM();
		currentOffset= currentOffset + 0x13C0;

		*targetAddress = (long)&ok_FreeSpace;
		*sourceAddress = 0x8004c0;
		runDMA();
		*targetAddress =  currentOffset;
		*sourceAddress = (long)&ok_FreeSpace;
		runTKM();
		currentOffset= currentOffset + 0x13C0;
		//
		//


	}

}



void setPreviews()
{

	//1F40

	//2F80
	if (hsID > 0)
	{
		for(int currentCourse = 0; currentCourse < 16; currentCourse++)
		{
			*sourceAddress = *(long*)(&ok_MenuOffsets + (currentCourse * 2) + ((hsID-1) * 0x28) + 1);

			if (*sourceAddress == 0x00000000)
			{
				*sourceAddress = (long)&previewU;
			}

			if (*sourceAddress == 0xFFFFFFFF)
			{
				*sourceAddress = (long)&previewN;
			}

			*sourceAddress += 0x98D65D0;

			*(long*)(&g_CoursePreviewOffsets + 1 + (0xA * currentCourse)) = *sourceAddress;

		}
	}
	else
	{

		*targetAddress = (long)&g_CoursePreviewOffsets;
		*sourceAddress = (long)&r_CoursePreviewOffsets;
		dataLength = 0x320;
		runDMA();

	}

}


void swapHS(int direction)
{
	if (direction == 0)
	{
		if  (hsID > 0)
		{
			if (hsID == 1)
			{
				stockASM();
			}
			hsID = hsID - 1;
		}
	}
	else
	{
		if  (hsID < 4)
		{
			if (hsID == 0)
			{
				customASM();
			}
			hsID = hsID + 1;
		}
	}
	setLabel();


	setPreviews();
	setBanners();
	playSound(0x4900801A);
}


void loadMinimap()
{
	*sourceAddress = *(long*)(&ok_CourseHeader + 0x12);

	if (*sourceAddress != 0x00000000)
	{
		*targetAddress = (long)&ok_FreeSpace;
		dataLength = 0x1000;
		runDMA();
		//
		g_mapX = (short)(*(long*)(&ok_FreeSpace) >> 16 & 0x0000FFFF);
		g_mapY = (short)(*(long*)(&ok_FreeSpace) & 0x0000FFFF);
		g_startX = (short)(*(long*)(&ok_FreeSpace + 0x1) >> 16 & 0x0000FFFF);
		g_startY = (short)(*(long*)(&ok_FreeSpace + 0x1) & 0x0000FFFF);
		g_mapHeight = (short)(*(long*)(&ok_FreeSpace + 0x2) >> 16 & 0x0000FFFF);
		g_mapWidth = (short)(*(long*)(&ok_FreeSpace + 0x2) & 0x0000FFFF);
		g_mapR = (short)(*(long*)(&ok_FreeSpace + 0x3) >> 16 & 0x0000FFFF);
		g_mapG = (short)(*(long*)(&ok_FreeSpace + 0x3) & 0x0000FFFF);
		g_mapB = (short)(*(long*)(&ok_FreeSpace + 0x4) >> 16 & 0x0000FFFF);
		g_mapScale = (*(float*)(&ok_FreeSpace + 0x5) / 100);


		*sourceAddress = (long)(&ok_FreeSpace + 0x6);
		*targetAddress = (long)&ok_MapTextureData;
		runMIO();
		g_mapTexture = (long)&ok_MapTextureData;

	}

}
