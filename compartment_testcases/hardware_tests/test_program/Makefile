.PHONY: clean all

clean::
	rm -f kernel_boot

# OCAML_FREESTANDING_RISCV_PATH := $(shell opam config exec --  ocamlfind query ocaml-freestanding-riscv)
LINKER_PATH = $(shell opam config exec -- ocamlfind -toolchain riscv query baremetal-linker-riscv)
# BOOT_PATH = "$(shell opam config var prefix)/lib"

a.out::
	riscv64-unknown-elf-gcc -static -nostdlib -nostartfiles -S hello.c

# kernel:: a.out
# 	riscv64-unknown-elf-gcc  -mcmodel=medany a.out -o kernel -static -nostdlib -nostartfiles -Wl,-T$(LINKER_PATH)/linker.x -Wl,--start-group $(OCAML_FREESTANDING_RISCV_PATH)/libnolibc.a $(BOOT_PATH)/libboot.a -Wl,--end-group -lm -lgcc

kernel_cap:: a.out
	riscv64-unknown-elf-gcc  -mcmodel=medany a.out -o kernel_boot -static -nostdlib -nostartfiles -Wl,-T$(LINKER_PATH)/linker.x -Wl,--start-group libboot.a -Wl,--end-group

all:: kernel_boot