@echo off
echo ====== Apagando a ROM antiga =====
del ptype.bin
echo ======= Compilando nova ROM ======
pasmo --msx ptype.asm ptype.bin
echo ============= Pronto =============
openmsx -machine Gradiente_Expert_GPC-1 -ext DDX_3.0 -diska .