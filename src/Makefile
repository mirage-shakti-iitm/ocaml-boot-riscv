CC=riscv64-unknown-elf-gcc

ASM_FLAGS= 

ASM_DEFINES=-DHTIF

ASM_INCLUDES=-I/home/sai/Shakti_TEE_Practical/mirage-shakti/ocaml-boot-riscv/include -I/home/sai/Shakti_TEE_Practical/mirage-shakti/ocaml-boot-riscv/include/ocaml-boot-riscv -I/home/sai/Shakti_TEE_Practical/mirage-shakti/ocaml-boot-riscv/src 

C_FLAGS=-mcmodel=medany  

C_DEFINES=-DHTIF

# C_INCLUDES=-I/home/sai/Shakti_TEE_Practical/mirage-shakti/ocaml-boot-riscv/include -I/home/sai/Shakti_TEE_Practical/mirage-shakti/ocaml-boot-riscv/include/ocaml-boot-riscv -I/home/sai/Shakti_TEE_Practical/mirage-shakti/ocaml-boot-riscv/src 
C_INCLUDES=-I../include -I../include/ocaml-boot-riscv -I. 

OBJS=config.o htif.o print.o string.o trap.o uart.o timer.o compat.o startup_2.o startup_1.o # htif_exception.o print_exception.o

SRCS=config.c htif.c print.c string.c trap.c uart.c timer.c compat.c startup_2.c startup_1.S # htif_exception.c print_exception.c

ASMS=config.s htif.s print.s string.s trap.s uart.s timer.s compat.s startup_2.s startup_1.s # htif_exception.s print_exception.s

CAPS=config.cap htif.cap print.cap string.cap trap.cap uart.cap timer.cap compat.cap startup_2.cap startup_1.cap # htif_exception.cap print_exception.cap

$(OBJS):%.o: %.s
	$(CC) $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o $@ -c $<

# $(ASMS):%.s: %.c
# 	$(CC) $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o $@ -c $<


.phony: generate-asm generate-initial-cap-tee add-checkap

add-checkcap: $(ASMS)
	for f in $^; do postProcessing.py ./$$f; done

startup_asm.o:
	$(CC) $(ASM_DEFINES) $(ASM_INCLUDES) $(C_FLAGS) -o startup_asm.o -c startup_1.S
# 	$(CC) $(ASM_DEFINES) $(ASM_INCLUDES) $(C_FLAGS) -o startup_asm.o -c startup.S  

libboot.a: generate-asm add-checkcap $(OBJS) # startup_asm.o
	riscv64-unknown-elf-ar qc libboot.a $(OBJS) # startup_asm.o
	riscv64-unknown-elf-ranlib libboot.a

generate-asm: $(SRCS)
	$(CC) $(C_FLAGS) $(C_DEFINES) $(C_INCLUDES) $(SRCS) -S
	$(CC) $(C_FLAGS) $(C_DEFINES) $(C_INCLUDES) startup_1.S -S > startup_1.s

generate-initial-cap-tee: generate-asm $(ASMS)
	initial_cap_file_generator c 254 $(ASMS)
# 	python postProcessing.py passParams.s passParams_out.s


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
