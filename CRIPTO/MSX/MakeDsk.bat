@echo off
echo ====== Apagando a BIN antiga =====
del DSK\CRIPTDSK.BIN
echo ======= Compilando nova BIN ======
pasmo --msx CRIPTDSK.ASM DSK\CRIPTDSK.BIN
echo ============= Pronto =============
