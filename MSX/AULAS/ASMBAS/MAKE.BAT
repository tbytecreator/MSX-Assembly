@echo off
echo ====== Apagando a ROM antiga =====
del INVERTE.BIN
echo ======= Compilando nova ROM ======
pasmo --msx INVERTE.ASM INVERTE.BIN
echo ============= Pronto =============
openmsx -machine Gradiente_Expert_GPC-1 -ext DDX_3.0 -diska .