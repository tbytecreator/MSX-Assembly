; =============================================================================
; PegarFrase.asm
; =============================================================================
; Manoel Neto 2019-09-25
; Pegar uma frase de no minimo 2 caracteres e no maximo 14 caracteres
; Receber a mensagem na area de memoria frase => (PegarMensagem)
; Validar o numero de caracteres durante a digitacao => (ValidaDuasLetras)
; Guardar o tamanho da frase digitada => (TamanhoFrase)
; Imprimir a mensagem vindo da memoria para teste => (ImprimirMensagem)
; =============================================================================
PegarFrase:
	ld a,NumPosYEntrada1 	; Prepara a linha para limpar
	call LimparLinha			; Limpa a linha de entrada
	ld h,NumPosXEntradas	; posicao x da entrada
	ld l,NumPosYEntrada1	; posicao y da entrada
	call POSIT						; posiciona cursor
	ld hl,StrFrase				; Carrega o endereco da frase
	call LimpaString			; Limpar a Frase
	ld hl,StrFrase				; Carrega o endereco da frase
	ld b,0								; Zera o contador de letras
LoopFrase:
	call CHGET						; ler um caracter
	cp 17 								; valida seta
	jp z,LoopFrase
	cp 18 								; valida seta
	jp z,LoopFrase
	cp 19 								; valida seta
	jp z,LoopFrase
	cp 20 								; valida seta
	jp z,LoopFrase
	cp 8 									; valida backspace
	jp z,LoopFrase
	ld (hl),a							; guarda o ascii desse caracter
	cp 13
	jp z,NaoImprime
	call CHPUT						; imprime o caracter
NaoImprime:
	inc hl								; proximo endereco
	inc b									; aumenta o contador de letras
	cp 13									; compara o carcter entrado com o ENTER(13)
	jp z,ValidaDuasLetras	; se a frase terminou por enter
	ld a,b								; prepara o contador para comparar
	ld (NumTamFrase),a		; guarda o tamanho da frase digitada
	cp 14									; compara o contador com 14
	jp z,AcabouFrase   		; se A-14 = 0 vc ja digitou 14 letras
	jp LoopFrase					; pega o proximo
ValidaDuasLetras:
	ld a,(NumTamFrase)		; prepara o contador para comparar
	cp 2									; compara com 2 letras
	jp nc,AcabouFrase			; se a >= 2 esta ok, retorna
	call LimpaString			; senao limpa a string
	jp PegarFrase					; e pega a mensagem novamente
AcabouFrase:
	inc hl								; vai para o proximo espaco
	ld (hl),13						; adiciona o fim da string
ret
