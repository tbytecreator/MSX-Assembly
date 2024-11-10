@echo off
echo ====== Apagando a ROM antiga =====
del BCALL.BIN
echo ======= Compilando nova ROM ======
pasmo --msx BCALL.ASM BCALL.BIN
echo ============= Pronto =============
openmsx -machine Gradiente_Expert_GPC-1 -ext DDX_3.0 -diska .