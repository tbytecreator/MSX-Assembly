; =====================================
; BASIC variables
; =====================================
org 0xC000
    db 0xFE	
    dw STARTCODE
    dw ENDCODE
    dw STARTCODE
STARTCODE:
	LD HL,(0XF7F8)
	LD A,(HL)		
	LD (0XF7F8),A
	INC HL
	LD A,(HL)		
	LD (0XF7F9),A
ret
; =====================================
; END OF PROGRAM
; =====================================
ENDCODE: