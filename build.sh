#!/bin/sh -ex

STRATEGY=1
./choose_compartment_strategy.sh ${STRATEGY}
make all
DESTLIB=/home/sai/Shakti-TEE-Practical/benchmarks/linked_list/strategy_${STRATEGY}
cp build/src/libboot.a ${DESTLIB}/libboot.a
