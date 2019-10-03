// functions exposed to ocaml-freestanding
// these need to not be name mangled
#include "bits.h"

#ifdef __cplusplus
extern "C" {
#endif
	typedef unsigned long long time__t;

    void riscv_poweroff(int status) __attribute__((noreturn));
    void riscv_write(const char* s, unsigned int length);
    size_t riscv_read(char* s, unsigned int length);
    time__t riscv_clock_monotonic();
    void riscv_wait(time__t delay);

#ifdef __cplusplus
}
#endif