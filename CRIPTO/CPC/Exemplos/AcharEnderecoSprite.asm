; =========================================================================================
; Achar endereco de um sprite 
; Manoel Neto 2019-10-23
; =========================================================================================
; Localizar a posicao onde gravar a informacao dos sprites do MSX
; =========================================================================================
read "..\BiosCPC.asm"
read "..\Variaveis.asm"
; ========================================================================================
; INICIO PROGRAMA
; ========================================================================================

; B = > Multiplicador (4)
; C = > Numero do Sprite 
org &8000
	ld b,4 	
	ld c,2
GetSpriteAdress:
	LD A,B			; a multiplicacao e feita por um loop
	CP 0			; caso b seja zero, nao precisamos multiplicar
	JR Z,PegouValorSoma 	; Vai para a soma do endereco base
	LD A,0			; limpa o acumulador para inicar o loop
MATHMULTAGAIN:
	ADD a,c			; soma o valor 
	DJNZ MATHMULTAGAIN	; se ainda temos multiplicador continuamos no loop
PegouValorSoma:
	ld hl,8192		; Endereco base da tabela de atributos
IncrementarPonteiro:
	cp 0
	jp z,AcheiEndereco
	inc hl
	dec a
	jp IncrementarPonteiro	
AcheiEndereco:

LoopInfinito:
jp LoopInfinito

; ========================================================================================
; FIM PROGRAMA
; ========================================================================================
read "..\Library.asm"
read "..\Strings.asm"


