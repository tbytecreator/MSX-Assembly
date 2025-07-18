; =============================================================================
; LIB.ASM
; =============================================================================
; Manoel Neto 2019-09-25
; Funcoes ASM de uso geral para o MSX
; =============================================================================

; =============================================================================
; Limpar a tela
; =============================================================================
; Nao tem parametros
; =============================================================================
; Altera => Nada
; =============================================================================
LimparTela:
	push af
		xor a
		call CLS
	pop af
ret

; =============================================================================
; Imprime uma Nova linha
; =============================================================================
; Nao usa parametros
; =============================================================================
; Altera => Nada
; =============================================================================
NovaLinha:
	push af
		ld a, 13
		call CHPUT
		ld a, 10
		call CHPUT
	pop af
ret

; =============================================================================
; Imprime uma Nova linha na tela grafica
; =============================================================================
; Nao usa parametros
; =============================================================================
; Altera => Nada
; =============================================================================
NovaLinhaSC2:
	push af
		ld a, 13
		call GRPPRT
		ld a, 10
		call GRPPRT
	pop af
ret

; =============================================================================
; Imprime uma string terminada em ENTER(13)
; =============================================================================
; HL => Endereco da string
; =============================================================================
; Altera => A,HL
; =============================================================================
ImprimeString:
	ld a,(hl)
	cp 13
	jp z,EndString
	call CHPUT
	inc hl
	jp ImprimeString
EndString:
ret

; =============================================================================
; Imprime uma string na tela grafica
; =============================================================================
; HL => Endereco da string
; =============================================================================
; Altera => A,HL
; =============================================================================
ImprimeStringSC2:
	ld a,(hl)
	cp 13
	jp z,EndStringSC2
	call GRPPRT
	inc hl
	jp ImprimeStringSC2
EndStringSC2:
ret

; =============================================================================
; Imprime um Numero decimal
; =============================================================================
; A => Numero a ser impresso (8 bits, 255)
; =============================================================================
; Altera => A,HL,D
; =============================================================================
ImprimeDecimal:
	ld hl,NumCentenas
	ld (hl),&00
	ld hl,NumDezenas
	ld (hl),&00
	ld hl,NumUnidades
	ld (hl),&00
ContaCentenas:
	ld d,&64
	ld hl,NumCentenas
ProximaCentena:
	sub d
	jr c,ContarDezenas
	inc (hl)
jr ProximaCentena

ContarDezenas:
	add a,d
	ld d,&0a
	ld hl,NumDezenas
ProximaDezena:
	sub d
	jr c,ContaUnidades
	inc (hl)
jr ProximaDezena

ContaUnidades:
	add a,d
	ld (NumUnidades),a
	ld d,0

ImprimeCentenas:
	ld a,(NumCentenas)
	cp 0
	jr z,ImprimeDezenas
	add a,&30
	call CHPUT
	ld d,1
ImprimeDezenas:
	ld a,(NumDezenas)
	add a,d
	cp &00
	jr z,ImprimeUnidades
	sub d
	ld d,1
	add a,&30
	call CHPUT
ImprimeUnidades:
	ld a,(NumUnidades)
	add a,&30
	call CHPUT
ret

; =============================================================================
; Imprime um Numero binário na tela grafica
; =============================================================================
; A => Numero a ser impresso (8 bits, 255)
; =============================================================================
; Altera => Carry Flag, A, B
; =============================================================================
ImprimeBinarioSC2:
	; checa cada bit do acumulador, se for 1 imprime 1, se for 0 imprime 0
	ld b,8
ProximoBitSC2:
	rla
	jr nc,ImprimeZeroSC2
	push af
		ld a,'1'
		call GRPPRT
	pop af
	jp ChecaFimSC2
ImprimeZeroSC2:
	push af
		ld a,'0'
		call GRPPRT
	pop af
ChecaFimSC2:
	djnz ProximoBitSC2
ret

; =============================================================================
; Imprime um Numero binário
; =============================================================================
; A => Numero a ser impresso (8 bits, 255)
; =============================================================================
; Altera => Carry Flag, A, B
; =============================================================================
ImprimeBinario:
	; checa cada bit do acumulador, se for 1 imprime 1, se for 0 imprime 0
	ld b,8
ProximoBit:
	rla
	jr nc,ImprimeZero
	push af
		ld a,'1'
		call CHPUT
	pop af
	jp ChecaFim
ImprimeZero:
	push af
		ld a,'0'
		call CHPUT
	pop af
ChecaFim:
	djnz ProximoBit
ret