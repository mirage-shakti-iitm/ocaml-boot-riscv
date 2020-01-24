// taken (and modified) from riscv-pk. See LICENSE.riscv-pk
#include <stdarg.h>


    void vprintf(const char* s, va_list vl);
    void printf(const char* s, ...);
    void putstring(const char* s, unsigned int len);