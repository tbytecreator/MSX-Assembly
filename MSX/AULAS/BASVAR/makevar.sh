#!/usr/bin/env bash
set -euo pipefail
BIN="levar.rom"
ASM="levar.asm"
# Se já existir, remove o binário antigo
if [ -f "$BIN" ]; then
  printf 'Removendo %s existente...\n' "$BIN"
  rm -f -- "$BIN"
fi
# Compila
printf 'Compilando %s -> %s\n' "$ASM" "$BIN"
if ! pasmo "$ASM" "$BIN"; then
  echo "Erro: compilação falhou"
  exit 1
fi
# Executa no emulador
exec openmsx -machine Gradiente_Expert_GPC-1 -cart "$BIN"