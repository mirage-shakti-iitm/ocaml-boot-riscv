#!/bin/sh -ex

# prefix=${1:-$PREFIX}
# if [ "$prefix" = "" ]; then
    prefix=`opam config var prefix`
# fi
DESTINC=${prefix}/include/ocaml-boot-riscv
# DESTLIB=${prefix}/lib/ocaml-boot-riscv
DESTLIB=${prefix}/lib
# mkdir -p ${DESTINC} ${DESTLIB}
# mkdir -p ${DESTINC}

# "nolibc"
cp -r build/include/* ${DESTINC}
cp build/src/libboot.a ${DESTLIB}/libboot.a

# META: ocamlfind and other build utilities test for existance ${DESTLIB}/META
# when figuring out whether a library is installed
# touch ${DESTLIB}/META

# pkg-config
mkdir -p ${prefix}/share/pkgconfig
cp ocaml-boot-riscv.pc ${prefix}/share/pkgconfig/ocaml-boot-riscv.pc
