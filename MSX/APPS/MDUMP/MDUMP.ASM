; ==============================================
; PROGRAMA DE DUMP DE MEMORIA PARA MSX 
; ==============================================
; ADAPATADO DO CODIGO NO LIVRO GUIA DO 
; PROGRAMADOR MSX PAG 105 
; POR: MANOEL NETO
; ==============================================
versao: equ 0X002D
linlen: equ 0XF3B0
valtyp: equ 0XF663
endini: equ 0XF600
tempo:  equ 0XF602
txtcgp: equ 0XF3B7
erafnk: equ 0X00CC
crtcnt: equ 0XF3B1
hkeyi:  equ 0XFD9A
    db 0XFE                     ; cabecalho para binario
    dw inicio                   ; endereco de inicio
    dw inidump+fimdump-dump+1   ; endereco de fim
    dw inicio                   ; endereco de execucao
    org 0X9000
inicio:
    di                  ; desabilita interrupcoes
    in a,(0XA8)         ; le os slots
    ld e,a              ; salva em E
    rrca                ; prepara para ativar
    rrca                ; a pagina 1
    or e                ; 
    and %11111100       ; ativa pag 1 em RAM
    out (0XA8),a        ; 
    rrca                ; descobre o slot da RAM
    rrca                ; 
    and 0X03            ;
    ld (slotnewhk),a    ; salva o slot
    ld hl,newhook       ; prepara o desvio
    ld de,hkeyi         ; para o novo hook
    ld bc,0X0005        ; 
    ldir                ; desvio 
    ld hl,inidump       ; prepara a transferencia
    ld de,dump          ; da rotina de interrupcao
    ld bc,fimdump-dump  ; para o endereco de 4000
    inc bc              ;
    ldir                ; transfere
    in a,(0XA8)         ; reestabelece a configuracao
    and %11110000       ; inicial dos slots
    out (0XA8),a        ;
    ld a,20             ; tira as ultimas 4 linhas
    ld (crtcnt),a       ; para a exibicao do dump
    ld a,20             ; inicializa o tempo
    ld (tempo),a        ;
    ld hl,0X8000        ; inicializa o endereco ini
    ld (endini),hl      ;
    call erafnk         ; apaga as teclas de funcao
    ei                  ; habilita interrupcoes
    ret                 ; e volta ao basic
newhook:
    db 0XF7 
slotnewhk:
    db 0X00
    dw dump
    db 0XC9
inidump: 
    ;equ $
    org 0X4000
dump:
    ld hl,tempo         ; 
    ld a,(temporeal)    ; verifica se chegou
    inc a               ; ao tempo limite
    cp (hl)             ;
    ld (temporeal),a    ;
    ret nz              ; nao, volta ao BASIC
    xor a               ; sim, zera o tempo
    ld (temporeal),a    ;
    di                  ; desabilita interrupcoes
    ld a,(versao)       ; versao do msx no acc
    or a                ; se igual a zero, msx 1
    jr z,inicio1        ; vai para msx 1
    ld a,(linlen)       ; o msx 2 tem 80 colunas?
    cp 41               ; 
    jr c,inicio1        ; nao, vai para msx 1
    ld a,25             ; numero de digitos no acc
    ld hl,1600          ; hl=20*80=1600 (pos inicial)
    jr inicio2          ; 
inicio1:   
    ld a,11             ; numero de digitos no acc
    ld hl,800           ; hl=20*40=800 (pos inicial)
inicio2:
    ld (posini),hl      ; salva a posicao inicial
    ld (numdigs),a      ; salva o numero de digitos
enderdump:
    ld de,(endini)      ; endereco de varredura
    ld hl,(posini)      ; end da tabela de nomes
    call setvdpwt       ; prepara o VDP para escrita
    ld b,4              ; b=4 (linhas para o dump)
loopdump1:
    push bc             ; salva bc
        ld a,d          ; a=2 (primeiros digitos do end)
        call hexa       ; imprime
        ld a,e          ; a=2 (segundos digitos do end)
        call hexa       ; imprime
        call espaco     ; imprime um espaco
        ld a,(numdigs)  ; a= numero de digitos
        ld b,a          ; b= numero de digitos
loopdump2:
        ld a,(de)       ; a= byte da memoria
        call hexa       ; imprime
        call espaco     ; imprime um espaco
        inc de          ; proximo byte
        djnz loopdump2  ; repete para todos os byte
        ld a,(numdigs)  ; testa se eh 40 colunas
        cp 12           ;
        jr nc,loopdump3 ; se 80 colunas, loop3
        ld a,(de)       ; se 40, imprime o ult byte
        call hexa       ;
loopdump3:
        inc de          ; proximo byte
    pop bc              ; recupera bc
    djnz loopdump1      ; continua ate terminar
    ei                  ; habilita interrupcoes
    ret                 ; volta ao BASIC
; rotina para imprimir um byte em hexadecimal
hexa:
    push de             ; salva de
        ld e,a          ; e=a=valor a ser impresso
        and 0XF0         ; pega os 4 bits mais altos
        rrca            ;
        rrca            ; joga os 4 bits mais altos
        rrca            ; para o fim
        rrca            ;
        call hexa1      ; imprime o byte
        ld a,e          ; a=valor a ser impresso
    pop de              ; recupera de
    and 0X0F            ; pega os 4 bits mais baixos
hexa1:
    cp 0X0A             ; se menor que 10
    jr c,hexa2          ; imprime o valor
    add a,0X07          ; se maior que 10, ajusta
hexa2:
    add a,0X30          ; converte para ASCII
    out (0X98),a        ; imprime
    ret                 ; volta
; rotina para imprimir um espaco
espaco:
    ld a,0X20           ; a=espaco
    out (0X98),a        ; imprime
    ret                 ; volta
; rotina para preparar o VDP para escrita
setvdpwt:
    ld a,(versao)       ; versao do MSX no acc
    or a                ; se igual a zero, MSX 1
    jr z,wrtvram1       ; sim, vai para wrtvram1
    xor a               ; nao, iniciliza o VDP
    out (0X99),a        ; do msx 2
    ld a,0X8E           ;
    out (0X99),a        ;
wrtvram1:
    ld a,l              ; l=low byte do endereco
    out (0X99),a        ; vdp o endereco na vram
    ld a,h              ; onde o dado sera gravado
    and 0X3F            ; h=high byte do endereco
    or 0X40             ;
    out (0X99),a        ;
    ret                 ; volta
posini:
    dw 0
numdigs:
    db 0
temporeal:
    db 0
fimdump:
    ;equ $