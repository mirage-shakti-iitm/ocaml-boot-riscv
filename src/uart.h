// taken (and modified) from riscv-pk. See LICENSE.riscv-pk

#ifndef _RISCV_UART_H
#if defined(QEMU_UART) || defined(SHAKTI_UART)
#define _RISCV_UART_H

#include <stdint.h>

namespace pk {
    void uart_putchar(uint8_t ch);
    int uart_getchar();
    void init_uart();
}

#endif
#endif
