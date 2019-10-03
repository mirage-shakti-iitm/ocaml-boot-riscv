// taken (and modified) from riscv-pk. See LICENSE.riscv-pk
#include "config.h"
#include "bits.h"
#include "read.h"
#include "string.h"
#include "uart.h"
#include "htif.h"

namespace util2 {
    
size_t get_string(char* s,unsigned int len){
    size_t i = 0;
    for(i = 0; i < len; ++i) {
#if defined(QEMU_UART) || defined(SHAKTI_UART)
            // pk::uart_getchar(s[i]);
#elif defined(HTIF)
           s[i] = pk::htif_console_getchar();
#else
#error "none of QEMU_UART, SHAKTI_UART or HTIF is defined!"
#endif
           if(s[i] == '\0' || s[i] == '\n'){
            return 0;
           }
  }
  return i;
}

}
