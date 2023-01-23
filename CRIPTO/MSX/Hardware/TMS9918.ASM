; =============================================================================
; TMS9918.ASM
; =============================================================================
; Manoel Neto 2019-10-04
; Biblioteca para uso do VDP do MSX 1
; =============================================================================
; VDP MODO GRAFICO I (SCREEN 1)
; =============================================================================
; Padrões de azulejos	=> 00000 ate 06143 (&H0000..&H07FF) => 6143 Bytes
; Mapa dos ajulejos		=> 06144 ate 06911 (&H1800..&H1AFF)	=> 0767 Bytes
; Tabela de atributos   => 06912 ate 07039 (&H1B00..&H1B7F)	=> 0127 Bytes
; Paleta				=> 07040 ate 07087 (&H1B80..&H1BAF)	=> 0047 Bytes
; Tabela de Cores 		=> 08192 ate 14335 (&H2000..&H37FF)	=> 6143 Bytes
; Tabela de Sprites 	=> 14336 ate 16384 (&H3800..&H3FFF) => 2048 Bytes
; =============================================================================
VDPDATA:              equ &98
VDPCONTROL:           equ &99
ADRPATTERNTBL:		  equ 0000
ADRNAMESTBL:		  equ 6144
ADRATRIBUTETBL:		  equ 6912
ADRPALLETTBL:		  equ 7040
ADRCOLORTBL:		  equ 8192
ADRSPRITETBL:		  equ 14336

; =============================================================================
; Carrega a Tabela de padroes
; =============================================================================
LoadPatternTable:
	ld bc,216            	; bytes a copiar
  	ld de,ADRPATTERNTBL     ; tabela de padrões na VRAM
  	ld hl,CriptoFont 		; localização na RAM
  	call LDIRVM             ; copio a tabela de padrões
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
; Carrega a Tabela de sprites
; =============================================================================
LoadSpritesTable:
	ld bc,216              	; bytes a copiar
  	ld de,ADRSPRITETBL	    ; tabela de sprites na VRAM
  	ld hl,CriptoFont		; localização na RAM
  	call LDIRVM             ; copio a tabela de sprites
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
