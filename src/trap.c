#include "trap.h"
#include "print.h"
#include "encoding.h"
#include "htif.h"

void trap_handler(uint64_t mcause, uintptr_t context) {
    if(mcause > 0 ) {
        //trap
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
