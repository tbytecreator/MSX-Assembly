include "BIOS.ASM"
include "CONST.ASM"
include "RAM.ASM"
include "Z80.ASM"

org romArea
	db "AB"
	dw startcode
	db 00,00,00,00,00
startcode:
    call ClearScreen    ; limpa a tela
    ld a,(0xf663)       ; obtém o tipo do parâmetro
    cp 2                ; verifica se é inteiro
    jp nz, endproc      ; se não for, sai
    call PrintDecimal   ; imprime o valor
    call CHGET          ; espera por uma tecla
    jp return           ; retorna ao MSX-BASIC
endproc:
    ld hl,msgEnd
    call PrintString    ; imprime a mensagem
    call CHGET          ; espera por uma tecla
return:
    ret
msgEnd: db "O parametro nao e inteiro",13
endcode: