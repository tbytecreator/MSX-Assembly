; =============================================================================
; Tela Introdutoria do jogo
; =============================================================================
; Manoel Neto 2019-10-24
; =============================================================================
TelaIntroducao:
  call DISSCR             		; desligo a exibição da tela
  call LimparTela             ; limpo a tela  
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
  call LoadAtributteTable     ; CARREGO A TABELA DE ATRIBUTOS
  call LoadCharPatternTable   ; CARREGO A TABELA DE CARACTERES
  ; ==========================================================================
  ; Escreve Titulo
  ; ==========================================================================
  ld h,NumPosXTituloJogo
	ld l,NumPosYTituloJogo
	call POSIT
  ld hl,MsgUsuario1
  call PrintString
  ; ==========================================================================
  ; Mudar cor do titulo do jogo
  ; ==========================================================================
  ld de,ADRCOLORTBL           ; posição tabela de cores
  ld bc,32                		; bytes a copiar
  ld hl,PadraoCores    			  ; padrao de cores
  call LDIRVM             		; copio na VRAM
  call ENASCR             		; religo a tela
LoopAguardarEnter:
  call CHGET
  cp 13
  jr z,FimTelaIntro
  jr LoopAguardarEnter
FimTelaIntro:
ret
