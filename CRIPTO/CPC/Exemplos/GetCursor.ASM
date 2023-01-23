TXT_GET_CURSOR	equ &BB78	; Funcao => Retorna a posicao do cursor (H=X,L=Y)
TXT_OUTPUT	equ &BB5A	; Funcao => Imprime um caracter

org &8000
	call TXT_GET_CURSOR
	push hl
		ld a, h
		call PrintNumber 
		ld a, ' '
		call TXT_OUTPUT 
	pop hl
	ld a, l
	call PrintNumber 
ret 

; ========================================================================================
; Imprime um Numero
; ========================================================================================
; A => Numero a ser impresso (8 bits, 255)
; ========================================================================================
; Altera => A,HL,D
; ========================================================================================
PrintNumber:
	ld hl,Centenas
	ld (hl),&00
	ld hl,Dezenas
	ld (hl),&00
	ld hl,Unidades
	ld (hl),&00
ContaCentenas:
	ld d,&64
	ld hl,Centenas
ProximaCentena:
	sub d
	jr c,ContarDezenas
	inc (hl)
jr ProximaCentena

ContarDezenas:
	add d
	ld d,&0a
	ld hl,Dezenas
ProximaDezena:
	sub d
	jr c,ContaUnidades
	inc (hl)
jr ProximaDezena

ContaUnidades:
	add d
	ld (Unidades),a
	ld d,0

ImprimeCentenas:
	ld a,(Centenas)
	cp &00
	jr z,ImprimeDezenas
	add a,&30
	call TXT_OUTPUT
	ld d,1
ImprimeDezenas:
	ld a,(Dezenas)
	add d
	cp &00
	jr z,ImprimeUnidades
	sub d
	ld d,1
	add a,&30
	call TXT_OUTPUT
ImprimeUnidades:
	ld a,(Unidades)
	add a,&30
	call TXT_OUTPUT
ret

Centenas:
	defb &00
Dezenas:
	defb &00
Unidades:
	defb &00

; ========================================================================================
