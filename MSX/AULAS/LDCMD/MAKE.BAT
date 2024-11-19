@echo off
echo ====== Apagando a ROM antiga =====
del ROM\LDCMD.ROM
echo ======= Compilando nova ROM ======
pasmo LDCMD.ASM ROM\LDCMD.ROM
echo ============= Pronto =============
openmsx -machine Gradiente_Expert_GPC-1 -cart ROM\LDCMD.ROM