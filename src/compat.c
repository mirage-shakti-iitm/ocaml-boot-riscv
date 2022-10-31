#include "htif.h"
#include "config.h"
#include "print.h"
#include "timer.h"
#include <ocaml-boot-riscv/compat.h>
#include "encoding.h"


    typedef unsigned long long time__t;

    void riscv_poweroff(int status){
        boot_printf("\nEnd => mcycle: 0x%lx\n", read_csr(mcycle));
        // boot_printf("\nEnd => minstret: 0x%lx\n", read_csr(minstret));
        // boot_printf("\nICache accesses => 0x%lx\n", read_csr(mhpmcounter3));
        // boot_printf("\nICache hits => 0x%lx\n", read_csr(mhpmcounter4));
        // boot_printf("\nNon-cacheable ICache accesses => 0x%lx\n", read_csr(mhpmcounter5));
        // boot_printf("\nDCache read accesses => 0x%lx\n", read_csr(mhpmcounter6));
        // boot_printf("\nDCache write accesses => 0x%lx\n", read_csr(mhpmcounter7));
        // boot_printf("\nDCache non-cacheable read => 0x%lx\n", read_csr(mhpmcounter8));
        // boot_printf("\nDCache non-cacheable write => 0x%lx\n", read_csr(mhpmcounter9));
        // boot_printf("\nDCache read hits => 0x%lx\n", read_csr(mhpmcounter10));
        // boot_printf("\nDcache write hits => 0x%lx\n", read_csr(mhpmcounter11));
        boot_printf("\nCross compartment exception => 0x%lx\n", read_csr(mhpmcounter12));
        boot_printf("\nCross compartment cycles => 0x%lx\n", read_csr(mhpmcounter13));
        boot_printf("\nHash cycles => 0x%lx\n", read_csr(mhpmcounter14));
        boot_printf("\nVal cycles => 0x%lx\n", read_csr(mhpmcounter15));
        boot_printf("ocaml-boot: caml runtime returned. shutting down!\n");
        #if !defined(SHAKTI_UART)   
            htif_poweroff();
        #elif defined(SHAKTI_UART)
            uart_exit();
        #else
            while(1);
        #endif
    }
    void riscv_write(const char* s, unsigned int length) {
        boot_putstring(s, length);
    }
    time__t riscv_clock_monotonic() {
        volatile unsigned long* tmp = (volatile unsigned long*)mtime;
        return (time__t) *tmp;
    }

    time__t riscv_cycle_counter() {
        volatile unsigned long* tmp = (volatile unsigned long*)mtime;
        return (time__t) *tmp;
    }
    void riscv_wait(time__t delay) {
        // time__t curr = riscv_clock_monotonic();
        // time__t next = curr+delay;
        time__t next = delay;
        set_timer(next);
        while(!timer_pending()){
            // asm volatile("wfi");
        }
        clear_timer();
    }
