; =============================================================================
; VAR.ASM
; =============================================================================
; Manoel Neto 2019-09-25
; Variaveis utilizadas no PROGRAMA
; =============================================================================
VDPDATA     equ ramArea     ; Endereco do registrador de dados do VDP
VDPCONTROL  equ ramArea+1	; Endereco do registrador de controle do VDP
NumCentenas equ ramArea+2   ; Usada em ImprimirNumero
NumDezenas  equ ramArea+3   ; Usada em ImprimirNumero
NumUnidades equ ramArea+4   ; Usada em ImprimirNumero
; =============================================================================