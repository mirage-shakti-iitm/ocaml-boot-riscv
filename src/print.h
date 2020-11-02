// taken (and modified) from riscv-pk. See LICENSE.riscv-pk
#include <stdarg.h>


    void boot_vprintf(const char* s, va_list vl);
    void boot_printf(const char* s, ...);
    void boot_putstring(const char* s, unsigned int len);