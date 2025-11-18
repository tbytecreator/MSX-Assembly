0010 ' ---------------------------------
0020 ' LE VARIAVIES DE AMBIENTE
0030 ' ---------------------------------
0035 gosub 1000:'limpa a area util da tela
0040 def fn hx$(e)=right$("00"+hex$(peek(e+1)),2)+right$("00"+hex$(peek(e)),2)
0050 locate 01,04:?"TXTTAB:";fn hx$(&hf676)
0060 locate 01,05:?"VARTAB:";fn hx$(&hf6c2)
0070 locate 01,06:?"ARYTAB:";fn hx$(&hf6c4)
0080 locate 01,07:?"STREND:";fn hx$(&hf6c6)
0090 locate 01,08:?"SKTOP :";fn hx$(&hf674)
0100 locate 01,09:?"MEMSIZ:";fn hx$(&hf672)
0110 locate 01,10:?"FRETOP:";fn hx$(&hf69b)
0120 locate 01,11:?"HIMEM :";fn hx$(&hfc4a)
0140 locate 27,21:op$=input$(1)
0150 run"AUTOEXEC.BAS"

1000 ' ------------------------------
1010 ' LIMPA A AREA UTIL DA TELA 
1020 ' ------------------------------
1030 FOR I = 4 TO 18
1040   LOCATE 1, I:? STRING$(27," ");
1050 NEXT I
1060 RETURN