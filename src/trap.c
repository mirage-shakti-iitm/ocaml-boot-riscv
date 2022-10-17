#include "trap.h"
#include "print_exception.h"
#include "encoding.h"
#include "htif_exception.h"
#include "htif.h"

void trap_handler(uint64_t mcause, uintptr_t context) {
    if(mcause > 0 ) {
        //trap
        // mtval not defined in riscv-gcc-7 assembler, can use mtval when using clang+llvm because finally we will be using latest clang to generate the object file
        //boot_printf("ocaml boot: trap (%d) @ 0x%x mtval=0x%x\n", mcause, read_csr(mepc), read_csr(mtval)); 
    }
    else {
        static uint64_t mask =  ~((uint64_t)1 << 63);
        uint64_t masked = mcause & mask;
        // irq
        //boot_printf("ocaml boot: irq (%x) @ 0x%x mtval=0x%x\n", masked, read_csr(mepc), read_csr(mtval));
    }
    #if !defined(SHAKTI_UART)   
        htif_poweroff();
    #elif defined(SHAKTI_UART)
        uart_exit();
    #else
        while(1);
    #endif
}

void print_checkcap_entry_fail() {
    //boot_printf("\nCheckcap no cross-comp fail(Due to invalid entry point) : (%d) to (%d) at 0x%x", read_csr(currcom), read_csr(targetcom), read_csr(comepc));
    //boot_printf("\nCurrcap_PC_Base = (%x)", read_csr(curcompcstart));
    //boot_printf("\nCurrcap_PC_Bound = (%x)", read_csr(curcompcend));
    //boot_printf("\nParcap_PC_Base = (%x)", read_csr(parcompcstart));
    //boot_printf("\nAnycap_PC_Base = (%x)", read_csr(anycompcstart));
    //boot_printf("\nAnycap_PC_Bound = (%x)\n", read_csr(anycompcend));
    
    #if !defined(SHAKTI_UART)   
        htif_poweroff();
    #elif defined(SHAKTI_UART)
        uart_exit();
    #else
        while(1);
    #endif
}

void print_checkcap_return_fail() {
    //boot_printf("\nCheckcap no cross-comp fail(Due to invalid return point) : (%d) to (%d) at 0x%x", read_csr(currcom), read_csr(targetcom), read_csr(comepc));
    //boot_printf("\nCurrcap_PC_Base = (%x)", read_csr(curcompcstart));
    //boot_printf("\nCurrcap_PC_Bound = (%x)", read_csr(curcompcend));
    //boot_printf("\nParcap_PC_Base = (%x)", read_csr(parcompcstart));
    //boot_printf("\nAnycap_PC_Base = (%x)", read_csr(anycompcstart));
    //boot_printf("\nAnycap_PC_Bound = (%x)\n", read_csr(anycompcend));
    
    #if !defined(SHAKTI_UART)   
        htif_poweroff();
    #elif defined(SHAKTI_UART)
        uart_exit();
    #else
        while(1);
    #endif
}

void print_checkcap_no_cross_comp_fail() {
    //boot_printf("\nCheckcap no cross-comp fail(Due to 254) : (%d) to (%d) at 0x%x", read_csr(currcom), read_csr(targetcom), read_csr(comepc));
    //boot_printf("\nCurrcap_PC_Base = (%x)", read_csr(curcompcstart));
    //boot_printf("\nCurrcap_PC_Bound = (%x)", read_csr(curcompcend));
    //boot_printf("\nParcap_PC_Base = (%x)", read_csr(parcompcstart));
    //boot_printf("\nAnycap_PC_Base = (%x)", read_csr(anycompcstart));
    //boot_printf("\nAnycap_PC_Bound = (%x)\n", read_csr(anycompcend));
    
    #if !defined(SHAKTI_UART)   
        htif_poweroff();
    #elif defined(SHAKTI_UART)
        uart_exit();
    #else
        while(1);
    #endif
}

void print_checkcap_cap_matrix_fail() {
    //boot_printf("\nCheckcap capability matrix fail(Due to invalid compartment jump) : (%d) to (%d) at 0x%x", read_csr(currcom), read_csr(targetcom), read_csr(comepc));
    //boot_printf("\nCurrcap_PC_Base = (%x)", read_csr(curcompcstart));
    //boot_printf("\nCurrcap_PC_Bound = (%x)", read_csr(curcompcend));
    //boot_printf("\nParcap_PC_Base = (%x)", read_csr(parcompcstart));
    //boot_printf("\nAnycap_PC_Base = (%x)", read_csr(anycompcstart));
    //boot_printf("\nAnycap_PC_Bound = (%x)\n", read_csr(anycompcend));
    
    #if !defined(SHAKTI_UART)   
        htif_poweroff();
    #elif defined(SHAKTI_UART)
        uart_exit();
    #else
        while(1);
    #endif
}