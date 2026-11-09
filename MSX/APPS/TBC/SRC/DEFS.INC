; ===========================================================================
; DEFS.INC - Constantes, mapa de memoria e estruturas do TBC
; ===========================================================================

; --- MSX-DOS 1 (BDOS) ------------------------------------------------------
BDOSV       equ 0005h       ; ponto de entrada do BDOS
F_DIRIO     equ 06h         ; E=0FFh: le tecla sem eco (A=0 se nao ha tecla)
F_PRSTR     equ 09h
F_SELDSK    equ 0Eh
F_OPEN      equ 0Fh
F_CLOSE     equ 10h
F_SFIRST    equ 11h
F_SNEXT     equ 12h
F_DELETE    equ 13h
F_MAKE      equ 16h
F_RENAME    equ 17h
F_LOGIN     equ 18h
F_CURDRV    equ 19h
F_SETDMA    equ 1Ah
F_ALLOC     equ 1Bh
F_WRBLK     equ 26h
F_RDBLK     equ 27h

; --- BIOS / variaveis de sistema -------------------------------------------
CALSLT      equ 001Ch       ; chamada inter-slot (existe na pagina 0 do DOS)
INITXT      equ 006Ch       ; SCREEN 0 (modo texto 40 colunas)
DSPFNK      equ 00CFh
FNKSTR      equ 0F87Fh      ; textos das teclas de funcao (16 bytes cada)
EXPTBL      equ 0FCC1h
LINL40      equ 0F3AEh
CNSDFG      equ 0F3DEh
FORCLR      equ 0F3E9h
BAKCLR      equ 0F3EAh
BDRCLR      equ 0F3EBh

; --- VDP -------------------------------------------------------------------
VDP_DATA    equ 98h
VDP_CMD     equ 99h
PATBASE     equ 0800h       ; tabela de padroes do SCREEN 0

; --- Codigos de teclas (via BDOS 6) ----------------------------------------
K_TAB       equ 09h
K_ENTER     equ 0Dh
K_ESC       equ 1Bh
K_BS        equ 08h
K_HOME      equ 0Bh
K_CLS       equ 0Ch         ; SHIFT+HOME
K_RIGHT     equ 1Ch
K_LEFT      equ 1Dh
K_UP        equ 1Eh
K_DOWN      equ 1Fh
K_QUIT      equ '%'         ; Shift+5 no teclado MSX

; --- Caracteres de moldura (padroes proprios nos codigos 1..8) -------------
CH_H        equ 1
CH_TL       equ 2
CH_TR       equ 3
CH_BL       equ 4
CH_BR       equ 5
CH_LT       equ 6
CH_RT       equ 7
CH_V        equ 8

; --- Layout da tela (40x24) ------------------------------------------------
PAN_W       equ 20          ; largura de cada painel
PAN_ROWS    equ 19          ; linhas de arquivos visiveis
MAXENT      equ 128         ; maximo de entradas por painel
ENT_SZ      equ 16          ; bytes por entrada: nome(11) tamanho(4) +1

; --- Estrutura do painel ---------------------------------------------------
P_DRV       equ 0           ; unidade (1=A:)
P_CNT       equ 1           ; numero de arquivos
P_CUR       equ 2           ; indice do cursor
P_TOP       equ 3           ; indice da primeira linha visivel
P_X         equ 4           ; coluna inicial na tela
P_ENT       equ 5           ; (word) ponteiro para a tabela de entradas
P_FREE      equ 7           ; (word) espaco livre em KB

; --- FCB -------------------------------------------------------------------
FCB_LEN     equ 37
FCB_REC     equ 14          ; tamanho do registro (word)
FCB_RND     equ 33          ; registro aleatorio (4 bytes)

; --- Mapa de memoria (RAM de trabalho, acima do codigo) --------------------
PAN0        equ 8000h
PAN1        equ 8010h
ACTIVE      equ 8020h       ; (word) ponteiro para o painel ativo
INV         equ 8022h       ; 0 ou 80h: somado a cada caractere (video inverso)
CNSDSAVE    equ 8023h
SO_I        equ 8024h
SO_J        equ 8025h
INLEN       equ 8026h
CP_SRC      equ 8027h
CP_DST      equ 8028h
ILPROMPT    equ 8029h       ; (word)
CP_N        equ 802Bh       ; (word)
CP_POS      equ 802Dh       ; (dword)
PN_DST      equ 8031h       ; (word)
CURROW      equ 8033h
VWN         equ 8034h       ; (word)
VWPOS       equ 8036h       ; (dword)
TMP8        equ 803Ah       ; (8 bytes)
FCB1        equ 8040h
FCB2        equ 8070h
DMA         equ 80A0h       ; 128 bytes
INBUF       equ 8120h       ; 16 bytes
TMPENT      equ 8130h       ; 16 bytes
CPNAME      equ 8140h       ; 11 bytes
NEWNAME     equ 8150h       ; 11 bytes
ENT0        equ 8200h       ; MAXENT*ENT_SZ = 2048 bytes
ENT1        equ 8A00h
COPYBUF     equ 9200h       ; 4096 bytes
FNKSAVE     equ 0A200h      ; copia de F1-F10 (160 bytes)
RAM_END     equ 0A300h

COPYSZ      equ 4096        ; bytes por bloco na copia
VWSZ        equ 920         ; 23 linhas x 40 colunas no visualizador
