#include "assert.h"
#include "uart.h"
#include "config.h"
#include "ocaml-freestanding-compat.h"

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
    // init nolibc of ocaml_freestanding
    uintptr_t start = (uintptr_t) &__KERNEL_END;
    uintptr_t size = config::mem_size - start;
    _nolibc_init(start, size);

    // call ocaml land
    caml_startup(nullptr);

    // idle spin
    while(1);
    __builtin_unreachable();
}

void boot_secondary() {
    assert(false && "multicore systems are not supported");
    __builtin_unreachable();
}
}
