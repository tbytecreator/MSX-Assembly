# PCURSOR

Aplicativo em Assembly Z80 para ativar um cursor piscante no MSX. O código é
baseado no programa de Luiz Carlos Bittencourt publicado na revista *Clube MSX
No. 9*.

## Requisitos

- Pasmo para montar `PCURSOR.ASM`.
- Para executar no Linux, Flatpak instalado e o app OpenMSX
  `org.openmsx.openMSX`.
- A máquina Gradiente Expert GPC-1 e a extensão DDX 3.0 configuradas no
  OpenMSX.

## Linux

Na pasta do aplicativo, execute:

```sh
./make.sh
```

O script compila `PCURSOR.ASM` em `PCURSOR.BIN` no formato MSX, inicia o
OpenMSX pelo Flatpak e disponibiliza a pasta do aplicativo como disco A.

Se o script não tiver permissão de execução, use:

```sh
chmod +x make.sh
./make.sh
```

## Windows

Com Pasmo e OpenMSX instalados e disponíveis no `PATH`, execute `MAKE.BAT`
na pasta do aplicativo. O script gera `PCURSOR.BIN` e inicia o OpenMSX com a
máquina e a extensão configuradas no comando.

## Carregar no MSX

No MSX-BASIC, com o disco do aplicativo acessível, carregue e execute a rotina:

```basic
BLOAD "PCURSOR.BIN",R
```

O arquivo `AUTOEXEC.BAS` contém esse mesmo comando caso prefira carregá-lo
como programa BASIC:

```basic
RUN "AUTOEXEC.BAS"
```

## Arquivos

- `PCURSOR.ASM`: código-fonte Z80.
- `PCURSOR.BIN`: binário MSX gerado pelo Pasmo.
- `AUTOEXEC.BAS`: linha BASIC para carregar e executar o binário.
- `make.sh` e `MAKE.BAT`: scripts de compilação e inicialização do emulador
  para Linux e Windows, respectivamente.
