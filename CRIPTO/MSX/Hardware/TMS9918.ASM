; =============================================================================
; TMS9918.ASM
; =============================================================================
; Manoel Neto 2019-10-04
; Biblioteca para uso do VDP do MSX 1
; =============================================================================
; PORTS 
; =============================================================================
VDPDATA:			equ &98
VDPCONTROL:         equ &99

; =============================================================================
; VDP MODO TEXTO 40X24 (SCREEN 0)
; =============================================================================
; Names table 		=> 0000H to 03BFH
; Patterns table	=> 0800H to 0FFFH
; =============================================================================
S0NAMESTBL:		  	equ &0000
S0PATTERNTBL:		equ &0800

; =============================================================================
; VDP MODO HIBRIDO 32X24 (SCREEN 1)
; =============================================================================
; Names table 				=> 1800H to 1AFFH
; Character Pattern Table	=> 0000H to 07FFH
; =============================================================================
S1CHARPATTERNTBL:	equ &0000
S1NAMESTBL:		  	equ &1800
LetterCAPos: 		equ &0200
LetterLAPos: 		equ &0300 
ADRCOLORTBL:		equ &2000
ADRATRIBUTETBL:		equ &1B00

; =============================================================================
; Carrega a Tabela de padroes de caracter
; =============================================================================
LoadCharPatternTable:
	ld bc,224            	; bytes a copiar
  	ld de,LetterCAPos  		; tabela de padrões na VRAM 
  	ld hl,CriptoFont 		; localização na RAM
  	call LDIRVM             ; copio a tabela de padrões letras maiusculas
	ld bc,224            	; bytes a copiar
	ld de,LetterLAPos  		; tabela de padrões na VRAM
  	ld hl,CriptoFont 		; localização na RAM
  	call LDIRVM             ; copio a tabela de padrões letras minusculas
ret
; =============================================================================

; =============================================================================
; Carrega a Tabela de Atributos
; =============================================================================
LoadAtributteTable:
	ld bc,32              	; bytes a copiar
  	ld de,ADRATRIBUTETBL    ; tabela de padrões na VRAM
  	ld hl,AttributePattern  ; localização na RAM
  	call LDIRVM             ; copio a tabela de padrões
ret
; =============================================================================

; =============================================================================
; Pegar a posicao de memoria de uma coordenada XY
; =============================================================================
; B	=> posicao X
; C => posicao Y
; =============================================================================
; Altera => HL (endereco de memoria da coordenada xy),A
; =============================================================================
GetVDPScreenPos:
	push bc
		ld h,0
		ld l,c
		or a
		rl l
		rl h
		rl l
		rl h
		rl l
		rl h
		rl l
		rl h
		rl l
		rl h
		ld a,l
		or b		; or na coordenada x
		ld l,a
		ld a,h
		or &18		; mapa de azulejos começa em &1800
		ld h,a
	pop bc
ret
; =============================================================================

; =============================================================================
; Pegar a posicao da tabela de cores da coordenada xy
; =============================================================================
; As coores pode ser setadas para uma area 8x1
; um byte define cor da frente e cor do background (%FFFFBBBB)
; B	=> posicao x (0-32)
; C => posicao y (0-191)
; =============================================================================
; Altera => HL (endereco de memoria da cor da coordenada xy)
; =============================================================================
GetColorMemPos:
	push af
	push bc
		ld a,c
		and %11111000
		rrca
		rrca
		rrca
		or &20					; a tabela de cores comeca em &2000
		ld h,a
		ld a,b
		and %00011111
		rlca
		rlca
		rlca
		ld b,a
		ld a,c
		and %00000111
		or b
		ld l,a
	pop bc
	pop af
ret
; =============================================================================
