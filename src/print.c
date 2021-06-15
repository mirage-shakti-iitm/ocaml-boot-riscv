// taken (and modified) from riscv-pk. See LICENSE.riscv-pk
#include "config.h"
#include "bits.h"
#include "print.h"
#include "string.h"
#include "uart.h"
#include "htif.h"


void vprintf(const char* s, va_list vl)
{
  char buf[256];
  vsnprintf(buf, sizeof buf, s, vl);
  size_t len = strlen_boot(buf);
  putstring(buf, len);
}

void printf_boot(const char* s, ...)
{
  va_list vl;

  va_start(vl, s);
  vprintf(s, vl);
  va_end(vl);
}

void putstring(const char* s,unsigned int len){
    for(size_t i = 0; i < len; ++i)
#if defined(QEMU_UART) || defined(SHAKTI_UART)
            uart_putchar(s[i]);
#elif defined(HTIF)
            htif_console_putchar(s[i]);
#else
#error "none of QEMU_UART, SHAKTI_UART or HTIF is defined!"
#endif

}
