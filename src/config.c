#ifndef __config_h__
#define __config_h__

#include <stdint.h>
#include "defs.h"

    // total memory size in bytes
    // spike default size is 2048 MiB
    extern const uintptr_t mem_size = 2147483648;

    // uart base address
    // hardcoded riscv-qemu's virt-io uart. change as needed.
#if defined(SHAKTI_UART) && !defined(QEMU_UART) && !defined(HTIF)
    extern const uintptr_t uart_base = 0x10000000;
#elif !defined(SHAKTI_UART) && defined(QEMU_UART) && !defined(HTIF)
    extern const uintptr_t uart_base = 0x10000000;
#elif !defined(SHAKTI_UART) && !defined(QEMU_UART) && defined(HTIF)
    // no uart
#endif

    
    extern const uintptr_t clint_consts_msip = 0x0;
    extern const uintptr_t clint_consts_mtimecmp = 0x4000;
    extern const uintptr_t clint_consts_mtime = 0xbff8;
    
    extern const uintptr_t clint_base = 0x2000000;
    extern const uintptr_t msip = 0x2000000 + 0x0; // clint_base + clint_consts_msip
    extern const uintptr_t mtimecmp = 0x2000000 + 0x4000; // clint_base + clint_consts_mtimecmp
    extern const uintptr_t mtime = 0x2000000 + 0xbff8; // clint_base + clint_consts_mtime

    //mirror defs.h
    extern const uint64_t stack_size = STACK_SIZE;
    extern const uint16_t stack_shift = STACK_SHIFT;

    // printm buffer size
    extern const uint64_t print_buf_size = 256;



#endif // __config_h__