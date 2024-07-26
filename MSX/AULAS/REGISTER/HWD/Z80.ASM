; =============================================================================
; Z80.ASM
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
; Imprime um Numero de 8 bits (0-255)
; =============================================================================
; A => Numero a ser impresso
; =============================================================================
; Altera => A,HL,D
; =============================================================================
ImprimeNumero8:
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
; Dividir um numero por outro 
; =============================================================================
; A => dividendo
; C => divisor
; =============================================================================
; Altera => A (RESULTADO), B (RESTO)
; =============================================================================
Divide:
    ld b,0			
DivideLoop:
    sub c
    jr c, DivideDone
    inc b 
    jr DivideLoop
DivideDone:
    add a,C
    dec b
ret

; =============================================================================
; Converter um numero para string 
; =============================================================================
; 
; =============================================================================
; Altera => 
; =============================================================================
ConvertToString:
    ld hl,Buffer 
    ld b,0
ConvertLoop:
    ld a,e
    ld c,10
    call Divide
    add a,'0'
    ld (hl), a
    inc hl
    ld a,d
	ld c,10
    call Divide
    add a,'0'
    ld (hl), a
    inc hl
    ld a,b
	or a
    jr nz, ConvertLoop
    ld (hl),0
ret

; =============================================================================
; Imprime um Numero de 16 bits (0-65535)
; =============================================================================
; DE => Numero a ser impresso
; =============================================================================
; Altera => HL
; =============================================================================
ImprimeNumero16:
    CALL ConvertToString	; Converte o número para string
	CALL PrintBuffer		; Imprime a string na tela
ret

; =============================================================================
; Imprime o Buffer na tela
; =============================================================================
; Nao usa parametros
; =============================================================================
; Altera => 
; =============================================================================
PrintBuffer:
    ld hl,Buffer
PRINT_LOOP:
    LD A,(HL)
    OR A
    RET Z
    CALL CHPUT
    INC HL
    JR PRINT_LOOP
ret