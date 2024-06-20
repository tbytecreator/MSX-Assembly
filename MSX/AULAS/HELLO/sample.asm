romSize                 equ &8000       ; O tamanho que a ROM deve ter
romArea                 equ &4000       ; Minha ROM começa aqui
ramArea                 equ &E000       ; Inicio da área de variáveis
include "HWD\BIOS.ASM"

NumCentenas  		equ ramArea     ; Variavel => Usada em PrintNumber
NumDezenas  		equ ramArea+1   ; Variavel => Usada em PrintNumber
NumUnidades  		equ ramArea+2   ; Variavel => Usada em PrintNumber
stackCopy           equ ramArea+3   ; copia da stack (2 bytes!)

org romArea
	db "AB"
	dw ProgramStart
	db 00,00,00,00,00

ProgramStart:
    call LimparTela
    call pc_on_stack
pc_on_stack:
    pop hl                              ; pc in hl
    ld a,h
	ld (stackCopy),a
    ld a,l
    ld (stackCopy+1),a
    ld a,(stackCopy)
    call ImprimeNumero
    ld a,(stackCopy+1)
    call ImprimeNumero
    call NovaLinha 
	
    ; faz o processamento
    
    ld a,(stackCopy)
    ld h,a
    ld a,(stackCopy+1)
    ld l,a
    inc  hl
    inc  hl
    inc  hl
    ld a,h
    call ImprimeNumero
    ld a,l
    call ImprimeNumero
    call NovaLinha 
    DI
  	Halt

; =====================================
; FIM PROGRAMA
; =====================================
include "HWD\LIB.ASM"

; =====================================
; PADDING
; =====================================
romPad:
 ds romSize-(romPad-romArea),0