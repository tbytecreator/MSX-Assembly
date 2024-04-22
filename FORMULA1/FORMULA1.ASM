; ====================================
; Formula 1 1.0 for MSX
; ====================================
; Manoel Neto 2024-03-23
; ====================================
__VERSION:  equ 1
__RELEASE:  equ 0
include "HWD\BIOS.ASM"
include "ASSETS\CONST.ASM"
include "ASSETS\VAR.ASM"

org romArea
	db "AB"		
 	dw startCode
 	db "CW01"   
 	ds 6,0

; ====================================
; startCode
; ====================================
startCode:
	ld a,1
	ld (CSRSW),a   ; turn off cursor
	call CLEAN							
	call SPLASHSCREEN		
	call INIT			
GameLoopBegin:				
	call UPDATE							
	call DRAW													
GameLoopEnd:
	jp GameLoopBegin
; ====================================
; SUBROUTINES 
; ====================================
;include "SPLASHSCREEN.ASM"
;include "INIT.ASM"
;include "UPDATE.ASM"
;include "DRAW.ASM"
; ====================================
; END PROGRAM
; ====================================
include "HWD\AY38910.ASM"
include "HWD\TMS9918.ASM"
include "LIB\LIB.ASM"
include "ASSETS\PT-BR.ASM"
include "ASSETS\FONT.ASM"
; ====================================
; Padding
; ====================================
romPad:
 ds romSize-(romPad-romArea),0