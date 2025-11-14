0010 ' -------------------------------
0020 ' passagem de paramatros 
0030 ' basic/assembly
0040 ' Manoel Neto 2025-06-12
0050 ' -------------------------------
0060 bload"leorig.bin":'carrega asm
0070 defusr=&hc000:'cria uma udf
0090 a=usr(&HF3B0):'passa parametro
0100 print"Valor pesquisado: ";a