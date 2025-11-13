org 0xc000
    db 0xfe
    dw startcode
    dw endcode
    dw startcode

; rotina usr:
; - recebe no buffer do parâmetro (ptr em f7f6) um inteiro de 16 bits (lsb/msb).
; - interpreta esse inteiro como endereço.
; - lê o byte nesse endereço.
; - escreve o resultado (0..255) de volta no mesmo buffer (lsb=valor, msb=0),
;   que o basic usará como valor retornado de usr.

startcode:
    ; hl = ponteiro para o buffer do parâmetro do usr
    ld hl,(0xf7f6)

    ; ler o endereço passado (lsb/msb) do buffer
    ld c,(hl)        ; lsb
    inc hl
    ld b,(hl)        ; msb

    ; guardar ponteiro do buffer para escrever o resultado depois
    dec hl           ; hl volta a apontar para o 1º byte do buffer
    push hl

    ; hl = endereço efetivo a ser lido
    ld l,c
    ld h,b

    ; ler o byte no endereço
    ld a,(hl)

    ; escrever o resultado no buffer do parâmetro (retorno do usr)
    pop hl
    ld (hl),a        ; lsb = valor (0..255)
    inc hl
    xor a
    ld (hl),a        ; msb = 0

    ret

endcode: