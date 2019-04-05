#ifndef __config_h__
#define __config_h__

#include <stdint.h>
#include "defs.h"
namespace config {
    // total memory size in bytes
    // spike default size is 2048 MiB
    constexpr uintptr_t mem_size = 2147483648;

    // uart base address
    // hardcoded riscv-qemu's virt-io uart. change as needed.
#if defined(SHAKTI_UART) && !defined(QEMU_UART) && !defined(HTIF)
    constexpr uintptr_t uart_base = 0x10000000;
#elif !defined(SHAKTI_UART) && defined(QEMU_UART) && !defined(HTIF)
    constexpr uintptr_t uart_base = 0x10000000;
#elif !defined(SHAKTI_UART) && !defined(QEMU_UART) && defined(HTIF)
    // no uart
#endif

    enum class clint_consts: uintptr_t {
        msip = 0x0,
        mtimecmp = 0x4000,
        mtime = 0xbff8
    };
    constexpr uintptr_t clint_base = 0x2000000;
    constexpr uintptr_t msip = clint_base + static_cast<uintptr_t>(clint_consts::msip);
    constexpr uintptr_t mtimecmp = clint_base + static_cast<uintptr_t>(clint_consts::mtimecmp);
    constexpr uintptr_t mtime = clint_base + static_cast<uintptr_t>(clint_consts::mtime);

    //mirror defs.h
    constexpr uint64_t stack_size = STACK_SIZE;
    constexpr uint16_t stack_shift = STACK_SHIFT;

    // printm buffer size
    constexpr uint64_t print_buf_size = 256;

}

#endif // __config_h__
