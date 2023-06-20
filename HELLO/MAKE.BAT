@echo off
echo ====== Apagando a ROM antiga =====
del ROM\HELLO.ROM
echo ======= Compilando nova ROM ======
pasmo HELLO.ASM ROM\HELLO.ROM
echo ============= Pronto =============
openmsx -machine Gradiente_Expert_GPC-1 -cart ROM\HELLO.ROM
