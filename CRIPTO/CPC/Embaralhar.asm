; =========================================================================================
; Embaralhar.asm
; =========================================================================================
; Manoel Neto 2019-09-25
; Embaralhar Frase
; Achar a posicao sorteada na matriz			=> AcharPosSort
; Achar a letra nessa posicao da matriz			=> AcharLetra
; Gravar a letra encontrada em sua posicao embaralhada	=> GravarLetra
; Imprimir a frase inicial 				=> StrFrase
; Imprimir a frase Embaralhada 				=> StrFraseEmb
; =========================================================================================
Embaralhar:
	xor a				; prepara primeira passada
	ld (NumContEmb),a		; zera o contador de embaralhamento
GravarProxima:	
	call AcharPosSort		; achar a posicao sorteada 
	call AcharLetra			; acha a letra dessa passada
	call GravarLetra		; gravar a letra dessa passada
	ld a,(NumTamFrase)
	ld b,a
	ld a,(NumContEmb)		
	cp b				; se pegamos todos
	jp z,GravouTudo			; gravamos tudo 
	inc a 				; senao vamos para a proxima
	ld (NumContEmb),a		; e guardamos no contador
	jp GravarProxima		; pega a proxima
GravouTudo:
	call NovaLinha			; pula linha
	ld hl,MsgUsuario3		; imprime mensagem para o usuario
	call PrintString		; print
	ld hl,StrFraseEmb		; imprime a frase embaralhada
	call PrintString		; print
	call NovaLinha	
ret

AcharPosSort:
	ld a,(NumContEmb)		; pegar o contador de embaralhamentos
	ld hl,MatSorteados		; pegar a matriz com os sorteios
LoopAcharPosSort:
	cp 0				; se o contador de embaralhamentos = 0
	jp z,AchouPosSort		; achamos a posicao desse sorteio
	dec a				; tentamos a proxima posicao
	inc hl				; apontamos para o proximo numero
	jp LoopAcharPosSort		; tentamos de novo 
AchouPosSort:
	ld a,(hl)			; pegamos o numero 
	ld (NumPosSort),a		; jogamos na variavel
ret

AcharLetra:
	ld a,(NumPosSort)		; pegamos a posicao sorteada
	dec a 				; enderecos comecam com 0
	ld hl,StrFrase			; Vamos procurar essa posicao na frase
LoopAcharLetra:
	cp 0				; se a posicao eh zero, achamos
	jp z,AchouLetra			; achou a letra	
	dec a				; tentamos a proxima posicao
	inc hl				; apontamos para a proxima letra
	jp LoopAcharLetra		; tentamos de novo
AchouLetra:
	ld a,(hl)			; pegamos a letra 
	ld (ChaLetraAtual),a		; carregamos a variavel 
ret

GravarLetra:
	ld a,(NumContEmb)		; pegamos a posicao do sorteio
	ld b,a				; separamos para comparar
	xor a				; zeramos o contador
	ld hl,StrFraseEmb		; apontamos para escrever 
LoopGravarLetra:
	cp b				; eh a posicao para escrever
	jp z,AchouPosGravar		; se for vamos gravar	
	inc hl				; se nao for tentamos a proxima
	inc a				; contamos essa posicao
	jp LoopGravarLetra		; tentamos de novo 
AchouPosGravar:
	ld a,(ChaLetraAtual)		; pegamos a letra guardada
	ld (hl),a			; colocamos na posicao correta
	inc hl				; vamos para proxima posicao
	ld (hl),13			; finalizamos a string
ret