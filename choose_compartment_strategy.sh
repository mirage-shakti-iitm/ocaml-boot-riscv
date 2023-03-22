#!/bin/sh -ex

# option=$1
# chosen_dir="compartment_allocations/strategy_${option}"
cap_matrix_dir="/home/sai/Shakti-TEE-Practical/mirage-shakti/fides-cap-matrix"
src_dir="src/"

# chosen_dir will contain the *(.cap/cap_tee.ml) files
# cp ${chosen_dir}/* ${src_dir}/

# generate cap_matrix.h in chosen_dir
cap_matrix_generator ${cap_matrix_dir}/fides-voting-system-1/cap_table.txt

# restore original startup_2.c
cp ${src_dir}/startup_2_org.c ${src_dir}/startup_2.c

# copy cap_matrix to startup_2.c, correct way is to manually add the cap_matrix to startup_2.c
cat cap_matrix.h >> ${src_dir}/startup_2.c
