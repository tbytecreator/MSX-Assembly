@echo off
echo ====== Apagando a ROM antiga =====
del ROM\FORMULA1.ROM
echo ======= Compilando nova ROM ======
pasmo FORMULA1.ASM ROM\FORMULA1.ROM
echo ============= Pronto =============
openmsx -machine Gradiente_Expert_GPC-1 -cart ROM\FORMULA1.ROM
