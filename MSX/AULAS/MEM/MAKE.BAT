@echo off
echo ====== Apagando a ROM antiga =====
del ROM\MEM.ROM
echo ======= Compilando nova ROM ======
pasmo MEM.ASM ROM\MEM.ROM
echo ============= Pronto =============
openmsx -machine Gradiente_Expert_GPC-1 -cart ROM\MEM.ROM