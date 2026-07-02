;=============================================================================
; Rotina assembly MSX para ler o tipo do parâmetro passado pelo BASIC via USR
; Retorna o tipo da variável em HL:
; 2 = Integer (%)
; 3 = String ($)
; 4 = Single (!)
; 8 = Double (#)
;=============================================================================
VALTYP  	EQU 0xF663  ; Tipo da última variável avaliada pelo BASIC
GETVAL1  	EQU 0xF7F8  ; Valor do basic
GETVAL2  	EQU 0xF7F9  ; Valor do basic
TYPE    	EQU 0xE030  ; Endereço onde o tipo será armazenado
VALOR1		EQU 0xE031  ; Endereço onde o valor será armazenado
VALOR2		EQU 0xE032  ; Endereço onde o valor será armazenado
;=============================================================================
ORG 0xE000
	db 0XFE	
 	dw STARTCODE
 	dW ENDCODE
 	dW STARTCODE
STARTCODE:  
    ld a,(VALTYP)       ; Lê o tipo da última variável avaliada
    ld (TYPE),a         ; Armazena o tipo em TYPE (0xE030)
    ld a,(GETVAL1)      ; Lê o valor LSB
	ld (VALOR1),a       ; Armazena o valor em VALOR1 (0xE031)
	ld a,(GETVAL2)      ; Lê o valor MSB
	ld (VALOR2),a       ; Armazena o valor em VALOR2 (0xE032)
    ld hl,TYPE          ; armazena o endereço do retorno em HL
ret                     ; Retorna ao BASIC com o tipo em HL      
ENDCODE:
;=============================================================================