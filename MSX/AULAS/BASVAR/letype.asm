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
STRDESC     EQU 0xF7F8  ; Descritor da string no BASIC
TYPE    	EQU 0xE030  ; Endereço onde o tipo será armazenado
VALOR1		EQU 0xE031  ; Endereço onde o valor será armazenado
VALOR2		EQU 0xE032  ; Endereço onde o valor será armazenado
NUMBYTES    EQU 0xE033	; Número de bytes da string do basic
STRLSB   	EQU 0xE034	; Endereço do LSB da string do basic
STRMSB   	EQU 0xE035	; Endereço do MSB da string do basic
;=============================================================================
ORG 0xE000
	db 0XFE	
 	dw STARTCODE
 	dW ENDCODE
 	dW STARTCODE
STARTCODE:  
    ld a,(VALTYP)       ; Lê o tipo da última variável avaliada
    ld (TYPE),a         ; Armazena o tipo em TYPE (0xE030)
	cp 3    			; Compara o tipo com 3 (String)
	jr z,handle_string
    ld a,(GETVAL1)      ; Lê o valor LSB
	ld (VALOR1),a       ; Armazena o valor em VALOR1 (0xE031)
	ld a,(GETVAL2)      ; Lê o valor MSB
	ld (VALOR2),a       ; Armazena o valor em VALOR2 (0xE032)
	jr continue
handle_string:
	ld hl,(STRDESC)    	; HL = ponteiro para o descritor da string (conteúdo de F7F8/F7F9)
	ld a,(hl)           ; Lê o tamanho da string (byte 0 do descritor)
	ld (NUMBYTES),a     ; Armazena o tamanho em NUMBYTES (E033)
	inc hl
	ld a,(hl)           ; Lê o LSB do endereço da string (byte 1 do descritor)
	ld (STRLSB),a       ; Armazena em STRLSB (E034)
	inc hl
	ld a,(hl)           ; Lê o MSB do endereço da string (byte 2 do descritor)
	ld (STRMSB),a       ; Armazena em STRMSB (E035)
continue:
    ld hl,TYPE          ; HL = endereço do tipo (retorno ao BASIC)
	ret
ENDCODE:
;=============================================================================