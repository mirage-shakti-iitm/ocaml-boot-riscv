#include "timer.h"
#include "config.h"
#include "encoding.h"
#include "bool.h"


    bool timer_pending() {
        int ip = read_csr(mip);
        return (ip & MIP_MTIP) > 0;
    }
    void set_timer(unsigned long long deadline) {
        volatile unsigned long *cmp = (volatile unsigned long*)mtimecmp;
        *cmp = deadline;
    }
    void clear_timer() {
        volatile unsigned long *cmp = (volatile unsigned long*)mtimecmp;
        *cmp = 0;
    }


