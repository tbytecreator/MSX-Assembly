; =====================================
; HELLO WORLD PARA CARTUCHO
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
  	ld hl, Message1
  	call ImprimeString
  	DI
  	Halt

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