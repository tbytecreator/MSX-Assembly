; =====================================
; Copiando bytes para VRAM
; =====================================
include "HWD/BIOS.ASM"

org 0xD000
	db 0XFE	
 	dw STARTCODE
 	dW ENDCODE
 	dW STARTCODE
ProgramStart:
	ld hl,0x6912		; Endereco de memoria VRAM
	ld a,(0X0C00)		; Pego o valor do endereco
	call WRTVRM
; =====================================
; FIM PROGRAMA
; =====================================
ENDCODE: