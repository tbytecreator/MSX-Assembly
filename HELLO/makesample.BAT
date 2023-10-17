@echo off
echo ====== Apagando a ROM antiga =====
del ROM\sample.ROM
echo ======= Compilando nova ROM ======
pasmo sample.ASM ROM\sample.ROM
echo ============= Pronto =============
openmsx -machine Gradiente_Expert_GPC-1 -cart ROM\sample.ROM
