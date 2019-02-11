// see LICENSE for licensing details
#ifndef __machine_h__
#define __machine_h__

#include "htif.h"

class Machine
{
public:
	static void shutdown(void) {
        pk::htif_poweroff();
	}
};

#endif
