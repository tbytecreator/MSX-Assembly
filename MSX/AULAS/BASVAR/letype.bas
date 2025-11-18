0010 ' -------------------------------
0020 ' passagem de paramatros 
0030 ' basic/assembly
0040 ' Manoel Neto 2025-06-12
0050 ' -------------------------------
0060 gosub 1000:'limpa tela
0070 bload"letype.bin":'carrega asm
0080 defusr=&hc000:'cria uma udf
0090 locate 1,4:?"PASSAGEM DE PARAMETROS     "
0100 locate 1,5:?"                           "
0110 locate 1,6:a$=usr("TESTE"):?a$
0120 locate 1,7:?"                           "
0130 locate 27,21:op$=input$(1)
0140 run"autoexec.bas"

1000 ' ------------------------------
1010 ' LIMPA A AREA UTIL DA TELA 
1020 ' ------------------------------
1030 FOR I = 4 TO 18
1040   LOCATE 1, I:? STRING$(27," ");
1050 NEXT I
1060 RETURN