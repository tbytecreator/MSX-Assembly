; =============================================================================
; RAM.ASM
; =============================================================================
; Manoel Neto 2024-03-23
; RAM MEMORY MAP
; =============================================================================
ramArea             equ &E000       ; RAM STARTING ADDRESS
Hundreds            equ ramArea     ; USED IN PRINTDECIMAL
Tens                equ ramArea+1   ; USED IN PRINTDECIMAL
Units               equ ramArea+2   ; USED IN PRINTDECIMAL
; =============================================================================