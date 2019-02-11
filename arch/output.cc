// see LICENSE for licensing details
#include "output.h"
#include "htif.h"
#include "uart.h"

#ifdef HTIF
HTIFOutputStream kout;
#endif
#ifdef UART
UARTOutputStream kout;
#endif

void UARTOutputStream::putchar(char ch) {
    pk::uart_putchar(ch);
}

void HTIFOutputStream::putchar(char ch) {
    pk::htif_console_putchar(ch);
}
