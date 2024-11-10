@echo off
echo ====== Apagando a ROM antiga =====
del ROM\REGMOD1.ROM
echo ======= Compilando nova ROM ======
pasmo REGMOD1.ASM ROM\REGMOD1.ROM
echo ============= Pronto =============
openmsx -machine Gradiente_Expert_GPC-1 -cart ROM\REGMOD1.ROM
