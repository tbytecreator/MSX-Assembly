@echo off
echo ====== Apagando a ROM antiga =====
del ROM\NUM16.ROM
echo ======= Compilando nova ROM ======
pasmo NUM16.ASM ROM\NUM16.ROM
echo ============= Pronto =============
openmsx -machine Gradiente_Expert_GPC-1 -cart ROM\NUM16.ROM
