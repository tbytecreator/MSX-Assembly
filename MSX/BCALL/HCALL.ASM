; ------------------------------------
; Exemplo de CALL 
; ------------------------------------ 
org &4000
 
    CHPUT   EQU #A2
    CALBAS	EQU	#159
    ERRHAND EQU #406F
    FRMEVL  EQU #4C64
    FRESTR	EQU	#67D0
    CHRGTR  EQU #4666
    VALTYP  EQU #F663
    USR     EQU #F7F8
    PROCNM	EQU	#FD89
  
    defw #4241,0,CALLHAND,0,0,0,0,0
; ------------------------------------ 
; CALL-instruction handler
; ------------------------------------ 
CALLHAND:
    push hl
	ld hl,CMDS	        
.CHKCMD:
	ld	de,PROCNM
.LOOP:	
    ld	a,(de)
	cp	(hl)
	jr	NZ,.TONEXTCMD
	inc	de
	inc	hl
	and	a
	jr	NZ,.LOOP	
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	pop	hl		
	CALL GETPREVCHAR
	CALL .CALLDE		
	and	a
	ret
.TONEXTCMD:
	ld	c,0FFH
	xor	a
	cpir
	inc	hl
	inc	hl		
	cp (hl)
	jr	NZ,.CHKCMD	
	pop	hl
    scf
	ret
.CALLDE:
	push de
	ret
CMDS:
; ------------------------------------ 
; Lista das instrucoes (ASCII) 
; e endereco de execucao (word)
; ------------------------------------
    DEFB	"PRINTMSG",0      
	DEFW	_PRINTMSG
	DEFB	0               
; ------------------------------------
; FUNCAO PRINTMSG
; ------------------------------------
_PRINTMSG:

ret
	
GETSTRPNT:
; OUT:
; HL = String Address
; B  = Lenght
    LD      HL,(#F7F8)
    LD      B,(HL)
    INC     HL
    LD      E,(HL)
    INC     HL
    LD      D,(HL)
    EX      DE,HL
    RET
EVALTXTPARAM:
	CALL	CHKCHAR
	DEFB	"("             ; Check for (
	LD	IX,FRMEVL
	CALL	CALBAS		; Evaluate expression
        LD      A,(VALTYP)
        CP      3               ; Text type?
        JP      NZ,TYPE_MISMATCH
        PUSH	HL
        LD	IX,FRESTR         ; Free the temporary string
        CALL	CALBAS
        POP	HL
	CALL	CHKCHAR
	DEFB	")"             ; Check for )
    RET
CHKCHAR:
	CALL	GETPREVCHAR	; Get previous basic char
	EX	(SP),HL
	CP	(HL) 	        ; Check if good char
	JR	NZ,SYNTAX_ERROR	; No, Syntax error
	INC	HL
	EX	(SP),HL
	INC	HL		; Get next basic char
GETPREVCHAR:
	DEC	HL
	LD IX,CHRGTR
	JP CALBAS
TYPE_MISMATCH:
    LD E,13
    DB 1
SYNTAX_ERROR:
    LD E,2
	LD IX,ERRHAND	; Call the Basic error handler
	JP CALBAS
 ;---------------------------
 DS      #8000-$