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
	ld a,255
	add a,1
	jp c,ImprimeFoi1
NaoFoi1:
	call ImprimeBinario
	call NovaLinha
	ld hl,Message1
	call ImprimeString
	jr Fim
ImprimeFoi1:
	call ImprimeBinario
	call NovaLinha
	ld hl,Message0
	call ImprimeString
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