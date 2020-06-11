#include "trap.h"
#include "print_exception.h"
#include "encoding.h"
#include "htif_exception.h"

void trap_handler(uint64_t mcause, uintptr_t context) {
    if(mcause > 0 ) {
        //trap
        // mtval not defined in riscv-gcc-7 assembler, can use mtval when using clang+llvm because finally we will be using latest clang to generate the object file
        printf_exception("ocaml boot: trap (%d) @ 0x%x mtval=0x%x\n", mcause, read_csr(mepc), read_csr(mtval)); 
    }
    else {
        static uint64_t mask =  ~((uint64_t)1 << 63);
        uint64_t masked = mcause & mask;
        // irq
        printf_exception("ocaml boot: irq (%d) @ 0x%x mtval=0x%x\n", masked, read_csr(mepc), read_csr(mtval));
    }
    htif_poweroff();
}

void print_checkcap_all_cond_fail() {
    printf_exception("\nCheckcap all condition fail fail : (%d) to (%d) at 0x%x\n", read_csr(ucurrcap), read_csr(utargetcap), read_csr(mepc)); 
    htif_poweroff();
}

void print_capability_fail() {
    printf_exception("\ncross compartment fail : (%d) to (%d) at 0x%x\n", read_csr(ucurrcap), read_csr(utargetcap), read_csr(mepc)); 
    htif_poweroff();    
}