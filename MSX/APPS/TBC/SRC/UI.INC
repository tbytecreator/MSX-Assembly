; ===========================================================================
; UI.INC - Desenho dos paineis, barra de teclas, mensagens e entrada de texto
; ===========================================================================

; --- Teclado ---------------------------------------------------------------
; Bloqueia ate uma tecla ser pressionada. Retorna A = codigo.
wait_key:
        ld c,F_DIRIO
        ld e,0FFh
        call bdos
        or a
        jr z,wait_key
        ret

; Chamada ao BDOS preservando IX (o BDOS do DOS 1 pode altera-lo).
bdos:
        push ix
        call BDOSV
        pop ix
        ret

; Chamada a BIOS (IX = endereco) via CALSLT
bios:
        ld iy,(EXPTBL-1)
        call CALSLT
        ei
        ret

; --- Painel ativo ----------------------------------------------------------
; Se IX e o painel ativo, INV = 80h; caso contrario INV = 0
active_inv:
        push ix
        pop hl
        ld de,(ACTIVE)
        or a
        sbc hl,de
        ld a,0
        jr nz,ai1
        ld a,80h
ai1:    ld (INV),a
        ret

; --- Desenho completo ------------------------------------------------------
draw_all:
        ld ix,PAN0
        call draw_panel
        ld ix,PAN1
        call draw_panel
        jp draw_keybar

; IX = painel
draw_panel:
        xor a
        ld (INV),a
        ld d,0
        ld a,CH_TL
        ld c,CH_TR
        call draw_hline
        ld d,20
        ld a,CH_LT
        ld c,CH_RT
        call draw_hline
        ld d,22
        ld a,CH_BL
        ld c,CH_BR
        call draw_hline
        call draw_title
        call draw_rows
        jp draw_info

; D = linha, A = canto esquerdo, C = canto direito
draw_hline:
        push af
        ld e,(ix+P_X)
        call gotoxy
        pop af
        call vputc
        ld a,CH_H
        ld b,PAN_W-2
        call vfill
        ld a,c
        jp vputc

; Titulo (unidade) na borda superior; invertido se o painel esta ativo
draw_title:
        ld d,0
        ld a,(ix+P_X)
        add a,8
        ld e,a
        call gotoxy
        call active_inv
        ld a,' '
        call vputc
        ld a,(ix+P_DRV)
        add a,'A'-1
        call vputc
        ld a,':'
        call vputc
        ld a,' '
        call vputc
        xor a
        ld (INV),a
        ret

; Redesenha as 19 linhas de arquivos
draw_rows:
        ld b,0
dp_l:   push bc
        ld a,b
        call draw_row
        pop bc
        inc b
        ld a,b
        cp PAN_ROWS
        jr c,dp_l
        ret

; A = indice da linha (0..18)
draw_row:
        ld (CURROW),a
        inc a
        ld d,a
        ld e,(ix+P_X)
        call gotoxy
        xor a
        ld (INV),a
        ld a,CH_V
        call vputc
        ld a,(CURROW)
        add a,(ix+P_TOP)
        ld c,a
        cp (ix+P_CNT)
        jr nc,dr_blank
        cp (ix+P_CUR)
        jr nz,dr_norm
        call active_inv
dr_norm:
        ld a,c
        call entry_addr
        call print_entry
        jr dr_end
dr_blank:
        ld a,' '
        ld b,PAN_W-2
        call vfill
dr_end: xor a
        ld (INV),a
        ld a,CH_V
        jp vputc

; HL = entrada -> imprime 18 colunas: NOME.EXT TTTTK
print_entry:
        ld b,8
pe1:    ld a,(hl)
        call vputc
        inc hl
        djnz pe1
        ld a,(hl)
        cp ' '
        ld a,'.'
        jr nz,pe2
        ld a,' '
pe2:    call vputc
        ld b,3
pe3:    ld a,(hl)
        call vputc
        inc hl
        djnz pe3
        ld a,' '
        call vputc
        ; tamanho em KB = (tam + 1023) >> 10
        ld e,(hl)
        inc hl
        ld d,(hl)
        inc hl
        ld c,(hl)
        inc hl
        ld b,(hl)
        ld hl,03FFh
        add hl,de
        jr nc,pe4
        inc bc
pe4:    ld a,h
        srl a
        srl a
        ld h,b
        ld l,c
        add hl,hl
        add hl,hl
        add hl,hl
        add hl,hl
        add hl,hl
        add hl,hl
        or l
        ld l,a
        ld de,10000
        push hl
        or a
        sbc hl,de
        pop hl
        jr c,pe5
        ld hl,9999
pe5:    call num4
        ld a,'K'
        jp vputc

; Linha de informacao do painel: "N files FFFFK"
draw_info:
        xor a
        ld (INV),a
        ld d,21
        ld e,(ix+P_X)
        call gotoxy
        ld a,CH_V
        call vputc
        ld a,' '
        ld b,PAN_W-2
        call vfill
        ld a,CH_V
        call vputc
        ld d,21
        ld a,(ix+P_X)
        inc a
        ld e,a
        call gotoxy
        ld l,(ix+P_CNT)
        ld h,0
        call print_dec
        ld hl,s_files
        call vputs
        ld l,(ix+P_FREE)
        ld h,(ix+P_FREE+1)
        call print_dec
        ld a,'K'
        jp vputc

; A = indice -> HL = endereco da entrada no painel IX
entry_addr:
        ld l,a
        ld h,0
        add hl,hl
        add hl,hl
        add hl,hl
        add hl,hl
        ld e,(ix+P_ENT)
        ld d,(ix+P_ENT+1)
        add hl,de
        ret

; HL = entrada sob o cursor do painel IX
cur_entry:
        ld a,(ix+P_CUR)
        jp entry_addr

; Ajusta P_TOP para manter o cursor visivel
scroll_fix:
        ld a,(ix+P_CUR)
        cp (ix+P_TOP)
        jr nc,sf1
        ld (ix+P_TOP),a
        ret
sf1:    sub PAN_ROWS-1
        ret c
        cp (ix+P_TOP)
        ret c
        ret z
        ld (ix+P_TOP),a
        ret

; --- Barra de teclas (linha 23) --------------------------------------------
draw_keybar:
        xor a
        ld (INV),a
        ld d,23
        ld e,0
        call gotoxy
        ld a,' '
        ld b,40
        call vfill
        ld d,23
        ld e,0
        call gotoxy
        ld hl,keybar
kb_l:   ld a,(hl)
        inc a
        ret z
        xor a
        ld (INV),a
        call vputs
        ld a,80h
        ld (INV),a
        call vputs
        xor a
        ld (INV),a
        ld a,' '
        call vputc
        jr kb_l

; --- Barra do visualizador -------------------------------------------------
msg_line:
        ld a,80h
        ld (INV),a
        ld d,23
        ld e,0
        call gotoxy
        ld a,' '
        ld b,40
        call vfill
        ld d,23
        ld e,0
        jp gotoxy

; --- Dialogos modais -------------------------------------------------------
; Moldura de 36 colunas, linhas 9..13. Preserva HL (texto do dialogo).
modal_box:
        push hl
        xor a
        ld (INV),a
        ld d,9
        ld e,2
        call gotoxy
        ld a,CH_TL
        call vputc
        ld a,CH_H
        ld b,34
        call vfill
        ld a,CH_TR
        call vputc
        ld d,10
modal_rows:
        ld e,2
        call gotoxy
        ld a,CH_V
        call vputc
        ld a,' '
        ld b,34
        call vfill
        ld a,CH_V
        call vputc
        inc d
        ld a,d
        cp 13
        jr nz,modal_rows
        ld e,2
        call gotoxy
        ld a,CH_BL
        call vputc
        ld a,CH_H
        ld b,34
        call vfill
        ld a,CH_BR
        call vputc
        ld d,10
        ld e,4
        call gotoxy
        pop hl
        ret

; HL = texto. Mostra uma mensagem e espera uma tecla.
show_msg:
        call modal_box
        call vputs
        ld d,12
        ld e,4
        call gotoxy
        ld hl,s_press
        call vputs
        call wait_key
        jp draw_all

; HL = pergunta. Retorna Z se o usuario respondeu Y.
ask_yn:
        call modal_box
        call vputs
        ld d,12
        ld e,4
        call gotoxy
        ld hl,s_yn
        call vputs
ay_l:   call wait_key
        cp K_ESC
        jr z,ay_n
        and 0DFh
        cp 'Y'
        jr z,ay_y
        cp 'N'
        jr nz,ay_l
ay_n:   call draw_all
        or 1
        ret
ay_y:   call draw_all
        xor a
        ret

; HL = prompt. Edita INBUF (ate 12 caracteres, maiusculas).
; Retorna C=1 se cancelado (ESC).
input_line:
        ld (ILPROMPT),hl
        xor a
        ld (INLEN),a
        ld (INBUF),a
il_draw:
        call modal_box
        ld hl,(ILPROMPT)
        call vputs
        ld hl,INBUF
        call vputs
        ld a,'_'
        call vputc
        ld d,12
        ld e,4
        call gotoxy
        ld hl,s_edit
        call vputs
        call wait_key
        cp K_ENTER
        jr z,il_ok
        cp K_ESC
        jr z,il_esc
        cp K_BS
        jr z,il_bs
        cp 7Fh
        jr z,il_bs
        cp 32
        jr c,il_draw
        cp 127
        jr nc,il_draw
        ld b,a
        ld a,(INLEN)
        cp 12
        jr nc,il_draw
        ld a,b
        cp 'a'
        jr c,il_st
        cp 'z'+1
        jr nc,il_st
        sub 20h
il_st:  ld c,a
        ld a,(INLEN)
        ld e,a
        ld d,0
        ld hl,INBUF
        add hl,de
        ld (hl),c
        inc hl
        ld (hl),0
        inc a
        ld (INLEN),a
        jr il_draw
il_bs:  ld a,(INLEN)
        or a
        jr z,il_draw
        dec a
        ld (INLEN),a
        ld e,a
        ld d,0
        ld hl,INBUF
        add hl,de
        ld (hl),0
        jr il_draw
il_ok:  call draw_all
        or a
        ret
il_esc: call draw_all
        scf
        ret
