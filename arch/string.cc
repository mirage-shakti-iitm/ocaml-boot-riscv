// taken (and modified) from riscv-pk. See LICENSE.riscv-pk
#include "string.h"

int util::strcmp(const char *a, const char *b) {
    for (int i = 0; ; i++) {
        if (a[i] != b[i]) {
            return a[i] < b[i] ? -1 : 1;
        }
        if (a[i] == '\0') {
            return 0;
        }
    }
}

char* util::strcpy(char *dst, const char *src) {
    for (int i = 0; ; i++) {
        dst[i] = src[i];
        if (src[i] == '\0') {
            return dst;
        }
    }
}

int util::strlen(const char *a) {
    unsigned ret = 0;
    for (; *a != '\0'; ret ++) {
        a++;
    }
    return ret;
}

int util::isstring(char c)
{
  if (c >= 'A' && c <= 'Z')
    return 1;
  if (c >= 'a' && c <= 'z')
    return 1;
  if (c >= '0' && c <= '9')
    return 1;
  if (c == '\0' || c == ' ' || c == ',' || c == '-')
    return 1;
  return 0;
}

void util::memset(void *x, int c, uint32_t n) {
    for (uint32_t i = 0; i < n; i++) {
        ((volatile char *)x)[i] = c;
    }
}
