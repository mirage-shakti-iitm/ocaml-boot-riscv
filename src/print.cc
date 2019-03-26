// taken (and modified) from riscv-pk. See LICENSE.riscv-pk
#include "config.h"
#include "bits.h"
#include "print.h"
#include "string.h"
#include "uart.h"
#include "htif.h"

namespace util {
    void vprintf(const char* s, va_list vl)
{
  char buf[256];
  vsnprintf(buf, sizeof buf, s, vl);
  size_t len = strlen(buf);
  putstring(buf, len);
}

void printf(const char* s, ...)
{
  va_list vl;

  va_start(vl, s);
  vprintf(s, vl);
  va_end(vl);
}

void putstring(const char* s,unsigned int len){
    for(size_t i = 0; i < len; ++i)
#ifdef UART 
            pk::uart_putchar(s[i]);
#else
            pk::htif_console_putchar(s[i]);
#endif

}


}
