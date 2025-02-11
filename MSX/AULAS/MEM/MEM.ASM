; =====================================
; DEMO DO COMANDO LD 
; =====================================
include "HWD\BIOS.ASM"
include "HWD\CONST.ASM"
include "HWD\VAR.ASM"

org romArea
	db "AB"
	dw ProgramStart
	db 00,00,00,00,00
ProgramStart:
	call LimparTela
	ld a,(0XC000)	; Este e o peek do asm 
	ld (0XC000),a	; Este e o poke do asm
	call ImprimeDecimal
Fim:
	call CHGET
	di
	halt

; =====================================
; FIM PROGRAMA
; =====================================
include "HWD\Z80.ASM"
include "HWD\PT-BR.ASM"

; =====================================
; PADDING
; =====================================
romPad:
 ds romSize-(romPad-romArea),0