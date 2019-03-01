#include "ocaml-freestanding-compat.h"
#include "print.h"
#include "htif.h"
#include "config.h"

extern "C" {
    void riscv_poweroff(int status){
        pk::htif_poweroff();
    }
    void riscv_write(const char* s, unsigned int length) {
        util::putstring(s, length);
    }
    unsigned long long riscv_clock_monotonic() {
        volatile unsigned long* tmp = (volatile unsigned long*)config::mtime;
        return (unsigned long long) *tmp;
    }
}
