;==============================================================================
; Embaralhar Frase
; Pegar o numero sorteado
; Pegar letra relativa ao numero sorteado
; Gravar letra na frase embaralhada
; Imprimir a Frase Embaralhada
;==============================================================================
Embaralhar:
	ld a,0									; prepara primeira passada
	ld (NumContEmb),a				; zera o contador de embaralhamento
GravarProxima:
	call AcharPosSort				; achar a posicao sorteada
	call AcharLetra					; acha a letra dessa passada
	call GravarLetra				; gravar a letra dessa passada
	ld a,(NumTamFrase)			; pega para comparar
	ld b,a									; o tamnho da frase
	ld a,(NumContEmb)				; com o contador de embaralhamento
	cp b										; se pegamos todos
	jp z,GravouTudo					; gravamos tudo
	inc a 									; senao vamos para a proxima
	ld (NumContEmb),a				; e guardamos no contador
	jp GravarProxima				; pega a proxima
GravouTudo:
	call ImpFraseEmb				; Imprimir a frase embaralhada
ret

AcharPosSort:
	ld a,(NumContEmb)
	ld hl,MatSorteados
LoopAcharPosSort:
	cp 0
	jp z,AchouPosSort
	dec a
	inc hl
	jp LoopAcharPosSort
AchouPosSort:
	ld a,(hl)
	ld (NumPosSort),a
ret

AcharLetra:
	ld a,(NumPosSort)
	dec a 												; enderecos comecam com 0
	ld hl,StrFrase
LoopAcharLetra:
	cp 0
	jp z,AchouLetra
	dec a
	inc hl
	jp LoopAcharLetra
AchouLetra:
	ld a,(hl)
	ld (ChaLetraAtual),a
ret

GravarLetra:
	ld a,(NumContEmb)
	ld b,a
	ld a,0
	ld hl,StrEmbaralhada
LoopGravarLetra:
	cp b
	jp z,AchouPosGravar
	inc hl
	inc a
	jp LoopGravarLetra
AchouPosGravar:
	ld a,(ChaLetraAtual)
	ld (hl),a
	inc hl
	ld (hl),13
ret

ImpFraseEmb:
	ld a,NumPosYEntrada1
	call LimparLinha
	ld h,NumPosXEntradas
	ld l,NumPosYEntrada1
	call POSIT
	ld hl,StrEmbaralhada
	call PrintString
ret
