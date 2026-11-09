; ===========================================================================
; OPS.INC - Operacoes de arquivo: copiar, renomear, apagar, visualizar
; ===========================================================================

; Monta um FCB. DE = FCB, A = unidade (1=A:), HL = nome (11 bytes)
fcb_set:
        push hl
        push de
        push af
        ld h,d
        ld l,e
        ld (hl),0
        inc de
        ld bc,FCB_LEN-1
        ldir
        pop af
        pop de
        pop hl
        ld (de),a
        inc de
        ld bc,11
        ldir
        ret

; Converte texto "NOME.EXT" (HL, terminado em 0) em 11 bytes (DE) preenchidos com espacos
parse_name:
        ld (PN_DST),de
        ld b,11
        ld a,' '
pn0:    ld (de),a
        inc de
        djnz pn0
        ld de,(PN_DST)
        ld b,8
pn1:    ld a,(hl)
        or a
        ret z
        inc hl
        cp '.'
        jr z,pn2
        ld (de),a
        inc de
        djnz pn1
pn1s:   ld a,(hl)
        or a
        ret z
        inc hl
        cp '.'
        jr nz,pn1s
pn2:    ld de,(PN_DST)
        ex de,hl
        ld bc,8
        add hl,bc
        ex de,hl
        ld b,3
pn3:    ld a,(hl)
        or a
        ret z
        ld (de),a
        inc hl
        inc de
        djnz pn3
        ret

; A = unidade do painel que NAO esta ativo
other_drive:
        ld hl,(ACTIVE)
        ld de,PAN0
        or a
        sbc hl,de
        ld a,(PAN1+P_DRV)
        ret z
        ld a,(PAN0+P_DRV)
        ret

; --- 5: apagar -------------------------------------------------------------
op_delete:
        ld ix,(ACTIVE)
        ld a,(ix+P_CNT)
        or a
        ret z
        ld hl,s_del
        call ask_yn
        ret nz
        ld ix,(ACTIVE)
        call cur_entry
        ld a,(ix+P_DRV)
        ld de,FCB1
        call fcb_set
        ld de,FCB1
        ld c,F_DELETE
        call bdos
        inc a
        jr nz,od_ok
        ld hl,s_edel
        call show_msg
od_ok:  jp reload_all

; --- 4: renomear -----------------------------------------------------------
op_rename:
        ld ix,(ACTIVE)
        ld a,(ix+P_CNT)
        or a
        ret z
        ld hl,s_ren
        call input_line
        ret c
        ld a,(INBUF)
        or a
        ret z
        ld hl,INBUF
        ld de,NEWNAME
        call parse_name
        ld ix,(ACTIVE)
        call cur_entry
        ld a,(ix+P_DRV)
        ld de,FCB1
        call fcb_set
        ld hl,NEWNAME
        ld de,FCB1+17
        ld bc,11
        ldir
        ld de,FCB1
        ld c,F_RENAME
        call bdos
        inc a
        jr nz,or_ok
        ld hl,s_eren
        call show_msg
or_ok:  jp reload_all

; --- 3: copiar para a unidade do outro painel ------------------------------
op_copy:
        ld ix,(ACTIVE)
        ld a,(ix+P_CNT)
        or a
        ret z
        ld a,(ix+P_DRV)
        ld (CP_SRC),a
        call other_drive
        ld (CP_DST),a
        ld b,a
        ld a,(CP_SRC)
        cp b
        jr nz,cp_go
        ld hl,s_same
        jp show_msg
cp_go:  ld hl,s_copy
        call ask_yn
        ret nz
        ld ix,(ACTIVE)
        call cur_entry
        ld de,CPNAME
        ld bc,11
        ldir
        ld a,(CP_DST)
        ld hl,CPNAME
        ld de,FCB2
        call fcb_set
        ld de,FCB2
        ld c,F_OPEN
        call bdos
        inc a
        jr z,cp_new
        ld de,FCB2
        ld c,F_CLOSE
        call bdos
        ld hl,s_over
        call ask_yn
        ret nz
        ld a,(CP_DST)
        ld hl,CPNAME
        ld de,FCB2
        call fcb_set
        ld de,FCB2
        ld c,F_DELETE
        call bdos
cp_new: ld a,(CP_DST)
        ld hl,CPNAME
        ld de,FCB2
        call fcb_set
        ld a,(CP_SRC)
        ld hl,CPNAME
        ld de,FCB1
        call fcb_set
        ld de,FCB1
        ld c,F_OPEN
        call bdos
        inc a
        jr nz,cp_o1
        ld hl,s_eopen
        jp show_msg
cp_o1:  ld de,FCB2
        ld c,F_MAKE
        call bdos
        inc a
        jr nz,cp_o2
        ld de,FCB1
        ld c,F_CLOSE
        call bdos
        ld hl,s_emake
        jp show_msg
cp_o2:  ld hl,1
        ld (FCB1+FCB_REC),hl
        ld (FCB2+FCB_REC),hl
        ld hl,0
        ld (CP_POS),hl
        ld (CP_POS+2),hl
cp_lp:  ld de,COPYBUF
        ld c,F_SETDMA
        call bdos
        call set_rnd
        ld de,FCB1
        ld hl,COPYSZ
        ld c,F_RDBLK
        call bdos
        ld a,h
        or l
        jr z,cp_end
        ld (CP_N),hl
        ld de,FCB2
        ld c,F_WRBLK
        call bdos
        or a
        jr nz,cp_full
        ld hl,(CP_N)
        ld de,(CP_POS)
        add hl,de
        ld (CP_POS),hl
        jr nc,cp_nc
        ld hl,(CP_POS+2)
        inc hl
        ld (CP_POS+2),hl
cp_nc:  ld hl,(CP_N)
        ld de,COPYSZ
        or a
        sbc hl,de
        jr z,cp_lp
cp_end: call cp_close
        jp reload_all
cp_full:
        call cp_close
        ld de,FCB2
        ld c,F_DELETE
        call bdos
        ld hl,s_full
        call show_msg
        jp reload_all

cp_close:
        ld de,FCB1
        ld c,F_CLOSE
        call bdos
        ld de,FCB2
        ld c,F_CLOSE
        jp bdos

set_rnd:
        ld hl,(CP_POS)
        ld (FCB1+FCB_RND),hl
        ld (FCB2+FCB_RND),hl
        ld hl,(CP_POS+2)
        ld (FCB1+FCB_RND+2),hl
        ld (FCB2+FCB_RND+2),hl
        ret

; --- 2: visualizar (texto bruto, 920 bytes por pagina) ---------------------
op_view:
        ld ix,(ACTIVE)
        ld a,(ix+P_CNT)
        or a
        ret z
        call cur_entry
        ld a,(ix+P_DRV)
        ld de,FCB1
        call fcb_set
        ld de,FCB1
        ld c,F_OPEN
        call bdos
        inc a
        jr nz,vw_ok
        ld hl,s_eopen
        jp show_msg
vw_ok:  ld hl,1
        ld (FCB1+FCB_REC),hl
        ld hl,0
        ld (VWPOS),hl
        ld (VWPOS+2),hl
vw_page:
        ld de,COPYBUF
        ld c,F_SETDMA
        call bdos
        ld hl,(VWPOS)
        ld (FCB1+FCB_RND),hl
        ld hl,(VWPOS+2)
        ld (FCB1+FCB_RND+2),hl
        ld de,FCB1
        ld hl,VWSZ
        ld c,F_RDBLK
        call bdos
        ld (VWN),hl
        xor a
        ld (INV),a
        ld d,0
        ld e,0
        call gotoxy
        ld bc,(VWN)
        ld hl,COPYBUF
        ld de,VWSZ
vw_pr:  ld a,d
        or e
        jr z,vw_pd
        ld a,b
        or c
        jr z,vw_blank
        ld a,(hl)
        inc hl
        dec bc
        cp 32
        jr c,vw_dot
        cp 127
        jr c,vw_ch
vw_dot: ld a,'.'
vw_ch:  call vputc
        dec de
        jr vw_pr
vw_blank:
        ld a,' '
        call vputc
        dec de
        jr vw_pr
vw_pd:  call msg_line
        ld hl,s_vwbar
        call vputs
        xor a
        ld (INV),a
vw_key: call wait_key
        cp K_ESC
        jr z,vw_exit
        cp '2'
        jr z,vw_exit
        and 0DFh
        cp 'Q'
        jr z,vw_exit
        cp ' '
        jr z,vw_next
        cp K_DOWN
        jr z,vw_next
        cp K_BS
        jr z,vw_prev
        cp K_UP
        jr z,vw_prev
        jr vw_key
vw_next:
        ld hl,(VWN)
        ld de,VWSZ
        or a
        sbc hl,de
        jr nz,vw_key
        ld hl,(VWPOS)
        add hl,de
        ld (VWPOS),hl
        jp nc,vw_page
        ld hl,(VWPOS+2)
        inc hl
        ld (VWPOS+2),hl
        jp vw_page
vw_prev:
        ld hl,(VWPOS+2)
        ld a,h
        or l
        jr nz,vp_sub
        ld hl,(VWPOS)
        ld de,VWSZ
        or a
        sbc hl,de
        jr nc,vp_set
        ld hl,0
vp_set: ld (VWPOS),hl
        jp vw_page
vp_sub: ld hl,(VWPOS)
        ld de,VWSZ
        or a
        sbc hl,de
        ld (VWPOS),hl
        jp nc,vw_page
        ld hl,(VWPOS+2)
        dec hl
        ld (VWPOS+2),hl
        jp vw_page
vw_exit:
        ld de,FCB1
        ld c,F_CLOSE
        call bdos
        jp draw_all
