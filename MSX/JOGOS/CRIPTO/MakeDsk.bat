@echo off
echo ====== Apagando a BIN antiga =====
del DSK\CRIPTDSK.BIN
echo ======= Compilando nova BIN ======
pasmo --msx CRIPTDSK.ASM DSK\CRIPTDSK.BIN
echo ============= Pronto =============
openmsx -machine Gradiente_Expert_GPC-1 -ext DDX_3.0 -diska DSK\.
