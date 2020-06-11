// taken (and modified) from riscv-pk. See LICENSE.riscv-pk

#include "htif_exception.h"
// #include "atomic.h"
#include "assert.h"
#include <string.h>

extern uint64_t __htif_base;
volatile uint64_t tohost __attribute__((section(".htif")));
volatile uint64_t fromhost __attribute__((section(".htif")));
volatile int htif_console_buf;

    

#define TOHOST(base_int)	(uint64_t *)(base_int + TOHOST_OFFSET)
#define FROMHOST(base_int)	(uint64_t *)(base_int + FROMHOST_OFFSET)

#define TOHOST_OFFSET		((uintptr_t)tohost - (uintptr_t)__htif_base)
#define FROMHOST_OFFSET		((uintptr_t)fromhost - (uintptr_t)__htif_base)

    static void __check_fromhost_exception()
    {
        uint64_t fh = fromhost;
        if (!fh)
            return;
        fromhost = 0;

        // this should be from the console
        assert(FROMHOST_DEV(fh) == 1);
        switch (FROMHOST_CMD(fh)) {
            case 0:
                htif_console_buf = 1 + (uint8_t)FROMHOST_DATA(fh);
                break;
            case 1:
                break;
            default:
                assert(0);
        }
    }

    static void __set_tohost_exception(uintptr_t dev, uintptr_t cmd, uintptr_t data)
    {
        while (tohost)
            __check_fromhost_exception();
        tohost = TOHOST_CMD(dev, cmd, data);
    }

    int htif_console_getchar_exception()
    {
#if __riscv_xlen == 32
        // HTIF devices are not supported on RV32
        return -1;
#endif

        
        __check_fromhost_exception();
        int ch = htif_console_buf;
        if (ch >= 0) {
            htif_console_buf = -1;
            __set_tohost(1, 0, 0);
        }
        

        return ch - 1;
    }

    static void do_tohost_fromhost_exception(uintptr_t dev, uintptr_t cmd, uintptr_t data)
    {
        
        __set_tohost_exception(dev, cmd, data);

        while (1) {
            uint64_t fh = fromhost;
            if (fh) {
                if (FROMHOST_DEV(fh) == dev && FROMHOST_CMD(fh) == cmd) {
                    fromhost = 0;
                    break;
                }
                __check_fromhost_exception();
            }
        }
        
    }

    void htif_console_putchar_exception(uint8_t ch)
    {
#if __riscv_xlen == 32
        // HTIF devices are not supported on RV32, so proxy a write system call
        volatile uint64_t magic_mem[8];
        magic_mem[0] = SYS_write;
        magic_mem[1] = 1;
        magic_mem[2] = (uintptr_t)&ch;
        magic_mem[3] = 1;
        do_tohost_fromhost_exception(0, 0, (uintptr_t)magic_mem);
#else
        
        __set_tohost_exception(1, 1, ch);
        
#endif
    }

    void htif_poweroff()
    {
        while (1) {
            fromhost = 0;
            tohost = 1;
        }
    }
