include "BIOS.ASM"
include "RAM.ASM"
include "Z80.ASM"

org 0xc000
    db 0xfe
    dw startcode
    dw endcode
    dw startcode
startcode:
    ; Obtendo o valor de parametro
    ld a,(0xf7f8)
    ld l,a
    ld a,(0xf7f9)
    ld h,a        
    ; Lendo o parametro de entrada
    ld a,(hl)    
    ld b,a   
    push hl
    call PrintDecimal  
    pop hl
    ; preparar o valor de retorno
    ld a,2
    ld (0xf663),a  ; define o tipo de retorno como inteiro (2)
    ld a,b
    ld (0xf7f8),a  ; coloca o resultado no byte baixo
    ld a,0
    ld (0xf7f9),a  ; zera o byte alto
    ret ; retorno ao msx-basic
endcode: