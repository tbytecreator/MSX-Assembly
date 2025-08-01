; =====================================
; Copiando bytes para VRAM
; =====================================
include "BIOS.ASM"

org 0xD000
	db 0xFE	
 	dw STARTCODE
 	dW ENDCODE
 	dW STARTCODE
STARTCODE:
	ld hl,0x1B01	; Endereco de memoria VRAM
	ld a,(0xC00A)	; Pego o valor do endereco
	call WRTVRM		; gravo o byte na VRAM
ret					; retorna ao BASIC
; =====================================
; FIM PROGRAMA
; =====================================
ENDCODE: