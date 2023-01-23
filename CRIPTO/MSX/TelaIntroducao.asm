; =============================================================================
; Tela Introdutoria do jogo
; =============================================================================
; Manoel Neto 2019-10-24
; =============================================================================
TelaIntroducao:
  call DISSCR             		; desligo a exibição da tela
  call LimparTela             ; limpo a tela  
  ld a,1
  ld (CSRSW),a                ; Apaga o cursor
  ld a,15
  ld (FORCLR),a               ; seto a cor da fonte
  ld a,1
  ld (BAKCLR),a               ; seto a cor do background
  ld a,1
  ld (BDRCLR),a               ; seto a cor da borda
  call CHGCLR                 ; uso a bios para alterar as cores
  call ERAFNK             		; desligo as teclas de função
  ld a,32                     ; preparo a largura da tela
  ld (LINL32),a           		; largura da tela em 32 colunas
  call INIT32                 ; inicializo a tela
  call LoadPatternTable       ; CARREGO A TABELA DE PADROES
  call LoadAtributteTable     ; CARREGO A TABELA DE ATRIBUTOS

  ; ==========================================================================
  ; Escreve Titulo
  ; ==========================================================================
  ld b,NumPosXTituloJogo
  ld c,NumPosYTituloJogo
  call GetVDPScreenPos
  ld d,h
  ld e,l
  ld bc,11                		; bytes a copiar
  ld hl,TituloPattern      		; padrão da string
  call LDIRVM             		; copio na VRAM
  ; ==========================================================================

  ; ==========================================================================
  ; Escreve Portado para MSX
  ; ==========================================================================
  ld b,NumPosXPortadoMsx
  ld c,NumPosYPortadoMsx
  call GetVDPScreenPos
  ld d,h
  ld e,l
  ld bc,16                		; bytes a copiar
  ld hl,MSXPattern        		; padrão da string
  call LDIRVM             		; copio na VRAM
  ; ==========================================================================

  ; ==========================================================================
  ; Escreve Manoel Neto
  ; ==========================================================================
  ld b,NumPosXManoelNeto
  ld c,NumPosYManoelNeto
  call GetVDPScreenPos
  ld d,h
  ld e,l
  ld bc,11                		; bytes a copiar
  ld hl,ManoelNetoPattern  		; padrão da string
  call LDIRVM             		; copio na VRAM
  ; ==========================================================================

  ; ==========================================================================
  ; Mudar cor do titulo do jogo
  ; ==========================================================================
  ld de,ADRCOLORTBL           ; posição tabela de cores
  ld bc,32                		; bytes a copiar
  ld hl,PadraoCores    				; padrao de cores
  call LDIRVM             		; copio na VRAM
  ; ==========================================================================

  call ENASCR             		; religo a tela
LoopAguardarEnter:
  call CHGET
  cp 13
  jr z,FimTelaIntro
  jr LoopAguardarEnter
FimTelaIntro:
  xor a
  ld (CSRSW),a                ; Liga o cursor
ret
