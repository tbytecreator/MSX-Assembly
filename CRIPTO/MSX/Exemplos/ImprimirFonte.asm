; =============================================================================
; Imprimir Fonte
; =============================================================================
; Manoel Neto 2019-10-08
; Imprimir as fontes em modo grafico
; =============================================================================
__VERSION:  equ 1
__RELEASE:  equ 1
include "..\Hardware\BiosMSX.asm"
include "..\Assets\Constantes.asm"
include "..\Assets\Variaveis.asm"

org romArea
	db "AB"                     ; identifica como ROM
  dw startCode                ; endereço de execução
  db "CW01"                   ; string de identificação
  db __VERSION+48							; cria o identificador de versao
  db __RELEASE+65							; cria o identificador da release
  ds 6,0
; =============================================================================
; INICIO PROGRAMA
; =============================================================================
startCode:
	call DISSCR             		; desligo a exibição da tela
	call LimparTela							; limpo a tela
	call ScreenInit						; inicializo pelos registradores VDP #0/#1
	call ERAFNK             		; desligo as teclas de função
	ld a,32											; preparo a largura da tela
  ld (LINL32),a           		; largura da tela em 32 colunas
	ld a,15
	ld (FORCLR),a               ; seto a cor da fonte
  ld a,1
  ld (BAKCLR),a               ; seto a cor do background
  ld a,1
  ld (BDRCLR),a               ; seto a cor da borda
  call CHGCLR                 ; uso a bios para alterar as cores
	call LoadPatternTable				; CARREGO A TABELA DE PADROES
	call LoadSpritesTable				; CARREGO A TABELA DE SPRITES

	; ==========================================================================
	; Carrega Tabela de nomes para escrever as fontes
	; ==========================================================================
	ld bc,26                		; bytes a copiar
  ld de,ADRNAMESTBL        		; posição na tela
  ld hl,TodosOsChar	      		; padrão da string
  call LDIRVM             		; copio na VRAM
	; ==========================================================================

	; ==========================================================================
	; Carrega tabela de atributos para imprimir os sprites
	; ==========================================================================
	ld bc,56
	ld a,0											; numero do sprite
	call CALATR									; coloca em HL o endereco dos atributos do
	ld d,h											; sprite 0
	ld e,l											; copia HL para DE
	ld hl,SpriteLinha						; pega os dados dos atributos do sprite
	call LDIRVM             		; copio na VRAM
	; ==========================================================================
  ; ==========================================================================
	; Alterar as cores
	; ==========================================================================
	ld bc,2		              		; bytes a copiar
	ld de,ADRCOLORTBL        		; Tabela de cores
	ld hl,CorAzul				    		; localização na RAM
	call LDIRVM             		; copio a tabela de atributos
	; ==========================================================================

	call ENASCR             		; religo a tela
LoopInfinito:
jr LoopInfinito

; =============================================================================
; FIM PROGRAMA
; =============================================================================
include "..\Hardware\AY38910.ASM"
include "..\Hardware\TMS9918.ASM"
include "..\Library\Library.asm"
include "..\Assets\Strings.asm"
include "..\Assets\Sprites.asm"
; =============================================================================
; Padding
; =============================================================================
romPad:
  ds romSize-(romPad-romArea),0
end
