; =============================================================================
; Strings.asm
; =============================================================================
; Manoel Neto 2019-09-25
; Strings utilizadas no Criptologic Z80
; =============================================================================
MsgUsuario1:
	db "SELECT GAME",13
MsgUsuario3:
	db "VOCE SO COMETEU ",13
MsgUsuario4:
	db " ERROS",13
MsgUsuario5:
	db "ESTA CORRETO!",13
MsgUsuario6:
	db "ESTA ERRADO!",13
MsgUsuario7:
	db "PARABENS, ACERTOU TUDO!",13
LinhaReta:
	db 64,64,64,64,64,64,64,64,64,64,64,64,64,64
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