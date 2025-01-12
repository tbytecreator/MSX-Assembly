@echo off
echo ====== Apagando a BIN antiga =====
del DSK\MDUMP.BIN
echo ======= Compilando nova BIN ======
pasmo --msx MDUMP.ASM DSK\MDUMP.BIN
copy AUTOEXEC.BAS DSK\AUTOEXEC.BAS
echo ============= Pronto =============
openmsx -machine Gradiente_Expert_GPC-1 -ext DDX_3.0 -diska DSK\.
