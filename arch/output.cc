#include "machine.h"
#include "output.h"
#include "htif.h"
#include "uart.h"

/* switch between serial and HTIF output */
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
