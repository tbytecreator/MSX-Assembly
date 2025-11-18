; =====================================
; leitura do parametro do BASIC
; =====================================
org 0xc000
    db 0xfe
    dw startcode
    dw endcode
    dw startcode

startcode:
    ld a,(0xf663)       ; lê o tipo do parâmetro passado
    cp 2                ; verifica se é inteiro
    jp z,inteiro
    cp 3                ; verifica se é string
    jp z,string 
    cp 4                ; verifica se é simples precisão
    jp z,simples
    cp 8                ; verifica se é dupla precisão
    jp z,dupla  
    jp tipodesconhecido

inteiro:
    ld a,3              ; define tipo de retorno = string
    ld (0xf663),a
    ld a,21             ; tamanho da string = 21
    ld (0xf7f8),a
    ld hl,msgInteger    ; endereço da mensagem
    ld a,l
    ld (0xf7f9),a       ; LSB do endereço
    ld a,h
    ld (0xf7fa),a       ; MSB do endereço
    ret

string:
    ld a,3              ; define tipo de retorno = string
    ld (0xf663),a
    ld a,20             ; tamanho da string = 20
    ld (0xf7f8),a
    ld hl,msgString     ; endereço da mensagem
    ld a,l
    ld (0xf7f9),a       ; LSB do endereço
    ld a,h
    ld (0xf7fa),a       ; MSB do endereço
    ret

simples:
    ld a,3              ; define tipo de retorno = string
    ld (0xf663),a
    ld a,30             ; tamanho da string = 30
    ld (0xf7f8),a
    ld hl,msgSimples    ; endereço da mensagem
    ld a,l
    ld (0xf7f9),a       ; LSB do endereço
    ld a,h
    ld (0xf7fa),a       ; MSB do endereço
    ret

dupla:
    ld a,3              ; define tipo de retorno = string
    ld (0xf663),a
    ld a,28             ; tamanho da string = 28
    ld (0xf7f8),a
    ld hl,msgDupla      ; endereço da mensagem
    ld a,l
    ld (0xf7f9),a       ; LSB do endereço
    ld a,h
    ld (0xf7fa),a       ; MSB do endereço
    ret

tipodesconhecido:
    ld a,3              ; define tipo de retorno = string
    ld (0xf663),a
    ld a,17             ; tamanho da string = 17
    ld (0xf7f8),a
    ld hl,msgDesconhecido ; endereço da mensagem
    ld a,l
    ld (0xf7f9),a       ; LSB do endereço
    ld a,h
    ld (0xf7fa),a       ; MSB do endereço
    ret

; =====================================
; MENSAGENS
; =====================================
msgInteger:      db "PARAMETRO: INTEIRO   "
msgString:       db "PARAMETRO: STRING   "
msgSimples:      db "PARAMETRO: SIMPLES PRECISAO   "
msgDupla:        db "PARAMETRO: DUPLA PRECISAO    "
msgDesconhecido: db "TIPO DESCONHECIDO"

; =====================================
; FIM DO PROGRAMA
; =====================================
include "ast/RAM.ASM"
endcode: