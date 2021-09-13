CC=riscv64-unknown-elf-gcc

ASM_FLAGS= 

ASM_DEFINES=-DSHAKTI_UART

ASM_INCLUDES=-I/home/sai/Shakti_TEE_Practical/mirage-shakti/ocaml-boot-riscv/include -I/home/sai/Shakti_TEE_Practical/mirage-shakti/ocaml-boot-riscv/include/ocaml-boot-riscv -I/home/sai/Shakti_TEE_Practical/mirage-shakti/ocaml-boot-riscv/src 

C_FLAGS=-mcmodel=medany

C_DEFINES=-DSHAKTI_UART

# C_INCLUDES=-I/home/sai/Shakti_TEE_Practical/mirage-shakti/ocaml-boot-riscv/include -I/home/sai/Shakti_TEE_Practical/mirage-shakti/ocaml-boot-riscv/include/ocaml-boot-riscv -I/home/sai/Shakti_TEE_Practical/mirage-shakti/ocaml-boot-riscv/src 
C_INCLUDES=-I../include -I../include/ocaml-boot-riscv -I. 

OBJS=config.o htif.o print.o string.o trap.o uart.o timer.o compat.o # initialize_pc_base_bounds.o# htif_exception.o print_exception.o

SRCS=config.c htif.c print.c string.c trap.c uart.c timer.c compat.c startup_1.S # initialize_pc_base_bounds.c # htif_exception.c print_exception.c

ASMS=config.s htif.s print.s string.s trap.s uart.s timer.s compat.s startup_2.s startup_1.s # initialize_pc_base_bounds.s # htif_exception.s print_exception.s

CAPS=config.cap htif.cap print.cap string.cap trap.cap uart.cap timer.cap compat.cap startup_1.cap # initialize_pc_base_bounds.cap # htif_exception.cap print_exception.cap

$(OBJS):%.o: %.c
	$(CC) $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o $@ -c $<

.phony: generate-asm generate-initial-cap-tee add-checkap

startup_asm.o:
	$(CC) $(ASM_DEFINES) $(ASM_INCLUDES) $(C_FLAGS) -o startup_asm.o -c startup_1.S

startup_2_mirage.o:
	$(CC) $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o startup_2_mirage.o -c startup_2_mirage.c

startup_2_c.o:
	$(CC) $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o startup_2_c.o -c startup_2_c.c

startup_2_ocaml.o:
	$(CC) $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o startup_2_ocaml.o -c startup_2_ocaml.c

libboot_mirage.a: $(OBJS) startup_asm.o startup_2_mirage.o
	riscv64-unknown-elf-ar qc libboot_mirage.a $(OBJS) startup_asm.o startup_2_mirage.o
	riscv64-unknown-elf-ranlib libboot_mirage.a

libboot_c.a: $(OBJS) startup_asm.o startup_2_c.o
	riscv64-unknown-elf-ar qc libboot_c.a $(OBJS) startup_asm.o startup_2_c.o
	riscv64-unknown-elf-ranlib libboot_c.a

libboot_ocaml.a: $(OBJS) startup_asm.o startup_2_ocaml.o
	riscv64-unknown-elf-ar qc libboot_ocaml.a $(OBJS) startup_asm.o startup_2_ocaml.o
	riscv64-unknown-elf-ranlib libboot_ocaml.a

# config.o:
# 	$(CC) $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o config.o -c config.c

# constructors.o:
# 	$(CC) $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o constructors.o -c constructors.c

# htif.o:
# 	$(CC) $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o htif.o -c htif.c

# print.o:
# 	$(CC) $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o print.o -c print.c

# string.o:
# 	$(CC) $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o string.o -c string.c

# trap.o:
# 	$(CC) $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o trap.o -c trap.c

# uart.o:
# 	$(CC) $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o uart.o -c uart.c

# timer.o:
# 	$(CC) $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o timer.o -c timer.c

# compat.o:
# 	$(CC) $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o compat.o -c compat.c

# startup.o:
# 	$(CC) $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o startup.o -c startup.c
