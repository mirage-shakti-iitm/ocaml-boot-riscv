#include "assert.h"
#include "uart.h"
#include "config.h"
#include "ocaml-freestanding-compat.h"
#include "print.h"
#include "encoding.h"

extern "C" {
    void boot_primary();
    void boot_secondary();
}
extern void _nolibc_init(uintptr_t heap_start, uint64_t heap_size);

extern "C" {
    unsigned char 
        __attribute__(( aligned (16) )) 
        stack[config::stack_size] = {0xde, 0xad, 0xbe, 0xef};

void boot_primary() {
    // init floating point unit
    write_csr(mstatus, MSTATUS_FS);

    // init nolibc of ocaml_freestanding
    uintptr_t start = (uintptr_t) &__KERNEL_END;

    util::printf("ocaml-boot: heap@0x%x stack@0x%x\n",start, &stack[config::stack_size]);
    _nolibc_init(start, config::mem_size);

    const char *argv[2] = { "ocaml-boot-riscv", nullptr };

    // call ocaml land
    caml_startup(argv);

    // idle spin
    while(1);
}

void boot_secondary() {
    assert(false && "multicore systems are not supported");
}
}
