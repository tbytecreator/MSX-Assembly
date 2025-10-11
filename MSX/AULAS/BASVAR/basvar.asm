; =====================================
; variaveis do basic 
; =====================================
include "BIOS.ASM"

org 0xD000
	db 0xFE	
 	dw STARTCODE
 	dW ENDCODE
 	dW STARTCODE
STARTCODE:
	ld a,(0xF7F8)
	ld e,a	; E = variavel i%
	ld a,(0xF7F9)
	ld d,a	; D = variavel i%
	call WRTVRM		; gravo o byte na VRAM
ret					; retorna ao BASIC
; =====================================
; FIM PROGRAMA
; =====================================
ENDCODE: