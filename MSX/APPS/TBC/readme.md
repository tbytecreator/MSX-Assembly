# TBC - TByteCreator Commander: Manual de Uso

TBC é um gerenciador de arquivos de dois painéis, inspirado no Norton
Commander, para **MSX 1 com MSX-DOS 1**.

## Requisitos

- MSX com MSX-DOS 1 (ou superior) e pelo menos uma unidade de disco.
- Para usar as operações entre unidades (copiar), duas unidades de disco ou
  duas unidades lógicas.
- Tela de 40 colunas (o TBC ativa o modo texto de 40 colunas sozinho).

## Instalação e execução

1. Copie `TBC.COM` para o disco de boot (ele é gerado em `.dist/TBC.COM`
   por `make`).
2. No prompt do MSX-DOS, digite:

```dos
A>TBC
```

Para iniciar o TBC automaticamente, coloque a linha `TBC` no
`AUTOEXEC.BAT` do disco.

No emulador openMSX (Linux, Flatpak), use `./make.sh` ou `make run`:
a pasta `DOS/A` vira a unidade A: e `DOS/B` a unidade B:.

## A tela

```ascii
┌──────── A: ─────────┐┌──────── B: ─────────┐
│AUTOEXEC.BAT      1K ││TESTE1  .TXT      1K │
│COMMAND .COM      7K ││                     │
│...                  ││                     │
├─────────────────────┤├─────────────────────┤
│4 files 698K         ││1 files 712K         │
└─────────────────────┘└─────────────────────┘
1Drv 2View 3Copy 4Ren 5Del S5Quit
```

- Dois painéis lado a lado, cada um mostrando uma unidade.
- O título do painel ativo aparece em vídeo inverso e a linha do cursor
  também é destacada.
- Cada linha mostra o nome, a extensão e o tamanho em KB (arredondado para
  cima).
- Na base de cada painel ficam a quantidade de arquivos e o espaço livre.
- A última linha da tela é a barra de teclas.

Os arquivos são listados em ordem alfabética. O MSX-DOS 1 não tem
subdiretórios, então cada painel mostra a raiz da unidade (até 128 arquivos).

## Teclas

As ações usam as teclas **1** a **5** do teclado principal. As teclas
**F1** a **F5** funcionam do mesmo jeito.

| Tecla                  | Função                                                       |
|------------------------|--------------------------------------------------------------|
| ↑ / ↓                  | move o cursor                                                |
| HOME                   | vai ao primeiro arquivo                                      |
| SHIFT+HOME             | vai ao último arquivo                                        |
| TAB, ← ou →            | alterna o painel ativo                                       |
| **1** / F1             | troca a unidade do painel ativo (próxima unidade disponível) |
| **2** / F2             | visualiza o arquivo sob o cursor                             |
| **3** / F3             | copia o arquivo para a unidade do outro painel               |
| **4** / F4             | renomeia o arquivo                                           |
| **5** / F5             | apaga o arquivo                                              |
| **Shift+5** / Shift+F5 | sai do TBC                                                   |

## Operações

### 1 - Trocar de unidade

Passa o painel ativo para a próxima unidade existente (A:, B:, ...),
voltando à primeira depois da última, e relê o diretório.

### 2 - Visualizar

Mostra o conteúdo do arquivo como texto bruto.

- **SPACE**: próxima página.
- **BACKSPACE**: página anterior.
- **ESC** (ou **2**): fecha o visualizador.

Arquivos binários (`.COM`, `.SYS`) aparecem com caracteres sem sentido; isso
é esperado.

### 3 - Copiar

Copia o arquivo sob o cursor do painel ativo para a unidade do **outro**
painel, mantendo o nome.

1. Pressione **3**.
2. Confirme com **Y** (ou cancele com **N** / **ESC**).
3. Se o arquivo já existir no destino, o TBC pergunta se deve sobrescrever.

Se os dois painéis estiverem na mesma unidade, a cópia é recusada. Se o
disco de destino encher, a cópia é abortada e o arquivo parcial é removido.
Ao final, os painéis são relidos.

### 4 - Renomear

Abre uma caixa pedindo o novo nome. Digite o nome (formato `NOME.EXT`) e
pressione **ENTER**; **ESC** cancela. **BACKSPACE** apaga o último
caractere.

### 5 - Apagar

Pede confirmação (**Y** / **N** / **ESC**) e apaga o arquivo sob o cursor.
A operação não pode ser desfeita.

### Shift+5 - Sair

Sai do TBC, restaura as teclas de função do MSX, limpa a tela e volta ao
MSX-DOS.

## Mensagens

| Mensagem                        | Significado                                                   |
|---------------------------------|---------------------------------------------------------------|
| Both panels use the same drive. | copiar exige unidades diferentes nos painéis                  |
| File exists. Overwrite?         | o destino já tem um arquivo com esse nome                     |
| Cannot open file.               | falha ao abrir o arquivo de origem                            |
| Cannot create file.             | falha ao criar o arquivo no destino                           |
| Disk full. Copy aborted.        | o destino não tem espaço                                      |
| Delete failed. / Rename failed. | o MSX-DOS recusou a operação (por exemplo, nome já existente) |
| Not enough memory.              | a TPA é pequena demais para o TBC                             |

## Limitações

- Sem subdiretórios (limitação do MSX-DOS 1).
- Sem seleção múltipla: uma operação por arquivo.
- Máximo de 128 arquivos por unidade.
- Erros de disco do próprio DOS (por exemplo, unidade sem disco) mostram o
  prompt padrão do MSX-DOS por cima da tela.
- Funcionamento em hardware real ainda não foi validado; os testes foram
  feitos no openMSX.
