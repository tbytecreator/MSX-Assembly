; ===========================================================================
; DIR.INC - Leitura e ordenacao de diretorios (MSX-DOS 1, sem subdiretorios)
; ===========================================================================

; IX = painel. Le o diretorio da unidade do painel e zera o cursor.
read_dir:
        xor a
        ld (ix+P_CNT),a
        ld (ix+P_CUR),a
        ld (ix+P_TOP),a
        ld (ix+P_FREE),a
        ld (ix+P_FREE+1),a
        ld hl,FCB1
        ld (hl),0
        ld de,FCB1+1
        ld bc,FCB_LEN-1
        ldir
        ld a,(ix+P_DRV)
        ld (FCB1),a
        ld hl,FCB1+1
        ld de,FCB1+2
        ld (hl),'?'
        ld bc,10
        ldir
        ld de,DMA
        ld c,F_SETDMA
        call bdos
        ld de,FCB1
        ld c,F_SFIRST
rd_l:   call bdos
        inc a
        jr z,rd_done
        call add_entry
        jr c,rd_done
        ld de,FCB1
        ld c,F_SNEXT
        jr rd_l
rd_done:
        call sort_entries
        ; espaco livre: clusters livres * setores por cluster / 2 (setor de 512 bytes)
        ld a,(ix+P_DRV)
        ld e,a
        ld c,F_ALLOC
        call bdos
        ld b,a
        srl b
        jr z,fr_half
        ld d,h
        ld e,l
        ld hl,0
fr_m:   add hl,de
        djnz fr_m
        jr fr_st
fr_half:
        srl h
        rr l
fr_st:  ld (ix+P_FREE),l
        ld (ix+P_FREE+1),h
        ret

; Copia a entrada encontrada (em DMA) para a tabela do painel IX.
; Retorna C=1 se a tabela esta cheia.
add_entry:
        ; MSX-DOS 1: DMA = byte 0 extra + entrada de diretorio (nome em +1, tamanho em +29..32)
        ld hl,DMA
        push hl
        ld a,(ix+P_CNT)
        cp MAXENT
        ccf
        jr nc,ae_ok
        pop hl
        ret
ae_ok:  call entry_addr
        ex de,hl
        pop hl
        push hl
        inc hl
        ld bc,11
        ldir
        pop hl
        ld bc,29
        add hl,bc
        ld bc,4
        ldir
        inc (ix+P_CNT)
        or a
        ret

; Ordena as entradas do painel IX por nome (insercao)
sort_entries:
        ld a,(ix+P_CNT)
        cp 2
        ret c
        ld a,1
        ld (SO_I),a
so_loop:
        ld a,(SO_I)
        call entry_addr
        ld de,TMPENT
        ld bc,ENT_SZ
        ldir
        ld a,(SO_I)
        ld (SO_J),a
so_inner:
        ld a,(SO_J)
        or a
        jr z,so_place
        dec a
        call entry_addr
        ld de,TMPENT
        call cmp11
        jr c,so_place
        jr z,so_place
        ld a,(SO_J)             ; cmp11 avancou HL: recalcula a origem
        dec a
        call entry_addr
        push hl
        ld a,(SO_J)
        call entry_addr
        ex de,hl
        pop hl
        ld bc,ENT_SZ
        ldir
        ld hl,SO_J
        dec (hl)
        jr so_inner
so_place:
        ld a,(SO_J)
        call entry_addr
        ex de,hl
        ld hl,TMPENT
        ld bc,ENT_SZ
        ldir
        ld hl,SO_I
        inc (hl)
        ld a,(hl)
        cp (ix+P_CNT)
        jr c,so_loop
        ret

; Compara 11 bytes (HL) com (DE). C se (HL)<(DE), Z se iguais.
cmp11:
        ld b,11
cm1:    ld a,(de)
        ld c,a
        ld a,(hl)
        cp c
        ret nz
        inc hl
        inc de
        djnz cm1
        ret

; IX = painel. Rele o diretorio mantendo (se possivel) cursor e rolagem.
reload_panel:
        ld b,(ix+P_CUR)
        ld c,(ix+P_TOP)
        push bc
        call read_dir
        pop bc
        ld a,(ix+P_CNT)
        or a
        ret z
        dec a
        cp b
        jr nc,rl1
        ld b,a
rl1:    ld (ix+P_CUR),b
        ld (ix+P_TOP),c
        jp scroll_fix

; Rele os dois paineis e redesenha a tela
reload_all:
        ld ix,PAN0
        call reload_panel
        ld ix,PAN1
        call reload_panel
        jp draw_all

; 1: avanca o painel ativo para a proxima unidade disponivel
op_drive:
        ld ix,(ACTIVE)
        ld c,F_LOGIN
        call bdos
        ld e,l
        ld d,(ix+P_DRV)
        ld b,8
od_l:   inc d
        ld a,d
        cp 9
        jr c,od1
        ld d,1
od1:    ld c,d
        ld a,e
od_s:   rrca
        dec c
        jr nz,od_s
        jr c,od_found
        djnz od_l
        ret
od_found:
        ld (ix+P_DRV),d
        call read_dir
        jp draw_panel
