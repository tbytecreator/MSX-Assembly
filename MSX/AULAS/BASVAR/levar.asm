org 0xC000
    db 0xFE
    dw STARTCODE
    dw ENDCODE
    dw STARTCODE
STARTCODE:
    LD HL,(0xF7F8)   ; HL = endereço passado pelo BASIC (parâmetro USR)
    LD A,(HL)        ; A = byte em [HL]
    LD (0xF7F8),A    ; retorna low byte (valor 0..255)
    LD A,0
    LD (0xF7F9),A    ; retorna high byte = 0 (positivo)
    RET
ENDCODE: