// taken (and modified) from riscv-pk. See LICENSE.riscv-pk

#ifndef _RISCV_UART_H
#if defined(QEMU_UART) || defined(SHAKTI_UART)
#define _RISCV_UART_H

#include <stdint.h>

/*! UART Baud Rate Configuration Registers sets the uart clock rate */
#define UART_BAUDRATE_CFG_REGISTER 0
// UART Data Transmit Register (W)
#define UART_DATA_TX_REGISTER 4
// UART Data Receive Register (R)
#define UART_DATA_RX_REGISTER 8
// UART Status REgister (R)
#define UART_STS_REGISTER 0x0C

namespace pk {
    void uart_putchar(uint8_t ch);
    int uart_getchar();
    void init_uart();
    void putchar(int ch);
	int getchar();
}

#endif
#endif
