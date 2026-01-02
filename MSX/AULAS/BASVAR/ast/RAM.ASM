; =============================================================================
; RAM.ASM
; =============================================================================
; Manoel Neto 2024-03-23
; RAM MEMORY MAP
; =============================================================================
ramArea     equ &E000       ; RAM STARTING ADDRESS
Hundreds    equ ramArea+1   ; USED IN PRINT DECIMAL ROUTINE
Tens        equ ramArea+2   ; USED IN PRINT DECIMAL ROUTINE
Units       equ ramArea+3   ; USED IN PRINT DECIMAL ROUTINE
; =============================================================================