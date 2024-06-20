; =====================================
; VAR.ASM
; =====================================
; Manoel Neto 2019-09-25
; RAM VARIABLES
; =====================================
VRAMDTRD            equ ramArea	        ; VRAM datum read
VRAMDTWR 		    equ ramArea+1       ; VRAM datum write
VDPCMD 		        equ ramArea+2       ; VDP Command
PALETTEREG 		    equ ramArea+3       ; Palette registers access
SEQREGACC   		equ ramArea+4       ; Sequential registers access
; =====================================