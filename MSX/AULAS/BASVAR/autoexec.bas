0010 ' -------------------------------
0020 ' passagem de paramatros 
0030 ' basic/assembly
0040 ' Manoel Neto 2025-06-12
0050 ' -------------------------------
0060 clear 200,&hdfff:'reserva memoria e define area de udf
0070 bload"letype.bin":'carrega asm
0080 defusr=&he000:'cria uma udf
0090 a$=usr(1):'passa parametro inteiro
0100 print"Tipo Passado: ";a$