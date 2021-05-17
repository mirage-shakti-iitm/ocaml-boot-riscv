// taken (and modified) from riscv-pk. See LICENSE.riscv-pk
#ifndef string_h
#define string_h

#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include "bits.h"


    int strcmp(const char * a, const char* b);
    char* strcpy(char* dst, const char* src);
    int strlen(const char* a);
    int isstring(char c);
    void memset_boot(void *x, int c, uint32_t n);
    int vsnprintf(char* out, size_t n, const char* s, va_list vl);
    int snprintf(char* out, size_t n, const char* s, ...);

#endif
