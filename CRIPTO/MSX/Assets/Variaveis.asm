; =============================================================================
; Variaveis.asm
; =============================================================================
; Manoel Neto 2019-09-25
; Variaveis utilizadas no Criptologic Z80
; =============================================================================
romSize             equ 8192        ; O tamanho que a ROM deve ter
romArea             equ &4000       ; Minha ROM começa aqui
ramArea             equ &E000       ; Inicio da área de variáveis
NumTamFrase 	    equ ramArea	    ; Variavel => Tamanho da entrada Jog 1
NumAleatorio 		equ ramArea+1	  ; Variavel => Numero sorteado
NumSorteios 		equ ramArea+2	  ; Variavel => Numero de sorteios realizados
NumDivIdeal 		equ ramArea+3	  ; Variavel => Divisor ideal
MatSorteados        equ ramArea+4   ; Matriz => Numeros sorteados
StrFrase            equ ramArea+19  ; String => frase digitada
NumPosSort		    equ ramArea+35  ; Variavel => PosicaoSorteada
ChaLetraAtual		equ ramArea+36  ; Variavel => Letra na posicao sorteada
NumContEmb  		equ ramArea+37  ; Variavel => Contador de embaralhamento
StrEmbaralhada      equ ramArea+38  ; String => frase Embaralhada
NumCentenas  		equ ramArea+54  ; Variavel => Usada em PrintNumber
NumDezenas  		equ ramArea+55  ; Variavel => Usada em PrintNumber
NumUnidades  		equ ramArea+56  ; Variavel => Usada em PrintNumber
ChaTestar			equ ramArea+57	; Variavel => Guarda o caracter para testar
NumContTeste		equ ramArea+58	; Variavel => Conta o teste atual
NumContErros		equ ramArea+59 	; Variavel => Conta os erros
