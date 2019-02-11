#include "assert.h"
#include "fdt.h"
#include "uart.h"
#include "config.h"
#include "ocaml-freestanding-compat.h"

extern "C" {
    void boot_primary(uintptr_t hartid, uintptr_t dtb);
    void boot_secondary(uintptr_t hartid, uintptr_t dtb);
}
extern void _nolibc_init(uintptr_t heap_start, uint64_t heap_size);

extern "C" {
    unsigned char __attribute__(( aligned (16) )) stacks[STACK_SIZE * MAX_HARTS] = {0xde, 0xad, 0xbe, 0xef};

void boot_primary(uintptr_t hartid, uintptr_t dtb) {
    // output first
    pk::query_uart(dtb);

    // system info
    pk::query_harts(dtb);
    pk::query_mem(dtb);
    pk::query_clint(dtb);


    pk::fdt_print(dtb);

    // init nolibc of ocaml_freestanding
    uintptr_t start = (uintptr_t) &__KERNEL_END;
    _nolibc_init(start, pk::mem_size - start);

    // call ocaml land
    caml_startup(nullptr);

    // idle spin
    while(1);
    __builtin_unreachable();
}

void boot_secondary(uintptr_t hartid, uintptr_t dtb) {
    assert(false && "multicore systems are not supported");
    __builtin_unreachable();
}
}
