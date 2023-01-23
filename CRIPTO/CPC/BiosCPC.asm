; ========================================================================================
; BIOS
; ========================================================================================
KM_WAIT_CHAR	equ &BB06 	; Funcao => Aguarda uma entrada
SCR_MODE_CLEAR  equ &BC14	; Funcao => Limpar a tela 
TXT_OUTPUT	equ &BB5A	; Funcao => Imprime um caracter
TXT_SET_CURSOR 	equ &BB75	; Funcao => Localizar o curson (H=x,L=y)
TXT_GET_CURSOR	equ &BB78	; Funcao => Retorna a posicao do cursor
