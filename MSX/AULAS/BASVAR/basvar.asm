; =====================================
; VARIABLE TYPE
; =====================================
VALTYP:		equ 0xF663
CHPUT:		equ 0x00A2

org 0xD000
    db 0xFE	
    dw STARTCODE
    dw ENDCODE
    dw STARTCODE
STARTCODE:
	ld a,(VALTYP)
	cp 2
	jp z,ParamInteiro
	cp 3	
	jp z,ParamString
	cp 4
	jp z,ParamSimples
	cp 8 
	jp z,ParamDupla
	jp ParamDesconhecido
ParamInteiro:
	ld hl,Msg1
	call PrintString
	jp EndProgram
ParamString:
	ld hl,Msg2
	call PrintString
	jp EndProgram
ParamSimples:
	ld hl,Msg3
	call PrintString
	jp EndProgram	
ParamDupla:
	ld hl,Msg4
	call PrintString
	jp EndProgram
ParamDesconhecido:	
	ld hl,Msg5
	call PrintString
EndProgram:
ret

PrintString:
    ld a,(hl)
    cp 13
    jp z,EndString
    call CHPUT
    inc hl
    jp PrintString
EndString:
ret
; =====================================
; END OF PROGRAM
; =====================================
Msg1:
  	db "Pametro inteiro",13
Msg2:
	db "Pametro string",13
Msg3:
	db "Precisao simples",13
Msg4:
	db "Precisao dupla",13
Msg5:
	db "Parametro Desconhecido",13
ENDCODE: