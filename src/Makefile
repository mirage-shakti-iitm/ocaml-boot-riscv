CC=riscv64-unknown-elf-gcc

ASM_FLAGS= 

ASM_DEFINES=-DHTIF

ASM_INCLUDES=-I/home/sai/Shakti_TEE_Practical/mirage-shakti/ocaml-boot-riscv/include -I/home/sai/Shakti_TEE_Practical/mirage-shakti/ocaml-boot-riscv/include/ocaml-boot-riscv -I/home/sai/Shakti_TEE_Practical/mirage-shakti/ocaml-boot-riscv/src 

C_FLAGS=-mcmodel=medany  

C_DEFINES=-DHTIF

# C_INCLUDES=-I/home/sai/Shakti_TEE_Practical/mirage-shakti/ocaml-boot-riscv/include -I/home/sai/Shakti_TEE_Practical/mirage-shakti/ocaml-boot-riscv/include/ocaml-boot-riscv -I/home/sai/Shakti_TEE_Practical/mirage-shakti/ocaml-boot-riscv/src 
C_INCLUDES=-I../include -I../include/ocaml-boot-riscv -I. 

OBJS=config.o htif.o print.o string.o trap.o uart.o timer.o compat.o startup.o

$(OBJS):%.o: %.c
	$(CC) $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o $@ -c $<

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

startup_asm.o:
	$(CC) $(ASM_DEFINES) $(ASM_INCLUDES) $(C_FLAGS) -o startup_asm.o -c startup.S  

libboot.a: $(OBJS) startup_asm.o
	riscv64-unknown-elf-ar qc libboot.a $(OBJS) startup_asm.o
	riscv64-unknown-elf-ranlib libboot.a

