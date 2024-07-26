; =====================================
; DEMONSTRACAO DOS REGISTRADORES
; =====================================
include "HWD\CONST.ASM"
include "HWD\BIOS.ASM"
include "HWD\VAR.ASM"

org romArea
	db "AB"
	dw Inicio
	db 00,00,00,00,00

Inicio:
	call LimparTela
	call INIT32
ExBC:
  	ld b, 100	; contador de loop
loop:
	ld a,b
  	call ImprimeNumero8
	ld a,' '
	call CHPUT
	djnz loop
	call NovaLinha
ExHL:
	ld hl, NumBuffer
	ld (hl), 100
	ld b,(hl)
loop2:
	ld a,b
  	call ImprimeNumero8
	ld a,' '
	call CHPUT
	djnz loop2
	call NovaLinha
ExDE:
	ld hl,1000
	call ImprimeNumero16
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