#include "library/OKAssembly.h"
#include "library/MarioKart.h"

void stockASM(void)
{
	//these functions will swap the ASM routines that load Mario's Raceway.
	//they will point to the custom setup we've implemented for HotSwap courses.
	//this does not swap in the course header table, only the ASM instructions.
	previewReloadA = 0x0C0266BB;
	previewReloadB = 0x0C0266BB;
	previewReloadC = 0x0C0266BB;
	previewReloadD = 0x0C0266BB;
	previewReloadE = 0x0C0267B1;
	previewReloadF = 0x0C0267B1;

	highpolypipeA= 0x3C190700;   //3C190700
	highpolypipeB= 0x373908E8;   //373908E8

	lowpolypipeA= 0x3C0A0700;   //3C0A0700
	lowpolypipeB= 0x354A2D68;   //354A2D68


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
	unknownA2 = 0x27399348; //0x80292810   ;;24849348 -> 24840000

	unknownB = 0x34841140; //0x802927FC   ;;34841140 -> 34840000
	unknownC = 0x348408E8; //0x80292810   ;;348408E8 -> 34840000
	unknownD = 0x34842D68; //0x80295E70   ;;34842D68 -> 34840000

	pathLength = 0x0258;
	pathOffset = 0x060057B0;
	pathOffsetB = 0x06005568;

	g_cup0Array0 = 0x08;
	g_cup0Array1 = 0x09;
	g_cup0Array2 = 0x06;
	g_cup0Array3 = 0x0B;
	g_cup1Array0 = 0x0A;
	g_cup1Array1 = 0x05;
	g_cup1Array2 = 0x01;
	g_cup1Array3 = 0x00;
	g_cup2Array0 = 0x0E;
	g_cup2Array1 = 0x0C;
	g_cup2Array2 = 0x07;
	g_cup2Array3 = 0x02;
	g_cup3Array0 = 0x12;
	g_cup3Array1 = 0x04;
	g_cup3Array2 = 0x03;
	g_cup3Array3 = 0x0D;

}
void customASM(void)
{
	//these functions will swap the ASM routines that load Mario's Raceway.
	//they will point to the custom setup we've implemented for custom courses.
	//this does not swap in the course header table, only the ASM instructions.
	previewReloadA = 0x00000000;
	previewReloadB = 0x00000000;
	previewReloadC = 0x00000000;
	previewReloadD = 0x00000000;
	previewReloadE = 0x00000000;
	previewReloadF = 0x00000000;

	highpolypipeA= 0x3C190700;  //3C190700
	highpolypipeB= 0x37390000;   //373908E8

	lowpolypipeA= 0x3C0A0700;   //3C0A0700
	lowpolypipeB= 0x354A0000;   //354A2D68


	bigmushroomA= 0x3C180700;   //3C180700
	bigmushroomB= 0x37180000;   //37181140

	bigmushroomsurfaceA= 0x3C040700;   //3C040700
	bigmushroomsurfaceB= 0x34840000;   //34841140

	audienceA= 0x3C0F0700;   //3C0F0700
	audienceB= 0x35EF0000;   //35EF14A0

	audienceflagsA= 0x3C0D0700;   //3C0D0700
	audienceflagsB= 0x35AD0000;   //35AD0160

	billboard1A= 0x3C0C0700;   //
	billboard1B= 0x358C0000;   //

	billboard2A= 0x3C0F0700;   //
	billboard2B= 0x35EF0000;   //

	billboardpost1A= 0x3C190700;   //
	billboardpost1B= 0x37390000;   //

	billboardpost2A= 0x3C0E0700;   //
	billboardpost2B= 0x35CE0000;   //

	fencesA= 0x3C180700;   //3C180700
	fencesB= 0x37180000;   //371800E0

	bigsignA= 0x3C0A0600;   //3C0A0601
	bigsignB= 0x254A0000;   //254A9330

	itemboxesA = 0x3C040600; //8029DBD4
	itemboxesB = 0x24841910; //8029DBDC

	treeslistA = 0x3C040600; //8029DBBC
	treeslistB = 0x24841B18; //8029DBC4

	treesdisplayA = 0x3C180600; //802992C8
	treesdisplayB = 0x27182240; //802992E0

	piranhalistA = 0x3C040600; //8029DBC8
	piranhalistB = 0x24841D20; //8029DBD0

	piranhadisplayA = 0x3C0F0600; //80298668
	piranhadisplayB = 0x25EF2168; //8029866C


	sectionviewA = 0x3C040600;   //3C040900
	sectionviewB = 0x248422E0;   //248401F0

	surfacemapA = 0x3C040600;   //3C040601
	surfacemapB = 0x248424F0;  //24849650


	unknownA1 = 0x3C190600; //0x802927FC   ;;3C190601 -> 3C190600
	unknownA2 = 0x27390000; //0x80292810   ;;27399348 -> 27390000

	unknownB = 0x34840000; //0x802927FC   ;;34841140 -> 34840000
	unknownC = 0x34840000; //0x80292810   ;;348408E8 -> 34840000
	unknownD = 0x34840000; //0x80295E70   ;;34842D68 -> 34840000

	pathLength = 0x320;
	pathOffset = 0x06000008;
	pathOffsetB = 0x06000008;

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
