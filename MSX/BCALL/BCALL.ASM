; =====================================
; EXEMPLO DE COMANDO EXTENDIDO
; =====================================

org 0x4000-7
	db 0xfe	
 	dw STARTCODE
 	dW ENDCODE
 	dW STARTCODE

STARTCODE:

    CSRY    equ 0xF3DC
    EXPTBL  equ 0xFCC1
    PROCNM  equ 0xFD89
    FILVRM	equ 0x0056

    ; standar ROM header with STATEMENT call defined
    db 0x41,0x42
    dw 0
    dw STATEMENT
    dw 0
    dw 0
    ds 6

STATEMENT:	
        push hl 
		ld ix,CMDTAB
		ld bc,4
STLOOP:	
        ld l,(ix+0) 
		ld a,(ix+1)
		or a
		jp z,SYNTAXERR 
		ld h,a
		ld de,PROCNM
		call MEMCMP 
		jr nz,NOMATCH
		pop hl 
		ld e,(ix+2)
		ld d,(ix+3)
		push de
		pop ix 
		jp (ix) 
NOMATCH:	
        add ix,bc 
		jr STLOOP
SYNTAXERR:	
        pop hl 
		xor a
		ccf  
		ret
MEMCMP:	
        ld a,(de) 
		cp (hl)
		ret nz
		or a
		inc hl
		inc de
		jr nz,MEMCMP
		ret

; Aqui comeca a implementação dos comandos 
; DE=enderco do texto proximo ao nome do comando

; Comando 1: preenche a screen 0 com um caracter
CMD1CODE:
		push hl  
		ld a,(hl)
		cp 0x28
		jp nz,SYNTAXERR
		inc hl
		ld a,(hl)
		cp 0x22
		jp nz,SYNTAXERR
		inc hl
		ld b,(hl)
		inc hl
		ld a,(hl)
		cp 0x22
		jp nz,SYNTAXERR
		inc hl
		ld a,(hl)
		cp 0x29
        jp nz,SYNTAXERR
LOOP3:		
        inc hl
		ld a,(hl)
		cp 0x20
		jr z,LOOP3
		or a 
		jr z,DOCMD1
		cp 0x3A 
		jp nz,SYNTAXERR
DOCMD1:
		push hl
		ld hl,0
		ld a,b
		ld bc,0x800
		call FILVRM
		pop hl
		pop bc
		xor a  
		ret

; Tabela dos comandos 
CMDTAB: 
    dw CMD1,CMD1CODE
    dw 0 
CMD1: 
    db "PREENCHE",0
DUMMY1: 
    ds 7989
DUMMY2: 
    db 0
ENDCODE: