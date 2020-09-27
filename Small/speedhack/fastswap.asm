 ;Tell armips linker where the assets we declared in hotswap.h are located



;Offsets to functions present inside the MK64 ROM.
.definelabel decodeMIO0, 0x800400D0 ;MIO0 File A0 = input, A1 = output
.definelabel DMA, 0x80001158
.definelabel decodeTKMK, 0x800405D0
.definelabel printString, 0x800577A4
.definelabel colorFont, 0x800930D8
.definelabel loadFont, 0x80057710


.definelabel g_CourseID,  0x800DC5A1
.definelabel loadedCourse, 0x800DC5A5
.definelabel startingIndicator,  0x800DC513
.definelabel p_Input, 0x800F6915
.definelabel d_Input, 0x800F6914

.definelabel songID, 0x8028ECE7




.definelabel titleDemo, 0x8018EE00

.definelabel backButton, 0x8018EDE3

.definelabel courseScreenA, 0x8018EDEE
.definelabel courseScreenB, 0x8018EDEC
.definelabel courseScreenC, 0x8018EDED


.definelabel gameMode, 0x800DC53F

.definelabel cupSelect, 0x8018EE09
.definelabel courseSelect, 0x8018EE0B

.definelabel inGame, 0x8018D9E7
.definelabel gameOn, 0x8018EDF3

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



.definelabel gameLap, 0x80164393

.definelabel lapA, 0x8018CAE1
.definelabel lapB, 0x8018CAE2

.definelabel timerA, 0x800DC598


.definelabel resetButton, 0x800DC50F


.definelabel playerCount, 0x800DC53B
.definelabel p2AI, 0x800F7768
.definelabel p3AI, 0x800F8540
.definelabel p4AI, 0x800F9318
.definelabel p5AI, 0x800F7768
.definelabel p6AI, 0x800F8540
.definelabel p7AI, 0x800F9318
.definelabel p8AI, 0x800F7768






.definelabel selectA, 0x800B3924
.definelabel selectB, 0x810B3936
.definelabel selectC, 0x810B39A4
.definelabel selectD, 0x810B39B6
.definelabel selectE, 0x810B3A38
.definelabel selectF, 0x810B3A4E

.definelabel player2OK, 0x8018EDE9
.definelabel player3OK, 0x8018EDEA
.definelabel player4OK, 0x8018EDEB



.definelabel itemBoolean, 0x80165F5F
.definelabel itemA, 0x80165F5B
.definelabel itemB, 0x80165F5D
.definelabel itemC, 0x80165F8A



.definelabel ingameX, 0x800F69A4
.definelabel ingameY, 0x800F69A8
.definelabel ingameZ, 0x800F69AC
.definelabel ingameX2, 0x800F69B0
.definelabel ingameY2, 0x800F69B4
.definelabel ingameZ2, 0x800F69B8
.definelabel ingameROT, 0x800F69BC

.definelabel ingamespeedA, 0x800F69C4
.definelabel ingamespeedB, 0x800F69CC
.definelabel ingamespeedC, 0x800F6A24
.definelabel ingamespeedD, 0x800F6A28
.definelabel ingamespeedE, 0x800F6A2C


.definelabel internalBool, 0x80600000
.definelabel internalX,0x80600004
.definelabel internalY,0x80600008
.definelabel internalZ,0x8060000C
.definelabel internalROT,0x80600010


.definelabel startupBool, 0x80600014
.definelabel forceCPU, 0x80600015
.definelabel menuFlag, 0x80600016
.definelabel buttonPressed, 0x80600017





.definelabel parameterFlag, 0x80600118
.definelabel cpuFlag, 0x80600119
.definelabel parameterFlagB, 0x8060011A
.definelabel parameterFlagC, 0x8060011B
