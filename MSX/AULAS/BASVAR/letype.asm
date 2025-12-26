; Rotina assembly MSX para ler o tipo do parâmetro passado pelo BASIC via USR
; Retorna o tipo da variável em A:
; 2 = Integer (%)
; 3 = String ($)
; 4 = Single (!)
; 8 = Double (#)

org 0E000h          ; Endereço de início típico para código assembly MSX

VALTYP: equ 0F663h  ; Endereço do VALTYP no MSX BASIC

inicio:  
    ld a,(VALTYP)   ; Lê o tipo da variável do BASIC
    ld (0F7F8h),a   ; Armazena temporariamente em memória
    ld a,2          ; Coloca o tipo em L   
    ret             ; Retorna para o BASIC