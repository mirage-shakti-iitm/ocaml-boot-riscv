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
   #if defined(HTIF) 
    s[i++] = pk::uart_getchar();
    s[i++] = pk::uart_getchar();
    pk::uart_putchar('a');
   #endif
//     do{
// #if defined(QEMU_UART) || defined(SHAKTI_UART)
//             s[i] = pk::uart_getchar();
// #elif defined(HTIF)
//            s[i] = pk::htif_console_getchar();
// #else
// #error "none of QEMU_UART, SHAKTI_UART or HTIF is defined!"
// #endif
//            i++;
//   } while((i-1)<10);
  return i;
}

}
