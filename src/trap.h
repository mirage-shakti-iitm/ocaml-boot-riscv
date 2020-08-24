#include <stdint.h>

void trap_handler(uint64_t mcause, uintptr_t context);
void print_checkcap_no_cross_comp_fail();
void print_capability_fail();
