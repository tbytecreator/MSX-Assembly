; =====================================
; leitura do parametro do BASIC
; =====================================
include "BIOS.ASM"
include "CONST.ASM"
include "RAM.ASM"

org 0xc000
    db 0xfe
    dw startcode
    dw endcode
    dw startcode
startcode:
    call ClearScreen    ; limpa a tela
    ld a,(0xf663)       ; obtém o tipo do parâmetro
    cp 2                ; verifica se é inteiro
    jp z,inteiro        ; se for, continua
    cp 3                ; verifica se é string
    jp z,texto          ; se for, vai para string
    cp 4                ; verifica se é real
    jp z,simples        ; se for, vai para simples 
    cp 8                ; verifica se é dupla
    jp z,dupla          ; se for, vai para dupla
    jp tipodesconhecido ; termina o programa
inteiro:
    ld hl,msgInteger
    call PrintString    ; imprime a mensagem
    jp endprog
texto:
    ld hl,msgString
    call PrintString    ; imprime a mensagem
    jp endprog
simples:
    ld hl,msgSimple
    call PrintString    ; imprime a mensagem
    jp endprog
dupla:
    ld hl,msgDouble
    call PrintString    ; imprime a mensagem
    jp endprog
tipodesconhecido:
    ld hl,msgErro
    call PrintString    ; imprime a mensagem
endprog:
    call CHGET          ; espera por uma tecla
    halt
; =====================================
; FIM PROGRAMA
; =====================================
include "Z80.ASM"
include "PT-BR.ASM"
; =====================================
; final da subrotina
; =====================================
endcode: