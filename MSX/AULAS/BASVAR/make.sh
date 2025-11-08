·#!/bin/sh
BIN="levar.bin"
ASM="levar.asm"
# Se já existir, remove o binário antigo
if [ -f "$BIN" ]; then
  echo "Removendo $BIN existente..."
  rm -f "$BIN"
fi
# Compila
echo "Compilando $ASM -> $BIN"
pasmo --msx "$ASM" "$BIN" || { echo "Erro: compilação falhou"; exit 1; }
# Executa no emulador
openmsx -machine Gradiente_Expert_GPC-1 -ext DDX_3.0 -diska .