; ====================================
; INVERTE COR DO TEXTO
; ====================================
; Manoel Neto 2024-06-20
; ====================================
__VERSION:  equ 1
__RELEASE:  equ 0
include "BIOS.ASM"

; ====================================
; CABECALHO DE UM ARQUIVO BINARIO
; ====================================
; Byte: #FE (Type of file)
; Word: Begin address of file
; Word: End address of file
; Word: Start address of file
; ====================================

org 0xD000
	db 0XFE	
 	dw STARTCODE
 	dW ENDCODE
 	dW STARTCODE
; ====================================
; startCode
; ====================================
STARTCODE:
	ld a,(VALTYP) 	; é string?
	cp 3			; se não for
	ret nz			; retorna
	ld ix,(ARGUSR)	; pega o argumento do basic
	ld hl,(TXTCGP)	; tabela de padroes de caracter
	ld a,(MSXVER)
	; versao do msx
	or a			; se for 0
	jp z,MSX1		; vai para a versao 1
	ld a,(LINLEN)	; pega o tamanho da linha
	cp 41			; se nao for 40 colunas
	jr c,MSX1		; vai para a versao 1
	add hl,hl		; calcula para msx 2
MSX1:
	di 				; desabilita interrupcoes
	push hl 		; salva o ponteiro
	ld de,0xE0*8	; endereco caracter E0
	add hl,de		; aponta para o caracter
	ex de,hl		; troca de por hl
	ld c,0xE0		; caracter E0
	ld b,(ix+0)		; num de caracteres da string
	ld l,(ix+1)		; endereco da string
	ld h,(ix+2)		; endereco da string
	push hl			; salva o endereco da string
	pop ix 			; coloca o endereco da string em ix
	pop hl			; recupera o ponteiro
loop1:
	push bc			; salva BC
	push hl			; salva HL
	push de			; salva DE
	ld de,8			; cada carater tem 8 bytes
	ld b,(ix+0)		; caracter para inverter
loop2:
	add hl,de		; calcula o endereço do caracter
	djnz loop2      ; loop para pegar os 8 bytes 
	pop de			; recupera DE
	ld b,8			; prepara para inverter os 8 bytes
loop3:
	call RDVRAM		; le o byte
	cpl				; inverte o byte
	ex de,hl	    ; novo endereço
	call WTVRAM		; escreve o byte
	ex de,hl		; volta o endereço
	inc hl			; proximo byte
	inc de			; proximo byte
	djnz loop3		; contador de loops -1
	pop hl			; recupere HL
	pop bc			; recupere BC
	ld (ix+0),c		; modifica a string
	inc c			; proximo caracter
	inc ix			; proximo caracter
	djnz loop1		; fim do loop da string
	ei				; reabilita as interrupcoes
	ret				; volta para o BASIC 
RDVRAM:
	ld a,(MSXVER)	; versao do msx
	or a			; é msx 1 ? (0)
	jr z,RDVRAM1	; se é vai para a versao 1
	xor a			; senao inicializa o vdp msx2
	out (0x99),a
	ld a,0x8E
	out (0x99),a
RDVRAM1:
	ld a,l			; informa ao vdp o endereço
	out (0x99),a	; o endereço de leitura do dado
	ld a,h
	and 0x3F
	out (0x99),a
	ex (sp),hl		; fazemos duas vezes porque o 
	ex (sp),hl		; vdp demora a sincronizar
	in a,(0x98)		; le o dado da VRAM 
	ret
WTVRAM:
	push af			; salva o dado que vamos gravar
	ld a,(MSXVER)	; versao do msx
	or a 			; é msx 1 ? (0)
	jr z,WTVRAM1	; se é vai para a versao 1
	xor a			; senao inicializa o vdp msx2
	out (0x99),a
	ld a,0x8E
	out (0x99),a
WTVRAM1:
	ld a,l			; informa ao vdp o endereço
	out (0x99),a	; o endereço na VRAM da gravação do dado
	ld a,h
	and 0x3F
	or 0x40
	out (0x99),a
	ex (sp),hl		; fazemos duas vezes porque o
	ex (sp),hl		; vdp demora a sincronizar
	pop af			; recupera o dado
	out (0x98),a	; grava o dado na VRAM
	ret
ENDCODE: