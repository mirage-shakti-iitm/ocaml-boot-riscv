#!/bin/sh -ex

option=$1
chosen_dir="compartment_testcases/hardware_tests/test_${option}"
src_dir="src"
kernel_name="kernel_hw_cap_${option}"
output_file="output_${option}.txt"
libboot_name="libboot_${option}.a"
build_dir="build/src"
test_program_dir="compartment_testcases/test_program"
output_dir="compartment_testcases/hardware_tests/outputs"

# OCAML_FREESTANDING_RISCV_PATH := $(shell opam config exec --  ocamlfind query ocaml-freestanding-riscv)
LINKER_PATH=${chosen_dir}
# BOOT_PATH = "$(shell opam config var prefix)/lib"
# echo ${LINKER_PATH}

# initial clean
make clean
# generate cap_matrix.h in chosen_dir
# cd ${chosen_dir}
# cap_matrix_generator cap_table.txt
# cd ../..
# chosen_dir will contain the .cap files and all the cap_matrix.h
cp ${chosen_dir}/* ${src_dir}/
# restore original startup_2.c
cp ${src_dir}/startup_2_org.c ${src_dir}/startup_2.c
# copy cap_matrix to startup_2.c, correct way is to manually add the cap_matrix to startup_2.c
cat ${src_dir}/cap_matrix.h >> ${src_dir}/startup_2.c
# build libboot.a
make all
# rename libboot.a
cp build/src/libboot.a ${output_dir}/${libboot_name}
# generate hello.s
# riscv64-unknown-elf-gcc -S ${test_program_dir}/hello.c -o ${test_program_dir}/hello.s
# generate hello.cap
# initial_cap_file_generator c 34 ${test_program_dir}/hello.s
# add checkcap instruction to hello.s
# postProcessing.py ${test_program_dir}/hello.s
# generate hello executable
# riscv64-unknown-elf-gcc -static -nostdlib -nostartfiles ${test_program_dir}/hello.s -o ${test_program_dir}/hello
# generate kernel_cap
riscv64-unknown-elf-gcc -mcmodel=medany ${test_program_dir}/hello -o ${output_dir}/${kernel_name} -static -nostdlib -nostartfiles -Wl,-L$(LINKER_PATH) -Wl,-T${LINKER_PATH}/linker.x -Wl,--start-group ${output_dir}/${libboot_name} -Wl,--end-group
# simulate in spike and store the output file in output.txt
# spike ${output_dir}/${kernel_name} > ${output_dir}/${output_file}