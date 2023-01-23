; =============================================================================
; Constantes.asm
; =============================================================================
; Manoel Neto 2019-10-3
; Constantes utilizadas no Criptologic Z80
; =============================================================================
romSize                 equ 32768       ; O tamanho que a ROM deve ter
romArea                 equ &4000       ; Minha ROM começa aqui
ramArea                 equ &E000       ; Inicio da área de variáveis

NumPosXTituloJogo:      equ 10
NumPosYTituloJogo:      equ 7
NumPosXPortadoMsx:      equ 8
NumPosYPortadoMsx:      equ 11
NumPosXManoelNeto:      equ 10
NumPosYManoelNeto:      equ 13
NumPosXCopyright:       equ 4
NumPosYCopyright:       equ 14
NumPosXMensagens:       equ 3
NumPosYMensagens:       equ 1
NumPosXErros:           equ 3
NumPosYErros:           equ 2
NumPosXEntradas:        equ 10
NumPosYEntrada1:        equ 8
NumPosYEntrada2:        equ 13
NumPosXLinhaApoio:      equ 9
NumPosYLinhaApoio1:     equ 8
NumPosYLinhaApoio2:     equ 13
NumPosYMensagemFinal:   equ 24
; =============================================================================
