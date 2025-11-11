@echo off
echo ====== Apagando a ROM antiga =====
del levar.bin
echo ======= Compilando nova ROM ======
pasmo --msx levar.asm levar.bin
echo ============= Pronto =============
openmsx -machine Gradiente_Expert_GPC-1 -ext DDX_3.0 -diska .