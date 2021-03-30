#!/bin/sh -ex

STRATEGY=1
./choose_compartment_strategy.sh ${STRATEGY}
make all
DESTLIB=/home/sai/Shakti-TEE-Practical/benchmarks/linked_list/strategy_${STRATEGY}
cp build/src/libboot.a ${DESTLIB}/libboot.a
make clean
./choose_compartment_strategy.sh ${STRATEGY}
make libboot_no_compartments
cp build/src/libboot_normal.a ${DESTLIB}/libboot.av
make clean