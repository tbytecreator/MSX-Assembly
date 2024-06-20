@echo off
echo ====== Apagando a ROM antiga =====
del ROM\CRIPTROM.ROM
echo ======= Compilando nova ROM ======
pasmo CRIPTROM.ASM ROM\CRIPTROM.ROM
echo ============= Pronto =============
openmsx -machine Gradiente_Expert_GPC-1 -cart ROM\CRIPTROM.ROM
