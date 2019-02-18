// taken (and modified) from riscv-pk. See LICENSE.riscv-pk
#include <stdarg.h>
#include "bits.h"

namespace util {
    void vprintf(const char* s, va_list vl);
    void printf(const char* s, ...);
    void putstring(const char* s, size_t len);
}
