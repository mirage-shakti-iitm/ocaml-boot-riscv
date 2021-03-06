#include "assert.h"
#include "uart.h"
#include "config.h"
#include "startup.h"
#include "print.h"
#include "encoding.h"
#include "htif.h"

extern "C" {
    unsigned char 
        __attribute__(( aligned (16) )) 
        stack[config::stack_size] = {0xde, 0xad, 0xbe, 0xef};
    extern void riscv_boot_finished(uintptr_t heap_start, uint64_t heap_size);
void boot_primary() {
    // init floating point unit
    // enable timer interrupts & interrupts in general
    uint64_t status = read_csr(mstatus);
    status |= MSTATUS_FS;
    status |= MSTATUS_MIE;
    write_csr(mstatus, status);
    set_csr(mie, IRQ_M_TIMER);

    // init nolibc of ocaml_freestanding
    uintptr_t start = (uintptr_t) &__KERNEL_END;

    util::printf("ocaml-boot: heap@0x%x stack@0x%x\n",start, &stack[config::stack_size]);
    /*  
    _nolibc_init(start, config::mem_size);

    const char *argv[2] = { "ocaml-boot-riscv", nullptr };

    // call ocaml land
    caml_startup(argv);
    */
    riscv_boot_finished(start, config::mem_size);

    util::printf("ocaml-boot: caml runtime returned. shutting down!\n");
// #ifndef UART
#if !defined(SHAKTI_UART)   
    pk::htif_poweroff();
#else
    while(1);
#endif
}

void boot_secondary() {
    assert(false && "multicore systems are not supported");
}
}
