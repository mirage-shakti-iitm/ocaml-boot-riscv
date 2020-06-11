// taken (and modified) from riscv-pk. See LICENSE.riscv-pk
#include "config.h"
#include "bits.h"
#include "print_exception.h"
#include "string.h"
#include "uart.h"
#include "htif_exception.h"


void vprintf_exception(const char* s, va_list vl)
{
  char buf[256];
  vsnprintf(buf, sizeof buf, s, vl);
  size_t len = strlen(buf);
  putstring_exception(buf, len);
}

void printf_exception(const char* s, ...)
{
  va_list vl;

  va_start(vl, s);
  vprintf_exception(s, vl);
  va_end(vl);
}

void putstring_exception(const char* s,unsigned int len){
    for(size_t i = 0; i < len; ++i)
#if defined(QEMU_UART) || defined(SHAKTI_UART)
            uart_putchar_exception(s[i]);
#elif defined(HTIF)
            htif_console_putchar_exception(s[i]);
#else
#error "none of QEMU_UART, SHAKTI_UART or HTIF is defined!"
#endif

}
