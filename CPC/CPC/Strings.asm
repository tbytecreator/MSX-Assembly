; =========================================================================================
; Strings.asm
; =========================================================================================
; Manoel Neto 2019-09-25
; Strings utilizadas no Criptologic Z80
; =========================================================================================
MsgUsuario1:
	db "Entre sua mensagem:",13
MsgUsuario2:
	db "Embaralhar:",13
MsgUsuario3:
	db "Frase Embaralhada:",13
MsgUsuario4:
	db "Entre um caracter:",13
MsgUsuario5:
	db "Esta Correto!",13
MsgUsuario6:
	db "Esta Errado.",13
MsgUsuario7:
	db "Parabens! Acertou tudo!",13
MsgUsuario8:
	db "Erros:",13
MatSorteados:
	db 255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
StrFrase:
	db 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,13
StrFraseEmb:
	db 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,13