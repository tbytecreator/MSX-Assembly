;=============================================================================
; Rotina assembly MSX para ler o tipo do parâmetro passado pelo BASIC via USR
; Retorna o tipo da variável em HL:
; 2 = Integer (%)
; 3 = String ($)
; 4 = Single (!)
; 8 = Double (#)
;=============================================================================
VALTYP  EQU 0xF663  ; Tipo da última variável avaliada pelo BASIC
TYPE    EQU 0xE010  ; Endereço onde o tipo será armazenado
;=============================================================================
ORG 0xE000
	db 0XFE	
 	dw STARTCODE
 	dW ENDCODE
 	dW STARTCODE
STARTCODE:  
    ld a,(VALTYP)       ; Lê o tipo da última variável avaliada
    ld (TYPE),a         ; Armazena o tipo em TYPE (0xE010)
    ld hl,TYPE          ; armazena o endereço do retorno em HL
ret                     ; Retorna ao BASIC com o tipo em HL      
ENDCODE:
;=============================================================================