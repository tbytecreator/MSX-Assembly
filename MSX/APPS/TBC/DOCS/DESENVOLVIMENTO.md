# TBC - Documentação de desenvolvimento

TBC (Tbyte Commander) é um gerenciador de arquivos em dois painéis, inspirado no
[Norton Commander](https://en.wikipedia.org/wiki/Norton_Commander), para **MSX 1**
rodando **MSX-DOS 1**. Escrito em Assembly Z80, compilado com
[PASMO](https://pasmo.speccy.org/).

## Compilação

```bash
make            # gera .dist/TBC.COM (e .dist/TBC.sym)
# ou diretamente:
pasmo -I SRC SRC/TBC.ASM .dist/TBC.COM .dist/TBC.sym
```

Formato de saída: binário puro (`.COM`), `org 0100h`. Copie `TBC.COM` para um
disco MSX-DOS e execute `TBC`.

## Execução no openMSX Flatpak

No Linux, execute na pasta do projeto:

```sh
./make.sh
# ou: make run
```

`make.sh` é um script Bash para Linux, não um
arquivo de lote do Windows. Ele compila com PASMO, copia `TBC.COM` para `DOS/A/`
e inicia `org.openmsx.openMSX` usando `Gradiente_Expert_GPC-1`, a extensão
`Mitsubishi_ML-30DC_ML-30FD`, `-diska DOS/A/` e `-diskb DOS/B/`.
A extensão Mitsubishi oferece dois drives físicos; a `DDX_3.0` usada no exemplo
HELLODSK emula apenas um drive.
O arquivo `DOS/A/AUTOEXEC.BAT` executa `TBC` quando o MSX-DOS termina de iniciar.
O script cria `DOS/B/` automaticamente se o diretório não existir.

São necessários o PASMO, o Flatpak do openMSX, os arquivos de ROM para essa
máquina e extensão e uma cópia de MSX-DOS 1 em `DOS/A/MSXDOS.SYS` e
`DOS/A/COMMAND.COM`. Esses dois arquivos não são distribuídos no repositório;
copie-os de uma instalação de MSX-DOS que você possa utilizar. O Flatpak deve
ter permissão de acesso à pasta do projeto. Confira com
`flatpak info --show-permissions org.openmsx.openMSX`.

Os diretórios `DOS/A/` e `DOS/B/` são discos graváveis compartilhados com o emulador: operações
de apagar, renomear e escrever dentro do MSX alteram os arquivos reais dessa
pasta. Não coloque neles arquivos importantes sem cópia de segurança. Cada
execução do script substitui `DOS/A/TBC.COM` pela versão recém-compilada.

## Estrutura do projeto

| Arquivo         | Conteúdo                                                            |
|-----------------|---------------------------------------------------------------------|
| `SRC/TBC.ASM`   | Ponto de entrada, inicialização, laço principal e saída             |
| `SRC/DEFS.INC`  | Constantes (BDOS, BIOS, VDP, teclas), estruturas e mapa de RAM      |
| `SRC/VIDEO.INC` | Acesso direto ao VDP, fonte de moldura/invertida, impressão decimal |
| `SRC/UI.INC`    | Painéis, barra de teclas e diálogos modais                          |
| `SRC/DIR.INC`   | Leitura/ordenação de diretório, recarga, troca de unidade           |
| `SRC/OPS.INC`   | Copiar, renomear, apagar, visualizar                                |
| `SRC/DATA.INC`  | Textos da interface                                                 |
| `make.sh`       | Compilação e execução no openMSX Flatpak (Bash no Linux)            |
| `DOS/A/`        | Disco da unidade A:, com arquivos do DOS e inicialização automática |
| `DOS/B/`        | Disco da unidade B:                                                 |

## Arquitetura

### Alvo

- MSX 1 (Z80, VDP TMS9918), 64 KB de RAM, MSX-DOS 1 (BDOS clássico estilo CP/M,
  FCB, **sem subdiretórios**).
- Tela: SCREEN 0, 40x24. Inicializada via BIOS `INITXT` (chamada com `CALSLT`),
  cores branco sobre azul escuro.

### Vídeo

- Escrita direta na VRAM (portas `98h`/`99h`); nome da tabela em `0000h`,
  padrões em `0800h`. O endereço é configurado com `DI`/`EI` para não
  colidir com a interrupção da BIOS.
- Moldura: padrões próprios nos códigos 1..8 (`CH_*`).
- Seleção: a fonte é duplicada de forma negativa nos códigos `A0h..FFh`
  (`c OR 80h` = negativo de `c`). A variável `INV` (0 ou 80h) é somada a cada
  caractere em `vputc`, produzindo vídeo inverso sem atributos de cor.

### Layout (40 colunas)

```ascii
col  0..19  painel esquerdo      col 20..39  painel direito
linha 0      borda superior + unidade (invertida se painel ativo)
linhas 1-19  arquivos (NOME.EXT TTTTK, 18 colunas)
linha 20     separador
linha 21     "N files LIVRE K"
linha 22     borda inferior
linha 23     barra de teclas ou instruções do visualizador
```

### Teclado

Leitura via BDOS 6 (sem eco). As ações dos painéis usam as teclas numéricas;
`S5` na barra indica Shift+5 (caractere `%` no teclado MSX).
F1–F5 também funcionam: ao iniciar, o TBC salva os textos de `FNKSTR` (`F87Fh`, F1–F10) e
reprograma F1–F5 para gerar `1`–`5` e Shift+F5 (F10) para gerar `%` (sair); ao sair, restaura os originais.

| Tecla               | Ação                                                        |
|---------------------|-------------------------------------------------------------|
| ↑ / ↓               | move cursor                                                 |
| HOME / SHIFT+HOME   | primeiro / último arquivo                                   |
| TAB, ← , →          | alterna painel ativo                                        |
| 1                   | próxima unidade no painel ativo                             |
| 2                   | visualizar (texto bruto; SPACE/BS paginam, ESC ou 2 fecha)  |
| 3                   | copiar para a unidade do outro painel                       |
| 4                   | renomear                                                    |
| 5                   | apagar                                                      |
| Shift+5             | sair                                                        |

Mensagens, confirmações e a entrada do novo nome aparecem em uma caixa modal
central. As confirmações aceitam Y, N ou ESC; a entrada aceita ENTER ou ESC.
Ao fechar o diálogo, os painéis são redesenhados.

### Dados

- Cada painel (`P_*` em `DEFS.INC`): unidade, contagem, cursor, topo, coluna,
  ponteiro da tabela e espaço livre.
- Tabela de entradas: até 128 × 16 bytes (nome 11, tamanho 4, 1 reservado),
  ordenada por nome (inserção) após a leitura.
- Listagem: BDOS `11h/12h` com FCB `???????????`; espaço livre: BDOS `1Bh`
  (assume setor de 512 bytes).
- Cópia: BDOS `27h/26h` (bloco aleatório, registro de 1 byte, blocos de 4096
  bytes) com posição de 32 bits mantida em `CP_POS`; preserva o tamanho exato.

### Convenções do código

- `IX` = painel corrente nas rotinas de painel. Todas as chamadas ao BDOS
  passam por `bdos` (salva/restaura `IX`).
- Nomes em MAIÚSCULAS = constantes/endereços de RAM; minúsculas = rotinas.
- Compatível com PASMO (`include`, `equ`, `defb`, `end start`).
  Saltos curtos (`jr`) fora de alcance devem virar `jp`.

## Mapa de memória

```ascii
0100h        código (≈2,9 KB)
8000h-80FFh  variáveis, painéis, FCBs, DMA, buffers pequenos (ver DEFS.INC)
8200h/8A00h  tabelas de entradas dos painéis (2 KB cada)
9200h        buffer de cópia/visualização (4 KB)
```

O programa verifica no início se a TPA chega a `RAM_END` (A300h).

## Estado e limitações conhecidas

- O boot e a abertura dos painéis foram observados no openMSX 21.0 com o
  MSX-DOS 1.03. As operações de arquivos e o funcionamento em hardware real
  ainda não foram validados.
- Tamanhos: o BDOS `11h/12h` (Search First/Next) devolve em `DMA` um byte
  extra seguido da entrada de diretório de 32 bytes: nome em `DMA+1..11` e
  tamanho de 32 bits em `DMA+29..32`. Antes o código lia `DMA+16` (o que
  resultava em `0K`); corrigido e verificado no openMSX (COMMAND.COM 7K,
  MSXDOS.SYS 3K, TBC.COM 3K).
- Ainda a verificar: `CALSLT` em `001Ch` e o retorno de `1Bh` (espaço livre).
- Sem subdiretórios (limitação do MSX-DOS 1). Erros de disco (ex.: sem disco)
  exibem o prompt padrão do DOS por cima da tela.
- Sem seleção múltipla; máximo de 128 arquivos por unidade.

## Roadmap

1. Validar em openMSX (MSX-DOS 1) e corrigir ajustes de BDOS/BIOS.
2. Tratador próprio de erros de disco (sem prompt do DOS sobre a tela).
3. Seleção múltipla (INS) e operações em lote.
4. Executar `.COM` com ENTER; linha de comando.
5. Visualizador com quebra de linha em CR/LF; modo hexadecimal.
6. Editor simples (F4); formatar disco; atributos.
7. Suporte a MSX-DOS 2 (subdiretórios, FIB) em build separado.
