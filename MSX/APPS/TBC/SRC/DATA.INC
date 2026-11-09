; ===========================================================================
; DATA.INC - Textos da interface
; ===========================================================================

s_nomem:    defb "Not enough memory.",13,10,"$"
s_files:    defb " files ",0
s_yn:       defb " (Y/N)",0
s_press:    defb "Press any key",0
s_edit:     defb "ENTER: OK   ESC: cancel",0
s_del:      defb "Delete selected file?",0
s_copy:     defb "Copy to other panel drive?",0
s_over:     defb "File exists. Overwrite?",0
s_ren:      defb "New name: ",0
s_same:     defb "Both panels use the same drive.",0
s_edel:     defb "Delete failed.",0
s_eren:     defb "Rename failed.",0
s_eopen:    defb "Cannot open file.",0
s_emake:    defb "Cannot create file.",0
s_full:     defb "Disk full. Copy aborted.",0
s_vwbar:    defb "SPACE/BS: page   ESC: close",0

; Barra de teclas: pares (numero, rotulo), terminada por 0FFh
keybar:     defb "1",0,"Drv",0
            defb "2",0,"View",0
            defb "3",0,"Copy",0
            defb "4",0,"Ren",0
            defb "5",0,"Del",0
            defb "S5",0,"Quit",0
            defb 0FFh
