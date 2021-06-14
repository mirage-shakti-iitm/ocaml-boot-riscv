#include "trap.h"
#include "print.h"
#include "encoding.h"
#include "htif.h"

void trap_handler(uint64_t mcause, uintptr_t context) {
    if(mcause > 0 ) {
        //trap
        // mtval not defined in riscv-gcc-7 assembler, can use mtval when using clang+llvm because finally we will be using latest clang to generate the object file
        printf_boot("ocaml boot: trap (%d) @ 0x%x mtval=0x%x\n", mcause, read_csr(mepc), read_csr(mtval)); 
    }
    else {
        static uint64_t mask =  ~((uint64_t)1 << 63);
        uint64_t masked = mcause & mask;
        // irq
        printf_boot("ocaml boot: irq (%d) @ 0x%x mtval=0x%x\n", masked, read_csr(mepc), read_csr(mtval));
    }
    #if defined(HTIF)   
        htif_poweroff();
    #endif
    #if defined(SHAKTI_UART)
        uart_poweroff();
    #else
        while(1);
    #endif
}