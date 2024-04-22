@echo off
echo ====== Apagando a ROM antiga =====
del ROM\REGISTER.ROM
echo ======= Compilando nova ROM ======
pasmo REGISTER.ASM ROM\REGISTER.ROM
echo ============= Pronto =============
openmsx -machine Gradiente_Expert_GPC-1 -cart ROM\REGISTER.ROM
