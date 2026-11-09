; ===========================================================================
; VIDEO.INC - Acesso direto ao VDP (SCREEN 0, 40x24)
; ===========================================================================

; HL = endereco da VRAM -> prepara escrita
vdp_setw:
        di
        ld a,l
        out (VDP_CMD),a
        ld a,h
        and 3Fh
        or 40h
        out (VDP_CMD),a
        ei
        ret

; HL = endereco da VRAM -> prepara leitura
vdp_setr:
        di
        ld a,l
        out (VDP_CMD),a
        ld a,h
        and 3Fh
        out (VDP_CMD),a
        ei
        ret

; D=linha, E=coluna -> posiciona o ponteiro de escrita da VRAM
; Preserva BC e DE.
gotoxy:
        push bc
        push de
        ld h,0
        ld l,d
        add hl,hl
        add hl,hl
        add hl,hl               ; 8*linha
        ld b,h
        ld c,l
        add hl,hl
        add hl,hl               ; 32*linha
        add hl,bc               ; 40*linha
        ld d,0
        add hl,de
        call vdp_setw
        pop de
        pop bc
        ret

; A = caractere. Soma INV (video inverso). Preserva A, BC, DE, HL.
vputc:
        push bc
        ld b,a
        ld a,(INV)
        or b
        out (VDP_DATA),a
        ld a,b
        pop bc
        ret

; HL = string terminada em 0. Ao retornar HL aponta APOS o terminador.
vputs:
        ld a,(hl)
        inc hl
        or a
        ret z
        call vputc
        jr vputs

; A = caractere, B = quantidade (1..255)
vfill:
        call vputc
        djnz vfill
        ret

; Limpa a tela inteira (960 posicoes) com espacos, video normal
cls:
        xor a
        ld (INV),a
        ld hl,0
        call vdp_setw
        ld bc,960
cls1:   ld a,' '
        out (VDP_DATA),a
        dec bc
        ld a,b
        or c
        jr nz,cls1
        ret

; Carrega os padroes de moldura (codigos 1..8) e gera a fonte invertida:
; o caractere (c OR 80h) e o negativo do caractere c, para c = 32..127.
load_font:
        ld hl,PATBASE+8
        call vdp_setw
        ld hl,box_pat
        ld b,64
lf1:    ld a,(hl)
        out (VDP_DATA),a
        inc hl
        djnz lf1

        ld c,32
lf2:    ld l,c
        ld h,0
        add hl,hl
        add hl,hl
        add hl,hl
        ld de,PATBASE
        add hl,de
        call vdp_setr
        ld hl,TMP8
        ld b,8
lf3:    in a,(VDP_DATA)
        cpl
        ld (hl),a
        inc hl
        djnz lf3

        ld a,c
        or 80h
        ld l,a
        ld h,0
        add hl,hl
        add hl,hl
        add hl,hl
        ld de,PATBASE
        add hl,de
        call vdp_setw
        ld hl,TMP8
        ld b,8
lf4:    ld a,(hl)
        out (VDP_DATA),a
        inc hl
        djnz lf4

        inc c
        ld a,c
        cp 128
        jr nz,lf2
        ret

; Padroes 6x8 (so os 6 bits mais altos de cada byte sao exibidos)
box_pat:
        defb 000h,000h,000h,0FCh,000h,000h,000h,000h   ; 1 horizontal
        defb 000h,000h,000h,01Ch,010h,010h,010h,010h   ; 2 canto sup. esq.
        defb 000h,000h,000h,0F0h,010h,010h,010h,010h   ; 3 canto sup. dir.
        defb 010h,010h,010h,01Ch,000h,000h,000h,000h   ; 4 canto inf. esq.
        defb 010h,010h,010h,0F0h,000h,000h,000h,000h   ; 5 canto inf. dir.
        defb 010h,010h,010h,01Ch,010h,010h,010h,010h   ; 6 T esquerdo
        defb 010h,010h,010h,0F0h,010h,010h,010h,010h   ; 7 T direito
        defb 010h,010h,010h,010h,010h,010h,010h,010h   ; 8 vertical

; HL = valor 0..9999 -> 4 colunas alinhadas a direita
num4:
        ld c,0
        ld de,1000
        call n4d
        ld de,100
        call n4d
        ld de,10
        call n4d
        ld a,l
        add a,'0'
        jp vputc
n4d:    ld a,'0'-1
n4l:    inc a
        or a
        sbc hl,de
        jr nc,n4l
        add hl,de
        cp '0'
        jr nz,n4p
        bit 0,c
        jr nz,n4o
        ld a,' '
n4o:    jp vputc
n4p:    ld c,1
        jp vputc

; HL = valor 0..65535 -> decimal sem zeros a esquerda
print_dec:
        ld c,0
        ld de,10000
        call pdd
        ld de,1000
        call pdd
        ld de,100
        call pdd
        ld de,10
        call pdd
        ld a,l
        add a,'0'
        jp vputc
pdd:    ld a,'0'-1
pdl:    inc a
        or a
        sbc hl,de
        jr nc,pdl
        add hl,de
        cp '0'
        jr nz,pdp
        bit 0,c
        ret z
pdp:    ld c,1
        jp vputc
