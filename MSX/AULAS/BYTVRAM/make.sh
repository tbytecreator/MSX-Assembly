echo ====== Apagando a ROM antiga =====
rm rom/bytvram.rom
echo ======= Compilando nova ROM ======
pasmo bytvram.asm rom/bytvram.rom
echo ============= Pronto =============
openmsx -machine Gradiente_Expert_GPC-1 -ext DDX_3.0 -diska .
