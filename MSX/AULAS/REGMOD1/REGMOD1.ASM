; =====================================
; REGISTRADOR DE MODO 1 
; =====================================
include "HWD\CONST.ASM"
include "HWD\BIOS.ASM"
include "HWD\VAR.ASM"

; =====================================
; O regmod1
; =====================================
; 4/16k	Blank IE	M1 M2 0 Size Mag
; =====================================
; Mag:   1=ampliado;2=normal
; Size:  0=8x8;1=16x16 
; M1:    Visto na ultima aula
; M2:    Visto na ultima aula
; IE:  	 0=desligado;1=ligado
; Blank: 0=desativa;1=ativa
; 4/16k: 0=4k;1=16k
; ===================================== 
org romArea
	db "AB"
	dw Inicio
	db 00,00,00,00,00

Inicio:
	call LimparTela
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
LigarZoom:
	call CHGET			; aguarda uma tecla
	ld a,(RG1SAV)       ; leio o valor do registro 1
	or 1                ; ajusto o bit de magnificacao
	ld b,a			    ; carrego o novo valor para o registrador
	ld c,1			    ; indico o registrador que vou alterar
	call WRTVDP         ; altero o valor do registrador 1
AlterarTamanho:
	call CHGET			; aguarda uma tecla
	ld a,(RG1SAV)       ; leio o valor do registro 1
	res 1,a             ; ajusto o bit de tamanho
	ld b,a			    ; carrego o novo valor para o registrador
	ld c,1			    ; indico o registrador que vou alterar
	call WRTVDP         ; altero o valor do registrador 1
DesligarVideo:
	call CHGET			; aguarda uma tecla
	ld a,(RG1SAV)       ; leio o valor do registro 1
	res 6,a             ; ajusto o bit de video
	ld b,a			    ; carrego o novo valor para o registrador
	ld c,1			    ; indico o registrador que vou alterar
	call WRTVDP         ; altero o valor do registrador 1
	call CHGET			; aguarda uma tecla
	ld a,(RG1SAV)       ; leio o valor do registro 1
	set 6,a             ; ajusto o bit de video
	ld b,a			    ; carrego o novo valor para o registrador
	ld c,1			    ; indico o registrador que vou alterar
	call WRTVDP         ; altero o valor do registrador 1
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