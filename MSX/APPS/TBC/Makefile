PASMO ?= pasmo
OUT   := .dist

all: $(OUT)/TBC.COM

$(OUT)/TBC.COM: $(wildcard SRC/*.ASM SRC/*.INC)
	@mkdir -p $(OUT)
	$(PASMO) -I SRC SRC/TBC.ASM $@ $(OUT)/TBC.sym

# Compila, copia o programa para DOS/A e inicia o openMSX Flatpak.
run:
	bash make.sh

clean:
	rm -f $(OUT)/TBC.COM $(OUT)/TBC.sym

.PHONY: all run clean
