; =====================================
; DEMONSTRACAO DE DJNZ
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
  	ld b, 100
loop:
	ld a,b
  	call ImprimeNumero
	call NovaLinha
	djnz loop
	di
	halt
; =====================================
; FIM PROGRAMA
; =====================================
include "HWD\LIB.ASM"
include "HWD\PT-BR.ASM"

; =====================================
; PADDING
; =====================================
romPad:
 ds romSize-(romPad-romArea),0