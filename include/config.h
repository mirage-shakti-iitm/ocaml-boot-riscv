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
    // note: spike doesn't support uart yet.
    constexpr uintptr_t uart_base = 0x10000000;

    // mtime address
    // note: uses spike default clint offset of 0x02000000
    //       mtime is clint_base + 0xbff8
    constexpr uintptr_t mtime = 0x0200bff8;

    //mirror defs.h
    constexpr uint64_t stack_size = STACK_SIZE;
    constexpr uint16_t stack_shift = STACK_SHIFT;

    // printm buffer size
    constexpr uint64_t print_buf_size = 256;

}

#endif // __config_h__
