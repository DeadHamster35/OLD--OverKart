;;These are new custom RAM values
;;0x80400000 - 0x804FFFFF is restricted for OverKart64 functions and data.
;;0x80500000 - 0x805FFFFF is reserved for Custom Course Assembly and data.
;;0X80600000 - 0X80780000 should be safe for any other custom code.
;;The end of RAM is course data, from 0x80800000 backwards.
;;This varies based on the size of data for the current course. Be cautious!

.definelabel nameOffset, 0x80417000
.definelabel nameEnd, 0x80417004
.definelabel ghostOffset, 0x80417008
.definelabel ghostEnd, 0x8041700C

.definelabel okSong, 0x80417010
.definelabel speedA, 0x80417011
.definelabel speedB, 0x80417012
.definelabel speedC, 0x80417013

.definelabel mapOffset, 0x80417014
.definelabel mapEnd, 0x80417018
.definelabel coordOffset, 0x8041701C
.definelabel coordEnd, 0x80417020
.definelabel skyOffset, 0x80417024
.definelabel skyEnd, 0x80417028
.definelabel asmOffset, 0x8041702C
.definelabel asmEnd, 0x80417030

.definelabel dmaLength, 0x80417040
.definelabel dmaTarget, 0x80417044
.definelabel dmaSource, 0x80417048
.definelabel mioTarget, 0x8041704C
.definelabel mioSource, 0x80417050

.definelabel buttonPressed, 0x80417054
.definelabel hsID, 0x80417055


.definelabel cpuFlag, 0x80417056
.definelabel practiceFlag, 0x80417057
.definelabel fastFlag, 0x80417058
.definelabel widescreenFlag, 0x80417059
.definelabel statsFlag, 0x8041705A
.definelabel menuFlag, 0x8041705B
.definelabel aliasFlag, 0x8041705C
.definelabel arduinoFlag, 0x8041705D
.definelabel mirrorFlag, 0x8041705E
.definelabel parameterFlag, 0x8041705F



.definelabel splitTimer, 0x8041FFD0
.definelabel splitStart, 0x8041FFD4
.definelabel splitEnd, 0x8041FFD8
.definelabel splitBool, 0x8041FFDC

.definelabel savestateSplit, 0x8041FFE3
.definelabel savestateTimeA, 0x8041FFE4
.definelabel savestateTimeB, 0x8041FFE8
.definelabel savestateTimeC, 0x8041FFEC

.definelabel savestateLapA, 0x8041FFF0
.definelabel savestateLapB, 0x8041FFF4
.definelabel savestateLapC, 0x8041FFF5
.definelabel saveTimer, 0x8041FFFC
;;simpleobjRegion 0x80420000
;;dynamicobjRegion 0x80422BC4
;;playerdataRegion 0x80440D08
;; region 0x80447BCC
;; region 0x80448410
;; region 0x804486F0

.definelabel planeYP1, 0x80449000
.definelabel planeYP2, 0x80449004
.definelabel planeYP3, 0x80449008
.definelabel planeYP4, 0x8044900C




.definelabel asmJump, 0x80500000
