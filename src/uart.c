// taken (and modified) from riscv-pk. See LICENSE.riscv-pk

#if defined(QEMU_UART) || defined(SHAKTI_UART)

#include "string.h"
#include "uart.h"
#include "config.h"


#define UART_REG_TXFIFO		0
#define UART_REG_RXFIFO		1
#define UART_REG_TXCTRL		2
#define UART_REG_RXCTRL		3
#define UART_REG_DIV		4

#define UART_TXEN		 0x1
#define UART_RXEN		 0x1

    void uart_putchar(uint8_t ch)
    {
#if defined(QEMU_UART) && !defined(SHAKTI_UART)
        volatile uint32_t *uart = (volatile uint32_t*) uart_base;
        volatile uint32_t *tx = uart + UART_REG_TXFIFO;
        while ((int32_t)(*tx) < 0);
        *tx = ch;
#elif !defined(QEMU_UART) && defined(SHAKTI_UART)
        register char a0 asm("a0") = ch;
        asm volatile ("li t1, 0x11300" "\n\t"	//The base address of UART config registers
            "uart_status_simple: lb a1, 12(t1)" "\n\t"
            "andi a1,a1,0x2" "\n\t"
            "beqz a1, uart_status_simple" "\n\t"
            "sb a0, 4(t1)"  "\n\t"
                    :
                    :
                    :"a0","t1","cc","memory");
#endif
    }

    int uart_getchar()
    {
        int32_t ch;
#if defined(QEMU_UART) && !defined(SHAKTI_UART)
        volatile uint32_t *uart = (volatile uint32_t*) uart_base;
        ch = uart[UART_REG_RXFIFO];
        if (ch < 0) return -1;
#elif !defined(QEMU_UART) && defined(SHAKTI_UART)
        register char a0 asm("a0");
        asm volatile ("li t1, 0x11300" "\n\t" //The base address of UART config registers
                "uart_statusr: lb t2, 40(t1)" "\n\t"
                "andi t2, t2, 0x1" "\n\t"
                "beqz t2, uart_statusr" "\n\t"
                "lb a0, 0(t1)"  "\n\t"      //The base address of UART data register
                :
                :
                :"a0","t1","t2","cc","memory");
        ch = a0;
#endif
        return ch;
    }

    void init_uart()
    {
#ifdef QEMU_UART
        volatile uint32_t *uart = (volatile uint32_t*) uart_base;
        // Enable Rx/Tx channels
        uart[UART_REG_TXCTRL] = UART_TXEN;
        uart[UART_REG_RXCTRL] = UART_RXEN;
#endif
    }


void uart_exit()
{
   asm volatile (
        "csrr t5, 0xb03" "\n\t"
        "csrr t6, 0xb04" "\n\t"
        "csrr t4, 0xb00" "\n\t"
        "uart_end: li t1, 0x11300" "\n\t"	//The base address of UART config registers
        "lb a0, 12(t1)" "\n\t"
        "andi a0, a0, 0x1" "\n\t"
        "beqz a0, uart_end" "\n\t"
        "li a0,  0x20000" "\n\t"
        "sw a0,  12(a0)" "\n\t"
				:
				:
				:"a0","t1","cc","memory");
}


#endif
