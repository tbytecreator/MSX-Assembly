; =======================================================================
; Meu primeiro Programa Assembly
; Manoel Neto 2023-06-2023
; =======================================================================
org &4000
db "AB"
dw ProgramStart
db 00,00,00,00,00

CLS:		equ 0x00C3	; Limpa tela
INIT32:		equ 0x006F  ; Inicializa tela em modo texto
CHPUT:		equ 0x00A2	; Escreve caractere na tela

ProgramStart:
	push af
		xor a
		call CLS
	pop af
  	call INIT32
  	ld hl, Message
  	call PrintString
  	call NewLine
  	DI
  	Halt

PrintString:
	ld a,(hl)
	cp 13
	jp z,EndString
	call CHPUT
	inc hl
	jp PrintString
EndString:
ret

NewLine:
	push af
		ld a, 13
		call CHPUT
		ld a, 10
		call CHPUT
	pop af
ret

Message:
  db "Ola Mundo!",13

org &C000 ; PAD para 32K
