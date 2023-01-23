; ========================================================================================
; PegarFrase.asm 
; ========================================================================================
; Manoel Neto 2019-09-25
; Pegar uma frase de no minimo 2 caracteres e no maximo 14 caracteres
; Receber a mensagem na area de memoria frase 		=> (PegarMensagem)
; Validar o numero de caracteres durante a digitacao 	=> (ValidaDuasLetras)
; Guardar o tamanho da frase digitada 			=> (TamanhoFrase)
; Imprimir a mensagem vindo da memoria para teste 	=> (ImprimirMensagem)
; ========================================================================================
PegarFrase:
	call SCR_MODE_CLEAR	; Limpar a tela 
	call Home		; Bota o cursor na posicao inicial
	ld hl,MsgUsuario1	; Carrega a primeira Mensagem para o usuario
	call PrintString	; Imprime a mensagem
	ld hl,StrFrase		; Carrega o endereco da frase
	call LimpaString	; Limpar a Frase
	ld hl,StrFrase		; Carrega o endereco da frase
	ld b,0			; Zera o contador de letras
LoopFrase:
	call KM_WAIT_CHAR	; ler um caracter
	ld (hl),a		; guarda o ascii desse caracter
	call TXT_OUTPUT		; imprime o caracter
	inc hl			; proximo endereco
	inc b			; aumenta o contador de letras
	cp 13			; compara o carcter entrado com o ENTER(13)				
	jp z,ValidaDuasLetras	; se a frase terminou por enter 
	ld a,b			; prepara o contador para comparar
	ld (NumTamFrase),a	; guarda o tamanho da frase digitada
	cp 14			; compara o contador com 14
	ret z			; se A-14 = 0 vc ja digitou 14 letras
	jp LoopFrase		; pega o proximo
ValidaDuasLetras:		
	ld a,(NumTamFrase)	; prepara o contador para comparar
	cp 2			; compara com 2 letras
	ret nc			; se a >= 2 esta ok, retorna
	call LimpaString	; senao limpa a string
jp PegarFrase			; e pega a mensagem novamente

ImprimirFrase:			; vamos imprimir a mensagem da memoria
	call Novalinha		; Pula uma Linha
	ld hl,MsgUsuario2	; Carrega a segunda mensagem para o usuario
	call PrintString	; Imprime a mensagem
	ld hl,StrFrase		; Carrega a frase
	call PrintString	; Imprime a frase
ret