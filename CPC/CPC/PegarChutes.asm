; =========================================================================================
; PegarChutes.asm
; =========================================================================================
; Pegar os chutes do jogador 2
; Pegar chute e gravar 			     	=>(PegarEntrada)
; Testar se o caracter esta na posicao atual 	=>(TestarCorreto)
; Imprimir os erros ao final 			=>(ImprimirErros)
; =========================================================================================
PegarChutes:
	xor a
	ld (NumContTeste),a
	ld (NumContErros),a
LoopPegaChar:
	call PegarEntrada
	jp TestarCorreto
EstaCorreto:
	ld hl,MsgUsuario5
	call PrintString
	call NovaLinha
	ld a,(NumTamFrase)
	dec a
	ld b,a
	ld a,(NumContTeste)
	cp b
	jp z,Acertou
	inc a
	ld (NumContTeste),a
	jp LoopPegaChar
Acertou:
	call ImprimirErros
ret

PegarEntrada:
	ld hl,MsgUsuario4
	call PrintString
	call KM_WAIT_CHAR
	ld (ChaTestar),a
	call NovaLinha
ret

TestarCorreto:
	ld hl,StrFrase
	ld a,(NumContTeste)			; Conta o teste
AcharPosicaoTeste:
	cp 0
	jp z,AchouTeste
	inc hl
	dec a					; proximo teste
	jp AcharPosicaoTeste
AchouTeste:
	ld a,(hl)
	ld b,a
	ld a,(ChaTestar)
	cp b
	jp z,EstaCorreto
	ld a,(NumContErros)
	inc a
	ld (NumContErros),a
	ld hl,MsgUsuario6
	call PrintString
	call Novalinha
	jp LoopPegaChar
ImprimirErros:
	ld hl,MsgUsuario7
	call PrintString
	call Novalinha
	ld hl,MsgUsuario8
	call PrintString
	ld a,(NumContErros)
	call PrintNumber
	call Novalinha
ret