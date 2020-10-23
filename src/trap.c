#include "trap.h"
#include "print_exception.h"
#include "encoding.h"
#include "htif_exception.h"
#include "htif.h"

void trap_handler(uint64_t mcause, uintptr_t context) {
    if(mcause > 0 ) {
        //trap
        // mtval not defined in riscv-gcc-7 assembler, can use mtval when using clang+llvm because finally we will be using latest clang to generate the object file
        printf("ocaml boot: trap (%d) @ 0x%x mtval=0x%x\n", mcause, read_csr(mepc), read_csr(mtval)); 
    }
    else {
        static uint64_t mask =  ~((uint64_t)1 << 63);
        uint64_t masked = mcause & mask;
        // irq
        printf("ocaml boot: irq (%d) @ 0x%x mtval=0x%x\n", masked, read_csr(mepc), read_csr(mtval));
    }
    htif_poweroff();
}

void print_checkcap_no_cross_comp_fail() {
    printf("\nCheckcap no cross-comp fail : (%d) to (%d) at 0x%x", read_csr(ucurrcap), read_csr(utargetcap), read_csr(mepc));
    printf("\nCurrcap_PC_Base = (%d)", read_csr(ucurrcappcbase));
    printf("\nCurrcap_PC_Bound = (%d)\n", read_csr(ucurrcappcbound));
    // printf("\n");
    htif_poweroff();
}

void print_checkcap_cap_matrix_fail() {
    printf("\nCheckcap capability matrix fail : (%d) to (%d) at 0x%x", read_csr(ucurrcap), read_csr(utargetcap), read_csr(mepc));
    printf("\nCurrcap_PC_Base = (%d)", read_csr(ucurrcappcbase));
    printf("\nCurrcap_PC_Bound = (%d)\n", read_csr(ucurrcappcbound));
    // printf("\n");
    htif_poweroff();    
}