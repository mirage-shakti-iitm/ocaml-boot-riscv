#include <stdint.h>

void trap_handler(uint64_t mcause, uintptr_t context);
void print_checkcap_all_cond_fail();
void print_capability_fail();
