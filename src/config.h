#ifndef __config_h__
#define __config_h__

#include <stdint.h>
#include "defs.h"

    // total memory size in bytes
    // spike default size is 2048 MiB
    const uintptr_t mem_size = 2147483648;

    // uart base address
    // hardcoded riscv-qemu's virt-io uart. change as needed.
#if defined(SHAKTI_UART) && !defined(QEMU_UART) && !defined(HTIF)
    const uintptr_t uart_base = 0x10000000;
#elif !defined(SHAKTI_UART) && defined(QEMU_UART) && !defined(HTIF)
    const uintptr_t uart_base = 0x10000000;
#elif !defined(SHAKTI_UART) && !defined(QEMU_UART) && defined(HTIF)
    // no uart
#endif

    
    const uintptr_t clint_consts_msip = 0x0;
    const uintptr_t clint_consts_mtimecmp = 0x4000;
    const uintptr_t clint_consts_mtime = 0xbff8;
    
    const uintptr_t clint_base = 0x2000000;
    const uintptr_t msip = 0x2000000 + 0x0; // clint_base + clint_consts_msip
    const uintptr_t mtimecmp = 0x2000000 + 0x4000; // clint_base + clint_consts_mtimecmp
    const uintptr_t mtime = 0x2000000 + 0xbff8; // clint_base + clint_consts_mtime

    //mirror defs.h
    const uint64_t stack_size = STACK_SIZE;
    const uint16_t stack_shift = STACK_SHIFT;

    // printm buffer size
    const uint64_t print_buf_size = 256;



#endif // __config_h__