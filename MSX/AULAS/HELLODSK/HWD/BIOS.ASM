;=============================================================================
; MSX1-BIOS CAllS
;=============================================================================
CHKRAM:		equ 0x0000			; Partida (boot)
RDSLT:		equ 0x000C			; Lê dado de qualquer slot
WRSLT:		equ 0x0014			; Escreve dado em qualquer slot
CALSLT:		equ 0x001C			; Chama rotina em qualquer slot
DCOMPR:		equ 0x0020			; Compara DE e HL
ENASLT:		equ 0x0024			; Mapeia slot
CALLF:		equ 0x0030			; Chama rotina em qualquer slot (inline)
KEYINT:		equ 0x0038			; Manipulador de interrupção padrão
INITIO:		equ 0x003B			; Inicializa PSG e porta de impressora
INIFNK:		equ 0x003E			; Inicializa strings das teclas de função
DISSCR:		equ 0x0041			; Desativa tela
ENASCR:		equ 0x0044			; Ativa tela
WRTVDP:		equ 0x0047			; Escreve em registrador do VDP
RDVRM:		equ 0x004A			; Lê byte da VRAM
WRTVRM:		equ 0x004D			; Escreve byte na VRAM
SETRD:		equ 0x0050			; Prepara VDP para leitura
SETWRT:		equ 0x0053			; Prepara VDP para escrita
FILVRM:		equ 0x0056			; Preenche bloco da VRAM
LDIRMV:		equ 0x0059			; Copia bloco da VRAM para a RAM
LDIRVM:		equ 0x005C			; Copia bloco da RAM para a VRAM
CHGMOD:		equ 0x005F			; Altera modo do VDP
CHGCLR:		equ 0x0062			; Altera cores do VDP
NMI:		equ 0x0066			; Manipulador da NMI
CLRSPR:		equ 0x0069			; Limpa todos os sprites
INITXT:		equ 0x006C			; Inicializa VDP em modo texto 40x24
INIT32:		equ 0x006F			; Inicializa VDP em modo texto 32x24
INIGRP:		equ 0x0072			; Inicializa VDP em modo gráfico 256x192
INIMLT:		equ 0x0075			; Inicializa VDP em modo multicolorido 64x48
CALPAT:		equ 0x0084			; Calcula endereço da imagem do sprite
CALATR:		equ 0x0087			; Calcula endereço do atributo do sprite
GSPSIZ:		equ 0x008A			; Obtém tamanho do sprite
GRPPRT:		equ 0x008D			; Escreve caractere na tela gráfica
GICINI:		equ 0x0090			; Inicializa PSG
WRTPSG:		equ 0x0093			; Escreve em registrador do PSG
RDPSG:		equ 0x0096			; Lê registrador do PSG
STRTMS:		equ 0x0099			; Desempilha fila musical
CHSNS:		equ 0x009C			; Verifica buffer do teclado
CHGET:		equ 0x009F			; Obtém caractere do buffer do teclado
CHPUT:		equ 0x00A2			; Escreve caractere na tela
LPTOUT:		equ 0x00A5			; Imprime caractere na porta de impressora
LPTSTT:		equ 0x00A8			; Teste de status da impressora
PINLIN:		equ 0x00AE			; Lê uma linha do console
INLIN:		equ 0x00B1			; Lê uma linha do console
QINLIN:		equ 0x00B4			; Lê uma linha do console
BREAKX:		equ 0x00B7			; Verifica Ctrl+Stop
BEEP:		equ 0x00C0			; Emite beep
CLS:		equ 0x00C3			; Limpa tela
POSIT:		equ 0x00C6			; Posiciona cursor
ERAFNK:		equ 0x00CC			; Apaga a linha das teclas de função
DSPFNK:		equ 0x00CF			; Mostra a linha das teclas de função
TOTEXT:		equ 0x00D2			; Retorna VDP ao modo texto
GTSTCK:		equ 0x00D5			; Lê status do joystick
GTTRIG:		equ 0x00D8			; Lê status do botão do joystick
GTPAD:		equ 0x00DB			; Lê status do tablet
GTPDL:		equ 0x00DE			; Lê status do paddle
TAPION:		equ 0x00E1			; Aciona entrada de fita
TAPIN:		equ 0x00E4			; Lê entrada de fita
TAPIOF:		equ 0x00E7			; Desliga entrada de fita
TAPOON:		equ 0x00EA			; Aciona saída de fita
TAPOUT:		equ 0x00ED			; Escreve na saída de fita
TAPOOF:		equ 0x00F0			; Desliga saída de fita
STMOTR:		equ 0x00F3			; Controla motor da unidade de fita
LFTQ:		equ 0x00F6			; Verifica espaço em fila musical
PUTQ:		equ 0x00F9			; Coloca byte em fila musical
RIGHTC:		equ 0x00FC			; Move endereço de pixel à direita
LEFTC:		equ 0x00FF			; Move endereço de pixel à esquerda
UPC:		equ 0x0102			; Move endereço de pixel acima
TUPC:		equ 0x0105			; Testa e move endereço de pixel acima
DOWNC:		equ 0x0108			; Move endereço de pixel abaixo
TDOWNC:		equ 0x010B			; Testa e Move endereço de pixel abaixo
SCALXY:		equ 0x010E			; "Clipa" coordenadas gráficas
MAPXYC:		equ 0x0111			; Converte coordenadas do modo gráfico
FETCHC:		equ 0x0114			; Obtém endereço físico do pixel atual
STOREC:		equ 0x0117			; Armazena endereço físico do pixel atual
SETATR:		equ 0x011A			; Muda cor de desenho
READC:		equ 0x011D			; Lê atributo do pixel atual
SETC:		equ 0x0120			; Muda atributo do pixel atual
NSETCX:		equ 0x0123			; Muda atributo de uma sequência de pixels
CHGCAP:		equ 0x0132			; Altera LED do CAPS LOCK
CHGSND:		equ 0x0135			; Altera o estado do click do teclado
RSLREG:		equ 0x0138			; Lê registrador do slot primário
WSLREG:		equ 0x013B			; Escreve registrador do slot primário
RDVDP:		equ 0x013E			; Lê registrador de status do VDP
SNSMAT:		equ 0x0141			; Lê linha da matriz de teclado
KILBUF:		equ 0x0156			; Limpa buffer do teclado
CALBAS:		equ 0x0159			; Chama rotina BASIC a partir de qualquer slot
;=============================================================================
; MSX1-BIOS SYSTEM VARIABLES
;=============================================================================
USRTAB0:	equ 0xF39A			; Endereço da função USR0
USRTAB1:	equ 0xF39C			; Endereço da função USR1
USRTAB2:	equ 0xF39E			; Endereço da função USR2
USRTAB3:	equ 0xF3A0			; Endereço da função USR3
USRTAB4:	equ 0xF3A2			; Endereço da função USR4
USRTAB5:	equ 0xF3A4			; Endereço da função USR5
USRTAB6:	equ 0xF3A6			; Endereço da função USR6
USRTAB7:	equ 0xF3A8			; Endereço da função USR7
USRTAB8:	equ 0xF3AA			; Endereço da função USR8
USRTAB9:	equ 0xF3AC			; Endereço da função USR9
LINL40:		equ 0xF3AE			; Largura da screen 0 (comando WIDTH)
LINL32:		equ 0xF3AF			; Largura da screen 1 (comando WIDTH)
LINLEN:		equ 0xF3B0			; Largura do modo de texto atual
CRTCNT:		equ 0xF3B1			; Número de linhas nos modos texto
TXTNAM:		equ 0xF3B3			; Modo texto 40*24: Base da tabela de nomes
TXTCOL:		equ 0xF3B5			; Modo texto 40*24: Base da tabela de cores
TXTCGP:		equ 0xF3B7			; Modo texto 40*24: Base da tabela de caracteres
TXTATR:		equ 0xF3B9			; Modo texto 40*24: Base dos atributos de sprite
TXTPAT:		equ 0xF3BB			; Modo texto 40*24: Base das imagens de sprite
T32NAM:		equ 0xF3BD			; Modo texto 32*24: Base da tabela de nomes
T32COL:		equ 0xF3BF			; Modo texto 32*24: Base da tabela de cores
T32CGP:		equ 0xF3C1			; Modo texto 32*24: Base da tabela de caracteres
T32ATR:		equ 0xF3C3			; Modo texto 32*24: Base dos atributos de sprite
T32PAT:		equ 0xF3C5			; Modo texto 32*24: Base das imagens de sprite
GRPNAM:		equ 0xF3C7			; Modo gráfico 256*192: Base da tabela de nomes
GRPCOL:		equ 0xF3C9			; Modo gráfico 256*192: Base da tabela de cores
GRPCGP:		equ 0xF3CB			; Modo gráfico 256*192: Base da tabela de caracteres
GRPATR:		equ 0xF3CD			; Modo gráfico 256*192: Base dos atributos de sprite
GRPPAT:		equ 0xF3CF			; Modo gráfico 256*192: Base das imagens de sprite
MLTNAM:		equ 0xF3D1			; Modo gráfico 64*48: Base da tabela de nomes
MLTCOL:		equ 0xF3D3			; Modo gráfico 64*48: Base da tabela de cores
MLTCGP:		equ 0xF3D5			; Modo gráfico 64*48: Base da tabela de caracteres
MLTATR:		equ 0xF3D7			; Modo gráfico 64*48: Base dos atributos de sprite
MLTPAT:		equ 0xF3D9			; Modo gráfico 64*48: Base das imagens de sprite
CLIKSW:		equ 0xF3DB			; Click do teclado: 0=desligado, 1-255: ligado
CSRY:		equ 0xF3DC			; Coordenada Y do cursor em modo texto (1...CRTCNT)
CSRX:		equ 0xF3DD			; Coordenada X do cursor em modo texto (1...LINLEN)
CONSDFG:	equ 0xF3DE			; Apresentação das teclas de função: 0=desligado
RG0SAV:		equ 0xF3DF			; Cópia dos registrador 0 do VDP (somente escrita)
RG1SAV:		equ 0xF3E0			; Cópia dos registrador 1 do VDP (somente escrita)
RG2SAV:		equ 0xF3E1			; Cópia dos registrador 2 do VDP (somente escrita)
RG3SAV:		equ 0xF3E2			; Cópia dos registrador 3 do VDP (somente escrita)
RG4SAV:		equ 0xF3E3			; Cópia dos registrador 4 do VDP (somente escrita)
RG5SAV:		equ 0xF3E4			; Cópia dos registrador 5 do VDP (somente escrita)
RG6SAV:		equ 0xF3E5			; Cópia dos registrador 6 do VDP (somente escrita)
RG7SAV:		equ 0xF3E6			; Cópia dos registrador 7 do VDP (somente escrita)
STATFL:		equ 0xF3E7			; Cópia do registrador de status do VDP
TRGFLG:		equ 0xF3E8			; Estado dos botões joysticks e da barra de espaço
FORCLR:		equ 0xF3E9			; Cor do primeiro plano
BAKCLR:		equ 0xF3EA			; Cor do segundo plano (fundo)
BDRCLR:		equ 0xF3EB			; Cor da borda
MAXUPD:		equ 0xF3EC			; (Código automodificável usado para traçar retas)
MINUPD:		equ 0xF3EF			; (Código automodificável usado para traçar retas)
ATRBYT:		equ 0xF3F2			; Cor da tinta gráfica em funções gráficas da BIOS
QUEUES:		equ 0xF3F3			; endereço do bloco de controle das filas musicais
FRCNEW:		equ 0xF3F5			; Indicador que distingue CLOAD (0) de CLOAD? (255)
SCNCNT:		equ 0xF3F6			; Contador controlar a freq das varreduras do teclado
REPCNT:		equ 0xF3F7			; Contador número de repetições de uma tecla
PUTPNT:		equ 0xF3F8			; Endereço de inserção em KEYBUF (buffer circular)
GETPNT:		equ 0xF3FA			; Endereço de remoção em KEYBUF (buffer circular)
CS1200:		equ 0xF3FC			; Parâmetros do cassete para 1200 baud
CS2400:		equ 0xF401			; Parâmetros do cassete para 2400 baud
CASLOW:		equ 0xF406			; Parâmetros do cassete atuais: ciclo LO
CASHIGH:	equ 0xF408			; Parâmetros do cassete atuais: ciclo HI
HEADER:		equ 0xF40A			; Parâmetros do cassete atuais: ciclos no cabeçalho
ASPCT1:		equ 0xF40B			; Inverso da razão de aspecto do CIRCLE*256
ASPCT2:		equ 0xF40D			; Razão de aspecto do CIRCLE*256
ENDPRG:		equ 0xF40F			; Usado pelo interpretador BASIC para ON ERROR GOTO
ERRFLG:		equ 0xF414			; Armazena o código de erro do BASIC
LPTPOS:		equ 0xF415			; LPRINT, armazena posição da cabeça de impressão
PRTFLG:		equ 0xF416			; OUTDO saida para a tela(0) ou impressora (1)
NTMSXP:		equ 0xF417			; conversão OUTDO (0=sem conversão, 1-255=espaços)
RAWPRT:		equ 0xF418			; OUTDO: 0=prefixos gráficos,1=envia sem tratamento
VLZADR:		equ 0xF419			; Temporário usado pela função VAL do BASIC
VLZDAT:		equ 0xF41B			; Temporário usado pela função VAL do BASIC
KBFMIN:		equ 0xF41E			; Utilizado no tratamento de erros do BASIC
KBUF:		  equ 0xF41F		  ; Utilizado no tratamento de erros do BASIC (318)
BUFMIN:		equ 0xF55D			; Utilizado na entrada de linhas BASIC
BUF:		  equ 0xF55E		  ; Utilizado na entrada de linhas BASIC (259)
TTYPOS:		equ 0xF661			; Posição de tela atual, usada pelo PRINT
DIMFLG:		equ 0xF662			; Usado pelo interpretador BASIC na instrução DIM
VALTYP:		equ 0xF663			; Usado pelo interpretador BASIC
DORES:		equ 0xF664			; Usada pelo interpretador BASIC (linhas DATA)
DONUM:		equ 0xF665			; Usada pelo interpretador BASIC
CONTXT:		equ 0xF666			; Usada pelo interpretador BASIC
CONSAV:		equ 0xF668			; Usada pelo interpretador BASIC
CONTYP:		equ 0xF669			; Usada pelo interpretador BASIC
CONLO:		equ 0xF66A			; Usada pelo interpretador BASIC
STKTOP:		equ 0xF674			; Contém o endereço do topo da pilha
TXTTAB:		equ 0xF676			; Contém o endereço do texto de programa BASIC
TEMPPT:		equ 0xF678			; Aponta para a próxima entrada livre de TEMPST
TEMPST:		equ 0xF67A			; Buffer de descritores de string (BASIC)
DSCTMP:		equ 0xF698			; Buffer temporário para funções de string (BASIC)
FRETOP:		equ 0xF69B			; próxima posição livre no buffer a partit de MEMSIZ
TEMP3:		equ 0xF69D			; Variável temporária (interpretador BASIC)
TEMP8:		equ 0xF69F			; Variável temporária (interpretador BASIC)
ENDFOR:		equ 0xF6A1			; Usada pelo interpretador BASIC (loops FOR)
DATLIN:		equ 0xF6A3			; Linha do programa BASIC do item DATA atual
SUBFLG:		equ 0xF6A5			; Usada pelo interpretador BASIC
FLGINP:		equ 0xF6A6			; BASIC: distingue INPUT (0) de READ (1-255)
TEMP:		  equ 0xF6A7			; Variável temporária (interpretador BASIC)
PTRFLG:		equ 0xF6A9			; Usada pelo interpretador BASIC
AUTFLG:		equ 0xF6AA			; Flag do modo AUTO do BASIC
AUTLIN:		equ 0xF6AB			; Número da linha AUTO atual (BASIC)
AUTINC:		equ 0xF6AD			; Incremento atual do AUTO (BASIC)
SAVTXT:		equ 0xF6AF			; Usado pelo manipulador de erro (BASIC)
ERRLIN:		equ 0xF6B3			; Número da linha que gerou o erro (BASIC)
DOT:		  equ 0xF6B5			; Usada pelo interpretador BASIC
ERRTXT:		equ 0xF6B7			; Usada pelo interpretador BASIC (RESUME)
ONELIN:		equ 0xF6B9			; Usada pelo interpretador BASIC (ON ERROR GOTO)
ONEFLG:		equ 0xF6BB			; Usada pelo interpretador BASIC (ON ERROR GOTO)
TEMP2:		equ 0xF6BC			; Variável temporária (interpretador BASIC)
OLDLIN:		equ 0xF6BE			; Linha que terminou o programa BASIC, usada por CONT
OLDTXT:		equ 0xF6C0			; Aponta a instrução que terminou o programa
VARTAB:		equ 0xF6C2			; área de armazenamento de variáveis (BASIC)
ARYTAB:		equ 0xF6C4			; área de armazenamente de arrays (BASIC)
STREND:		equ 0xF6C6			; byte seguinte à área de ARYTAB (BASIC)
DATPTR:		equ 0xF6C8			; Aponta para item DATA atual (BASIC)
DEFTBL:		equ 0xF6CA			; Tp de variavel,por letra (BASIC),DEFINT,DEFSTR,...
PRMSTK:		equ 0xF6E4			; Usada pelo interpretador BASIC
PRMLEN:		equ 0xF6E6			; Usada pelo interpretador BASIC
PARM1:		equ 0xF6E8			; Usada pelo interpretador BASIC (buffer do FN)
PRMPRV:		equ 0xF74C			; Usada pelo interpretador BASIC (FN)
PRMLN2:		equ 0xF74E			; Usada pelo interpretador BASIC (FN)
PARM2:		equ 0xF750			; Usada pelo interpretador BASIC (buffer do FN)
PRMFLG:		equ 0xF7B4			; Usada pelo interpretador BASIC
ARYTA2:		equ 0xF7B5			; Usada pelo interpretador BASIC
NOFUNS:		equ 0xF7B7			; Usada pelo interpretador BASIC
TEMP9:		equ 0xF7B8			; Variável temporária (interpretador BASIC)
FUNACT:		equ 0xF7BA			; Usada pelo interpretador BASIC
SWPTMP:		equ 0xF7BC			; Usada pelo interpretador BASIC (SWAP)
TRCFLG:		equ 0xF7C4			; Ativado quando TRON está ligado (BASIC)
FBUFFR:		equ 0xF7C5			; Buffer de conversão numérica (BASIC)
DECTM2:		equ 0xF7F2			; Variável temporária (interpretador BASIC)
DECCNT:		equ 0xF7F4			; Variável temporária (interpretador BASIC)
DAC:		  equ 0xF7F6			; Buffer de avaliação de expressão do BASIC
ARGUSR:		equ 0xF7F8			; ?
HOLD8:		equ 0xF806			; Buffer temporário de multiplicação (BASIC)
ARG:		  equ 0xF847			; Buffer de avaliação de expressão do BASIC
RNDX:		  equ 0xF857			; Contém o último número aleatório (precisão dupla)
MAXFIL:		equ 0xF85F			; Número de buffers de E/S alocados (BASIC)
FILTAB:		equ 0xF860			; Aponta tabela de FCBs dos buffers de E/S (BASIC)
NULBUF:		equ 0xF862			; Aponta para o buffer de E/S
PTRFIL:		equ 0xF864			; Aponta para o FCB do buffer de E/S ativo
FILNAM:		equ 0xF866			; Buffer de nome de arquivo. (BASIC)
FILNM2:		equ 0xF871			; Buffer de nome de arquivo. (BASIC)
NLONLY:		equ 0xF87C			; Usada pelo interpretador BASIC
SAVEND:		equ 0xF87D			; Usada pelo interpretador BASIC
FNKSTR:		equ 0xF87F			; Buffer com strings das teclas de função
CGPNT:		equ 0xF91F			; Tabela de caract. em ROM (Slot ID 0,endereço 0x1BBF)
NAMBAS:		equ 0xF922			; Base da tabela de nomes no modo de video atual
CGPBAS:		equ 0xF924			; Base da tabela de caracteres no modo de video atual
PATBAS:		equ 0xF926			; Base da tabela de imagens de sprites no modo de video atual
ATRBAS:		equ 0xF928			; Base da tabela de atributos de sprites no modo de ví deo atual
CLOC:		  equ 0xF92A			; Endereço do pixel atual (funções gráficas da BIOS)
CMASK:		equ 0xF92C			; Máscara do pixel atual
MINDEL:		equ 0xF92D			; Usado pela instrução LINE
MAXDEL:		equ 0xF92F			; Usado pela instrução LINE
ASPECT:		equ 0xF931			; Usado pela instrução CIRCLE
CENCNT:		equ 0xF933			; Usado pela instrução CIRCLE
CLINEF:		equ 0xF935			; Usado pela instrução CIRCLE
CNPNTS:		equ 0xF936			; Usado pela instrução CIRCLE
CPLOTF:		equ 0xF938			; Usado pela instrução CIRCLE
CPCNT:		equ 0xF939			; Usado pela instrução CIRCLE
CPCNT8:		equ 0xF93B			; Usado pela instrução CIRCLE
CRCSUM:		equ 0xF93D			; Usado pela instrução CIRCLE
CSTCNT:		equ 0xF93F			; Usado pela instrução CIRCLE
CSCLXY:		equ 0xF941			; Usado pela instrução CIRCLE
CSAVEA:		equ 0xF942			; Temporário usado por funções gráficas da BIOS
CSAVEM:		equ 0xF944			; Temporário usado por funções gráficas da BIOS
CXOFF:		equ 0xF945			; Usado pela instrução CIRCLE
CYOFF:		equ 0xF947			; Usado pela instrução CIRCLE
LOHMSK:		equ 0xF949			; Usado pela instrução PAINT
LOHDIR:		equ 0xF94A			; Usado pela instrução PAINT
LOHADR:		equ 0xF94B			; Usado pela instrução PAINT
LOHCNT:		equ 0xF94D			; Usado pela instrução PAINT
SKPCNT:		equ 0xF94F			; Usado pela instrução PAINT
MOVCNT:		equ 0xF951			; Usado pela instrução PAINT
PDIREC:		equ 0xF953			; Usado pela instrução PAINT
LEPROG:		equ 0xF954			; Usado pela instrução PAINT
RTPROG:		equ 0xF955			; Usado pela instrução PAINT
MCLFLG:		equ 0xF958			; Linguagem de macro atual, 0=DRAW, 1-255=PLAY
QUETAB:		equ 0xF959			; Blocos de controle das filas musicais
QUEBAK:		equ 0xF971			; Usado pelo manipulador de fila musical
VOICAQ:		equ 0xF975			; Buffer da fila musical A
VOICBQ:		equ 0xF9F5			; Buffer da fila musical B
VOICCQ:		equ 0xFA75			; Buffer da fila musical C
RS2IQ:		equ 0xFAF5			; Buffer da fila RS232
PRSCNT:		equ 0xFB35			; Usado pelo interpretador BASIC (PLAY)
SAVSP:		equ 0xFB36			; Usado pelo interpretador BASIC (PLAY)
VOICEN:		equ 0xFB38			; Voz atual do interpretador PLAY
SAVVOL:		equ 0xFB39			; Usado pelo interpretador BASIC (PLAY)
MCLLEN:		equ 0xFB3B			; Comprimento do operando de macro-linguagem analisado
MCLPTR:		equ 0xFB3C			; Aponta para caractere de macro-linguagem sendo analisado
QUEUEN:		equ 0xFB3E			; Fila atual do interpretador PLAY
MUSICF:		equ 0xFB3F			; Usado pelo interpretador BASIC (PLAY)
PLACNT:		equ 0xFB40			; Usado pelo interpretador BASIC (PLAY)
VCBA:		  equ 0xFB41			; Buffer com parâmetros da voz A do PLAY
VCBB:		  equ 0xFB66			; Buffer com parâmetros da voz B do PLAY
VCBC:		  equ 0xFB8B			; Buffer com parâmetros da voz C do PLAY
ENSTOP:		equ 0xFBB0			; Se diferente de 0, faz warm boot quando CODE+GRAPH+CTRL+SHIFT forem pressionadas
BASROM:		equ 0xFBB1			; Ativa (0) ou desativa (1-255) manipulador de CTRL+STOP
LINTTB:		equ 0xFBB2			; Variável interna de funções da BIOS
FSTPOS:		equ 0xFBCA			; Usada internamente pelo editor de tela do BASIC
CURSAV:		equ 0xFBCC			; Armazena o caractere sob o cursor
FNKSWI:		equ 0xFBCD			; Usada pela rotina CHSNS para determinar se SHIFT está pressionado (0) ou não (1) para apresentar as strings das teclas de função
FNKFLG:		equ 0xFBCE			; Usada pelo BASIC. (indicadores de KEY(n) ON)
ONGSBF:		equ 0xFBD8			; Usado pelo interpretador BASIC
OLDKEY:		equ 0xFBDA			; Armazena o estado anterior da matriz de teclado
NEWKEY:		equ 0xFBE5			; Armazena o estado atual da matriz de teclado
KEYBUF:		equ 0xFBF0			; Buffer circular do teclado (caracteres decodificados)
LINWRK:		equ 0xFC18			; Buffer de linha de tela, usado pelo BIOS
PATWRK:		equ 0xFC40			; Buffer usado pelo BIOS
BOTTOM:		equ 0xFC48			; Armazena o início da RAM usada pelo interpretador BASIC
TRPTBL:		equ 0xFC4C			; Usado pelas instruções de interrupção (ON...) do BASIC
RTYCNT:		equ 0xFC9A			; Não-utilizada
INTFLG:		equ 0xFC9B			; Flag de detecção de CTRL-STOP (3) e STOP (4)
PADY:		  equ 0xFC9C			; Última coordenada Y do tablet
PADX:		  equ 0xFC9D			; Última coordenada X do tablet
JIFFY:		equ 0xFC9E			; Contador incrementado a cada interrupção do VDP
INTVAL:		equ 0xFCA0			; Duração do intervalo do ON INTERVAL (BASIC)
INTCNT:		equ 0xFCA2			; Contador do ON INTERVAL (BASIC)
LOWLIM:		equ 0xFCA4			; Duração mnima do bit de partida no cassete (TAPION)
WINWID:		equ 0xFCA5			; Duração de discriminação LO/HI (TAPION)
GRPHED:		equ 0xFCA6			; Variável auxiliar da rotina CNVCHR do BIOS
ESCCNT:		equ 0xFCA7			; Variável auxiliar da rotina CHPUT do BIOS
INSFLG:		equ 0xFCA8			; Indica modo de inserção do editor de tela
CSTYLE:		equ 0xFCAA			; Estilo do cursor, bloco (0) ou sublinhado (1-255)
CAPST:		equ 0xFCAB			; Status do CAPS LOCK (0=desligado, 1-255=ligado)
KANAST:		equ 0xFCAC			; Status do KANA LOCK (0=desligado, 1-255=ligado)
KANAMD:		equ 0xFCAD			; Modo kana (MSX japoneses)
FLBMEM:		equ 0xFCAE			; Usada pelo manipulador de erro de E/S
SCRMOD:		equ 0xFCAF			; Modo de tela (SCREEN) atual
OLDSCR:		equ 0xFCB0			; último modo de texto
CASPRV:		equ 0xFCB1			; Temporário de E/S do cassete
BDRATR:		equ 0xFCB2			; Usado pelas rotinas gráficas do BIOS
GXPOS:		equ 0xFCB3			; Temporário das rotinas gráficas do BIOS
GYPOS:		equ 0xFCB5			; Temporário das rotinas gráficas do BIOS
GRPACX:		equ 0xFCB7			; Temporário das rotinas gráficas do BIOS
GRPACY:		equ 0xFCB9			; Temporário das rotinas gráficas do BIOS
DRWFLG:		equ 0xFCBB			; Usado pelo manipulador do DRAW
DRWSCL:		equ 0xFCBC			; Usado pelo manipulador do DRAW
DRWANG:		equ 0xFCBD			; Usado pelo manipulador do DRAW
RUNBNF:		equ 0xFCBE			; Usado pelo manipulador do BLOAD
SAVENT:		equ 0xFCBF			; Usado pelo manipulador do BLOAD
EXPTBL:		equ 0xFCC1			; 4 slots, (0x00=não expandido, 0x80=expandido)
SLTTBL:		equ 0xFCC5			; Cópia dos registradores de slot primário
SLTATR:		equ 0xFCC9			; Atributos de ROM,16 bytes por slot (4 por subslot)
SLTWRK:		equ 0xFD09			; bytes de trabalho para cada uma das 64 exten. ROM
PROCNM:		equ 0xFD89			; Buffer dispositivo/instrução analisado ROM de exten.
DEVICE:		equ 0xFD99			; passar número de dispositivo para ROM extensão.
CSRSW:		equ 0xFCA9			; Status do cursor (0=desligado, 1-255=ligado?)
