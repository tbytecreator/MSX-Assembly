; ========================================================================================
; Criptologic para Z80
; ========================================================================================
; Versao 0.1 (Prototipo)
; Manoel Neto 2019-09-09
; ========================================================================================
read "BiosCPC.asm" 
read "Variaveis.asm"
; ========================================================================================
; INICIO DO PROGRAMA
; ========================================================================================
org &8000
	call LimpaMem		; Limpa a memoria a cada execucao
	call PegarFrase		; Obtem a mensagem do usuario
	call Sortear		; Sortear os numeros para embaralhar a frase
	call Embaralhar		; Embaralha a frase
	call PegarChutes	; Desembaralha a frase
ret

read "PegarFrase.asm"
read "Sortear.asm"
read "Embaralhar.asm"
read "PegarChutes.asm"

; =========================================================================================
; FIM DO PROGRAMA
; =========================================================================================
read "Library.asm"
read "Strings.asm"

