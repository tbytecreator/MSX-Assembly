; =============================================================================
; Criptologic 1.0 para MSX
; =============================================================================
; Manoel Neto 2019-10-02
; =============================================================================
__VERSION:  equ 1
__RELEASE:  equ 0
include "Hardware\BiosMSX.asm"
include "Assets\Constantes.asm"
include "Assets\Variaveis.asm"
org &810A
; =============================================================================
; INICIO PROGRAMA
; =============================================================================
startCode:
	call LimpaMem					; Limpa a memoria a cada execucao
	call TelaIntroducao				; Desenhar a tela de introducao
	call DesenharTela				; Desenhar a tela do jogo
	call PegarFrase					; Obtem a mensagem do usuario
	call Sortear					; Sortear os numeros aleatorios
	call Embaralhar					; Embaralha a frase
	call PegarChute					; Pegar os chutes do jogador 2
	ld a,1
	ld (CSRSW),a              		; Desliga o cursor
loopInfinito:
	ld h,NumPosXMensagens
	ld l,NumPosYMensagemFinal
	call POSIT
	ld hl,MsgUsuario8
	call PrintString
	call CHGET
	cp 13
	jp z,startCode
jp loopInfinito

include "TelaIntroducao.asm"
include "DesenharTela.asm"
include "PegarFrase.asm"
include "Sortear.asm"
include "Embaralhar.asm"
include "PegarChutes.asm"
; =============================================================================
; FIM PROGRAMA
; =============================================================================
include "Hardware\AY38910.ASM"
include "Hardware\TMS9918.ASM"
include "Library\Library.asm"
include "Assets\Strings.asm"
include "Assets\Sprites.asm"