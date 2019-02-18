// taken (and modified) from riscv-pk. See LICENSE.riscv-pk

#ifndef _RISCV_UART_H
#define _RISCV_UART_H

#include <stdint.h>

namespace pk {
    void uart_putchar(uint8_t ch);
    int uart_getchar();
    void init_uart();
}

#endif
