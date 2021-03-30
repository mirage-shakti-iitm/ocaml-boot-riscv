#!/bin/sh -ex

STRATEGY=1
./choose_compartment_strategy.sh ${STRATEGY}
make libboot_no_compartments
DESTLIB=/home/sai/Shakti-TEE-Practical/benchmarks/linked_list/strategy_${STRATEGY}
cp build/src/libboot_normal.a ${DESTLIB}/libboot_normal.a
make clean