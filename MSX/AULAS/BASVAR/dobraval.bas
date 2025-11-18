0010 ' --------------------------------
0020 ' DOBRA VALOR USANDO ASSEMBLY
0030 ' marmsx.msxall.com
0030 ' --------------------------------
0035 GOSUB 1000: 'limpa tela
0040 FOR E=&HC000 TO &HC005
0050   READ A$
0060   POKE E,VAL("&H"+A$)
0070 NEXT
0080 DEFUSR=&HC000
0090 LOCATE 1,4:?"VALOR DOBRADO:";:? MID$(STR$(USR(4)),2);
0100 LOCATE 27,21:OP$=INPUT$(1)
0110 RUN"AUTOEXEC.BAS"
0120 DATA 23,23,7E,87,77,C9
0130 END

1000 ' ------------------------------
1010 ' LIMPA A AREA UTIL DA TELA 
1020 ' ------------------------------
1030 FOR I = 4 TO 18
1040   LOCATE 1, I:? STRING$(27," ");
1050 NEXT I
1060 RETURN