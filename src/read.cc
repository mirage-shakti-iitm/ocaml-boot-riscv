// taken (and modified) from riscv-pk. See LICENSE.riscv-pk
#include "config.h"
#include "bits.h"
#include "read.h"
#include "string.h"
#include "uart.h"
#include "htif.h"

namespace util {
    
void getstring(char* s,unsigned int len){
    for(size_t i = 0; i < len; ++i) {
#if defined(QEMU_UART) || defined(SHAKTI_UART)
            // pk::uart_getchar(s[i]);
#elif defined(HTIF)
           s[i] = pk::htif_console_getchar();
#else
#error "none of QEMU_UART, SHAKTI_UART or HTIF is defined!"
#endif
           if(s[i] == '\0' || s[i] == '\n'){
            break;
           }
  }
}


}
