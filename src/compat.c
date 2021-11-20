#include "htif.h"
#include "config.h"
#include "print.h"
#include "timer.h"
#include <ocaml-boot-riscv/compat.h>


    typedef unsigned long long time__t;

    void riscv_poweroff(int status){
        htif_poweroff();
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
