; =============================================================================
; Strings.asm
; =============================================================================
; Manoel Neto 2019-09-25
; Strings utilizadas no Criptologic Z80
; =============================================================================
MsgUsuario3:
		db "Voce so cometeu ",13
MsgUsuario4:
		db " erros",13
MsgUsuario5:
	db "Esta Correto! 8-)",13
MsgUsuario6:
	db "Esta Errado. 8-(",13
MsgUsuario7:
	db "Parabens! Acertou tudo!",13
MsgUsuario8:
	db "Aperte <ENTER> para jogar",13
MsgUsuario9:
	db "Um jogo de Manoel Neto",13
LinhaReta:
	db 0,0,0,0,0,0,0,0,0,0,0,0,0,0
PadraoCores:
	db %01010001
	db %10110001
	db %10010001
	db %00110001
	db %01110001
	db %11010001
	db %11110001
	db %01010001
	db %10110001
	db %10010001
	db %00110001
	db %01110001
	db %11010001
	db %11110001
	db %01010001
	db %10110001
	db %10010001
	db %00110001
	db %01110001
	db %11010001
	db %11110001
	db %01010001
	db %10110001
	db %10010001
	db %00110001
	db %01110001
	db %11010001
	db %11110001
	db %01010001
	db %10110001
	db %10010001
	db %00110001
SpriteLinha:
	; =======================================================================
	; Achamos a posicao multiplicando o numero do sprite por 4 e somando ao
	; endereco base da tabela de
	; Sprite 	Padrao		Conteudo
	; 0			XXXXXXXX	Posicao X
	; 0			YYYYYYYY	Posicao Y
	; 0			PPPPPPPP	Numero do azulejo na tabela de padroes
	; 0			E---CCCC	E=Extendido---C=Cor
	; =======================================================================
	; Para definir um sprite precisamos de 4 bytes temos 14 sprites, entao
	; precisamos copiar para a tabela de atributos da VRAM 14*4 bytes(56)
	; =======================================================================
	db 15,15,0,%00000101
	db 16,16,0,%00000101
	db 17,17,0,%00000101
	db 18,18,0,%00000101
	db 19,19,0,%00000101
	db 20,20,0,%00000101
	db 21,21,0,%00000101
	db 22,22,0,%00000101
	db 23,23,0,%00000101
	db 24,24,0,%00000101
	db 25,25,0,%00000101
	db 26,26,0,%00000101
	db 27,27,0,%00000101
	db 28,28,0,%00000101
TituloPattern:
	; Select Game 
	db 19,5,12,5,3,20,27,7,1,13,5
AttributePattern:
	db %01010001
	db %10010001
	db %00110001
	db %01010001
	db %01110001
	db %11010001
	db %11110001
	db %10110001
	db %10010001
	db %00110001
	db %01010001
	db %01110001
	db %11010001
	db %11110001
	db %10110001
	db %10010001
	db %00110001
	db %01010001
	db %01110001
	db %11010001
	db %11110001
	db %10110001
	db %10010001
	db %00110001
	db %01010001
	db %01110001
	db %11010001
	db %11110001
	db %10110001
	db %10010001
	db %00110001
	db %01010001
	db %01110001
