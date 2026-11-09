#!/usr/bin/env bash
set -euo pipefail

cd -- "$(dirname -- "$0")"

for tool in pasmo flatpak; do
    if ! command -v "$tool" >/dev/null 2>&1; then
        echo "Erro: $tool nao encontrado." >&2
        exit 1
    fi
done

for file in DOS/A/MSXDOS.SYS DOS/A/COMMAND.COM DOS/A/AUTOEXEC.BAT; do
    if [[ ! -f "$file" ]]; then
        echo "Erro: $file nao encontrado; consulte DOCS/DESENVOLVIMENTO.md." >&2
        exit 1
    fi
done

if ! flatpak info org.openmsx.openMSX >/dev/null 2>&1; then
    echo "Erro: Flatpak org.openmsx.openMSX nao instalado." >&2
    exit 1
fi

echo "Compilando TBC..."
mkdir -p .dist DOS/B
pasmo -I SRC SRC/TBC.ASM .dist/TBC.COM .dist/TBC.sym
cp -- .dist/TBC.COM DOS/A/TBC.COM

echo "Iniciando openMSX com DOS/A na unidade A: e DOS/B na unidade B:..."
exec flatpak run org.openmsx.openMSX \
    -machine Gradiente_Expert_GPC-1 -ext Mitsubishi_ML-30DC_ML-30FD \
    -diska "$PWD/DOS/A" -diskb "$PWD/DOS/B" "$@"
