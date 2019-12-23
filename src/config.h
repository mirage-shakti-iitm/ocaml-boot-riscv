#ifndef __config_h__
#define __config_h__

#include <stdint.h>
#include "defs.h"

    // total memory size in bytes
    // spike default size is 2048 MiB
    extern const uintptr_t mem_size;

    // uart base address
    // hardcoded riscv-qemu's virt-io uart. change as needed.
#if defined(SHAKTI_UART) && !defined(QEMU_UART) && !defined(HTIF)
    extern const uintptr_t uart_base;
#elif !defined(SHAKTI_UART) && defined(QEMU_UART) && !defined(HTIF)
    extern const uintptr_t uart_base;
#elif !defined(SHAKTI_UART) && !defined(QEMU_UART) && defined(HTIF)
    // no uart
#endif

    
    extern const uintptr_t clint_consts_msip;
    extern const uintptr_t clint_consts_mtimecmp;
    extern const uintptr_t clint_consts_mtime;
    
    extern const uintptr_t clint_base;
    extern const uintptr_t msip;
    extern const uintptr_t mtimecmp;
    extern const uintptr_t mtime;

    //mirror defs.h
    extern const uint64_t stack_size;
    extern const uint16_t stack_shift;

    // printm buffer size
    extern const uint64_t print_buf_size;



#endif // __config_h__