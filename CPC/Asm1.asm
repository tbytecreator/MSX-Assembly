; =======================================================================
; Primeiros passos no ASM - Amstrad CPC
; =======================================================================
CLS		equ &BC14	; Limpa tela
CHPUT	equ &BB5A	; Escreve caractere na tela

org &8000
	ld hl, Message
  	call PrintString
  	call NewLine
 
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
	ld a, 13
	call CHPUT
	ld a, 10
	call CHPUT
ret

Message:
  db "Ola Mundo!",13