@echo off
echo ====== Apagando a ROM antiga =====
del bytvram.bin
echo ======= Compilando nova ROM ======
pasmo --msx bytvram.asm bytvram.bin
echo ============= Pronto =============
openmsx -machine Gradiente_Expert_GPC-1 -ext DDX_3.0 -diska .