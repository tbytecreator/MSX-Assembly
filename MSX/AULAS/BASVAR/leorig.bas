0010 ' -------------------------------
0020 ' passagem de paramatros 
0030 ' basic/assembly
0040 ' Manoel Neto 2025-06-12
0050 ' -------------------------------
0060 bload"leorig.bin":'carrega asm
0070 defusr=&hc000:'cria uma udf' 
0080 input "digite um parametro para USR:";p
0090 a=usr(p):'passa parametro
0100 print "parametro passado: "; hex$(a)
0110 tp=peek(&hf663)
0120 if tp = 2 then print "tipo de parametro: inteiro":goto 1000
0130 if tp = 4 then print "tipo de parametro: simples":goto 2000
0140 if tp = 8 then print "tipo de parametro: dupla":goto 3000
0150 if tp = 3 then print "tipo de parametro: string":goto 4000
0160 print "tipo de parametro: desconhecido"
0170 goto 80 

1000 ' -------------------------------
1010 ' parametro eh inteiro 
1020 ' -------------------------------
1030 ls=peek(&hf7f8):'lsb do parametro
1040 ms=peek(&hf7f9):'msb do parametro
1050 ed=ls+ms*256
1060 ? "Endereco para ver: "; hex$(ed)
1070 vl=peek(ed)
1080 print "valor inteiro: ";vl
1090 end 

2000 ' -------------------------------
2010 ' parametro eh simples
2020 ' -------------------------------
2030 b1=peek(&hf7f6):'byte 1
2040 b2=peek(&hf7f7):'byte 2
2050 b3=peek(&hf7f8):'byte 3
2060 b4=peek(&hf7f9):'byte 4
2070 ps=b1 + b2 * 256 + b3 * 65536 + b4 * 16777216
2080 print "valor simples: ";ps
2090 end

3000 ' -------------------------------
3010 ' parametro eh dupla
3020 ' -------------------------------
3030 b1=peek(&hf7f6):'byte 1
3040 b2=peek(&hf7f7):'byte 2
3050 b3=peek(&hf7f8):'byte 3
3060 b4=peek(&hf7f9):'byte 4
3070 b5=peek(&hf7fa):'byte 5
3080 b6=peek(&hf7fb):'byte 6
3090 b7=peek(&hf7fc):'byte 7
3100 b8=peek(&hf7fd):'byte 8
3110 pd=b1 + b2 * 256 + b3 * 65536 + b4 * 16777216 + b5 * 4294967296 + b6 * 1099511627776 + b7 * 281474976710656 + b8 * 72057594037927936
3120 print "valor dupla: ";pd
3130 end

4000 ' -------------------------------
4010 ' parametro eh string
4020 ' -------------------------------
4030 sl=peek(&hf7f8):'tamanho da string
4040 st$=""
4050 for i=0 to sl-1
4060  sc=peek(&hf7f9 + i):'caractere da string
4070  st$=st$ + chr$(sc)
4080 next i
4090 print "valor string: ";st$
4100 end

