; =============================================================================
; Sortear.asm
; =============================================================================
; Manoel Neto 2019-09-25
; =============================================================================
; Sortear X numeros aleatorios entre 1 e X
; X deve ser igual ao tamanho da frase do jogador 1
; Validar se o numero sorteado nao eh maior que N 			=> (ValidarMaiorN)
; Validar se o numero sorteado ja foi sorteado 	  			=> (ValidarJaFoi)
; Jogar o resultado para a variavel NumAleatorio  			=> (NumAleatorio)
; Jogar o resultado para a matriz de numeros sorteados 		=> (MatSorteados)
; Converter o numero em seu codigo Hexadeciaml 				=> (ChaLetraAtual)
; Somar um a cada elemento da matriz						=> Somar um
; =============================================================================
Sortear:
	xor a					; ld a,0 so que mais rapido
	ld (NumSorteios),a		; zera contador de sorteios
	call AcharDivIdeal		; achar o divisor ideal
SortearDeNovo:
	call SortearNumero		; Sorteei o numero em NumAleatorio
	jp ValidarMaiorN		; O numero nao pode ser maior que a entrada
ValidadoMaiorN:
	jp ValidarJafoi			; O Numero nao pode se repetir
ValidadoJaFoi:
	call GravarNaMatriz		; Grava o sorteio na matriz
	ld a,(NumTamFrase)		; carrega o contador de sorteios
	ld c,a					; so irei sortear de acordo com a entrada
	ld a,(NumSorteios)		; Pega o numero de sorteios
	inc a					; Aumenta numero de sorteios
	cp c					; testa se eh ultimo sorteio
	jp z,FimSorteio			; Acabou
	ld (NumSorteios),a		; Grava o numero de sorteios
	jp SortearDeNovo		; faz de novo
FimSorteio:
	call SomarUm			; soma um em cada elemento da matriz
ret

AcharDivIdeal:
	ld a,(NumTamFrase)		; pegar o tamanho da frase
	ld b,a								; usar o tamanho da frase como divisor
	ld a,128							; Dividir 128 pelo tamanho da frase
	ld d,0								; contador de subtracao sucessivas
DivPorTamanho:
	sub b 								; comeca a divisao pelo tamanho da frase
	inc d									; aumenta o acumulador
	jr nc, DivPorTamanho  ; repete enquanto nao tem "vai um"
	dec d									; elimina o resto
	ld a,d								; nesse momento D tem o divisior ideal
	ld (NumDivIdeal),a		; nesse momento A tem o divisior ideal
ret

SortearNumero:
	ld a,(NumDivIdeal)		; carrega o divisor ideal
	ld b,a								; carrega o divisor ideal
	ld a,r								; Gera um aleatorio entre 0 e 127
	ld d,0								; contador de subtracao sucessivas
DividirPorIdeal:
	sub b 								; comeca a divisao pelo divisor ideal
	inc d									; aumenta o acumulador
	jr nc, DividirPorIdeal; repete enquanto nao tem "vai um"
	dec d									; elimina o resto
	ld a,d								; prepara gravacao do numero
GravaAleatorio:
	ld (NumAleatorio),a		; grava na variavel
ret

ValidarMaiorN:
	ld a,(NumTamFrase)		; pegar o tamanho da frase
	ld b,a								; guarda tamanho frase
	ld a,(NumAleatorio)		; pega o numero aleatorio para comparacao
	cp b									; A < TamFrase ?
	jp c,ValidadoMaiorN		; A < TamFrase ?
jp SortearDeNovo

ValidarJafoi:
	ld a,(NumTamFrase)		; pega o tamnaho da entrada
	ld hl,MatSorteados		; pega o endereco da matriz
AcharFimFrase:					; Comeca o loop para chegar no fim da frase
	cp 0									; se andamos todo o tam. da entrada
	jp z,AcheiFimFrase		; achamos o endereco final da entrada
	inc hl								; proxima posicao
	dec a									; controla se chegamos no fim
	jp AcharFimFrase			; senao continuamos procurando
AcheiFimFrase:					; nesse momento temos hl apontando para o lugar certo
	ld a,(NumTamFrase)		; pega o tamanho da entrada
	inc a
	ld c,a								; prepara parte baixa do loop de CPDR
	ld b,0								; prepara parte alta do loop de CPDR
	ld a,(NumAleatorio)  	; pega o numero aleatorio para a pesquisa na matriz
	cpdr 									; procura a matriz ate achar A
	jp z,SortearDeNovo		; Achou! Precisamos sortear de novo!
	jp ValidadoJaFoi

GravarNaMatriz:
	ld hl,MatSorteados
	ld a,(NumSorteios)
	cp 0
	jp z,AcheiPosMat
AcharPosMat:
	inc hl
	dec a
	cp 0
	jp z,AcheiPosMat
	jp AcharPosMat
AcheiPosMat:
	ld a,(NumAleatorio)
	ld (hl),a
ret

SomarUm:
	ld hl,MatSorteados
LoopSomarUm:
	ld a,(hl)
	cp 255
	jp z,FimSomarUm
	inc a
	ld (hl),a
	inc hl
	jp LoopSomarUm
FimSomarUm:
ret
