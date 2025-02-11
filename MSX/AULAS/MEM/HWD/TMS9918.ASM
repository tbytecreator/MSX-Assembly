; =============================================================================
; TMS9918.ASM
; =============================================================================
; (C) 2024 Manoel Neto - tbytecreator@gmail.com
; Biblioteca para uso do VDP do MSX 1
; =============================================================================

; =============================================================================
; MODOS DE OPERACAO DO VDP
; =============================================================================
;	M1	M2	M3	M4	M5	Mode	 	MSX Version	    BASIC           
;	1	0	0	0	0	40x24 Text	1 2 2+ tR		0
;	0	0	0	0	0	32x24 Text	1 2 2+ tR	 	1
;	0	0	1	0	0	Graphics 1	1 2 2+ tR		2
;	0	1	0	0	0	Multicolour	1 2 2+ tR		3
; =============================================================================

; =============================================================================
; VDP MODO GRAFICO I (SCREEN 1)
; =============================================================================
; Padrões de azulejos	=> 00000 ate 06143 (&H0000..&17FFH) => 6143 Bytes
; Mapa dos ajulejos		=> 06144 ate 06911 (&H1800..&H1AFF)	=> 0767 Bytes
; Tabela de atributos 	=> 06912 ate 07039 (&H1B00..&H1B7F)	=> 0127 Bytes
; Paleta				=> 07040 ate 07087 (&H1B80..&H1BAF)	=> 0047 Bytes
; Tabela de Cores 		=> 08192 ate 14335 (&H2000..&H37FF)	=> 6143 Bytes
; Tabela de Sprites 	=> 14336 ate 16384 (&H3800..&H3FFF) => 2048 Bytes
; =============================================================================

; =============================================================================
; VDP MODO GRAFICO II (SCREEN 2)
; =============================================================================
; Padrões de azulejos	=> 00000 ate 06143 (&H0000..&17FFH) => 6143 Bytes
; Mapa dos ajulejos		=> 06144 ate 06911 (&H1800..&H1AFF)	=> 0767 Bytes
; Tabela de atributos 	=> 06912 ate 07039 (&H1B00..&H1B7F)	=> 0127 Bytes
; Paleta				=> 07040 ate 07087 (&H1B80..&H1BAF)	=> 0047 Bytes
; Tabela de Cores 		=> 08192 ate 14335 (&H2000..&H37FF)	=> 6143 Bytes
; Tabela de Sprites 	=> 14336 ate 16384 (&H3800..&H3FFF) => 2048 Bytes
; =============================================================================
ADRPATTERNTBL12:		equ 0000
ADRNAMESTBL12:			equ 6144
ADRATRIBUTETBL12:		equ 6912
ADRPALLETTBL12:			equ 7040
ADRCOLORTBL12:			equ 8192
ADRSPRITETBL12:			equ 14336

; =============================================================================
; CORES
; =============================================================================
; 00	0000 transparent		06	0110 dark red		12	1100 dark green
; 01	0001 black				07	0111 cyan			13	1101 magenta
; 02	0010 medium green		08	1000 medium red		14	1110 gray
; 03	0011 light green 		09	1001 light red		15	1111 white
; 04	0100 dark blue			10	1010 dark yellow
; 05	0101 light blue			11	1011 light yellow
; =============================================================================

; =============================================================================
; SPRITE PATTERNS => 256(8X8) OU 64(16X16) PADROES DE PIXELS
; APENAS 32 EXIBIDOS NA TELA
; =============================================================================
; SE O BIT DE TAMANHO DE SPRITE = 1 NO REGISTRADOR DO VDP #1, ENTAO OS SPRITES
; SERAO 16X16 SEGUINDO O ESQUEMA ABAIXO,OU SEJA,VOCE PODE TER 256 OU 64 SPRITES
; =============================================================================
; BLOCO A => PRIMEIROS 8 BYTES
; BLOCO B => PROXIMOS 8 BYTES
; BLOCO C => PROXIMOS 8 BYTES
; BLOCO D => PROXIMOS 8 BYTES
; SPRITE FINAL => A,C,B,D
; =============================================================================

; =============================================================================
; ReadVDPPorts 
; =============================================================================
; Le as portas de dados e comandos do VDP para a RAM
; =============================================================================
; Parametros
; Nenhum
; =============================================================================
; Altera
; VDPDATA 		=> porta de dados do MSX 
; VDPCONTROL 	=> porta de comandos do MSX
; =============================================================================
ReadVDPPorts:
    push af
        ld a,(0006H)
        ld (VDPDATA),a
        ld a,(0007H)		
	    inc a				 
        ld (VDPCONTROL),a
    pop af
ret
; =============================================================================

; =============================================================================
; ReadVDPStatus
; =============================================================================
; Pegar o contedo do registrador de STATUS do VDP
; =============================================================================
; Status Register #0
; 7				F		Vertical scan interrupt flag
; 6				5S		Flag do quinto sprite (SCREEN 1 and 2)
; 5				C		Flag de colisao
; 4 to 0		5SN		Number of the 5th sprite (SCREEN 1 and 2)
;
; * 5,6 e 7 sao resetados quando o registrador eh lido ou o VDP Resetado
; * O registrador deve ser lido apenas quando o VDP interrupt esta pendente
; =============================================================================
; Parametros
; Nenhum
; =============================================================================
; Altera
; A => Status do VDP
; =============================================================================
ReadVDPStatus:
	push bc
		ld a,(VDPCONTROL)
		ld c,a
		in a,(c)
	pop bc
	;ld a,(STATFL)         ; le os flags de status do VDP
ret
; =============================================================================

; =============================================================================
; LoadSpritesTable
; =============================================================================
; Carrega a Tabela de sprites
; =============================================================================
; Parametros
; Nenhum
; =============================================================================
; Altera
; Tabela de Sprites
; =============================================================================
LoadSpritesTable:
	push bc
	push de
	push hl
		ld bc,32             	; bytes a copiar
  		ld de,ADRSPRITETBL12	; tabela de sprites na VRAM
  		ld hl,Sprites			; endereco dos sprites
  		call LDIRVM             ; copio a tabela de sprites
	pop hl
	pop de
	pop bc
ret
; =============================================================================

; =============================================================================
; PutSprite
; =============================================================================
;	Você pode colar até trinta e dois sprites (0 a 31)
;	só quatro podem estar presentes na mesma linha horizontal
;	o processador sempre irá desenhá-los uma linha abaixo de onde
;	você realmente mandou
; =============================================================================
; VVVVVVVV					=> POSICAO VERTICAL
; HHHHHHHH					=> POSICAO HORIZONTAL
; PPPPPPPP					=> NUMERO DO PADRAO (TABELA DE PADROES)
; E000CCCC					=> EARLY / 000 / COR DO SPRITE
; =============================================================================
; Parametros
; A => Numero do Sprite na tabela de atributos
; D => posicao Y
; E => posicao X
; B => Numero do sprite na tabela de sprites
; C => Early / Cor
; =============================================================================
; ALTERA => Nada
; =============================================================================
PutSprite:
	push hl
	push af
		push de				; salvo o valor de DE pq CALATR o altera
			call CALATR		; pega o endereco do sprite na TBL de atributos
		pop de				; retorno DE
		ld a,d
		call WRTVRM			; gravo a posicao Y
		inc hl				; proximo endereco
		ld a,e
		call WRTVRM			; gravo a posicao X
		inc hl				; proximo endereco
		ld a,b
		call WRTVRM			; Gravo o numero na tabela de padroes
		inc hl				; proximo endereco
		ld a,c
		call WRTVRM			; gravo Early / Color
	pop af
	pop hl
ret
; =============================================================================
