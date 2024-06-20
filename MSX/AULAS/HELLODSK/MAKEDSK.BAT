@echo off
echo ====== Apagando a BIN antiga =====
del DSK\HELLODSK.BIN
echo ======= Compilando nova BIN ======
pasmo --msx HELLODSK.ASM DSK\HELLODSK.BIN
echo ============= Pronto =============
openmsx -machine Gradiente_Expert_GPC-1 -ext DDX_3.0 -diska DSK\.
