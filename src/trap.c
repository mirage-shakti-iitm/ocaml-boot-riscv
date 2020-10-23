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
        printf("ocaml boot: irq (%x) @ 0x%x mtval=0x%x\n", masked, read_csr(mepc), read_csr(mtval));
    }
    htif_poweroff();
}

void print_checkcap_no_cross_comp_fail() {
    printf("\nCheckcap no cross-comp fail(Due to 254) : (%d) to (%d) at 0x%x", read_csr(ucurrcap), read_csr(utargetcap), read_csr(mepc));
    printf("\nCurrcap_PC_Base = (%x)", read_csr(ucurrcappcbase));
    printf("\nCurrcap_PC_Bound = (%x)", read_csr(ucurrcappcbound));
    printf("\nParcap_PC_Base = (%x)", read_csr(uparcappcbase));
    printf("\nAnycap_PC_Base = (%x)", read_csr(uanycappcbase));
    printf("\nAnycap_PC_Bound = (%x)\n", read_csr(uanycappcbound));
    
    htif_poweroff();
}

void print_checkcap_cap_matrix_fail() {
    printf("\nCheckcap capability matrix fail(Due to invalid compartment jump) : (%d) to (%d) at 0x%x", read_csr(ucurrcap), read_csr(utargetcap), read_csr(mepc));
    printf("\nCurrcap_PC_Base = (%x)", read_csr(ucurrcappcbase));
    printf("\nCurrcap_PC_Bound = (%x)", read_csr(ucurrcappcbound));
    printf("\nParcap_PC_Base = (%x)", read_csr(uparcappcbase));
    printf("\nAnycap_PC_Base = (%x)", read_csr(uanycappcbase));
    printf("\nAnycap_PC_Bound = (%x)\n", read_csr(uanycappcbound));
    
    htif_poweroff();    
}