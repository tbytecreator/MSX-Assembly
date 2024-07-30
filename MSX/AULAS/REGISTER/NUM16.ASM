romSize                 equ &8000       ; O tamanho que a ROM deve ter
romArea                 equ &4000       ; Minha ROM começa aqui
ramArea                 equ &E000       ; Inicio da área de variáveis


org romArea
	db "AB"
	dw Inicio
	db 00,00,00,00,00
Inicio:
    ; Inicializa a screen 1
    LD A, 1
    CALL 0x005F

    ; Número de 16 bits a ser impresso
    LD DE,1234

    ; Converte o número para string
    CALL CONVERT_TO_STRING

    ; Imprime a string na tela
    CALL PRINT_STRING

    HALT

CONVERT_TO_STRING:
    ; Converte o número em DE para uma string em HL
    LD HL, BUFFER
    LD B, 0
CONVERT_LOOP:
    LD A,E
    LD C,10
    CALL DIVIDE
    ADD A,'0'
    LD (HL), A
    INC HL
    LD A,D
    LD C,10
    CALL DIVIDE
    ADD A, '0'
    LD (HL), A
    INC HL
    LD A, B
    OR A
    JR NZ, CONVERT_LOOP
    LD (HL), 0
    RET

DIVIDE:
    LD B, 0
DIVIDE_LOOP:
    SUB C
    JR C, DIVIDE_DONE
    INC B
    JR DIVIDE_LOOP
DIVIDE_DONE:
    INC A
    DEC B
RET

PRINT_STRING:
    ; Imprime a string em HL na tela
    LD HL, BUFFER
PRINT_LOOP:
    LD A, (HL)
    OR A
    RET Z
    CALL 0x00A2
    INC HL
    JR PRINT_LOOP

BUFFER:
    DS 6

; =====================================
; PADDING
; =====================================
romPad:
 ds romSize-(romPad-romArea),0
