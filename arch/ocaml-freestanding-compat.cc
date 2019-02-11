#include "ocaml-freestanding-compat.h"
#include "fdt.h"
#include "htif.h"

extern "C" {
    void riscv_poweroff(){
        pk::htif_poweroff();
    }
    void riscv_write(const char* s, unsigned int length) {
        for(unsigned int i = 0; i < length; ++i)
            pk::htif_console_putchar(s[i]);
    }
    unsigned long long riscv_clock_monotonic() {
        return (unsigned long long)*(pk::mtime);
    }
}
