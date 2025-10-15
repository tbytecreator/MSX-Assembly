; =====================================
; VARIABLE TYPE
; =====================================
VALTYP:		equ 0xF663
CHPUT:		equ 0x00A2
NBYTES:		equ 0XF7F8
ENDSTR: 	equ 0xF7F9

org 0xD000
    db 0xFE	
    dw STARTCODE
    dw ENDCODE
    dw STARTCODE
STARTCODE:
	ld a,(VALTYP)		;pega o tipo passado pelo basic
	ld d,a				;guarda o valor
	ld a,3				;o retorno da nossa funcao e string
	ld (VALTYP),a		;informa o retorno da nossa funcao
	ld a,d				;resgata o parametro passado pelo basic
	cp 2				;se for 2 eh inteiro
	jp z,ParamInteiro
	cp 3				;se for 3 eh string
	jp z,ParamString
	cp 4				;se for 4 eh precisao simples
	jp z,ParamSimples	
	cp 8 				;se for 8 eh precisao dupla
	jp z,ParamDupla
	jp ParamDesconhecido
ParamInteiro: 
	ld a,17 			;a string da mensagem 1 tem 17 bytes
	ld (NBYTES),a
	ld hl,Msg1
	ld a,l
	ld (ENDSTR),a
	ld a,h
	ld (ENDSTR+1),a	
	jp EndProgram
ParamString:
	ld a,14
	ld (NBYTES),a 
	ld hl,Msg2
	ld a,l
	ld (ENDSTR),a
	ld a,h
	ld (ENDSTR+1),a	
	jp EndProgram
ParamSimples:
	ld a,16
	ld (NBYTES),a
	ld hl,Msg3
	ld a,l
	ld (ENDSTR),a
	ld a,h
	ld (ENDSTR+1),a	
	jp EndProgram	
ParamDupla:
	ld a,16 
	ld (NBYTES), a
	ld hl,Msg4
	ld a,l
	ld (ENDSTR),a
	ld a,h
	ld (ENDSTR+1),a	
	jp EndProgram
ParamDesconhecido:	
	ld a,22
	ld (NBYTES),a
	ld hl,Msg5
	ld a,l
	ld (ENDSTR),a
	ld a,h
	ld (ENDSTR+1),a	
EndProgram:
ret

; =====================================
; END OF PROGRAM
; =====================================
Msg1:
  	db "Parametro inteiro",13
Msg2:
	db "Pametro string",13
Msg3:
	db "Precisao simples",13
Msg4:
	db "Precisao dupla",13
Msg5:
	db "Parametro Desconhecido",13
ENDCODE: