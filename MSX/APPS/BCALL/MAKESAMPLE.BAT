@echo off
echo ====== Apagando a ROM antiga =====
del SAMPLE.ROM
echo ======= Compilando nova ROM ======
pasmo SAMPLE.ASM SAMPLE.ROM
echo ============= Pronto =============
openmsx -machine Gradiente_Expert_GPC-1 -cart SAMPLE.ROM