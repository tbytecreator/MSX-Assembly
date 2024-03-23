; =============================================================================
; Library.asm
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
; Inicializar as variaveis com zero
; =============================================================================
; Nao tem parametros
; =============================================================================
; Altera => A,HL, Todas as variaveis
; =============================================================================
LimpaMem:
	; ========== Zera Numericos ==========
	xor a
	ld (NumTamFrase),a
	ld (NumAleatorio),a
	ld (NumSorteios),a
	ld (NumDivIdeal),a
	ld (NumPosSort),a
	ld (NumContEmb),a
	ld (NumCentenas),a
	ld (NumDezenas),a
	ld (NumUnidades),a
	ld (NumContTeste),a
	ld (NumContErros),a
	; ========== Zera Caracteres ==========
	ld a,' '
	ld (ChaLetraAtual),a
	ld (ChaTestar),a
	; ========== Zera Strings ==========
	ld a,14
	ld hl,StrFrase
	call CleanBytes
	ld hl,StrEmbaralhada
	call CleanBytes
	; ========== Zera Matrizes ==========
	ld hl,MatSorteados
	call ZerarMatriz
ret

; =============================================================================
; Limpa uma string terminada em ENTER(13)
; =============================================================================
; HL => Endereco da string
; =============================================================================
; Altera => A, HL
; =============================================================================
LimpaString:
	ld b,0
LoopLimpaString:
	ld a,32
	ld (hl),a
	ld a,b
	cp 13
	jp z,LimpouString
	inc hl
	inc b
	jp LoopLimpaString
LimpouString:
	inc hl
	ld a,13
	ld (hl),a
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
; Imprime uma string terminada em ENTER(13)
; =============================================================================
; HL => Endereco da string
; =============================================================================
; Altera => A,HL
; =============================================================================
PrintString:
	ld a,(hl)
	cp 13
	jp z,EndString
	call CHPUT
	inc hl
	jp PrintString
EndString:
ret

; =============================================================================
; Zerar uma Matriz terminada em 255
; =============================================================================
; HL => Endereco da Matriz
; =============================================================================
; ALTERA => A,HL
; =============================================================================
ZerarMatriz:
	ld b,0
LoopZerarMatriz:
	ld a,255
	ld (hl),a
	ld a,b
	cp 13
	jp z,ZerouMatriz
	inc hl
	inc b
	jp LoopZerarMatriz
ZerouMatriz:
	inc hl
	ld a,255
	ld (hl),a
ret

; =============================================================================
; Imprimir um espaco
; =============================================================================
; Nao usa parametros
; =============================================================================
; ALTERA => nada
; =============================================================================
ImprimeEspaco:
	push af
		ld a, ' '
		call CHPUT
	pop af
ret

; =============================================================================
; Converter um numero de 0 a 15 em seu digito hexadecimal
; =============================================================================
; A => Numero a ser convertido
; =============================================================================
; ALTERA => A
; =============================================================================
ConvNumChar:
	cp 0
	jp z,Zero
	cp 1
	jp z,Um
	cp 2
	jp z,Dois
	cp 3
	jp z,Tres
	cp 4
	jp z,Quatro
	cp 5
	jp z,Cinco
	cp 6
	jp z,Seis
	cp 7
	jp z,Sete
	cp 8
	jp z,Oito
	cp 9
	jp z,Nove
	cp 10
	jp z,DezA
	cp 11
	jp z,OnzeB
	cp 12
	jp z,Dozec
	cp 13
	jp z,TrezeD
	cp 14
	jp z,QuatorzeE
	cp 15
	jp z,QuinzeF
	ret
Zero:
	ld a,'0'
ret

Um:
	ld a,'1'
ret

Dois:
	ld a,'2'
ret

Tres:
	ld a,'3'
ret

Quatro:
	ld a,'4'
ret

Cinco:
	ld a,'5'
ret

Seis:
	ld a,'6'
ret

Sete:
	ld a,'7'
ret

Oito:
	ld a,'8'
ret

Nove:
	ld a,'9'
ret

DezA:
	ld a,'A'
ret

OnzeB:
	ld a,'B'
ret

Dozec:
	ld a,'C'
ret

TrezeD:
	ld a,'D'
ret

QuatorzeE:
	ld a,'E'
ret

QuinzeF:
	ld a,'F'
ret

; =============================================================================
; Imprime um Numero
; =============================================================================
; A => Numero a ser impresso (8 bits, 255)
; =============================================================================
; Altera => A,HL,D
; =============================================================================
PrintNumber:
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
; Limpar uma linha em modo INIT32
; =============================================================================
; A => Numero da linha (entre 1 e 24)
; =============================================================================
; Altera => Nada
; =============================================================================
LimparLinha:
	push hl
		ld h,1
		ld l,a
		call POSIT
		ld hl,LinhaLimpa
		call PrintString
	pop hl
ret

LinhaLimpa:
	db "                                ",13

; =============================================================================
; Causar uma pausa em segundos
; =============================================================================
; BC => Tempo de parada
; =============================================================================
; Altera => A,C
; =============================================================================
Delay:
  nop
  dec BC
  ld A,B
  or C
  ret Z
jr Delay

; =============================================================================
; Sortear Numero randomico
; =============================================================================
; A => Numero maximo do sorteio
; =============================================================================
; Altera => A
; =============================================================================
RandomNumber:
	ld b,a								; Numero Maximo Sorteio
	ld a,128							; Dividir 128 pelo tamanho da frase
	ld d,0								; contador de subtracao sucessivas
DvPTamanho:
	sub b 								; comeca a divisao pelo tamanho da frase
	inc d									; aumenta o acumulador
	jr nc, DvPTamanho		  ; repete enquanto nao tem "vai um"
	dec d									; elimina o resto
	ld a,d								; nesse momento D tem o divisior ideal
	ld b,a								; carrega o divisor ideal
	ld a,r								; Gera um aleatorio entre 0 e 127
	ld d,0								; contador de subtracao sucessivas
DvPIdeal:
	sub b 								; comeca a divisao pelo divisor ideal
	inc d									; aumenta o acumulador
	jr nc, DvPIdeal 			; repete enquanto nao tem "vai um"
	dec d									; elimina o resto
	ld a,d								; Retorna o numero aleatorio
ret

; =============================================================================
; Limpar um espaco de memoria
; =============================================================================
; HL => Inicio da memoria
; A	 => bytes a limpar
; =============================================================================
; Altera => A, Todos os bytes a partir de HL ate HL+D
; =============================================================================
CleanBytes:
CleanByteAgain:
	ld (hl),32
	cp 0
	jr z,CleanedBytes
	dec a
	jp CleanByteAgain
CleanedBytes:
ret
