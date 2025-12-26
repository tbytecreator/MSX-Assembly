; Rotina assembly MSX para ler o tipo do parâmetro passado pelo BASIC via USR
; Retorna o tipo da variável em A:
; 2 = Integer (%)
; 3 = String ($)
; 4 = Single (!)
; 8 = Double (#)

org     0E000h          ; Endereço de início típico para código assembly MSX

VALTYP: equ     0F663h      ; Endereço do VALTYP no MSX BASIC

inicio:
    push    hl              ; Preserva registradores
    push    de
    push    bc
    
    ld      a,(VALTYP)      ; Lê o tipo da variável do BASIC
    ld      l,a             ; Coloca o tipo em L
    ld      h,0             ; H = 0 para retornar valor em HL
    
    pop     bc              ; Restaura registradores
    pop     de
    pop     hl
    
    ret                     ; Retorna para o BASIC

    end