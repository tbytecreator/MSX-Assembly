; =====================================
; leitura do parametro do BASIC
; =====================================
include "PT-BR.ASM"

org 0xe000
    db 0xfe
    dw startcode
    dw endcode
    dw startcode
startcode:
    ld a,(0xf663)           ; obtém o tipo do parâmetro
    cp 2                    ; verifica se é inteiro
    jp z,inteiro            ; se for, continua
    jp tipodesconhecido     ; termina o programa
inteiro:
    ld a,3
    ld (0xf663),a           ; altera o tipo do parametro para string
    ld a,21
    ld (0xf7f8),a           ; indica que a string tem 21 bytes
    ld hl,msgInteger        ; carrega o endereço da string
    ld a,h                  ; obtém o byte mais significativo do endereço
    ld (0xf7f9),a           ; msb do endereço da string                 ; obtém o byte menos significativo do endereço
    ld a,l               ; obtém o byte menos significativo do endereço
    ld (0xf7fa),a           ; lsb do endereço da string
    ret                     ; retorna para o BASIC
tipodesconhecido:
    ld a,3                  ; o tipo de retorno eh string 
    ld (0xf663),a           ; altera o tipo do parametro para string
    ld a,17                 ; tamanho da string de erro
    ld (0xf7f8),a           ; indica que a string tem 17 bytes
    ld hl,msgErro           ; carrega o endereço da string
    ld a,h                  ; obtém o byte mais significativo do endereço
    ld (0xf7f9),a           ; msb do endereço da string
    ld a,l                  ; obtém o byte menos significativo do endereço
    ld (0xf7fa),a           ; lsb do endereço da string
    ret                     ; retorna para o BASIC
; =====================================
; FIM PROGRAMA
; =====================================
endcode:

