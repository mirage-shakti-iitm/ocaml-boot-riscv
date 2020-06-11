// taken (and modified) from riscv-pk. See LICENSE.riscv-pk
#include <stdarg.h>


    void vprintf_exception(const char* s, va_list vl);
    void printf_exception(const char* s, ...);
    void putstring_exception(const char* s, unsigned int len);