#!/bin/sh

set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
cd "$SCRIPT_DIR"

echo "====== Apagando a ROM antiga ====="
rm -f PCURSOR.BIN

echo "======= Compilando nova ROM ======"
pasmo --msx PCURSOR.ASM PCURSOR.BIN

echo "====== CHAMANDO O EMULADOR ======="
flatpak run --filesystem="$SCRIPT_DIR" org.openmsx.openMSX \
    -machine Gradiente_Expert_GPC-1 \
    -ext DDX_3.0 \
    -diska .
