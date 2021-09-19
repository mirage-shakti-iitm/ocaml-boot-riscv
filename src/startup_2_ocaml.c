#include "assert.h"
#include "uart.h"
#include "config.h"
#include "startup_2.h"
#include "print.h"
#include "encoding.h"
#include "htif.h"
#include "defs.h"
#include "bool.h"

    unsigned char 
        __attribute__(( aligned (16) )) 
        stack[STACK_SIZE] = {0xde, 0xad, 0xbe, 0xef};
    extern void riscv_boot_finished(uintptr_t heap_start, uint64_t heap_size);
void boot_primary() {
    
    // init floating point unit
    // enable timer interrupts & interrupts in general    
    uint64_t status = read_csr(mstatus);
    const char *argv[2] = { "ocaml-boot-riscv", 0};
    
    status |= MSTATUS_FS;
    status |= MSTATUS_MIE;
    write_csr(mstatus, status);
    set_csr(mie, IRQ_M_TIMER);

    // init nolibc of ocaml_freestanding
    uintptr_t start = (uintptr_t) &__KERNEL_END;

    boot_printf("ocaml-boot: heap@0x%x stack@0x%x\n",start, &stack[stack_size]);
      
    boot_printf("\n \n Performance numbers : \n mcycle: 0x%lx \n", read_csr(mcycle));

    _nolibc_init(start, mem_size);

    // call ocaml land
    caml_startup(argv);

    boot_printf("\n \n Performance numbers : \n mcycle: 0x%lx \n comp_exceptions : 0x%lx \n cycles_comp_exceptions : 0x%lx \n cycles_hash : 0x%lx \n cycles_val : 0x%lx", read_csr(mcycle), read_csr(mhpmcounter3), read_csr(mhpmcounter4), read_csr(mhpmcounter5), read_csr(mhpmcounter6));
    boot_printf("\nLeast sp : 0x%x \n ",read_csr(0x80a));

    boot_printf("ocaml-boot: caml runtime returned. shutting down!\n");

// #ifndef UART
#if !defined(SHAKTI_UART)   
    htif_poweroff();
#elif defined(SHAKTI_UART)
    uart_exit();
#else
    while(1);
#endif
}

void boot_secondary() {
    // assert(false && "multicore systems are not supported");
}
