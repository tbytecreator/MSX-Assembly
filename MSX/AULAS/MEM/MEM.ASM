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
	ld a,0
	ld (0XC000),a	; Este e o peek do asm
	ld a,1 
	ld (0XC001),a	; Este e o poke do asm
	call ImprimeDecimal
	call NovaLinha
	call NovaLinha
EnderecamentoIndireto:
	ld hl,0xC000	; Endereco de memoria
	ld a,(hl)		; Pega o valor do endereco
	call ImprimeDecimal
	call NovaLinha 
	ld hl,0xC001	; Endereco de memoriadereco
	ld a,(hl)		; Pega o valor do endereco
	call ImprimeDecimal
	call NovaLinha
	call NovaLinha
TrocaBytes:
	ld bc,(0xc000)		; Pega o valor do endereco
	ld hl,(0xc001)		; Pega o valor do endereco
	ld a,(bc)			; Troca o valor do endereco
	ld d,(hl)			; Troca o valor do endereco
	ld (hl),a
	ld a,d
	ld (bc),a			; Troca o valor do endereco
ImprimeTroca:
	ld hl,0xC000	; Endereco de memoria
	ld a,(hl)		; Pega o valor do endereco
	call ImprimeDecimal
	call NovaLinha 
	ld hl,0xC001	; Endereco de memoriadereco
	ld a,(hl)		; Pega o valor do endereco
	call ImprimeDecimal
	call NovaLinha
	call NovaLinha
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