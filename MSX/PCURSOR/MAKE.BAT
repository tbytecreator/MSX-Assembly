@ECHO OFF
ECHO ====== Apagando a ROM antiga =====
DEL PCURSOR.BIN
ECHO ======= Compilando nova ROM ======
PASMO --bin PCURSOR.ASM PCURSOR.BIN
echo ====== CHAMANDO O EMULADOR =======
OPENMSX -machine Gradiente_Expert_GPC-1 -ext DDX_3.0 -diska .