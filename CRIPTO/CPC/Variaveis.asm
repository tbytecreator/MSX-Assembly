; =========================================================================================
; Variaveis.asm
; =========================================================================================
; Manoel Neto 2019-09-25
; Variaveis utilizadas no Criptologic Z80
; =========================================================================================
NumTamFrase 		equ &9000	; Variavel => Tamanho da entrada Jog 1
NumAleatorio 		equ &9001	; Variavel => Numero sorteado
NumSorteios 		equ &9002	; Variavel => Numero de sorteios realizados
NumDivIdeal 		equ &9003	; Variavel => Divisor ideal de acordo com a frase
NumPosSort		equ &9005	; Variavel => PosicaoSorteada
ChaLetraAtual		equ &9006	; Variavel => Letra na posicao sorteada
NumContEmb		equ &9007	; Variavel => Contador de embaralhamento
ChaTestar		equ &9008	; Variavel => Guarda o caracter para testar
NumContTeste		equ &9009	; Variavel => Conta o teste atual
NumContErros		equ &900A 	; Variavel => Conta os erros (Nao e 9010)!		



