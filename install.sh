#!/bin/sh -ex

# prefix=${1:-$PREFIX}
# if [ "$prefix" = "" ]; then
    prefix=`opam var prefix`
# fi

DESTINC=${prefix}/riscv-sysroot/include/ocaml-boot-riscv
# DESTLIB=${prefix}/lib/ocaml-boot-riscv
DESTLIB=${prefix}/riscv-sysroot/lib/ocaml-boot-riscv
mkdir -p ${DESTINC} ${DESTLIB}
# mkdir -p ${DESTINC}

# "nolibc"
cp -r build/include/* ${DESTINC}
cp build/src/libboot_c.a ${DESTLIB}/libboot_c.a
cp build/src/libboot_ocaml.a ${DESTLIB}/libboot_ocaml.a
cp build/src/libboot_mirage.a ${DESTLIB}/libboot_mirage.a

# META: ocamlfind and other build utilities test for existance ${DESTLIB}/META
# when figuring out whether a library is installed
touch ${DESTLIB}/META

# pkg-config
mkdir -p ${prefix}/riscv-sysroot/lib/pkgconfig
cp ocaml-boot-riscv.pc ${prefix}/riscv-sysroot/lib/pkgconfig/ocaml-boot-riscv.pc