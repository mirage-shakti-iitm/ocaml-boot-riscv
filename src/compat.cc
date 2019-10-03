#include "htif.h"
#include "config.h"
#include "print.h"
#include "read.h"
#include "timer.h"
#include "bits.h"
#include <ocaml-boot-riscv/compat.h>

extern "C" {
    typedef unsigned long long time__t;

    void riscv_poweroff(int status){
        pk::htif_poweroff();
    }
    void riscv_write(const char* s, unsigned int length) {
        util::putstring(s, length);
    }
    size_t riscv_read(char* s, unsigned int length) {
        size_t n = util::getstring(s, length);
        return n;
    }
    time__t riscv_clock_monotonic() {
        volatile unsigned long* tmp = (volatile unsigned long*)config::mtime;
        return (time__t) *tmp;
    }

    void riscv_wait(time__t delay) {
        // time__t curr = riscv_clock_monotonic();
        // time__t next = curr+delay;
        time__t next = delay;
        pk::set_timer(next);
        while(!pk::timer_pending()){
            // asm volatile("wfi");
        }
        pk::clear_timer();
    }
}