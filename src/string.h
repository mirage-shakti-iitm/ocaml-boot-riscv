// taken (and modified) from riscv-pk. See LICENSE.riscv-pk
#ifndef string_h
#define string_h

#include <stdint.h>

namespace util {
    int strcmp(const char * a, const char* b);
    char* strcpy(char* dst, const char* src);
    int strlen(const char* a);
    int isstring(char c);
    void memset(void *x, int c, uint32_t n);
}
#endif
