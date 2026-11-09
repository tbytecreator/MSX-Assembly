; ===========================================================================
; TBC - Tbyte Commander para MSX 1 (MSX-DOS 1)
; Clone de gerenciador de arquivos em dois paineis (estilo Norton Commander)
;
; Compilar:  pasmo -I SRC SRC/TBC.ASM .dist/TBC.COM
; Executar:  no MSX-DOS 1, digite TBC
; ===========================================================================

        org 0100h

        include "DEFS.INC"

start:
        ld hl,(0006h)                   ; topo da TPA
        ld de,RAM_END
        or a
        sbc hl,de
        jr nc,mem_ok
        ld de,s_nomem
        ld c,F_PRSTR
        call BDOSV
        jp 0
mem_ok:
        ; zera a area de variaveis e tabelas
        ld hl,PAN0
        ld de,PAN0+1
        ld bc,ENT0-PAN0-1
        ld (hl),0
        ldir

        ; modo texto 40 colunas, branco sobre azul escuro
        ld a,(CNSDFG)
        ld (CNSDSAVE),a
        ld a,40
        ld (LINL40),a
        ld a,15
        ld (FORCLR),a
        ld a,4
        ld (BAKCLR),a
        ld (BDRCLR),a
        ld ix,INITXT
        call bios
        xor a
        ld (CNSDFG),a
        call load_font
        call cls

        ; F1-F5 passam a gerar '1'..'5'
        ld hl,FNKSTR
        ld de,FNKSAVE
        ld bc,160
        ldir
        ld hl,FNKSTR+9*16       ; Shift+F5 = Quit
        ld (hl),K_QUIT
        inc hl
        ld (hl),0
        ld hl,FNKSTR
        ld b,5
        ld a,'1'
fk_l:   ld (hl),a
        inc hl
        ld (hl),0
        ld de,15
        add hl,de
        inc a
        djnz fk_l

        ; paineis
        ld c,F_CURDRV
        call bdos
        inc a
        ld (PAN0+P_DRV),a
        ld (PAN1+P_DRV),a
        ld a,20
        ld (PAN1+P_X),a
        ld hl,ENT0
        ld (PAN0+P_ENT),hl
        ld hl,ENT1
        ld (PAN1+P_ENT),hl
        ld hl,PAN0
        ld (ACTIVE),hl

        ld ix,PAN0
        call read_dir
        ld ix,PAN1
        call read_dir
        call draw_all

; --- Laco principal --------------------------------------------------------
main_loop:
        call wait_key
        cp K_UP
        jr z,key_up
        cp K_DOWN
        jr z,key_down
        cp K_HOME
        jr z,key_home
        cp K_CLS
        jr z,key_end
        cp K_TAB
        jr z,key_tab
        cp K_LEFT
        jr z,key_tab
        cp K_RIGHT
        jr z,key_tab
        cp '1'
        jr z,key_f1
        cp '2'
        jr z,key_f3
        cp '3'
        jr z,key_f5
        cp '4'
        jr z,key_f6
        cp '5'
        jr z,key_f8
        cp K_QUIT
        jr z,quit
        jr main_loop

key_up:
        ld ix,(ACTIVE)
        ld a,(ix+P_CUR)
        or a
        jr z,main_loop
        dec a
        jr set_cur
key_down:
        ld ix,(ACTIVE)
        ld a,(ix+P_CUR)
        inc a
        cp (ix+P_CNT)
        jr nc,main_loop
        jr set_cur
key_home:
        ld ix,(ACTIVE)
        xor a
        jr set_cur
key_end:
        ld ix,(ACTIVE)
        ld a,(ix+P_CNT)
        or a
        jr z,main_loop
        dec a
set_cur:
        ld (ix+P_CUR),a
        call scroll_fix
        call draw_rows
        jr main_loop

key_tab:
        ld hl,(ACTIVE)
        ld de,PAN0
        or a
        sbc hl,de
        ld hl,PAN1
        jr z,kt1
        ld hl,PAN0
kt1:    ld (ACTIVE),hl
        call draw_all
        jp main_loop

key_f1: call op_drive
        jp main_loop
key_f3: call op_view
        jp main_loop
key_f5: call op_copy
        jp main_loop
key_f6: call op_rename
        jp main_loop
key_f8: call op_delete
        jp main_loop

; --- Saida: restaura a linha de teclas de funcao e limpa a tela --------------
quit:
        ld hl,FNKSAVE
        ld de,FNKSTR
        ld bc,160
        ldir
        ld a,(CNSDSAVE)
        ld (CNSDFG),a
        or a
        jr z,q1
        ld ix,DSPFNK
        call bios
q1:     ld e,0Ch                        ; CLS
        ld c,02h
        call BDOSV
        jp 0

        include "VIDEO.INC"
        include "UI.INC"
        include "DIR.INC"
        include "OPS.INC"
        include "DATA.INC"

        end start
