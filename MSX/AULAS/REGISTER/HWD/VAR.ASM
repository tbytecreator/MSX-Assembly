; =============================================================================
; VAR.ASM
; =============================================================================
; Manoel Neto 2019-09-25
; Variaveis utilizadas no PROGRAMA
; =============================================================================
NumDezMilhares  	equ ramArea     ; Variavel => Usada em PrintNumber E000
NumMilhares  		equ ramArea+1     ; Variavel => Usada em PrintNumber E000
NumCentenas  		equ ramArea+2   ; Variavel => Usada em PrintNumber E000
NumDezenas  		equ ramArea+3   ; Variavel => Usada em PrintNumber E001
NumUnidades  		equ ramArea+4   ; Variavel => Usada em PrintNumber E002
NumBuffer    		equ ramArea+5   ; Variavel => Usada em PrintNumber E003
; =============================================================================