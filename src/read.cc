// taken (and modified) from riscv-pk. See LICENSE.riscv-pk
#include "config.h"
#include "bits.h"
#include "read.h"
#include "string.h"
#include "uart.h"
#include "htif.h"

namespace util {
    
size_t getstring(char* s,unsigned int len){
    size_t i = 0;
    do{
#if defined(QEMU_UART) || defined(SHAKTI_UART)
            // pk::uart_getchar(s[i]);
#elif defined(HTIF)
           s[i] = pk::htif_console_getchar();
#else
#error "none of QEMU_UART, SHAKTI_UART or HTIF is defined!"
#endif
           i++;
  } while( s[i-1] != '\0' || s[i-1] != '\n');
  return i-1;
}

}
