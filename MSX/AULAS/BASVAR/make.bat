@echo off
echo ====== Apagando a ROM antiga =====
del letype.bin
echo ======= Compilando nova ROM ======
pasmo --msx letype.asm letype.bin
echo ============= Pronto =============
openmsx -machine Gradiente_Expert_GPC-1 -ext DDX_3.0 -diska .
