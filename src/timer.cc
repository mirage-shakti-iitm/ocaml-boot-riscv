#include <timer.h>
#include <config.h>
#include <encoding.h>
#include <print.h>

namespace pk {
    bool timer_pending() {
        int ip = read_csr(mip);
        int ie = read_csr(mie);
        util::printf("%d",ip);
        return (ip & MIP_MTIP) > 0;
    }
    void set_timer(unsigned long long deadline) {
        volatile unsigned long *cmp = (volatile unsigned long*)config::mtimecmp;
        *cmp = deadline;
    }
    void clear_timer() {
        volatile unsigned long *cmp = (volatile unsigned long*)config::mtimecmp;
        *cmp = 0;
    }

}
