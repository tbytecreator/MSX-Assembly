; =============================================================================
; DesenharTela.asm
; =============================================================================
; Manoel Neto 2019-10-22
; =============================================================================
; Desligar a tela
; Limpar a tela
; Inicializar a tela em modo 32x24
; Setar as cores de fundo e borda
; Apagar as teclas de funcao
; Imprimir cabecalho do jogo
; Imprimir mesagem inicial
; Desenhar duas linhas
; Posicionar o cursor na posicao da entrada do jogador 1
; Religar a tela
; =============================================================================
DesenharTela:
	call DISSCR
	call LimparTela             ; limpo a tela

	; Imprimir linha da apoio 1
	ld b,NumPosXLinhaApoio      ; posicionar a linha de apoio 1 x
	ld c,NumPosYLinhaApoio1     ; posicionar a linha de apoio 1 y
	call GetVDPScreenPos        ; pegar a area de memoria da posicao BC em HL
	ld d,h                      ; posição na tela
	ld e,l                      ; posição na tela
	ld bc,14                	; bytes a copiar
	ld hl,LinhaReta	      		; tabela de nomes
	call LDIRVM             	; copio na VRAM

	; Imprimir linha da apoio 2
	ld b,NumPosXLinhaApoio      ; posicionar a linha de apoio 2 x
	ld c,NumPosYLinhaApoio2     ; posicionar a linha de apoio 2 y
	call GetVDPScreenPos        ; pegar a area de memoria da posicao BC em HL
	ld d,h                      ; posição na tela
	ld e,l                      ; posição na tela
	ld bc,14               		; bytes a copiar
	ld hl,LinhaReta	   			; Padrao da tabela de nomes
	call LDIRVM            		; copio na VRAM

	call ENASCR
ret