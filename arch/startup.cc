#include "assert.h"
#include "fdt.h"
#include "uart.h"
#include "config.h"

extern "C" {
    void boot_primary(uintptr_t hartid, uintptr_t dtb);
    void boot_secondary(uintptr_t hartid, uintptr_t dtb);
}
extern void caml_startup (char **argv);

extern "C" {
    char __attribute__(( aligned (16) )) stacks[STACK_SIZE * MAX_HARTS] = {0xde, 0xad, 0xbe, 0xef};

void boot_primary(uintptr_t hartid, uintptr_t dtb) {
    // output first
    pk::query_uart(dtb);

    // system info
    pk::query_harts(dtb);
    pk::query_mem(dtb);
    pk::query_clint(dtb);


    pk::fdt_print(dtb);

    // call ocaml land
    caml_startup(nullptr);

    // idle spin
    while(1);
}

void boot_secondary(uintptr_t hartid, uintptr_t dtb) {
    assert(false && "multicore systems are not supported");
    __builtin_unreachable();
}
}
