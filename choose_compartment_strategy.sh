#!/bin/sh -ex

option=$1
chosen_dir="compartment_allocations/strategy_${option}"
src_dir="src/"

cp ${chosen_dir}/* ${src_dir}/