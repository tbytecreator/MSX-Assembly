; =============================================================================
; PegarChutes.asm
; =============================================================================
; Manoel Neto 2019-09-25
; Pegar chute e gravar 												=> (CaracterTestar)
; Testar se o caracter esta na posicao atual 	=> (TestarCorreto)
; Imprimir os erros 													=> (ImprimirErros)
; =============================================================================
PegarChute:
	ld h,NumPosXEntradas
	ld l,NumPosYEntrada2
	call POSIT
	xor a
	ld (NumContTeste),a
	ld (NumContErros),a
LoopPegaChar:
	call PegarEntrada
	jp TestarCorreto
EstaCorreto:
	call CursorCorreto
	ld a,(NumContTeste)
	add a,NumPosXEntradas
	ld h,a
	ld l,NumPosYEntrada2
	call POSIT
	ld a,(ChaTestar)
	call CHPUT
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
	ld a,(NumContTeste)
	add a,NumPosXEntradas
	ld h,a
	ld l,NumPosYEntrada2
	call POSIT
	call CHGET
	ld (ChaTestar),a
ret

TestarCorreto:
	ld hl,StrFrase
	ld a,(NumContTeste)						; Conta o teste
AcharPosicaoTeste:
	cp 0
	jp z,AchouTeste
	inc hl
	dec a													; proximo teste
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
	call CursorErrado
	jp LoopPegaChar

ImprimirErros:
	ld a,NumPosYMensagens
	call LimparLinha
	ld h,NumPosXMensagens
	ld l,NumPosYMensagens
	call POSIT
	ld hl,MsgUsuario7
	call PrintString
	ld a,NumPosYErros
	call LimparLinha
	ld h,NumPosXErros
	ld l,NumPosYErros
	call POSIT
	ld hl,MsgUsuario3
	call PrintString
	ld a,(NumContErros)
	call PrintNumber
	ld hl,MsgUsuario4
	call PrintString
ret

CursorCorreto:
		ld a,NumPosYMensagens
		call LimparLinha
		ld h,NumPosXMensagens
		ld l,NumPosYMensagens
		call POSIT
		ld hl,MsgUsuario5
		call PrintString
		ld a,%0000001					; NVPPPPP
		call PlaySound				; Toca som de letra correta
		LD BC,&AFFF						; define o tempo de espera
		call Delay						; aguarda
		ld a,0
		call PlaySound				; Para de tocar o som
ret

CursorErrado:
		ld a,NumPosYMensagens
		call LimparLinha
		ld h,NumPosXMensagens
		ld l,NumPosYMensagens
		call POSIT
		ld hl,MsgUsuario6
		call PrintString
		ld a,%1101111					; NVPPPPP
		call PlaySound				; Toca som de letra Errada
		LD BC,&FFFF
		call Delay
		ld a,0
		call PlaySound				; Para de tocar o som
ret
