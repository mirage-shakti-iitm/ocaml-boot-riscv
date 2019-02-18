#include "trap.h"
#include "print.h"
#include "encoding.h"
#include "htif.h"

extern "C" void trap_handler(uint64_t mcause, uintptr_t context) {
    util::printf("machine mode: unhandlable trap %ld @ %lx, mtval=%lx \n", mcause, read_csr(mepc), read_csr(mtval));
    pk::htif_poweroff();

}
