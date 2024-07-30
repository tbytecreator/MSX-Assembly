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
	call NovaLinha
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
SetScreen2_16x16:
	call INIGRP             ; inicia modo grafico 256x192
	ld a,(RG1SAV)           ; leio o valor do registro 1
	and 0xE6                ; também desligo o zoom dos sprites
	or 2                    ; e ajusto os sprites para 16x16
	ld b,a					; carrego o novo valor para o registrador
	ld c,1					; indico o registrador que vou alterar
	call WRTVDP             ; altero o valor do registrador 1
	
	; Address  : 005C - LDIRVM
    ; Function : Transfere um bloco de memória para a VRAM
    ; Input    : BC - tamanho do bloco
    ; DE - Endereço na VRAM
    ; HL - Endereço na RAM
CarregaVRAM:
	ld bc,192             	; bytes a copiar
  	ld de,14336	    		; tabela de sprites na VRAM
  	ld hl,Sprites			; localização na RAM
  	call LDIRVM             ; copio a tabela de sprites
PutSprite:
	; Parametros
	; A => Numero do Sprite na tabela de atributos
	; D => posicao Y
	; E => posicao X
	; B => Numero do sprite na tabela de sprites
	; C => Early / Cor

	ld a,0
	ld d,60
	ld e,128
	ld b,16
	ld c,13

	push de
		call CALATR		; pega o endereco do sprite na TBL de atributos
	pop de				; retorno DE
	ld a,d
	call WRTVRM			; gravo a posicao Y
	inc hl				; proximo endereco
	ld a,e
	call WRTVRM			; gravo a posicao X
	inc hl				; proximo endereco
	ld a,b
	call WRTVRM			; Gravo o numero na tabela de padroes
	inc hl				; proximo endereco
	ld a,c
	call WRTVRM			; gravo Early / Color
	
di
halt
; =====================================
; FIM PROGRAMA
; =====================================
include "HWD\Z80.ASM"
include "HWD\PT-BR.ASM"
include "AST\Sprites.asm"

; =====================================
; PADDING
; =====================================
romPad:
 ds romSize-(romPad-romArea),0