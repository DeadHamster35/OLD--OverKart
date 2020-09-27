.definelabel decodeMIO0, 0x800400D0 ;MIO0 File A0 = input, A1 = output
.definelabel DMA, 0x80001158
.definelabel decodeTKMK, 0x800405D0
.definelabel loadCourse, 0x802AA918
.definelabel ramCopy, 0x800D7FE0

.definelabel printString, 0x800577A4
.definelabel drawBox, 0x80098DF8
.definelabel boxOffset, 0x80150298

.definelabel initializePlayer, 0x800393C0

.definelabel playSound, 0x800C8E10

.definelabel colorFont, 0x800930D8
.definelabel loadFont, 0x80057710

.definelabel readControllers, 0x80000A28
.definelabel InitControllers, 0x800008A4

;;
;;

.definelabel nopASM, 0x80002714
.definelabel tempo1A, 0x800015C4  ;;3C0F8015
.definelabel tempo1AS, 0x800015C7  ;;speed value
.definelabel tempo1B, 0x800015C8  ;;8DEF0114
.definelabel tempo1BS, 0x800015CB  ;; speed value

.definelabel tempo2A, 0x80001A38  ;;3C098015
.definelabel tempo2AS, 0x80001A3B  ;;speed value
.definelabel tempo2B, 0x80001A3C  ;;8D290114
.definelabel tempo2BS, 0x80001A3F  ;; speed value

.definelabel tempo3A, 0x80001C90  ;;3C0A8015
.definelabel tempo3AS, 0x80001C93  ;;speed value
.definelabel tempo3B, 0x80001C94  ;;8D4A0114
.definelabel tempo3BS, 0x80001C97  ;; speed value

.definelabel asm_selectA, 0x800B3924
.definelabel asm_selectB, 0x800B3936
.definelabel asm_selectC, 0x800B39A4
.definelabel asm_selectD, 0x800B39B6
.definelabel asm_selectE, 0x800B3A38
.definelabel asm_selectF, 0x800B3A4E

.definelabel g_resetToggle, 0x800DC50F
.definelabel g_startingIndicator,  0x800DC513
.definelabel g_playerCount, 0x800DC53B
.definelabel g_gameType, 0x800DC53F
.definelabel g_ccSelection, 0x800DC54B
.definelabel g_gameTimer, 0x800DC598
.definelabel g_CourseID,  0x800DC5A1
.definelabel g_loadedcourseFlag, 0x800DC5A5
.definelabel g_gameMode, 0x800DC53F
.definelabel g_mirrorMode, 0x800DC604



.definelabel gravity_1, 0x800E2650
.definelabel gravity_2, 0x800E2654
.definelabel gravity_3, 0x800E2658
.definelabel gravity_4, 0x800E265C
.definelabel gravity_5, 0x800E2660
.definelabel gravity_6, 0x800E2664
.definelabel gravity_7, 0x800E2668
.definelabel gravity_8, 0x800E266C

.definelabel antialiasToggle, 0x800EB3DC
.definelabel antialiasToggleB, 0x800EB40C




.definelabel player1inputX, 0x800F6910
.definelabel player1inputY, 0x800F6912
.definelabel p1Button, 0x800F6914


.definelabel p_Input, 0x800F6915
.definelabel d_Input, 0x800F6914
.definelabel c_Input, 0x800F691A

.definelabel player1X, 0x800F69A4
.definelabel player1Y, 0x800F69A8
.definelabel player1Z, 0x800F69AC
.definelabel player1ROT, 0x800F69BC
.definelabel player1SpeedA, 0x800F69C4
.definelabel player1SpeedB, 0x800F69CC
.definelabel player1SpeedC, 0x800F6A24
.definelabel player1SpeedD, 0x800F6A28
.definelabel player1SpeedE, 0x800F6A2C


.definelabel surface_p0, 0x800F6A4E

.definelabel player2X, 0x800F777C
.definelabel player2Y, 0x800F7780
.definelabel player2Z, 0x800F7784
.definelabel player3X, 0x800F8854
.definelabel player3Y, 0x800F8858
.definelabel player3Z, 0x800F885C
.definelabel player4X, 0x800F9324
.definelabel player4Y, 0x800F9328
.definelabel player4Z, 0x800F932C

.definelabel cpu2Speed, 0x800F797C
.definelabel cpu3Speed, 0x800F8754
.definelabel cpu4Speed, 0x800F952C

.definelabel boost2, 0x800F7776
.definelabel boost3, 0x800F854E
.definelabel boost4, 0x800F9326

.definelabel g_player0State, 0x800F6990
.definelabel g_player1State, 0x800F7768
.definelabel g_player2State, 0x800F8540
.definelabel g_player3State, 0x800F9318
.definelabel g_player4State, 0x800F7768
.definelabel g_player5State, 0x800F8540
.definelabel g_player6State, 0x800F9318
.definelabel g_player7State, 0x800F7768

.definelabel aspectRatio, 0x80150148
.definelabel farClip, 0x8015014C

.definelabel lastLoadedAddress, 0x8015F728
.definelabel g_lap1Time, 0x8015F898
.definelabel g_lap2Time, 0x8015F89C
.definelabel g_lap3Time, 0x8015F8A0

.definelabel g_progressValue, 0x80163288



.definelabel g_gameLap, 0x80164390
.definelabel itemBoolean, 0x80165F5F
.definelabel itemA, 0x80165F5B
.definelabel itemB, 0x80165F5D
.definelabel itemC, 0x80165F8A

.definelabel g_lapCheckA, 0x8018CAE1
.definelabel g_lapCheckB, 0x8018CAE2
.definelabel backButton, 0x8018EDE3
.definelabel menuScreenA, 0x8018EDEE
.definelabel menuScreenB, 0x8018EDEC
.definelabel menuScreenC, 0x8018EDED

.definelabel titleDemo, 0x8018EE00

.definelabel cupSelect, 0x8018EE09
.definelabel courseSelect, 0x8018EE0B
.definelabel inGame, 0x8018EDFB

.definelabel songID, 0x8028ECE7

.definelabel player2OK, 0x8018EDE9
.definelabel player3OK, 0x8018EDEA
.definelabel player4OK, 0x8018EDEB




; the following all deal with ASM instructions in the game.
; we edit them in the customASM and stockASM routines.

.definelabel highpolypipeA, 0x802911E8   ;;3C190700
.definelabel highpolypipeB, 0x802911EC   ;;373908E8

.definelabel lowpolypipeA, 0x8029120C   ;;3C0A0700
.definelabel lowpolypipeB, 0x80291210   ;;354A2D68


.definelabel bigmushroomA, 0x802911A4   ;;3C180700
.definelabel bigmushroomB, 0x802911A8   ;;37181140

.definelabel bigmushroomsurfaceA, 0x80295E3C   ;;3C040700
.definelabel bigmushroomsurfaceB, 0x80295E44   ;;34841140

.definelabel audienceA, 0x802927EC   ;;3C0F0700
.definelabel audienceB, 0x802927F0   ;;35EF14A0

.definelabel audienceflagsA, 0x802928F0   ;;3C0D0700
.definelabel audienceflagsB, 0x802928F4   ;;35AD0160

.definelabel billboard1A, 0x802927CC   ;;3C0C0700
.definelabel billboard1B, 0x802927D0   ;;358C3240

.definelabel billboard2A, 0x802927AC   ;;3C0F0700
.definelabel billboard2B, 0x802927B0   ;;35EF3508

.definelabel billboardpost1A, 0x80292898   ;;3C190700
.definelabel billboardpost1B, 0x8029289C   ;;37390240

.definelabel billboardpost2A, 0x80292878   ;;3C0E0700
.definelabel billboardpost2B, 0x8029287C   ;;35CE0450



.definelabel fencesA, 0x802928BC   ;;3C180700
.definelabel fencesB, 0x802928D4   ;;371800E0

.definelabel bigsignA, 0x802A2AA4   ;;3C0A0601
.definelabel bigsignB, 0x802A2AA8   ;;254A9330

.definelabel pathLength, 0x800DD9D0
.definelabel pathOffset, 0x800DC8D0

.definelabel pathOffsetB, 0x800DC780


;; these are offsets to POP data inside segment 6.

.definelabel itemboxesA, 0x8029DBD4   ;;3C040601
.definelabel itemboxesB, 0x8029DBDC   ;;24849498

.definelabel treeslistA, 0x8029DBBC   ;;3C040601
.definelabel treeslistB, 0x8029DBC4   ;;24849570

.definelabel treesdisplayA, 0x802992C8   ;;3C180600
.definelabel treesdisplayB, 0x802992E0   ;;27186A68

.definelabel piranhalistA, 0x8029DBC8   ;;3C040601
.definelabel piranhalistB, 0x8029DBD0   ;;24849518

.definelabel piranhadisplayA, 0x80298668   ;;3C0F0600
.definelabel piranhadisplayB, 0x8029866C   ;;25EF6990


;; offsets for course data


.definelabel sectionviewA, 0x802927FC   ;;3C040900
.definelabel sectionviewB, 0x80292810   ;;248401F0

.definelabel surfacemapA, 0x80295E74   ;;3C040601
.definelabel surfacemapB, 0x80295E7C   ;;24849650
