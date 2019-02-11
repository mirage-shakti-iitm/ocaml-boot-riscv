#ifndef __MACHINE_H__
#define __MACHINE_H__

#include "htif.h"
#include "encoding.h"
#include "fdt.h"
#include "output.h"
#include <stdint.h>

class Machine
{
public:
	static void disable_interrupts() {
	   clear_csr(mstatus, MSTATUS_MIE);
    }

	static  void enable_interrupts() {
        // clear any pending external interrupts
        clear_csr(mip, MIP_MEIP);
        // enable external irqs
        set_csr(mie, MIP_MEIP);
        // enable irqs in general
		set_csr(mstatus, MSTATUS_MIE);
    }

	static  bool interrupts_enabled(void) {
        bool global = read_csr(mstatus) & MSTATUS_MIE;
        bool ext = read_csr(mie) & MIP_MEIP;
		return global & ext;
	}

	static void shutdown(void) {
        pk::htif_poweroff();
	}
};

#endif // __MACHINE_H__
