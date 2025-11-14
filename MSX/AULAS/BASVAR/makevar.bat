@echo off
echo ====== Apagando a ROM antiga =====
del levar.rom
echo ======= Compilando nova ROM ======
pasmo levar.asm levar.rom
echo ============= Pronto =============
openmsx -machine Gradiente_Expert_GPC-1 -cart levar.rom
