; =====================================
; Copiando bytes para VRAM
; =====================================
include "BIOS.ASM"

org 0xC000
STARTCODE:
	ld hl,0x6912		; Endereco de memoria VRAM
	ld a,(0XC00A)		; Pego o valor do endereco
	call WRTVRM
; =====================================
; FIM PROGRAMA
; =====================================
ENDCODE: