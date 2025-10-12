@echo off
echo ====== Apagando a ROM antiga =====
del BASVAR.BIN
echo ======= Compilando nova ROM ======
pasmo --msx BASVAR.ASM BASVAR.BIN
echo ============= Pronto =============
openmsx -machine Gradiente_Expert_GPC-1 -ext DDX_3.0 -diska .