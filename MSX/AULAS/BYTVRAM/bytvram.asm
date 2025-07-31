; =====================================
; Copiando bytes para VRAM
; =====================================
include "BIOS.ASM"
org 0xC000
	db 0XFE	
 	dw STARTCODE
 	dW ENDCODE
 	dW STARTCODE
STARTCODE:
	ld hl,0x1B01		; Endereco de memoria VRAM
	ld a,(0XC00A)		; Pego o valor do endereco
	call WRTVRM
; =====================================
; FIM PROGRAMA
; =====================================
ENDCODE: