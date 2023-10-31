; ====================================
; Criptologic 1.0 para MSX
; ====================================
; Manoel Neto 2019-10-02
; ====================================
__VERSION:  equ 1
__RELEASE:  equ 0
include "Hardware\BiosMSX.asm"
include "Assets\Constantes.asm"
include "Assets\Variaveis.asm"
org &810A
; ====================================
; INICIO PROGRAMA
; ====================================
startCode:
	ld a,1
	ld (CSRSW),a     
	call LimpaMem					
	call TelaIntroducao				
	call DesenharTela				
	call PegarFrase					
	call Sortear					
	call Embaralhar					
	call PegarChute					
loopInfinito:
	call CHGET
	cp 13
	jp z,startCode
jp loopInfinito
; ====================================
; SUBPROGRAMAS 
; ====================================
include "TelaIntroducao.asm"
include "DesenharTela.asm"
include "PegarFrase.asm"
include "Sortear.asm"
include "Embaralhar.asm"
include "PegarChutes.asm"
; ====================================
; FIM PROGRAMA
; ====================================
include "Hardware\AY38910.ASM"
include "Hardware\TMS9918.ASM"
include "Library\Library.asm"
include "Assets\Strings.asm"
include "Assets\Patterns.asm"