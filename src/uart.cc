// taken (and modified) from riscv-pk. See LICENSE.riscv-pk

#include "string.h"
#include "uart.h"
#include "config.h"


namespace pk {
#define UART_REG_TXFIFO		0
#define UART_REG_RXFIFO		1
#define UART_REG_TXCTRL		2
#define UART_REG_RXCTRL		3
#define UART_REG_DIV		4

#define UART_TXEN		 0x1
#define UART_RXEN		 0x1

    void uart_putchar(uint8_t ch)
    {
        volatile uint32_t *uart = (volatile uint32_t*) config::uart_base;
#ifdef __riscv_atomic
        int32_t r;
        do {
            __asm__ __volatile__ (
                    "amoor.w %0, %2, %1\n"
                    : "=r" (r), "+A" (uart[UART_REG_TXFIFO])
                    : "r" (ch));
        } while (r < 0);
#else
        volatile uint32_t *tx = uart + UART_REG_TXFIFO;
        while ((int32_t)(*tx) < 0);
        *tx = ch;
#endif
    }

    int uart_getchar()
    {
        volatile uint32_t *uart = (volatile uint32_t*) config::uart_base;
        int32_t ch = uart[UART_REG_RXFIFO];
        if (ch < 0) return -1;
        return ch;
    }

    void init_uart()
    {
        volatile uint32_t *uart = (volatile uint32_t*) config::uart_base;
        // Enable Rx/Tx channels
        uart[UART_REG_TXCTRL] = UART_TXEN;
        uart[UART_REG_RXCTRL] = UART_RXEN;
    }

}
