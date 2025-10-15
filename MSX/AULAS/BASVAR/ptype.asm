org 0xC000
    db 0xFE	
    dw STARTCODE
    dw ENDCODE
    dw STARTCODE
STARTCODE:
    LD HL,(0XF7F8)  ; Pega o argumento da função USR
    LD A,(HL)       ; Pega o valor do argumento
    LD (0XF7F8),A   ; Coloca o valor de volta (não é necessário, mas é bom para manter o estado)
    INC HL
    LD A,(HL)       ; Pega o próximo byte (tipo da variável)
    LD (0XF7F9),A   ; Coloca o tipo da variável no endereço de retorno
RET   
ENDCODE: